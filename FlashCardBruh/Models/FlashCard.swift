import Foundation


class FlashCard: Codable {
    var english: String
    var japanese: String
    
    init(english: String, japanese: String){
        self.english = english
        self.japanese = japanese
    }
}

extension FlashCard: Equatable {
    static func == (lhs: FlashCard, rhs: FlashCard) -> Bool{
    return lhs.english == rhs.english &&
           lhs.japanese == rhs.japanese
}
}
