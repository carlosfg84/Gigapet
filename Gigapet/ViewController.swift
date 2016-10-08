//
//  ViewController.swift
//  Gigapet
//
//  Created by Carlos Flores Guardado on 9/26/16.
//  Copyright © 2016 Carlos Flores Guardado. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var penalty1: UIImageView!
    @IBOutlet weak var penalty2: UIImageView!
    @IBOutlet weak var penalty3: UIImageView!
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem:UInt32 = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        penalty1.alpha = DIM_ALPHA
        penalty2.alpha = DIM_ALPHA
        penalty3.alpha = DIM_ALPHA
        
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDropped(_:)), name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = OPAQUE
        heartImg.userInteractionEnabled = true
        
        startTimer()
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func itemDropped(notif: AnyObject) {
        if currentItem == 0 {
            sfxBite.play()
        } else {
            sfxHeart.play()
        }
        
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
    }
    
    func changeGameState() {
        if !monsterHappy {
            sfxSkull.play()
            penalties+=1
            
            if penalties == 1 {
                penalty1.alpha = OPAQUE
            } else if penalties == 2 {
                penalty1.alpha = OPAQUE
                penalty2.alpha = OPAQUE
            } else {
                penalty1.alpha = OPAQUE
                penalty2.alpha = OPAQUE
                penalty3.alpha = OPAQUE
            }
        }
        
        if penalties >= MAX_PENALTIES {
            gameOver()
            return
        }
        
        let rand = arc4random_uniform(2)
        currentItem = rand
        
        if rand == 0 {
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
        } else {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        }
        
        monsterHappy = false
        
    }
    
    func gameOver() {
        musicPlayer.stop()
        sfxDeath.play()
        timer.invalidate()
        monsterImg.playDeathAnimation()
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
    }
}



