
import SwiftUI

struct ContentView: View {

  private static let scrollToTopID = UUID()
  let items = (1...10000).map { "Item \($0)" }
  let columns = [GridItem(.adaptive(minimum: 80))]

  var body: some View {
    ScrollViewReader { proxy in

      ScrollView {

        let _ = print("SCROLL VIEW")
        let _ = print("\(proxy)")
        let _ = Self._printChanges()

        Spacer()
          .frame(height: 1)
          .id(ContentView.scrollToTopID)

        VStack(spacing: .zero) {
          LazyVGrid(columns: columns, spacing: 20) {
            
            let _ = print("LAZY VGRID")
            let _ = Self._printChanges()
            
            ForEach(items, id: \.self) { item in
              Text(item)
            }
            .onAppear {
              proxy.scrollTo(ContentView.scrollToTopID, anchor: .bottom)
            }
          }
        }
      }
    }
  }
}


#Preview {
  ContentView()
}
