# 项目规范与最佳实践审计

- 审计日期：2026-08-08
- 审计基线：Swift 6.3.3、SwiftUI、Swift Package Manager

## 结论

项目核心代码规模小、没有第三方依赖。2026-08-09 复审后，原 P0 项已处理，macOS/iOS 构建、Swift 6 严格并发和 API 兼容均有 CI 门禁；后续重点转为扩大行为测试、无障碍实机验证和阴影性能基准。

## 已确定事项

1. 撤销 tvOS 支持声明。**状态：已完成。**
   - 已从 `Package.swift` 移除 `.tvOS(.v13)`。
   - `NeumorphicKit.color(light:dark:)` 将所有非 iOS 平台走入 macOS `NSColor` 分支。
   - 使用 tvOS SDK typecheck 已确认失败：`cannot find type 'NSColor' in scope`。
   - 本次只移除支持声明，不扩展 tvOS 实现。

## P0：发布阻断项

### 1. tvOS 支持声明与实现冲突

- 位置：`Package.swift:9`、`Sources/Neumorphic/NeumorphicKit.swift:30`
- 影响：使用者会看到 tvOS 受支持，但项目无法通过 tvOS 编译。
- 处理：已从 Package 平台声明中撤销 tvOS 支持；相关实现暂不扩展。

### 2. 测试实际为空。**状态：已完成。**

- 位置：`Tests/NeumorphicTests/NeumorphicTests.swift:5`
- 原占位测试已替换为颜色模式往返、默认颜色解析和控件行为测试。
- 已移除旧的 `Tests/LinuxMain.swift`、`XCTestManifests.swift` 和手工 `allTests` 列表，改用自动发现；当前 `swift test` 执行 17 个测试，全部通过，覆盖公共样式入口、disabled 状态、负几何参数、Slider 步进/映射/编辑会话与非有限值，以及 Progress 边界归一化。

### 3. 缺少 CI。**状态：已完成。**

- `.github/workflows/ci.yml` 已包含严格格式检查、macOS `swift test`、macOS 10.15 和 iOS 13 SDK 构建。
- 已补充 Swift 6 严格检查、DocC 编译和基于最近发布 tag 的 API 兼容性门禁，并在 `v*` tag push 时运行。

## P1：高优先级兼容性问题

### 1. 公开类型与 SwiftUI 重名。**状态：已修复，属于下一 major 的 API 变更。**

- 位置：`Sources/Neumorphic/SwitchToggleStyle.swift:10`
- 原 `Neumorphic.SwitchToggleStyle` 已重命名为 `NeumorphicSwitchToggleStyle`。
- 已提供 `.toggleStyle(.neumorphicSwitch)` 静态入口，客户端 smoke typecheck 通过。
- 该改动移除了冲突的旧公开名称，发布时必须作为 major 版本变更说明。

### 2. Swift 6 严格并发检查。**状态：已修复。**

- 位置：`Sources/Neumorphic/NeumorphicKit.swift:15`
- `colorSchemeType` 原为公开的全局可变静态状态。
- 已改为由 `NSLock` 保护的 `Sendable` 存储对象，保留原有 API 并通过 Swift 6 strict concurrency typecheck。
- CI 已加入严格并发检查，避免回归。

### 3. 最低工具链声明不真实。**状态：已修复。**

- `Package.swift` 已调整为 Swift tools 5.7，与源码使用的并发标记和可选绑定简写一致。
- README 与贡献文档已同步 Swift 5.7+ / Xcode 14+ 要求，同时保留 iOS 13 和 macOS 10.15 部署目标。

## P2：无障碍与交互缺口。**状态：基础交互修正已完成。**

- 自定义 Toggle 已改用 `Button` 承载交互，并保留现有样式入口。
- Toggle 样式已加入最小 44pt 命中区域，并处理 disabled 的视觉状态。
- `switchToggleStyle` 默认高度 30pt、`fixedSizeSoftButtonStyle` 默认视觉尺寸 30×30pt；按钮样式现在提供最小 44pt 命中区域。
- 默认浅色文字与背景按源码 RGB 计算约为 3.45:1，无法覆盖普通文本 4.5:1 的 WCAG AA 要求。**已修复：默认 secondary 调整为约 5.63:1。**
- Toggle 动画已适配 Reduce Motion。
- 开关状态已补充可读的 On/Off accessibility value，避免仅依赖颜色区分。
- `fixedSizeSoftButtonStyle` 保留 30pt 视觉尺寸并提供 44pt 最小命中区域，符合触控目标；颜色对比度与状态语义已修复。
- 自定义控件的 VoiceOver fallback 已覆盖 iOS 13/macOS 10.15，Slider 命中区域、步进和编辑回调语义已修正，Progress 的确定/不确定状态已统一视觉与语义并适配 Reduce Motion。

## P2：测试、文档与发布规范

- 新单元测试应优先考虑 Swift Testing；XCTest 可保留给 UI 和性能测试。
- 删除已过时的 `Tests/LinuxMain.swift` 与 `XCTestManifests.swift`；Swift 5.4 起已默认自动发现测试。
- 所有公开类型和方法应补充 `///` 文档注释。
- 已增加 DocC catalog、公开类型/成员注释和 API 使用入口；catalog 已纳入 Package target，并由 CI 以 warnings-as-errors 编译。
- CI 已增加 `swift package diagnose-api-breaking-changes v2.1.0`，防止意外破坏公共 API。
- 已补充 `CHANGELOG.md`、`CONTRIBUTING.md`、`SECURITY.md` 和工具链支持说明。

## P3：维护性现代化

- README 的平台要求已与 Package 声明同步。
- README 安装示例已更新为 `2.1.0`，并补充 2.1 控件、Theme 和无障碍说明。
- 示例工程已重建为共享源码的 iOS/macOS 单 Target 工程，使用 SwiftUI `App` 生命周期与文件夹同步，部署目标为 iOS 14/macOS 11。
- 已清理本次涉及代码中的冗余 `return`/`self`、行尾空白和多余空行；更大范围的格式化可按 `.swift-format` 配置分批执行。
- 已增加 `.swift-format` 统一配置；CI 同时执行 `git diff --check` 和 `swift format lint --strict`。

## 建议执行顺序

1. 撤销 tvOS 支持声明，并同步 README。**已完成；README 原已仅列出 iOS/macOS。**
2. 建立 iOS/macOS CI，补充非空测试。**已完成并持续扩充行为测试。**
3. 解决 `SwitchToggleStyle` 命名冲突。**已完成；需在 major 版本发布。**
4. 解决 Swift 6 全局可变状态问题。
5. 完成无障碍修正。**交互、对比度、状态语义和命中区域已完成。**
6. 确定最低工具链策略，清理旧测试清单和示例代码。**已完成；最低工具链为 Swift 5.7。**
7. 补齐公开成员文档、贡献规范、变更日志和 API 兼容检查。**DocC catalog 已纳入构建并由 CI 验证。**

## 官方参考

- [Swift 6.3 Released](https://www.swift.org/blog/swift-6.3-released/)
- [Swift Package Description](https://docs.swift.org/swiftpm/documentation/packagedescription/package/)
- [Swift Testing](https://developer.apple.com/documentation/testing)
- [Swift 5.4 Released](https://www.swift.org/blog/swift-5.4-released/)
- [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
- [Swift DocC](https://www.swift.org/documentation/docc/)
- [SwiftUI ToggleStyle](https://developer.apple.com/documentation/swiftui/togglestyle)
- [Apple Accessibility HIG](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- [Diagnose API-breaking changes](https://docs.swift.org/swiftpm/documentation/packagemanagerdocs/packagediagnoseapibreakingchange/)
