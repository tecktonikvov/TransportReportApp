//
//  KingFisher.swift
//  MyFondTransportnie
//
//  Created by Mac on 23.01.2021.
//

import Foundation
import Kingfisher

struct KingFisher {
    
    static func downloadOdometerImages(currentTrip: Trip, startImageView: UIImageView, finishImageView: UIImageView){
        let startUrlString = currentTrip.odometer_start_img_url
        let endUrlString = currentTrip.odometer_end_img_url
        
    //Create processor for "start" task
        var processor = DownsamplingImageProcessor(size: startImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
        startImageView.kf.indicatorType = .activity

    //Download image and cache for start textField
        if startUrlString != "" {
            let startUrl = URL(string: startUrlString!)
                startImageView.kf.setImage(with: startUrl,options: [.processor(processor),
                                                                .scaleFactor(UIScreen.main.scale),
                                                                .transition(.fade(1)),
                                                                .cacheOriginalImage
                                                                ])
                
            
        } else { print("[!]KingFisher - Trip id: \(String(describing: currentTrip.id)) has no start image urlSring") }
        
    //Create processor for "finish" task
        processor = DownsamplingImageProcessor(size: finishImageView.bounds.size)
            |> RoundCornerImageProcessor(cornerRadius: 20)
        finishImageView.kf.indicatorType = .activity

    //Download image and cache for finish textField
        if endUrlString != "" {
            let endUrl = URL(string: endUrlString!)
            finishImageView.kf.setImage(with: endUrl, options: [.processor(processor),
                                                            .scaleFactor(UIScreen.main.scale),
                                                            .transition(.fade(1)),
                                                            .cacheOriginalImage
                                                            ])
        } else { print("[!]KingFisher - Trip id: \(String(describing: currentTrip.id)) has no finish image urlSring") }
    }

    
}
