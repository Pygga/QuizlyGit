// MARK: - Модели данных
struct AppSettings: Codable {
    var language: String = "ru"
    var notificationsEnabled: Bool = true
    var theme: String = "system"
}