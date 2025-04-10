import SwiftUI

/// View-компонент для загрузки и отображения изображения закуски по URL.
///
/// Использует `ImageLoader` как `@StateObject` для асинхронной загрузки изображения.
/// При отображении вызывает `load(fromURLString:)`, а сам UI обновляется через `RemoteImage`.
///
/// - Параметры:
///   - urlString: URL-строка для загрузки изображения.
///
/// - Пример использования:
/// ```swift
/// AppetizerRemoteImage(urlString: "https://example.com/image.jpg")
/// ```
struct AppetizerRemoteImage: View {

    /// Объект загрузчика изображений.
    @StateObject var imageLoader = ImageLoader()

    /// URL-строка изображения.
    let urlString: String

    var body: some View {
        RemoteImage(image: imageLoader.image)
            .onAppear {
                imageLoader.load(fromURLString: urlString)
            }
    }
}
