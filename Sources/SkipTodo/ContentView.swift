import SwiftUI

struct ContentView: View {
    @State var viewModel = ViewModel()
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
                    
                    HStack(spacing: 12) {
                        ZStack(alignment: .leading) {
                            if newTodoTitle.isEmpty {
                                Text("Yeni todo ekle...")
                                    .font(.body)
                                    .foregroundStyle(Color.white.opacity(0.4))
                                    .padding(.horizontal, 12)
                            }
                            TextField("", text: $newTodoTitle)
                                .textFieldStyle(.plain)
                                .font(.body)
                                .foregroundStyle(.white)
                                .tint(.white)
                                .padding(.horizontal, 12)
                                #if SKIP
                                .padding(.vertical, 0)
                                #else
                                .padding(.vertical, 0)
                                #endif
                        }
                        #if SKIP
                        .padding(.vertical, 10)
                        #else
                        .frame(height: 44)
                        #endif
                        .background(Color(red: 0.18, green: 0.18, blue: 0.28))
                        .cornerRadius(12)
                        .colorScheme(.dark)
                        
                        Button {
                            guard !newTodoTitle.isEmpty else { return }
                            viewModel.addTodo(title: newTodoTitle)
                            newTodoTitle = ""
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .foregroundStyle(Color(red: 1.0, green: 0.5, blue: 0.1))
                        }
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.todos) { todo in
                                HStack {
                                    Button {
                                        viewModel.toggleStatus(todo)
                                    } label: {
                                        Text(todo.isDone ? "✓" : "○")
                                            .font(.title2)
                                            .foregroundStyle(todo.isDone ? Color(red: 1.0, green: 0.5, blue: 0.1) : Color.white.opacity(0.5))
                                    }
                                    
                                    Text(todo.title)
                                        .strikethrough(todo.isDone)
                                        .foregroundStyle(todo.isDone ? .gray : .white)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Button {
                                        if let index = viewModel.todos.firstIndex(where: { $0.id == todo.id }) {
                                            viewModel.delete(at: IndexSet([index]))
                                        }
                                    } label: {
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
                    }
                }
                .padding(.top)
            }
            .environment(viewModel)
        }
    }
}

