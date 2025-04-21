import SwiftUI

/// Кнопка закрытия (dismiss) в виде иконки `X`.
///
/// `XDismissButton` используется для закрытия модальных экранов, попов и алертов.
/// Визуально представляет собой круглую кнопку с белым фоном и чёрным `xmark`-иконкой.
///
/// Может быть обёрнут в `.onTapGesture` или использоваться вместе с `.toolbar`.
///
/// - Пример использования:
/// ```swift
/// XDismissButton()
///     .onTapGesture {
///         isPresented = false
///     }
/// ```
struct XDismissButton: View {
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .opacity(0.6)
            Image(systemName: "xmark")
                .frame(width: 44, height: 44)
                .imageScale(.small)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    XDismissButton()
}
