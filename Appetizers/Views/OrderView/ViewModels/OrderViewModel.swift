import SwiftUI

/// ViewModel для управления списком выбранных закусок (заказом).
///
/// `OrderViewModel` используется для хранения и управления состоянием текущего заказа пользователя.
/// Предоставляет методы добавления и удаления товаров, а также вычисляет общую стоимость заказа.
///
/// Использует `@Published` для автоматического обновления представлений при изменении данных.
///
/// - Свойства:
///   - items: Список закусок, добавленных в заказ.
///   - totalPrice: Вычисляемое свойство, возвращающее суммарную стоимость всех закусок.
///
/// - Методы:
///   - add(_:): Добавляет закуску в заказ.
///   - deleteItems(at:): Удаляет закуски по указанному индексу (используется с `.onDelete` в SwiftUI).
///
final class OrderViewModel: ObservableObject {
    
    /// Список закусок, добавленных в заказ.
    @Published var items: [AppetizerDTO] = []
    
    /// Общая сумма заказа, вычисляется как сумма цен всех закусок.
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    /// Добавляет новую закуску в заказ.
    ///
    /// - Parameter item: Объект `AppetizerDTO`, представляющий закуску.
    func add(_ item: AppetizerDTO) {
        items.append(item)
    }
    
    /// Удаляет элементы из заказа по переданным индексам.
    ///
    /// - Parameter offsets: Индексы элементов, которые нужно удалить.
    /// - Note: Используется в SwiftUI в паре с `.onDelete`.
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
