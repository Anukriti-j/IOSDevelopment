import SwiftUI

struct HomeView: View {
    @StateObject var groceryViewModel = GroceryViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // Grocery List
                VStack {
                    HStack {
                        Spacer()
                        Text("Your Grocery List")
                            .padding()
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .background(Color.blue)
                    GroceryListView()
                        .listStyle(.automatic)
                }
                
                // Add Button
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .padding(.bottom, 10)
                    }
                }
                .sheet(isPresented: $showingSheet, content: {
                    SheetView(showingSheet: $showingSheet)
                        .presentationDetents([.medium, .large])
                        .padding()
                })
            }
        }
        .environmentObject(groceryViewModel)
    }
}

#Preview {
    HomeView()
}
