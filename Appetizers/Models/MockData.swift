import Foundation

/// Модель с тестовыми данными закусок для предварительного просмотра и тестирования
struct MockData {
    
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
    static let appetizers = Array(repeating: sampleAppetizer, count: 0)
    
    static func orderItems() -> [AppetizerDTO] {
        var orders: [AppetizerDTO] = []
        for index in 1...Int.random(in: 3...5) {
            let sampleAppetizer = AppetizerDTO(
                id: 0000 + index,
                name: "Test Appetizer \(index)",
                description: "This is the description for my test appetizer #\(index)",
                price: Double.random(in: 5...20),
                imageURL: "",
                calories: Int.random(in: 30...350),
                protein: Int.random(in: 30...350),
                carbs: Int.random(in: 30...350)
                )
            orders.append(sampleAppetizer)
        }
        return orders
    }
}
