import SwiftUI

struct ContentView: View {
    @State var data: [Country] = []
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hello, world!")
            List {
                ForEach(viewModel.countries, id: \.country) { country in
                    Text(country.country)
                }
            }
        }
        .task {
            do {
                try await viewModel.loadData()
            } catch NetworkError.invalidURL {
                print("invalid url")
            } catch NetworkError.invalidResponse {
                print("invalid Response ")
            } catch NetworkError.invalidData {
                print("invalid Data ")
            } catch {
                print(" unexpected error")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
