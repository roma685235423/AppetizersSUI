import SwiftUI

/// Кастомная кнопка для приложения.
///
/// `APButton` представляет собой переиспользуемую кнопку с фиксированным стилем:
/// - закруглённые углы,
/// - фон `brandPrimary`,
/// - белый текст,
/// - фиксированный размер.
///
/// Используется во всех основных экранах, где требуется однородный внешний вид кнопок.
///
/// - Пример использования:
/// ```swift
/// APButton(title: "Сохранить")
/// ```
struct APButton: View {
    
    /// Локализованный заголовок кнопки.
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundStyle(.white)
            .background(.brandPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    APButton(title: "title")
}
