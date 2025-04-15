import SwiftUI

/// ViewModel для экрана списка закусок (`AppetizerListView`).
///
/// `AppetizerListViewModel` отвечает за:
/// - Загрузку списка закусок с сервера;
/// - Управление состоянием загрузки (`isLoading`);
/// - Обработку ошибок через `alertItem`;
/// - Управление выбором элемента и отображением детального экрана.
///
/// ViewModel использует `@Published` свойства, чтобы автоматически оповещать SwiftUI-представления об изменениях.
///
/// - Свойства:
///   - appetizers: Список загруженных закусок.
///   - isShowingAlert: Флаг, отображается ли в данный момент алерт.
///   - alertItem: Модель текущего алерта. Установка значения активирует `isShowingAlert = true`.
///   - isLoading: Флаг загрузки. Используется для отображения индикатора загрузки.
///   - isShowingDetailView: Флаг, указывающий, открыт ли экран с деталями выбранной закуски.
///   - selectedAppetizer: Выбранная закуска, данные которой отображаются в детальном представлении.
///
/// - Методы:
///   - getAppetizers(): Загружает список закусок через `NetworkManager`, обновляет `appetizers` или отображает ошибку.
///
/// - Пример использования:
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
    
    /// Флаг, указывающий, отображается ли детальный экран выбранной закуски.
    @Published var isShowingDetailView: Bool = false
    
    /// Выбранная закуска, данные которой используются для отображения в детальном экране.
    @Published var selectedAppetizer: AppetizerDTO?
    
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
