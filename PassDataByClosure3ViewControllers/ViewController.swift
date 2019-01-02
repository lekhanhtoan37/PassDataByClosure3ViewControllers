//
//  ViewController.swift
//  PassDataByClosure3ViewControllers
//
//  Created by Toan on 12/3/18.
//  Copyright © 2018 Toan. All rights reserved.
//  CHECKED


import UIKit
typealias closure = (_ data : String?) -> ()
class ViewControllerA: UIViewController, SmartDelegate {
    @IBOutlet weak var textFieldA : UITextField!
    var vcC = ViewControllerC()
    var passDataFromA: closure?
    var stringA : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func updateData(data: String?) {
        textFieldA.text = data
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vcB = segue.destination as! ViewControllerB
        vcB.passDataFromB = { [unowned self] data in
            self.textFieldA.text = data
            
        }
        passDataFromA = { [unowned self] data in
            vcB.stringB = data
        }
        passDataFromA?(textFieldA.text)
        
    }
    
    
}

class ViewControllerB: UIViewController {
    @IBOutlet weak var textFieldB : UITextField!
    var stringB : String?
    var passDataFromB : closure?
    var receiveDataFromB : closure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if stringB != nil {
            textFieldB.text = stringB
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vcC = segue.destination as? ViewControllerC else { return }
        vcC.receiveDataFromC = passDataFromB
        passDataFromB = { [unowned self] data in
            vcC.stringC = data
        }
        passDataFromB?(textFieldB.text)
//        vcC.receiveDataFromC = { [unowned self] data in
//            self.textFieldB.text = data
//        }
        
    }
}

protocol SmartDelegate: class {
    func updateData(data : String?)
}

class ViewControllerC: UIViewController {
    @IBOutlet weak var textFieldC : UITextField!
    var stringC : String?
    var delegate : SmartDelegate?
    var receiveDataFromC : closure?
    override func viewDidLoad() {
        super.viewDidLoad()
        if stringC != nil {
            textFieldC.text = stringC
        }
    }
    // MARK: Navigation
    
    @IBAction func popback(_ sender : UIButton){
        receiveDataFromC?(textFieldC.text)
        navigationController?.popToRootViewController(animated: true)
    }
}
