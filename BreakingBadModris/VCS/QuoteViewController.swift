//
//  QuoteViewController.swift
//  BreakingBadModris
//
//  Created by Modris Ozols on 16/01/2020.
//  Copyright © 2020 Modris Ozols. All rights reserved.
//

import UIKit
import MOBreakingBadAPI

class QuoteViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideShareButton()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @IBAction func shareQuote(_ sender: UIBarButtonItem) {
        if let quote = quoteLabel.text, let author = authorLabel.text {
            let text = "\"\(quote)\" // \(author),"

            // set up activity view controller
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func showShareButton(){
        shareBtn.isEnabled = true
        shareBtn.tintColor = nil
    }

    func hideShareButton(){
        shareBtn.isEnabled = false
        shareBtn.tintColor = .clear
    }
    
}
