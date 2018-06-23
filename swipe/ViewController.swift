//
//  ViewController.swift
//  swipe
//
//  Created by Akshat Aggarwal on 16/06/18.
//  Copyright © 2018 Akshat Aggarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var lable: UILabel!

  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    view.isUserInteractionEnabled = true
    lable.text = "Blink"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewDidAppear(_ animated: Bool) {
    var contentSize: CGFloat = CGFloat(0.0);
    for x in 0...2 {
      // Create a reference to a image
      let image = UIImage(named: "icon\(x).png")
      // Now create a imageView with that image
      let imgView = UIImageView(image: image)

      // Add the imgView to the scrollView
      scrollView.addSubview(imgView)

      // Now set the position of the newly added UIImageView
      let newX: CGFloat = scrollView.frame.size.width / 2 + scrollView.frame.size.width * CGFloat(x)
      contentSize += newX;
      imgView.frame = CGRect(x: newX - 75, y: (scrollView.frame.size.height / 2) - 75, width: 150, height: 150)
    }
    // We have added all the images to the scrollView
    // Now set the content size of the ScrolView
    scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(3), height: scrollView.frame.size.height)

    // Now set the view visible outside the bounds of the scrollView also
    scrollView.clipsToBounds = false

    // Enable the paging of the scrollView
    scrollView.isPagingEnabled = true

    // Disable the scrolling of the scrollView sice we are using the scroll from SwipeGesture
    scrollView.isScrollEnabled = false
  }

  // This function if connected to both right and left swipe recognizers
  @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
    if sender.state == .ended {
      if sender.direction == .left {
        print("swiped left")
        moveScrollView(direction: 1)
      }
      if sender.direction == .right {
        print("swiped right")
        moveScrollView(direction: -1)
      }
      lable.isHidden = !lable.isHidden
    }
  }

  // Function to move the scrollView right or left
  // direction = 1: to move scrollView to right
  // direction = -1: to move scrollView to left

  func moveScrollView(direction: Int) -> Void {
    // move right
    if direction == 1 {
      var temp = scrollView.contentOffset
      temp.x += scrollView.frame.size.width
      if temp.x < scrollView.contentSize.width {
        scrollView.setContentOffset(temp, animated: true)
      }

    } else if direction == -1 {
      var temp = scrollView.contentOffset
      temp.x -= scrollView.frame.size.width
      if temp.x >= 0 {
        scrollView.setContentOffset(temp, animated: true)
      }
    }
  }
}

