import Foundation

/// Модель данных для ответа сервера с массивом закусок
struct AppetizerResponse: Decodable {
    
    /// Массив закусок/аппетайзеров
    let request: [AppetizerDTO]
}
