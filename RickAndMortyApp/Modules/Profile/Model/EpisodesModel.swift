struct EpisodesModel: Hashable {
    let name: String
    let episodeNumber: String
    let episodeSeason: String
    let releaseDate: String

    init(from episode: Episode) {
        self.name = episode.name

        // Разбираем код эпизода (например, "S01E01")
        let episodeParts = episode.episode.split(separator: "E")
        if episodeParts.count == 2 {
            let seasonPart = String(episodeParts[0].dropFirst()) // Убираем 'S'
            self.episodeSeason = "Season \(seasonPart)"
            self.episodeNumber = "Episode \(episodeParts[1])"
        } else {
            self.episodeSeason = episode.episode
            self.episodeNumber = ""
        }
        self.releaseDate = episode.air_date
        print("Created EpisodesModel: \(self.name), \(self.episodeSeason), \(self.episodeNumber), \(self.releaseDate)")

    }
}
