//
//  FlashCardManager.swift
//  FlashCardBruh
//
//  Created by Jeremy Warren on 9/11/21.
//

import Foundation

class FlashCardManager {
    static let shared = FlashCardManager()
    var flashCards: [FlashCard] = []
    var fileURL: URL {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        url.appendPathComponent("flashCards")
        url.appendPathExtension("json")
            return url
    
}

func createFlashCard(english: String, japanese: String) {
    let flashCard = FlashCard(english: english, japanese: japanese)
    flashCards.append(flashCard)
    saveFlashCards()
}
    
    private init() {
        loadFlashCards()
    }

private func loadFlashCards() {
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let flashCards = try decoder.decode([FlashCard].self, from: data)
        self.flashCards = flashCards
    } catch {
        print(error)
    }
}

func update(flashCard: FlashCard, newEnglish: String, newJapanese: String){
    flashCard.english = newEnglish
    flashCard.japanese = newJapanese
    saveFlashCards()
}

func delete(flashCard: FlashCard) {
    guard let index = flashCards.firstIndex(of: flashCard) else { return }
    flashCards.remove(at: index)
    saveFlashCards()
}

private func saveFlashCards() {
    do {
        let encoder = JSONEncoder()
        let data = try encoder.encode(flashCards)
        try data.write(to: fileURL)
    } catch {
        print(error)
    }
}

}
