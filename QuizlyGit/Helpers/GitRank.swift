enum GitRank: String, CaseIterable {
    case newcomer = "Новичок"
    case contributor = "Контрибьютор"
    case maintainer = "Мейнтейнер"
    case architect = "Архитектор"
    case maestro = "Маэстро"
    case legend = "Git-Легенда"
    
    var requiredScore: Int {
        switch self {
        case .newcomer: return 0
        case .contributor: return 1000
        case .maintainer: return 5000
        case .architect: return 15000
        case .maestro: return 30000
        case .legend: return 50000
        }
    }
    
    var icon: String {
        switch self {
        case .newcomer: return "🌱"
        case .contributor: return "👨💻"
        case .maintainer: return "🛠️"
        case .architect: return "🏗️"
        case .maestro: return "🎻"
        case .legend: return "🏆"
        }
    }
}