//
//  CharacterList.swift
//  BreakingBadModris
//
//  Created by Modris Ozols on 14/01/2020.
//  Copyright © 2020 Modris Ozols. All rights reserved.
//

import UIKit
import MOBreakingBadAPI

class CharacterList: UITableViewController {
    
    
    var characters: [Character] = []
    var apiController = MOBreakingBadAPI()
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillTable()
    }
    
    @IBAction func refresh(_ sender: UIRefreshControl) {
        fillTable()
        dispatchGroup.notify(queue: .main) {
            sender.endRefreshing()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        cell.textLabel?.text = self.characters[indexPath.row].name
        return cell
    }
    
    func fillTable() {
        dispatchGroup.enter()
        apiController.getAllCharacters { (characters) in
            if type(of: characters) == [Character].self {
                self.characters = characters
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.dispatchGroup.leave()
                }
            }
            else {
                print("Character is nil!!!")
            }
            
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSpecificQuote",
            let showView = segue.destination as? QuoteViewController,
            let row = tableView.indexPathForSelectedRow?.row {
                apiController.getQuote(from: self.characters[row].name) { (quote) in
                    showView.hideShareButton()
                    DispatchQueue.main.async {
                        showView.authorLabel.text = self.characters[row].name
                        if let quote = quote {
                            showView.quoteLabel.text = quote.quote
                            showView.showShareButton()
                        } else {
                            showView.quoteLabel.text = "No quotes found"
                        }
                        showView.activityIndicator.stopAnimating()
                    }
                }
        } else if segue.identifier == "toRandomQuote",
            let showView = segue.destination as? QuoteViewController {
                apiController.getRandomQuote { (quote) in
                    showView.hideShareButton()
                    DispatchQueue.main.async {
                        showView.authorLabel.text = quote?.author
                        showView.quoteLabel.text = quote?.quote
                        showView.showShareButton()
                        showView.activityIndicator.stopAnimating()
                    }
                }
        }
    }
}
