//
//  ViewController.swift
//  FlashCardBruh
//
//  Created by Jeremy Warren on 9/11/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var japaneseTextLabel: UILabel!
    @IBOutlet weak var englishTextLabel: UILabel!
    var flashCard: FlashCard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        englishTextLabel.text = flashCard?.english
        japaneseTextLabel.text = flashCard?.japanese
        
    }

}

