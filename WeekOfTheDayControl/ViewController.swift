//
//  ViewController.swift
//  WeekOfTheDayControl
//
//  Created by Artemy Ozerski on 23/06/2022.
//

import UIKit
//https://github.com/bartjacobs/HowToCreateACustomControlUsingABitmask
class ViewController: UIViewController {
    @IBOutlet weak var wod: Wod!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    fileprivate func setupView() {
        // Setup Schedule Picker
        setupSchedulePicker()
    }

    fileprivate func setupSchedulePicker() {
        // Fetch Stored Value
        let scheduleRawValue = UserDefaults.standard.integer(forKey: UserDefaults.Keys.schedule)

        // Configure Schedule Picker
        wod.schedule = Schedule(rawValue: scheduleRawValue)
    }

    // MARK: - Actions
    @IBAction func scheduleDidChange(_ sender: Wod) {
        // Helpers
        let userDefaults = UserDefaults.standard

        // Store Value
        let scheduleRawValue = sender.schedule.rawValue
        userDefaults.set(scheduleRawValue, forKey: UserDefaults.Keys.schedule)
        userDefaults.synchronize()
        print("\(scheduleRawValue)")
    }

}

extension UserDefaults {

    enum Keys {

        static let schedule = "schedule"

    }

}

