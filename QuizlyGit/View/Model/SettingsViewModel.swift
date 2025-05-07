// MARK: - Обновленный SettingsViewModel
class SettingsViewModel: ObservableObject {
    @Published var settings = AppSettings()
    @Published var currentUser: Profile
    @Published var isLoading = false
    
    private let firestoreService = FirestoreService.shared
    private var userId: String
    
    init() {
        guard let user = Auth.auth().currentUser else {
            fatalError("User not authenticated")
        }
        self.userId = user.uid
        self.currentUser = Profile(
            id: user.uid,
            name: user.displayName ?? "",
            email: user.email ?? "",
            score: 0
        )
    }
    
    func loadData() async {
        isLoading = true
        do {
            async let settings = firestoreService.getSettings(userId: userId)
            async let stats = firestoreService.getStatistics(userId: userId)
            
            let (loadedSettings, loadedStats) = await (try settings, try stats)
            
            await MainActor.run {
                self.settings = loadedSettings
                self.currentUser.score = loadedStats.totalScore
            }
        } catch {
            print("Error loading data: \(error)")
        }
        isLoading = false
    }
    
    func saveSettings() async {
        do {
            try await firestoreService.updateSettings(userId: userId, settings: settings)
        } catch {
            print("Error saving settings: \(error)")
        }
    }
}