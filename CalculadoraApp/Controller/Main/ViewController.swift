//
//  ViewController.swift
//  CalculadoraApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 25/10/25.
//

import UIKit

final class ViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var myResult: UILabel!
    @IBOutlet weak var number0: UIButton!
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    @IBOutlet weak var number5: UIButton!
    @IBOutlet weak var number6: UIButton!
    @IBOutlet weak var number7: UIButton!
    @IBOutlet weak var number8: UIButton!
    @IBOutlet weak var number9: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    // Operators Outlets
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPlusMinus: UIButton!
    @IBOutlet weak var operatorPercentage: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var opeatorMinus: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    //Variables
    private var total:Double = 0
    private var temp:Double = 0 //Temporal
    private var operating = false
    private var decimal = false
    private var operation: OperationType = .none //Operacion actual
    
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLength = 9
    private let kTotal = "total"
    
    
    
    // Enum Constantes
    private enum OperationType {
        case none, addition, subtraction, multiplication, division, percent
    }
    
    //Formateo de valores auxiliar
    private let auxFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
  
        return formatter
    }()
    
    //Formateo de valores auxiliares totales
    private let auxTotalFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = ""
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 100
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 100
  
        return formatter
    }()
    
    
    //Formateo de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    //Formateo Scientifico
    private let printScientificFormatter: NumberFormatter = {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.maximumFractionDigits = 3
        formatter.exponentSymbol = "e"
        
        return formatter
        
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
        
        total = UserDefaults.standard.double(forKey: kTotal)
        
        result()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //UI
        
        number0.round()
        number1.round()
        number2.round()
        number3.round()
        number4.round()
        number5.round()
        number6.round()
        number7.round()
        number8.round()
        number9.round()
        numberDecimal.round()
        
        operatorAC.round()
        operatorPlusMinus.round()
        operatorPercentage.round()
        operatorResult.round()
        operatorAddition.round()
        opeatorMinus.round()
        operatorMultiplication.round()
        operatorDivision.round()
        
    }
    
    
    
    //Actions Buttons
    
    @IBAction func actionAC(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func actionPlusMinus(_ sender: UIButton) {
        temp = temp * (-1)
        myResult.text = printFormatter.string(from: NSNumber(value: temp))
        
        sender.shine()
    }
    
    @IBAction func actionPercentage(_ sender: UIButton) {
        if operation != .percent{
            result()
        }
        operating = true
        operation = .percent
        result()
 
        sender.shine()
    }
    
    @IBAction func actionResult(_ sender: UIButton) {
        result()
        sender.shine()
    }
    
    @IBAction func actionAddition(_ sender: UIButton) {
        
        if operation != .none{
            result()
            
        }
       
        operating = true
        operation = .addition
        sender.selectOperation(true)
        sender.shine()
    }
    
    @IBAction func actionMinus(_ sender: UIButton) {
        
        if operation != .none{
            result()
            
        }
        
        operating = true
        operation = .subtraction
        
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func actionMultiplication(_ sender: UIButton) {
        
        if operation != .none{
            result()
            
        }
        
        operating = true
        operation = .multiplication
        
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    @IBAction func actionDivision(_ sender: UIButton) {
        
        if operation != .none{
            result()
            
        }
        
        operating = true
        operation = .division
        
        sender.selectOperation(true)
        
        sender.shine()
    }
    
    //Action Number Buttons
    @IBAction func actionNumberDecimal(_ sender: UIButton) {
        
        let currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        myResult.text = myResult.text! + kDecimalSeparator
        decimal = true
        
        selectVisualOperation()
        
        sender.shine()
    }
    
    @IBAction func actionNumber(_ sender: UIButton) {
        
        operatorAC.setTitle("C", for: .normal)
        
        var currentTemp = auxTotalFormatter.string(from: NSNumber(value: temp))!
        
        if !operating && currentTemp.count >= kMaxLength {
            return
        }
        
        currentTemp = auxFormatter.string(from: NSNumber(value: temp))!
        
        //Operacion
        if operating{
            total = total == 0 ? temp : total
            myResult.text = ""
            currentTemp = ""
            operating = false
            
        }
        
        // Operacion Decimal
        if decimal{
            currentTemp = "\(currentTemp)\(kDecimalSeparator)"
            decimal = false
        }
        
        let number = sender.tag
        temp = Double(currentTemp + String(number))!
        myResult.text = printFormatter.string(from: NSNumber(value: temp))
        
        selectVisualOperation()
        
        sender.shine()
        
    }
    
    
    // ------  FUNCTIONS -----
    
    //Limpia los valores
    private func clear(){
        
    
        if temp != 0 {
            
            temp = 0
            total = 0
            myResult.text = "0"
            print("Total: \(total)")
           
        }else {
            total = 0
            result()
            
        }
        
        operation = .none
        
        operatorAC.setTitle("AC", for: .normal)
        
        
        
    }
    
    //Obtiene el resultado final
    private func result(){
        
        switch operation{
        
        case .none:
            //No hacemos nada
            break
        case .addition:
            total = total + temp
            break
        case .subtraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        
        }
        
        //Formateo en pantalla
        if let currentTotal = auxTotalFormatter.string(from: NSNumber(value: total)), currentTotal.count > kMaxLength{
            myResult.text = printScientificFormatter.string(from: NSNumber(value: total))
        }else{
            myResult.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        operation = .none
        
        selectVisualOperation()
        
        UserDefaults.standard.set(total, forKey: kTotal)
        
    
        print("Total: \(total)")
    }
    
    //Muestra de forma visual la operacion seleccionada
    private func selectVisualOperation(){
        
        if !operating{
            //No estamos operando
            operatorAddition.selectOperation(false)
            opeatorMinus.selectOperation(false)
            operatorMultiplication.selectOperation(false)
            operatorDivision.selectOperation(false)
            
            
        }else{
            switch operation {
            
            
                
            case .none, .percent:
                operatorAddition.selectOperation(false)
                opeatorMinus.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .addition:
                operatorAddition.selectOperation(true)
                opeatorMinus.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .subtraction:
                operatorAddition.selectOperation(false)
                opeatorMinus.selectOperation(true)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(false)
                break
            case .multiplication:
                operatorAddition.selectOperation(false)
                opeatorMinus.selectOperation(false)
                operatorMultiplication.selectOperation(true)
                operatorDivision.selectOperation(false)
                break
            case .division:
                operatorAddition.selectOperation(false)
                opeatorMinus.selectOperation(false)
                operatorMultiplication.selectOperation(false)
                operatorDivision.selectOperation(true)
                break
                

            
            }
        }
        
    }
    
    
    
    
    
    
}

