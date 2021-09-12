//
//  TableViewController.swift
//  FlashCardBruh
//
//  Created by Jeremy Warren on 9/11/21.
//
import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Flash Card Bruh", message: "", preferredStyle: .alert)
        
        alert.addTextField{textField in
            textField.placeholder = "English"
        }
        alert.addTextField{textField in
            textField.placeholder = "Japanese"
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            
            guard let englishField = alert.textFields?.first,
                  let japaneseField = alert.textFields?.last else { return }
            
            let english = englishField.text ?? "No English"
            let japanese = japaneseField.text ?? "なし"
            
            FlashCardManager.shared.createFlashCard(english: english, japanese: japanese)
            
            self.tableView.reloadData()
        }
        alert.addAction(cancelButton)
        alert.addAction(saveButton)
        
        present(alert, animated: true)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlashCardManager.shared.flashCards.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flashCardCell", for: indexPath)
        
        let flashCard = FlashCardManager.shared.flashCards[indexPath.row]
        
        cell.textLabel?.text = flashCard.english
        
        return cell
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let flashCard = FlashCardManager.shared.flashCards[indexPath.row]
            FlashCardManager.shared.delete(flashCard: flashCard)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showFlashCardSegue",
              
              let indexPath = tableView.indexPathForSelectedRow,
              
              let destination = segue.destination as? ViewController else { return }
        
        let flashCard = FlashCardManager.shared.flashCards[indexPath.row]
        
        destination.flashCard = flashCard
        
    }
    
}
