

protocol ProvidesProfile {
    func fetchEpisodes() async throws -> [EpisodesModel]
}

struct ProfileProvider: ProvidesProfile {
    func fetchEpisodes() -> [EpisodesModel] { //async throws
        array1 //try await
    }
}

let array1 = [mock1, mock2, mock3, mock4, mock5, mock6, mock7, mock8, mock9, mock10, mock11]
fileprivate let mock1 = EpisodesModel(name: "name1", episodeNumber: "num1", episodeSeason: "season1", releaseDate: "date1")
fileprivate let mock2 = EpisodesModel(name: "name2", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock3 = EpisodesModel(name: "name3", episodeNumber: "num3", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock4 = EpisodesModel(name: "name4", episodeNumber: "num4", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock5 = EpisodesModel(name: "name5", episodeNumber: "num5", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock6 = EpisodesModel(name: "name6", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock7 = EpisodesModel(name: "name7", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock8 = EpisodesModel(name: "name8", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock9 = EpisodesModel(name: "name9", episodeNumber: "num2", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock10 = EpisodesModel(name: "name10", episodeNumber: "num10", episodeSeason: "season2", releaseDate: "date2")
fileprivate let mock11 = EpisodesModel(name: "name11", episodeNumber: "num11", episodeSeason: "season2", releaseDate: "date2")
