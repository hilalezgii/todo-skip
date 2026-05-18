import SwiftUI

struct TodoRow: View {
    let todo: Todo
    let onToggle: () -> Void
    let onDelete: () -> Void
    let onUpdate: (String) -> Void
    
    @State var isEditing = false
    @State var editingText = ""

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
            
            Button {
                            editingText = todo.title // Alert açılmadan önce input'un içine mevcut metni koy
                            isEditing = true
                        } label: {
                            Image(systemName: "pencil")
                                .font(.title2)
                                .foregroundStyle(.blue)
                        }
                        .padding(.trailing, 4)

            Button(action: onDelete) {
                Image(systemName: "trash.fill")
                    .foregroundStyle(.red.opacity(0.7))
            }
        }
        .padding()
        .background(Color.white.opacity(0.07))
        .cornerRadius(12)
        .padding(.horizontal)
        
        .alert("Todo Düzenle", isPresented: $isEditing) {
                    TextField("Yeni başlık...", text: $editingText)
                    
                    Button("Vazgeç", role: .cancel) {
                        editingText = ""
                    }
                    
                    Button("Kaydet") {
                        guard !editingText.isEmpty else { return }
                        onUpdate(editingText) // Yeni metni ContentView'a fırlatıyoruz
                    }
                } message: {
                    Text("Lütfen görev için yeni bir isim girin.")
                }
            }
    }

