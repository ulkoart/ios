//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Anton Nazarov on 28.03.2020.
//  Copyright © 2020 Anton Nazarov. All rights reserved.
//

import RealmSwift

protocol CharacterRepository {
    func save(_ characters: [Character])
    func getCharacters() -> Results<CharacterRealm>
}

final class CharacterRepositoryImpl: CharacterRepository {
    var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Realm can't be created")
        }
    }

    func save(_ characters: [Character]) {
        let characters = characters.map(CharacterRealm.init(character:))
        try? realm.write {
            realm.add(characters, update: .modified)
        }
    }

    func getCharacters() -> Results<CharacterRealm> {
        realm.objects(CharacterRealm.self)
    }
}
