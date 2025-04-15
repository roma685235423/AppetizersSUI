import SwiftUI

/// Представление для отображения изображения с фолбэком.
///
/// Если переданное изображение (`image`) не `nil`, отображает его в виде `.resizable()`.
/// В противном случае отображает плейсхолдер с именем `"appetizerPlaceholder"`.
///
/// Используется как обёртка для упрощённого отображения загружаемых изображений.
struct RemoteImage: View {

    /// Изображение для отображения (может быть `nil`).
    var image: Image?

    var body: some View {
        image?.resizable() ?? Image("appetizerPlaceholder").resizable()
    }
}
