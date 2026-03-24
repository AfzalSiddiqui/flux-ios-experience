# flux-ios-experience

**The live showcase app for the Flux iOS Design System.** See every component in action — interactive, configurable, and production-ready.

`flux-ios-experience` is a native iOS app that serves as both a **component gallery** and **developer reference**. Every Flux component has a dedicated showcase screen with live configuration options, variant previews, and real usage examples.

---

## Features

- **29 interactive showcase screens** — One for every component
- **Live configuration** — Toggle variants, sizes, states, and themes in real time
- **Component gallery** — Browse all Atoms, Molecules, and Organisms
- **Theme switching** — Preview components in Light, Dark, and custom themes
- **Attributed text demo** — Rich text with bold, italic, underline, URLs
- **Real app patterns** — Production-ready MVVM examples
- **Developer reference** — See exactly how to use each component

---

## Setup

1. Open in Xcode:
   ```
   flux-ios-experience/flux-ios-experience/flux-ios-experience.xcodeproj
   ```
2. Build & run on **iOS 16+** simulator or device
3. The project references `flux-ios-foundation` and `flux-ios-assets` as local packages

---

## Showcase Screens (29)

### Atoms

| Screen | Component | What It Demonstrates |
|--------|-----------|---------------------|
| FluxButtonShowcase | FluxButton | Primary, secondary, destructive variants; small/medium/large sizes; loading & disabled states |
| FluxTextShowcase | FluxText | All 11 text styles from largeTitle to caption |
| FluxAttributedTextShowcase | FluxText | Bold, italic, underline, strikethrough, custom colors, URL segments |
| FluxIconShowcase | FluxIcon | SF Symbols, asset images, URL loading; size & color options |
| FluxLoaderShowcase | FluxLoader | Indeterminate spinner, determinate progress bar; 3 sizes |
| FluxDividerShowcase | FluxDivider | Horizontal & vertical; color & thickness variations |
| FluxCheckBoxShowcase | FluxCheckBox | Filled & outlined; all sizes; animated toggle |
| FluxToggleShowcase | FluxToggle | Native toggle with labels; sizes & tint colors |
| FluxSegmentedControlShowcase | FluxSegmentedControl | Filled & outlined styles; dynamic segment counts |
| FluxRadioButtonShowcase | FluxRadioButton | Single-select groups; sizes & colors |
| FluxImageShowcase | FluxImage | System, asset, URL sources; borders & corner radius |
| FluxShimmerShowcase | FluxShimmer | Line, circle, rectangle shapes; text block & card helpers |

### Molecules

| Screen | Component | What It Demonstrates |
|--------|-----------|---------------------|
| FluxCardShowcase | FluxCard | Padding, corner radius, shadow variations |
| FluxTextFieldShowcase | FluxTextField | Label, placeholder, secure input, error states |
| FluxListRowShowcase | FluxListRow | Icon, title, subtitle, chevron; tap actions |
| FluxAlertViewShowcase | FluxAlertView | Info, success, warning, error variants; dismissible |
| FluxInfoViewShowcase | FluxInfoView | Horizontal & vertical layouts; icon colors |
| FluxOptionCardShowcase | FluxOptionCard | Single & multi selection; icon + label + subtitle |
| FluxExpandableViewShowcase | FluxExpandableView | Card, plain, bordered styles; expand/collapse |
| FluxFlapViewShowcase | FluxFlapView | Underlined, filled, pill tab styles; icon tabs |
| FluxCardFlapShowcase | FluxCardFlap | 3D flip animation; front & back content |
| FluxBoxGridShowcase | FluxBoxGrid | Grid columns, selection modes, item sizes |

### Organisms

| Screen | Component | What It Demonstrates |
|--------|-----------|---------------------|
| FluxHeaderShowcase | FluxHeader | Title, subtitle, leading/trailing actions |
| FluxBottomSheetShowcase | FluxBottomSheet | Small, medium, large detents; drag-to-dismiss |
| FluxFormSectionShowcase | FluxFormSection | Grouped form fields with section titles |
| FluxGraphShowcase | FluxGraph | Bar, line, pie charts; animated data visualization |
| FluxWebViewShowcase | FluxWebView | URL loading, progress bar, error handling |

---

## App Structure

```
flux-ios-experience/
|-- README.md
|-- LICENSE
+-- flux-ios-experience/
    |-- flux-ios-experience.xcodeproj
    +-- flux-ios-experience/
        |-- flux_ios_experienceApp.swift   (app entry point)
        |-- ContentView.swift              (master navigation)
        |-- FluxButtonShowcase.swift
        |-- FluxTextShowcase.swift
        |-- FluxAttributedTextShowcase.swift
        |-- FluxIconShowcase.swift
        |-- FluxLoaderShowcase.swift
        |-- FluxDividerShowcase.swift
        |-- FluxCheckBoxShowcase.swift
        |-- FluxToggleShowcase.swift
        |-- FluxSegmentedControlShowcase.swift
        |-- FluxRadioButtonShowcase.swift
        |-- FluxImageShowcase.swift
        |-- FluxShimmerShowcase.swift
        |-- FluxCardShowcase.swift
        |-- FluxTextFieldShowcase.swift
        |-- FluxListRowShowcase.swift
        |-- FluxAlertViewShowcase.swift
        |-- FluxInfoViewShowcase.swift
        |-- FluxOptionCardShowcase.swift
        |-- FluxExpandableViewShowcase.swift
        |-- FluxFlapViewShowcase.swift
        |-- FluxCardFlapShowcase.swift
        |-- FluxBoxGridShowcase.swift
        |-- FluxHeaderShowcase.swift
        |-- FluxBottomSheetShowcase.swift
        |-- FluxFormSectionShowcase.swift
        |-- FluxGraphShowcase.swift
        +-- FluxWebViewShowcase.swift
```

---

## Dependencies

| Package | Purpose |
|---------|---------|
| [flux-ios-foundation](../flux-ios-foundation) | All UI components + design tokens |
| [flux-ios-assets](../flux-ios-assets) | Strings, images, and localized resources |

---

## License

MIT License - Copyright (c) 2026 Afzal Siddiqui
