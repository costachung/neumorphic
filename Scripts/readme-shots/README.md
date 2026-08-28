# README illustrations

The images in `Docs/images/` are rendered from the same code the README shows, so a snippet and the
picture beside it cannot drift apart. This directory holds the tool that produces most of them, and
the procedure for the three that need a running app.

## Rendered here

```sh
swift run --package-path Scripts/readme-shots readme-shots
```

Run it from the repository root; it writes into `Docs/images/` (pass a directory to override). It
produces `outer-shadow`, `inner-shadow`, `shadows-side-by-side`, `bar-chart`, `soft-button`,
`custom-button`, `switch-toggle`, and `shape-toggle` at scale 3.

Afterwards, cap the wide ones at 900 points so they render at a sensible size on GitHub:

```sh
sips -Z 900 Docs/images/{shadows-side-by-side,outer-shadow,inner-shadow}.png
```

## Captured from the simulator

`hero.png`, `search-bar.png`, and `pressed-effects.gif` cannot come from `ImageRenderer`:

- Both stills contain a `TextField`, which `ImageRenderer` draws as a yellow "unsupported" placeholder.
- The GIF needs real touch input, which no offscreen renderer can supply.

Add this view to `neumorphic-examples/Shared` temporarily, point `ExampleApp` at it, and **revert both
changes afterwards** — it is a capture harness, not example code. The fixed block heights are what make
the crops below deterministic.

```swift
struct ReadmeShotsView: View {
    var body: some View {
        VStack(spacing: 0) {
            Color.Neumorphic.main.frame(height: 80)   // clears the status bar
            ShotSearchBar().frame(width: 402, height: 110)
            ShotHero().frame(width: 402, height: 420)
            ShotPressedEffects().frame(width: 402, height: 120)
            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.Neumorphic.main.ignoresSafeArea())
        .ignoresSafeArea()
    }
}
```

`ShotSearchBar` is the README's search-bar snippet, `ShotHero` is a `neumorphicCard` holding a slider,
text field, progress view, both button roles and a switch, and `ShotPressedEffects` is a row of three
capsule buttons using `.none`, `.flat`, and `.hard`.

Build for an iPhone 17 Pro simulator (402×874 points, scale 3), then capture at native resolution:

```sh
xcrun simctl io booted screenshot full.png
ffmpeg -i full.png -vf "crop=1206:330:0:240"  Docs/images/search-bar.png
ffmpeg -i full.png -vf "crop=1206:1260:0:570" Docs/images/hero.png
sips -Z 900 Docs/images/{hero,search-bar}.png
```

The crop offsets are the block heights above multiplied by the scale factor: the search bar starts at
80 points, the card at 190, the button row at 610.

## The pressed-effects GIF

Start a recording, long-press each of the three buttons in turn (roughly 800 ms each, at y = 670
points, x = 125 / 203 / 279), then stop the recording:

```sh
xcrun simctl io booted recordVideo --codec h264 pressed.mov
```

Find when each press lands — the recording is variable frame rate, and the idle gaps between presses
are long:

```sh
ffmpeg -i pressed.mov -vf "crop=1206:360:0:1830,showinfo" -f null - 2>&1 | grep pts_time
```

Then trim the three windows, concatenate them, and build the GIF. Check the result frame by frame:
`.flat` should lose its shadow, `.hard` should look pressed in, and `.none` should not change at all.

```sh
ffmpeg -i pressed.mov -filter_complex \
  "[0:v]crop=1206:360:0:1830,fps=15,scale=560:-1:flags=lanczos[v];\
   [v]split=3[a][b][c];\
   [a]trim=16.30:16.90,setpts=PTS-STARTPTS[a1];\
   [b]trim=22.60:23.70,setpts=PTS-STARTPTS[b1];\
   [c]trim=28.75:29.60,setpts=PTS-STARTPTS[c1];\
   [a1][b1][c1]concat=n=3:v=1:a=0,split[s0][s1];\
   [s0]palettegen=max_colors=64[p];[s1][p]paletteuse=dither=bayer:bayer_scale=3" \
  -loop 0 Docs/images/pressed-effects.gif
```

The trim timestamps are from one particular recording; read yours out of the `showinfo` pass above.
