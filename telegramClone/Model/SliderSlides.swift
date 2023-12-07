//
//  SliderSlides.swift
//  telegramClone
//
//  Created by Egor Rybin on 19.06.2023.
//

import Foundation


class SliderSlides {
    func getSlides()->[Slides] {
        var slides: [Slides] = []
        let slide1 = Slides(id: 1, text: "Text1", image: #imageLiteral(resourceName: "IMG-4077"))
        let slide2 = Slides(id: 2, text: "Text2", image: #imageLiteral(resourceName: "IMG-4076"))
        let slide3 = Slides(id: 3, text: "Text3", image: #imageLiteral(resourceName: "IMG-4078"))

        slides.append(slide1)
        slides.append(slide2)
        slides.append(slide3)
        
        return slides
    }
}
