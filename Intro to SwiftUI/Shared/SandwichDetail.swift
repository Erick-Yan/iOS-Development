import SwiftUI

struct SandwichDetail: View {
    var sandwich: Sandwich
    @State private var zoomed = false

    var body: some View {
        VStack {
            Spacer(minLength: 0)

            // Sandwich Image.
            Image(sandwich.imageName)
                .resizable()
                .aspectRatio(contentMode: zoomed ? .fill : .fit)
                .onTapGesture {
                    withAnimation {
                        zoomed.toggle()
                    }
                }
            
            Spacer(minLength: 0)

            // Spicy Banner.
            if sandwich.isSpicy && !zoomed {
                HStack {
                    Spacer()
                    Label("Spicy", systemImage: "flame.fill")
                    Spacer()
                }
                .padding(.all)
                .font(Font.headline.smallCaps())
                .background(Color.red)
                .foregroundColor(.yellow)
                .transition(.move(edge: .bottom))
            }
        }
        .navigationTitle(sandwich.name) /// Must be within a NavigationView.
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SandwichDetail_Previews: PreviewProvider {
    static var previews: some View {
        /// Display multiple canvas views.
        Group {
            NavigationView {
                SandwichDetail(sandwich: testData[0])
            }
            NavigationView {
                SandwichDetail(sandwich: testData[1])
            }
        }
    }
}