//
//  UIButtonExtension.swift
//  CalculadoraApp
//
//  Created by EDGAR MIGUEL FLORES OVANDO on 27/10/25.
//

import UIKit

private let orange = UIColor(red: 254/255, green: 148/255, blue: 0/255, alpha: 1)

extension UIButton{
    
    //Borde Redondo
    func round(){
       
        //self.layer.cornerRadius = self.frame.width / 2.0
        //self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
                
    }
    
    //Brilla
    func shine(){
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }){(completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1.0
            })
        }
            
    }
    
    //Apariencia seleccion boton de operacion
    func selectOperation(_ selected: Bool){

        self.backgroundColor = selected ? .white : orange
        self.configuration?.baseForegroundColor = selected ? orange : .white
                 
        
    }
    
    
        
}
