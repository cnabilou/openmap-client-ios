//
//  ivViewController.swift
//  OpenPokeMap
//
//  Created by Jamie Bishop on 04/09/2016.
//  Copyright © 2016 nullpixel Development. All rights reserved.
//

import UIKit

class ivViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var PokemonName: UITextField!
    @IBOutlet weak var PokemonCP: UITextField!
    @IBOutlet weak var PokemonHP: UITextField!
    @IBOutlet weak var PokemonDustPrice: UITextField!
    @IBOutlet weak var PoweredUpSwitch: UISwitch!

    func calcIV() {
        let pokemon = PokemonName.text
        let CP = Int(PokemonCP.text!)
        let HP = Int(PokemonHP.text!)
        let dustPrice = Int(PokemonDustPrice.text!)
        let poweredUp = PoweredUpSwitch.isOn
        let enabled = false
        
        if enabled {
            if pokemon?.isEmpty ?? true || CP == nil || HP == nil || dustPrice == nil {
                let alertController = UIAlertController(title: "Error", message: "You did not fill out all the fields.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                alertController.show()
            } else {
                CalculateIV().doEquation(for: pokemon, CP: CP!, HP: HP!, dustPrice: dustPrice!, poweredUp: poweredUp)
            }
        } else {
            let alertController = UIAlertController(title: "Error", message: "Error parsing pokemon. Ensure all fields are filled out.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            alertController.show()
        }
    }
    
    @IBAction func userTappedBackground(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        cell.selectedBackgroundView = selectionView
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.white.withAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            let color = UIColor.white.withAlphaComponent(0.5)
            view.detailTextLabel?.textColor = color
            view.textLabel?.textColor = color
        }
    }
    
    func initializeTextFields() {
        PokemonName.delegate = self
        PokemonName.keyboardType = UIKeyboardType.asciiCapable
        
        PokemonCP.delegate = self
        PokemonCP.keyboardType = UIKeyboardType.numberPad
        
        PokemonHP.delegate = self
        PokemonHP.keyboardType = UIKeyboardType.numberPad
        
        PokemonDustPrice.delegate = self
        PokemonDustPrice.keyboardType = UIKeyboardType.numberPad
    }
    
    // MARK: UITextFieldDelegate events and related methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.characters.count == 0 {
            return true
        }
        
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        switch textField {

        case PokemonName:
            return prospectiveText.characters.count <= 20
        case PokemonCP:
            return prospectiveText.containsOnlyCharactersIn("0123456789") &&
                prospectiveText.characters.count < 4
        case PokemonHP:
            return prospectiveText.containsOnlyCharactersIn("0123456789") &&
                prospectiveText.characters.count <= 4
        case PokemonDustPrice:
            return prospectiveText.containsOnlyCharactersIn("0123456789") &&
                prospectiveText.characters.count <= 4
        default:
            return true
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 1 {
            calcIV()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor().HexToColor("#36393E", alpha: 1.0)
        self.tableView.backgroundColor = UIColor().HexToColor("#36393E", alpha: 1.0)
        initializeTextFields()
    }
    
    
}
