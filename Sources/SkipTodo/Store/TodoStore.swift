import Foundation
import Observation
import SkipFuse

@Observable public class TodoStore {
    var todos: [Todo] = TodoStore.load() {
        didSet { save() }
    }

    public init() {}

    func add(title: String) {
        todos.insert(Todo(title: title), at: 0)
    }

    func toggle(_ todo: Todo) {
        todos = todos.map { t in
            t.id == todo.id ? Todo(id: t.id, title: t.title, isDone: !t.isDone) : t
        }
    }

    func delete(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
}

private extension TodoStore {
    static let savePath = URL.applicationSupportDirectory
        .appendingPathComponent("todos.json")

    static func load() -> [Todo] {
        do {
            let data = try Data(contentsOf: savePath)
            return try JSONDecoder().decode([Todo].self, from: data)
        } catch {
            return []
        }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(todos)
            try FileManager.default.createDirectory(
                at: URL.applicationSupportDirectory,
                withIntermediateDirectories: true
            )
            try data.write(to: TodoStore.savePath)
        } catch {
            logger.error("Kaydetme hatası: \(error)")
        }
    }
}
