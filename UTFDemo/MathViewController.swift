//
//  MathViewController.swift
//  UTFDemo
//
//  Created by Catalin Patrascu on 15.02.2023.
//

import UIKit

final class MathViewController: UIViewController {

    @IBOutlet weak var txtFirstTerm: UITextField!
    @IBOutlet weak var txtSecondTerm: UITextField!
    @IBOutlet weak var txtResult: UITextField!
        
    private let viewModel: MathViewModel
        
    init(viewModel: MathViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func tapAdd(_ sender: Any) {
        let result = viewModel.add(txtFirstTerm.text, and: txtSecondTerm.text)
        txtResult.text = "\(result)"
    }
    
    @IBAction func tapSubstract(_ sender: Any) {
        let result = viewModel.substract(txtFirstTerm.text, and: txtSecondTerm.text)
        txtResult.text = "\(result)"
    }
}
