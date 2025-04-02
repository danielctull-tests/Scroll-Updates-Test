import SwiftUI

struct ContentView: View {

  @State private var layout = ColumnLayout.two
  @State private var visibleItems: [Int: Anchor<CGRect>] = [:]

  let items = (1...10_000)
  let max = 10_000
  let columns = [GridItem(.adaptive(minimum: 80))]

  var body: some View {
    let _ = Self._printChanges()
    ScrollViewReader { proxy in
      ScrollView {
        CardGrid(layout: layout, spacing: .ms) {

          ForEach(items, id: \.self) { item in
            ItemView(item: item, max: max)
              .anchorPreference(key: VisibleItems.self, value: .bounds) {
                [item: $0]
              }
          }
        }
      }
      .onPreferenceChange(VisibleItems.self) { newValue in
        visibleItems = newValue
      }
      .toolbar {
        Button("Toggle") {
          layout = layout.toggle()
          print(visibleItems.keys.sorted())
          if let first = visibleItems.keys.sorted().first {
            proxy.scrollTo(first, anchor: .top)
          }
        }
      }
    }
  }
}

// MARK: - VisibleItems

/// PreferenceKey to track the visible items.
private struct VisibleItems<ID: Hashable>: PreferenceKey {
  static var defaultValue: [ID: Anchor<CGRect>] { [:] }
  static func reduce(value: inout Value, nextValue: () -> Value) {
    value.merge(nextValue(), uniquingKeysWith: { $1 })
  }
}

// MARK: - Item

struct ItemView: View {
  let item: Int
  let max: Int
  var body: some View {
    Text("Item \(item)")
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        Color(hue: Double(item) / Double(max), saturation: 1, brightness: 1),
        in: RoundedRectangle(cornerRadius: 12),
      )
  }
}

// MARK: - Preview

#Preview {
  ContentView()
}
