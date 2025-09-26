import Foundation
import NetworkingManager

struct EpisodesModel: Hashable {
    let name: String
    let episodeNumber: String
    let episodeSeason: String
    let releaseDate: String

    init(from episode: WebDTO.Episode) {
        self.name = episode.name

        let episodeParts = episode.episode.split(separator: "E")
        if episodeParts.count == 2 {
            let seasonPart = String(episodeParts[0].dropFirst()) 
            self.episodeSeason = "Season \(seasonPart)"
            self.episodeNumber = "Episode \(episodeParts[1])"
        } else {
            self.episodeSeason = episode.episode
            self.episodeNumber = ""
        }
        self.releaseDate = episode.airDate
    }
}
