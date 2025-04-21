/// Перечисление типов пустых состояний.
///
/// Используется для определения отображаемого изображения и текста в `EmptyState`.
///
/// - Cases:
///   - `orders`: Пустой список заказов.
///   - `appetizer`: Пустой список закусок.
enum EmptyStateType {
    
    /// Пустое состояние для заказов.
    case orders
    
    /// Пустое состояние для закусок.
    case appetizer

    /// Возвращает имя изображения, соответствующее типу состояния.
    ///
    /// - Returns: Название изображения из ассетов.
    func imageName() -> String {
        switch self {
        case .orders:
            return "ordersPlaceholder"
        case .appetizer:
            return "appetizerPlaceholder"
        }
    }

    /// Возвращает сообщение, отображаемое при данном типе пустого состояния.
    ///
    /// - Returns: Текст сообщения.
    func message() -> String {
        switch self {
        case .orders:
            return "Заказов пока нет"
        case .appetizer:
            return "Закусок пока нет"
        }
    }
}
