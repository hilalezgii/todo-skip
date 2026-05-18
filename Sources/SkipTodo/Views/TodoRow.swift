import SwiftUI

struct TodoRow: View {
    let todo: Todo
    let onToggle: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack {
            Button(action: onToggle) {
                Text(todo.isDone ? "✓" : "○")
                    .font(.title2)
                    .foregroundStyle(
                        todo.isDone
                            ? Color(red: 1.0, green: 0.5, blue: 0.1)
                            : Color.white.opacity(0.5)
                    )
            }

            Text(todo.title)
                .strikethrough(todo.isDone)
                .foregroundStyle(todo.isDone ? .gray : .white)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundStyle(.red.opacity(0.7))
            }
        }
        .padding()
        .background(Color.white.opacity(0.07))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
