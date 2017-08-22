//
//  FrontViewController.swift
//  cardMaker
//
//  Created by Zenab Owaid on 8/17/17.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {



    //@IBOutlet weak var addNewCardButton: UIButton!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var MyView: UIView!
    @IBOutlet weak var viewCardsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        addNewCardButton.layer.cornerRadius = 5
//        addNewCardButton.layer.borderWidth = 1
//        addNewCardButton.layer.borderColor = UIColor.white.cgColor
        
        viewCardsButton.layer.cornerRadius = 5
        viewCardsButton.layer.borderWidth = 1
        viewCardsButton.layer.borderColor = UIColor.white.cgColor
        viewCardsButton.setBackgroundImage(UIImage(named: "images.png"), for: .normal)
            
        shadowView.layer.shadowColor = UIColor.black.cgColor
        //shadowView.layer.shadowOffset = CGSizeZero
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.cornerRadius = 8
        shadowView.layer.shadowRadius = 5
        
        
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        
        MyView.backgroundColor = UIColor.white
        MyView.layer.cornerRadius = 8
        MyView.layer.borderColor = UIColor.blue.cgColor
        MyView.layer.borderWidth = 1
        MyView.clipsToBounds = true
        
        //shadowView.addSubview(view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
