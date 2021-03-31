//
//  ViewController.swift
//  Magic 8 Ball
//
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVAudioPlayer()
    var randomArray = [#imageLiteral(resourceName: "lee"),#imageLiteral(resourceName: "jason"),#imageLiteral(resourceName: "dustin"),#imageLiteral(resourceName: "willie"),#imageLiteral(resourceName: "charles"),#imageLiteral(resourceName: "michael"),#imageLiteral(resourceName: "eric"),#imageLiteral(resourceName: "megan")]
    var randNum:UIImage!
    var arrayKey:Int!
    var playBoo = true
    
    @IBOutlet weak var imageView: UIImageView!

    @IBAction func askButtonPressed(_ sender: UIButton) {
        if (randomArray.count > 1) {
            let randImageNumber = Int.random(in: 0...(randomArray.count-1))
            randNum = randomArray[randImageNumber]
            Animations.requireUserAtencion(on: imageView)
            imageView.image = randNum
            if (randImageNumber == 0 && playBoo == true) {
                playBooingSound()
                playBoo = false
            } else if (randomArray.count > 4) {
                playHappySound()
            } else {
                playSadSound()
            }
            randomArray.remove(at: randImageNumber)
        } else if (randomArray.count == 1) {
            Animations.requireUserAtencion(on: imageView)
            imageView.image = randomArray[0]
            playSadSound()
            randomArray.remove(at: 0)
        } else {
            Animations.requireUserAtencion(on: imageView)
            playBooingSound()
            imageView.image = #imageLiteral(resourceName: "blank")
        }
    }
    
    func playSadSound() {
        let path = Bundle.main.path(forResource: "sad-clap", ofType : "wav")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print ("There is an issue with this code!")
        }
    }
    
    func playHappySound() {
        let path = Bundle.main.path(forResource: "happy-clap", ofType : "wav")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print ("There is an issue with this code!")
        }
    }
    
    func playBooingSound() {
        let path = Bundle.main.path(forResource: "booing", ofType : "wav")!
        let url = URL(fileURLWithPath : path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.play()
        } catch {
            print ("There is an issue with this code!")
        }
    }

}

class Animations {
    static func requireUserAtencion(on onView: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: onView.center.x - 10, y: onView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: onView.center.x + 10, y: onView.center.y))
        onView.layer.add(animation, forKey: "position")
    }
}

