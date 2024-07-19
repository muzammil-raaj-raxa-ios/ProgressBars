

//
//  ViewController.swift
//  ProgressBarTest
//
//  Created by Mag isb-10 on 18/07/2024.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var analogProgressBar: UIProgressView!
  @IBOutlet weak var digitalProgressBar: UIProgressView!
  
  var displayLink: CADisplayLink!
  var duration: TimeInterval = 5.0
  var startTime: CFTimeInterval!
  var timer : Timer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    digitalProgressBar.isHidden = true
    digitalProgressBar.progress = 5.0
    analogProgressBar.isHidden = true
    analogProgressBar.progress = 5.0
  }
  
  @IBAction func digitalStartBtn(_ sender: Any) {
    digitalProgressBar.isHidden = false
    startAnimation()
    digitalProgressBar.progress = 5.0
    print("START BTN PRESS")
  }
  
  @IBAction func analogStartBtn(_ sender: Any) {
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(analogProgressBarUpdate), userInfo: self, repeats: true)
    analogProgressBar.isHidden = false
    analogProgressBar.progress = 5.0
    print("START BTN PRESS")
  }
  
  func startAnimation() {
    startTime = CACurrentMediaTime()
    displayLink = CADisplayLink(target: self, selector: #selector(digitalProgressBarUpdate))
    displayLink.add(to: .main, forMode: .default)
  }
  
  @objc func digitalProgressBarUpdate() {
    let elapsedTime = CACurrentMediaTime() - startTime
    let progress = Float(1.0 - (elapsedTime / duration))
    digitalProgressBar.setProgress(progress, animated: true)
    print(digitalProgressBar.progress)
    if progress <= 0 {
      displayLink.invalidate()
      print("Finished")
    }
  }
  
  @objc func analogProgressBarUpdate() {
    analogProgressBar.progress = analogProgressBar.progress - 0.1
    print(analogProgressBar.progress)
    if analogProgressBar.progress == 0.0 {
      timer.invalidate()
      print("Finished")
    }
  }
  
}

