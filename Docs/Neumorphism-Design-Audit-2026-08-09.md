# Neumorphism 设计适配审计（2026-08-09）

## 结论

当前实现适合作为 Neumorphic 控件演示，但距离现代生产级设计系统仍有差距。建议保留 Neumorphism 作为交互控件的视觉层，不让它覆盖页面所有容器和层级。

本次审计依据：

- iOS 模拟器浅色 / 深色运行截图
- `Sources/Neumorphic` 当前 SwiftUI 实现
- Apple Accessibility HIG
- WCAG 2.2 对比度、焦点和目标尺寸要求

## 已具备能力

- 浅色 / 深色配色
- 控件最小触控尺寸约 44pt
- Toggle 提供 On / Off accessibility value
- Toggle 动画支持 Reduce Motion
- iOS / macOS 使用共享示例和分区布局

## 待适配问题

### P0：焦点状态

自定义 ButtonStyle 主要依赖按压缩放和阴影，没有明确的键盘焦点、鼠标悬停或 macOS Focus Ring。需要为键盘、VoiceOver、Switch Control 和 macOS pointer 提供独立的可见状态。

涉及：`Sources/Neumorphic/SoftButtonStyle.swift`、自定义 ToggleStyle。

### P0：Disabled 与高对比度

Disabled 控件当前通过低不透明度表达，深色模式下几乎不可见。需要保留轮廓、文字和状态语义，并支持 Increase Contrast / `accessibilityContrast`。

涉及：`SoftDynamicButtonStyle`、`SoftDynamicToggleStyle`、`SwitchToggleStyle`、`ColorExtension`。

### P1：Dynamic Type 与本地化

示例使用固定网格最小宽度、固定阴影尺寸和固定 padding。大字号或长文本可能造成拥挤、换行失衡和控件裁切。需要使用系统 Text Style、自适应列数和长文本快照测试。

涉及：`neumorphic-examples/Shared/ExampleShowcaseView.swift`。

### P1：视觉层级

背景、容器、按钮和 Toggle 使用相同的凸起表面，层级不够清晰。建议使用纯色或系统语义材质承载页面结构，仅让交互控件使用 Neumorphic 阴影。

### P1：主题配置

`NeumorphicKit.colorSchemeType` 是全局可变状态，不适合多窗口和局部主题。后续应增加基于 SwiftUI Environment 的 Theme / Shadow Preset，并兼容系统颜色方案和高对比度。

### P2：性能与平台差异

内阴影依赖 GeometryReader、mask 和 blur，多层控件滚动时可能增加渲染成本。macOS 还有单独的 mask workaround。需要提供低成本阴影预设，并验证 macOS hover、键盘焦点和滚动性能。

## 实施计划

1. 为 ButtonStyle 和 ToggleStyle 增加 Reduce Motion、Focus Ring、hover 与明确的状态语义。
2. 增加高对比度颜色 Token，修正 Disabled 状态的文字和轮廓表现。
3. 把示例中的固定布局改为 Dynamic Type 友好的自适应布局。
4. 增加 Environment Theme / Shadow Preset API，降低全局状态依赖。
5. 增加浅色、深色、高对比度、大字号、Reduce Motion、iOS 和 macOS 构建验证。

## 参考规范

- [Apple Accessibility HIG](https://developer.apple.com/design/human-interface-guidelines/accessibility/)
- [Apple Liquid Glass / Materials direction](https://www.apple.com/uk/newsroom/2025/06/apple-introduces-a-delightful-and-elegant-new-software-design/)
- [WCAG 2.2](https://www.w3.org/TR/WCAG22/)

## 限制

本次截图审计覆盖 iOS 浅色和深色运行态；macOS 的实际键盘焦点、hover、VoiceOver 和性能仍需在 macOS 环境中验证。

## 本轮完成

- Button 按压缩放已响应 Reduce Motion，避免无必要的缩放动效。
- Disabled Button / Toggle 的文字和整体可见度已提高，减少深色模式下的“消失”问题。
- 新增 `neumorphicFocusRing(_:isFocused:)`，为键盘和辅助技术提供显式焦点环 API。
- 新增 `NeumorphicTheme`、`standard` / `highContrast` Token；Theme 已覆盖内置控件及 themed Button / Toggle / Switch modifiers。
- 新增 macOS 专用 `neumorphicHover(_:isHovered:)`，iOS 自动保持 no-op。
- 新增 `NeumorphicShadowPreset`，提供 `standard`、低成本 `subtle` 和 `none` 预设。
- iOS / macOS 共享示例已使用自适应网格，并完成浅色、深色运行态验证。
- 自定义 Slider / Progress / Picker / Checkbox / Radio / Stepper 已补充 VoiceOver 标签、状态值、可调节操作和按钮语义，包含 iOS 13/macOS 10.15 fallback。
- 交互控件触控区域统一提升到至少 44pt，Picker 支持大字号多行标签，选择状态不再只依赖颜色。
- Swift Package 的 17 个测试、iOS 模拟器构建、macOS 构建均通过。

系统 `accessibilityContrast` 自动切换、完整 macOS 键盘/VoiceOver 测试和真实设备阴影性能基准仍需后续验证；当前已提供显式 `highContrast` Theme、Focus/Hover API 和阴影成本预设。
