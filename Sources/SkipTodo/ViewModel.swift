import Foundation
import Observation
import SkipFuse

@Observable public class ViewModel {
    var todos: [Todo] = loadTodos() {
        didSet { saveTodos() }
    }

    init() {
    }

    func addTodo(title: String) {
        let todo = Todo(title: title)
        todos.insert(todo, at: 0)
    }

    func toggleStatus(_ todo: Todo) {
        todos = todos.map { t in
            t.id == todo.id ? Todo(id: t.id, title: t.title, isDone: !t.isDone) : t
        }
    }

    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

struct Todo: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var isDone: Bool

    init(id: UUID = UUID(), title: String = "", isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}

extension ViewModel {
    private static let savePath = URL.applicationSupportDirectory.appendingPathComponent("todos.json")

    fileprivate static func loadTodos() -> [Todo] {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode([Todo].self, from: data)
        } catch {
            return []
        }
    }

    fileprivate func saveTodos() {
        do {
            let data = try JSONEncoder().encode(todos)
            try FileManager.default.createDirectory(at: URL.applicationSupportDirectory, withIntermediateDirectories: true)
            try data.write(to: ViewModel.savePath)
        } catch {
            logger.error("Kaydetme hatası: \(error)")
        }
    }
}
