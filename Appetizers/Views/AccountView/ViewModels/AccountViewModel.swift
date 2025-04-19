import SwiftUI

/// ViewModel для экрана профиля пользователя (`AccountView`).
///
/// `AccountViewModel` управляет состоянием формы профиля, проверкой введённых данных,
/// сохранением и загрузкой информации о пользователе через `@AppStorage`.
///
/// Также обрабатывает валидацию формы и отображение алертов при ошибках или успешных действиях.
///
/// - Свойства:
///   - user: Объект пользователя, содержащий редактируемые данные.
///   - alertItem: Модель текущего алерта. При установке автоматически активирует `isShowingAlert`.
///   - isShowingAlert: Флаг, указывающий, нужно ли отображать алерт.
///   - isValidForm: Вычисляемое свойство, проверяющее корректность заполненной формы.
///
/// - Методы:
///   - saveChanges(): Сохраняет текущие данные пользователя в `AppStorage`. Отображает алерт в случае успеха или ошибки.
///   - retrieveUserData(): Загружает сохранённые данные пользователя из `AppStorage`. Отображает алерт при ошибке.
///
/// - Пример использования:
/// ```swift
/// @StateObject private var viewModel = AccountViewModel()
///
/// Form {
///     TextField("First Name", text: $viewModel.user.firstName)
///     TextField("Last Name", text: $viewModel.user.lastName)
///     TextField("Email", text: $viewModel.user.email)
///     Button("Save", action: viewModel.saveChanges)
/// }
/// .onAppear {
///     viewModel.retrieveUserData()
/// }
/// .alert(item: $viewModel.alertItem) { alert in
///     Alert(title: alert.title, message: alert.message, dismissButton: .default(Text("OK")))
/// }
/// ```
final class AccountViewModel: ObservableObject {
    
    /// Текущий пользователь, отображаемый и редактируемый в форме.
    @Published var user = UserDTO()
    
    /// Закодированные пользовательские данные, сохраняемые в `UserDefaults`.
    @AppStorage("user") private var userData: Data?
    
    /// Текущий алерт, который нужно отобразить. При установке активирует флаг `isShowingAlert`.
    var alertItem: AlertItem? {
        didSet { isShowingAlert = true }
    }
    
    /// Флаг, указывающий, нужно ли отобразить алерт пользователю.
    @Published var isShowingAlert = false
    
    /// Проверяет корректность заполнения формы пользователя.
    ///
    /// - Проверяет, что все поля (`firstName`, `lastName`, `email`) заполнены.
    /// - Проверяет, что email является валидным.
    /// - В случае ошибки — заполняет `alertItem` соответствующим сообщением.
    ///
    /// - Returns: `true`, если форма корректна, иначе `false`.
    var isValidForm: Bool {
        guard !user.firstName.isEmpty, !user.lastName.isEmpty, !user.email.isEmpty else {
            alertItem = APError.invalidForm.alertItem()
            return false
        }
        
        guard user.email.isValidEmail else {
            alertItem = APError.invalidEmail.alertItem()
            return false
        }
        return true
    }
    
    /// Сохраняет изменения в `@AppStorage` при условии валидной формы.
    ///
    /// - При успешном сохранении отображает алерт об успехе.
    /// - В случае ошибки кодирования — отображает алерт об ошибке.
    func saveChanges() {
        guard isValidForm else { return }
        
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            alertItem = APError.userSaveSuccess.alertItem()
        } catch {
            alertItem = APError.invalidUserData.alertItem()
        }
    }
    
    /// Загружает данные пользователя из `@AppStorage`.
    ///
    /// - Если данные успешно загружены — обновляет `user`.
    /// - В случае ошибки — отображает алерт с описанием ошибки.
    func retrieveUserData() {
        guard let userData else { return }
        
        do {
            user = try JSONDecoder().decode(UserDTO.self, from: userData)
        } catch {
            alertItem = APError.invalidUserData.alertItem()
        }
    }
}
