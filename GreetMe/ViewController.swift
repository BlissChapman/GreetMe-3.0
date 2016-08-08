//
//  ViewController.swift
//  GreetMe
//
//  Created by Bliss Chapman on 8/7/16.
//  Copyright © 2016 Bliss Chapman. All rights reserved.
//

import UIKit
import UserNotifications

final class ViewController: UIViewController {

    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var greetingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction private func sayHiTapped(_ sender: UIButton) {
        nameTextField.resignFirstResponder()

        guard let name = nameTextField.text, name.characters.count >= 1 else {
            greetingLabel.text = "Please enter your name in the text field."
            return
        }

        greetingLabel.text = "Hi, \(name)!"


        //get the notification center
        let center = UNUserNotificationCenter.current()

        //request authorization to issue the user notifications
        center.requestAuthorization(options: [.alert]) { (granted, error) in

            guard granted else {
                self.greetingLabel.text = "For a full introduction, please adjust your notification preferences."
                return
            }

            guard error == nil else {
                // handle the error if needed
                debugPrint(error!)
                return
            }

            // create the notification content
            let greetingNotificationContent = UNMutableNotificationContent()
            greetingNotificationContent.title = "Hi, \(name)!"
            greetingNotificationContent.body = "It was a pleasure to meet you and I hope to see you again soon! - ❤️ CocoaNuts ❤️ "

            // create the notification trigger
            let greetingNotificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)

            // create the notification request
            let greetingNotification = UNNotificationRequest(identifier: "Greeting", content: greetingNotificationContent, trigger: greetingNotificationTrigger)

            // add the notification request to the notification center
            center.add(greetingNotification) { error in

                guard error == nil else {
                    // handle the error if needed
                    debugPrint(error!)
                    return
                }

                print("Notification scheduled!")
            }
        }
    }

}

