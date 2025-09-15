struct BiographyModel: Hashable {
    let photo: String
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: String

    init(from character: CharacterModel) {
        self.photo = character.image
        self.name = character.name
        self.status = character.status
        self.species = character.species
        self.type = character.type
        self.gender = character.gender
        self.origin = character.origin
    }
}
