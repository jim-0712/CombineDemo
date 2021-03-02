//
//  SimpleDemoViewController.swift
//  CombineDemo
//
//  Created by Fu Jim on 2021/2/26.
//

import UIKit
import Combine

struct Message {
    let message: String
    let content: String
}

class SimpleDemoViewController: UIViewController {
    
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(tapOnSwitch(sender:)), for: .valueChanged)
        return switcher
    }()
    
    let tapButton: UIButton = {
       let button = UIButton()
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapOnButton(sender:)), for: .touchUpInside)
        return button
    }()
    
    @Published var canSendMessage: Bool = false
    private var switchSubscription: AnyCancellable?
    private var child = SimpleChildViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCombine()
    }

    private
    func setupView() {
        self.view.backgroundColor = .systemBackground
        view.addSubview(switcher)
        NSLayoutConstraint.activate([
            switcher.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            switcher.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            switcher.widthAnchor.constraint(equalToConstant: 50),
            switcher.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.view.addSubview(tapButton)
        NSLayoutConstraint.activate([
            tapButton.topAnchor.constraint(equalTo: switcher.bottomAnchor, constant: 30),
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.widthAnchor.constraint(equalToConstant: 100),
            tapButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        addChild(child)
        child.view.frame = CGRect(x: 0,
                                  y: UIScreen.main.bounds.height / 2,
                                  width: UIScreen.main.bounds.width,
                                  height: 200)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    private
    func setupCombine() {
        switchSubscription = $canSendMessage
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: tapButton)
    }
    
    @objc
    func tapOnSwitch(sender: UISwitch) {
        canSendMessage = sender.isOn
    }
    
    @objc
    func tapOnButton(sender: UIButton) {
        let message = Message(message: "現在時間是：", content: "\(Date())")
        NotificationCenter.default.post(name: .newMessage, object: message)
    }
    
}
