import SwiftUI

struct ToastModifier: ViewModifier {
    let message: String
    let isShowing: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                Text(message)
                    .padding()
                    .background(Color.black.opacity(1))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            // Code to hide the toast after 2 seconds
                        }
                    }
            }
        }
    }
}

extension View {
    func toast(message: String, isShowing: Bool) -> some View {
        self.modifier(ToastModifier(message: message, isShowing: isShowing))
    }
}
