import Foundation

/// Модель данных для представления закуски/аппетайзера в приложении.
///
/// Соответствует структуре данных, получаемой с сервера (DTO - Data Transfer Object).
/// Поддерживает протоколы:
/// - `Decodable` - для парсинга из JSON
/// - `Identifiable` - для использования в SwiftUI списках и ForEach
struct AppetizerDTO: Decodable, Identifiable {
    
    /// Уникальный идентификатор закуски
    let id: Int
    /// Название закуски
    let name: String
    /// Описание состава и характеристик закуски
    let description: String
    /// Цена за единицу продукта
    let price: Double
    /// Ссылка на изображение продукта
    let imageURL: String
    /// Количество калорий
    let calories: Int
    /// Количество белка (в граммах)
    let protein: Int
    /// Количество углеводов (в граммах)
    let carbs: Int
}
