
import SwiftUI

struct ContentView: View {

  let items = (1...10000).map { "Item \($0)" }
  let columns = [GridItem(.adaptive(minimum: 80))]

  var body: some View {
    ScrollView {

      let _ = print("SCROLL VIEW")
      let _ = Self._printChanges()

      LazyVGrid(columns: columns, spacing: 20) {

        let _ = print("LAZY VGRID")
        let _ = Self._printChanges()

        ForEach(items, id: \.self) { item in
          Text(item)
        }
      }
    }
  }
}


#Preview {
  ContentView()
}
