import SwiftUI

/// Представление пустого состояния (плейсхолдер при отсутствии данных).
///
/// `EmptyState` используется в экранах, где может отсутствовать контент (например, список заказов или закусок).
/// Показывает иконку и текст, соответствующие типу пустого состояния.
///
/// Отображает:
/// - Иллюстрацию (по имени из `EmptyStateType.imageName()`),
/// - Сообщение (по тексту из `EmptyStateType.message()`).
///
/// - Пример использования:
/// ```swift
/// EmptyState(type: .orders)
/// ```
struct EmptyState: View {

    /// Тип пустого состояния, определяет отображаемое изображение и сообщение.
    let type: EmptyStateType

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea(.all)
            VStack {
                Image(type.imageName())
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                Text(type.message())
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .offset(y: -50)
        }
    }
}

#Preview {
    EmptyState(type: .orders )
}
