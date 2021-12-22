//
//  SepetResponse.swift
//  gotur
//
//  Created by Kemal Sanlı on 12.12.2021.
//

import Foundation

struct SepetResponse:Codable{
    var sepet_yemekler:Array<SepetYemek>?
    var success:Int?
}

struct confirmResponse:Codable{
    var success:Int?
}
