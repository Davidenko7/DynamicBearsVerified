//
//  PauseViewController.swift
//  DynamicBears
//
//  Created by Marco Davide Fioretto on 12/12/17.
//  Copyright © 2017 Davide Maimone. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController, TimerDelegate{

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    var snapshot: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.image = snapshot
        loadBlurredImage()
        scoreLabel.text = SessionController.score.description
                Singleton.shared.delegate = self
        
        //        scoreLabel.text = SessionController.score.description
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Singleton.shared.delegate = nil
    }
    
    func loadBlurredImage () {
        //        let transition: CATransition = CATransition()
        //        transition.duration = 1
        //        transition.timingFunction = backgroundView
        self.backgroundView.addBlurEffect()
    }
    
    
    
    @IBAction func goBackToStart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "mainstart") as UIViewController
        SessionController.newGame()
        self.present(controller, animated: false, completion: nil)
        SessionController.score=0
        SessionController.lives=3
//        Singleton.shared.resetButtonTapped()
    }
    @IBAction func restartGame(_ sender: Any) {
        SessionController.newGame()
        let storyboard = UIStoryboard(name: "CardViewer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CardViewerController") as UIViewController
        self.present(controller, animated: false, completion: nil)
        
        SessionController.score = 0
        SessionController.lives = 3
//        Singleton.shared.runTimer()
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "InfoScreen", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InfoScreenViewController") as UIViewController
        
        self.present(controller, animated: true, completion: nil)
        
    }

    
    @IBAction func buttonPressed(_ sender: Any) {
        
        if Singleton.shared.resumeTapped == false {
            Singleton.shared.timer.invalidate()
            Singleton.shared.resumeTapped = true
        } else {
            Singleton.shared.runTimer()
            Singleton.shared.resumeTapped = false
        }
        
        self.dismiss(animated: false, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerElapsed() {
        
    }
    
    func reset() {
        
    }

}

extension UIImageView
{
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}

