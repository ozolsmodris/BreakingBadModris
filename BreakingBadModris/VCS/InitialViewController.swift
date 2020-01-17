//
//  InitialViewController.swift
//  BreakingBadModris
//
//  Created by Modris Ozols on 17/01/2020.
//  Copyright © 2020 Modris Ozols. All rights reserved.
//

import UIKit
import MOBreakingBadAPI

class InitialViewController: UIViewController {

    var apiController = MOBreakingBadAPI()
    var characters: [Character] = []
    let dispatchGroup = DispatchGroup()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        apiController.getAllCharacters { (characters) in
            if type(of: characters) == [Character].self {
                self.characters = characters
                DispatchQueue.main.async {
                    self.characters = characters
                    self.performSegue(withIdentifier: "toCharacterList", sender: nil)
                }
            }
            else {
                print("Character is nil!!!")
            }
            
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCharacterList",
            let showView = segue.destination as? CharacterList {
            showView.navigationItem.hidesBackButton = true
            showView.characters = self.characters
                
        }
    }
}
