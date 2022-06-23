//
//  Wod.swift
//  WeekOfTheDayControl
//
//  Created by Artemy Ozerski on 23/06/2022.
//

import UIKit
struct Schedule: OptionSet {

    let rawValue: Int

    static let monday       = Schedule(rawValue: 1 << 0)
    static let tuesday      = Schedule(rawValue: 1 << 1)
    static let wednesday    = Schedule(rawValue: 1 << 2)
    static let thursday     = Schedule(rawValue: 1 << 3)
    static let friday       = Schedule(rawValue: 1 << 4)
    static let saturday     = Schedule(rawValue: 1 << 5)
    static let sunday       = Schedule(rawValue: 1 << 6)

    static let weekend: Schedule    = [.saturday, .sunday]
    static let weekdays: Schedule   = [.monday, .tuesday, .wednesday, .thursday, .friday]

}

class Wod: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setBackground()
        setupButtons()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setBackground()
        setupButtons()
      }
    private func setBackground(){
        self.backgroundColor = .systemBackground

    }

    private func configure(){

    }
    var schedule: Schedule = []{
        didSet{
            updateView()
        }
    }

    private var buttons : [UIButton] = []

    private enum Color{
        static let selected = UIColor.white
        static let tint = UIColor(displayP3Red: 1, green: 0.37, blue: 0.3, alpha: 1)
        static let normal = UIColor.black//UIColor(red:0.2, green:0.25, blue:0.3, alpha:1.0)

    }
    private func updateView(){
        updateButtons()
    }
    private func setupButtons(){
        for title in ["Mon", "Tue", "Wed", "Thu","Fri", "Sat", "Sun"]{
            let button = UIButton(type: .system)

//            button.layer.borderWidth = 1
//            button.layer.borderColor = UIColor.gray.cgColor
            button.tintColor = Color.tint
            button.setTitleColor(Color.normal, for: .normal)
            button.setTitleColor(Color.selected, for: .selected)
            button.setTitle(title, for: .selected)
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(toggleSchedule(_:)), for: .touchUpInside)
            buttons.append(button)
        }
        let stackView = UIStackView(arrangedSubviews: buttons)
        self.addSubview(stackView)
        // Configure Stack View
        stackView.spacing = 8.0
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.gray.cgColor
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Add Constraints
        topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
    }

    private func updateButtons(){
        buttons[0].isSelected = schedule.contains(.monday)
        buttons[1].isSelected = schedule.contains(.tuesday)
        buttons[2].isSelected = schedule.contains(.wednesday)
        buttons[3].isSelected = schedule.contains(.thursday)
        buttons[4].isSelected = schedule.contains(.friday)
        buttons[5].isSelected = schedule.contains(.saturday)
        buttons[6].isSelected = schedule.contains(.sunday)

    }

    @objc func toggleSchedule(_ sender: UIButton){
        guard let index = buttons.firstIndex(of: sender) else {return}
        let element : Schedule.Element

        switch index{
        case 0: element = .monday
        case 1: element = .tuesday
        case 2: element = .wednesday
        case 3: element = .thursday
        case 4: element = .friday
        case 5: element = .saturday
        default: element = .sunday
        }
        if schedule.contains(element){
            schedule.remove(element)
        }else {
            schedule.insert(element)
        }
        updateButtons()
        sendActions(for: .valueChanged)
    }
}
