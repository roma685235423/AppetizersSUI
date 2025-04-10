import SwiftUI

/// ViewModel для экрана списка закусок (`AppetizerListView`).
///
/// `AppetizerListViewModel` отвечает за загрузку данных, управление состояниями загрузки и ошибок,
/// а также предоставляет данные для отображения в UI.
///
/// Использует `@Published` свойства для автоматического обновления привязанных View.
///
/// - Свойства:
///   - appetizers: Список загруженных закусок.
///   - isShowingAlert: Флаг, отображается ли в данный момент алерт.
///   - alertItem: Модель текущего алерта. Установка значения активирует `isShowingAlert = true`.
///   - isLoading: Флаг загрузки. Используется для отображения индикатора.
///
/// - Методы:
///   - getAppetizers(): Загружает список закусок через `NetworkManager`, обрабатывает результат и ошибки.
///
/// - Пример использования в SwiftUI:
/// ```swift
/// @StateObject private var viewModel = AppetizerListViewModel()
///
/// List(viewModel.appetizers) { appetizer in
///     Text(appetizer.name)
/// }
/// .onAppear {
///     viewModel.getAppetizers()
/// }
/// .alert(item: $viewModel.alertItem) { alert in
///     Alert(title: alert.title, message: alert.message, dismissButton: .default(Text("OK")))
/// }
/// ```
final class AppetizerListViewModel: ObservableObject {
    
    /// Список загруженных закусок.
    @Published var appetizers: [AppetizerDTO] = []
    
    /// Флаг, указывающий, нужно ли отобразить алерт.
    @Published var isShowingAlert = false
    
    /// Текущий алерт, который нужно отобразить.
    /// При установке значения автоматически активирует флаг `isShowingAlert`.
    @Published var alertItem: AlertItem? {
        didSet {
            isShowingAlert = true
        }
    }
    
    /// Флаг загрузки. Используется для отображения индикатора загрузки.
    @Published var isLoading = false
    
    /// Загружает список закусок с сервера.
    ///
    /// Использует `NetworkManager.shared.getAppetizers`, обрабатывает результат:
    /// - В случае успеха — сохраняет полученные данные в `appetizers`.
    /// - В случае ошибки — заполняет `alertItem` соответствующим сообщением.
    func getAppetizers() {
        isLoading = true
        NetworkManager.shared.getAppetizers { result in
            DispatchQueue.main.async { [weak self]  in
                self?.isLoading = false
                switch result {
                case .success(let appetizers):
                    self?.appetizers = appetizers
                case .failure(let error):
                    self?.alertItem = error.alertItem()
                }
            }
        }
    }
}
