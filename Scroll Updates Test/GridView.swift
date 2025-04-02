import SwiftUI

struct ColumnLayout: Equatable, Hashable {
  fileprivate let count: Int
}

extension ColumnLayout {
  static let one = ColumnLayout(count: 1)
  static let two = ColumnLayout(count: 2)
  static let three = ColumnLayout(count: 3)
}

extension ColumnLayout {
  func toggle() -> ColumnLayout {
    switch count {
    case 3: ColumnLayout(count: 1)
    default: ColumnLayout(count: count + 1)
    }
  }
}

struct Spacing: Equatable, Hashable {
  fileprivate let amount: Double
}

extension Spacing {
  static let xxs = Spacing(amount: 2)
  static let s = Spacing(amount: 8)
  static let ms = Spacing(amount: 12)
}

struct CardGrid<Content: View>: View {

  init(
    layout: ColumnLayout,
    spacing: Spacing,
    @ViewBuilder content: () -> Content
  ) {
    self.layout = layout
    self.spacing = spacing
    self.content = content()
  }

  private let layout: ColumnLayout
  private let spacing: Spacing
  private let content: Content
  private var columns: [GridItem] {
    Array(
      repeating: GridItem(spacing: spacing.amount, alignment: .top),
      count: layout.count
    )
  }

  var body: some View {
    VStack(spacing: .zero) {
      LazyVGrid(columns: columns, spacing: spacing.amount) {
        content
      }
    }
  }
}
