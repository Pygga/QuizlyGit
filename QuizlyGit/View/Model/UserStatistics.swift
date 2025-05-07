struct UserStatistics: Codable {
    var totalPlayTime: Int = 0
    var fastestQuiz: Int = 0
    var slowestQuiz: Int = 0
    var gamesPlayed: Int = 0
    var questionsAnswered: Int = 0
    var totalScore: Int = 0
    var hintsUsed: Int = 0
}