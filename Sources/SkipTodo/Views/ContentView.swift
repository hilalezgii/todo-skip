import SwiftUI

struct ContentView: View {
    @State var store = TodoStore()
    @State var newTodoTitle = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.1, green: 0.1, blue: 0.2)
                    .ignoresSafeArea()

                VStack(spacing: 16) {
                    HStack {
                        Text("Todo")
                            .font(.largeTitle.bold())
                            .foregroundStyle(Color(red: 1.0, green: 0.5, blue: 0.1))
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    TodoInput(text: $newTodoTitle) {
                        guard !newTodoTitle.isEmpty else { return }
                        store.add(title: newTodoTitle)
                        newTodoTitle = ""
                    }

                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(store.todos) { todo in
                                TodoRow(
                                    todo: todo,
                                    onToggle: { store.toggle(todo) },
                                    onDelete: {
                                        if let index = store.todos.firstIndex(where: { $0.id == todo.id }) {
                                            store.delete(at: IndexSet([index]))
                                        }
                                    },
                                    onUpdate: { newTitle in
                                        store.update(id: todo.id, newTitle: newTitle)
                                    }
                                )
                            }
                        }
                    }
                }
                .padding(.top)
            }
            .environment(store)
        }
    }
}
