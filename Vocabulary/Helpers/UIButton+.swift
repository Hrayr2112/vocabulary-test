//
//  UIButton+.swift
//  Vocabulary
//
//  Created by Gevorg Avetisyan on 07.04.25.
//

import UIKit

extension UIButton {
    func setupStyle() {
        setTitleColor(.black, for: .normal)
        backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
        titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        layer.cornerRadius = 24
        clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 1
        layer.shadowRadius = 8
    }
}
