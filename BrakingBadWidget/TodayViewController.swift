//
//  TodayViewController.swift
//  BrakingBadWidget
//
//  Created by Modris Ozols on 16/01/2020.
//  Copyright © 2020 Modris Ozols. All rights reserved.
//

import UIKit
import NotificationCenter
import MOBreakingBadAPI

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var author: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    var apiController = MOBreakingBadAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideLabels()
        self.quote.numberOfLines = 3
        self.quote.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.quote.sizeToFit()
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        self.activityIndicator.startAnimating()
        self.apiController.getRandomQuote { (quote) in
            DispatchQueue.main.async {
                self.author.text = quote?.author
                self.quote.text = quote?.quote
                self.showLabels()
                self.activityIndicator.stopAnimating()
            }
        }
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func hideLabels(){
        self.author.text = ""
        self.quote.text = ""
        self.author.isEnabled = false
        self.quote.isEnabled = false
    }
    
    func showLabels(){
        self.author.isEnabled = true
        self.quote.isEnabled = true
    }
}
