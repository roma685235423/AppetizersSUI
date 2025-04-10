import SwiftUI

/// Класс для загрузки изображений по URL и преобразования их в SwiftUI `Image`.
///
/// Используется в SwiftUI для асинхронной загрузки изображений из сети.
/// Хранит загруженное изображение как `@Published`, чтобы UI автоматически обновлялся.
///
/// - Свойства:
///   - image: Загруженное изображение (`Image?`). Обновляется после успешной загрузки.
///
/// - Методы:
///   - load(fromURLString:): Загружает изображение по строке URL через `NetworkManager`.
final class ImageLoader: ObservableObject {

    /// Загруженное изображение. При изменении автоматически обновляет SwiftUI View.
    @Published var image: Image?

    /// Загружает изображение по заданному URL.
    ///
    /// - Parameter urlSrting: Строка с URL изображения.
    /// - Discussion: Использует `NetworkManager` для получения `UIImage`, затем
    /// преобразует его в `Image` и сохраняет в `@Published image` на главном потоке.
    func load(fromURLString urlSrting: String) {
        NetworkManager.shared.downloadImage(from: urlSrting) { uiImage in
            guard let uiImage else { return }

            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                image = Image(uiImage: uiImage)
            }
        }
    }
}
