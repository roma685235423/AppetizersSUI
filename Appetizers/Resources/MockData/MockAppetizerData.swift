import Foundation

/// Модель с тестовыми данными закусок для предварительного просмотра и тестирования
struct MockAppetizerData {
    
    /// Тестовый экземпляр закуски
    static let sampleAppetizer = AppetizerDTO(
        id: 00001,
        name: "Test Appetizer",
        description: "This is the description for my test appetizer",
        price: 9.999566,
        imageURL: "",
        calories: 99,
        protein: 99,
        carbs: 99
    )
    
    /// Массив тестовых закусок (4 одинаковых экземпляра)
    static let appetizers = Array(repeating: sampleAppetizer, count: 25)
}
