//
//  ProfilePictureView.swift
//  Moovie
//
//  Created by Ермолицкий Иван on 19/10/2026.
//

import SwiftUI
import UIKit

struct ProfilePictureView: View {
    
    let profilePic: UIImage
    
    var body: some View {
        Image(uiImage: profilePic)
            .resizable()
            .scaledToFill()
            .frame(width: 120, height: 120)
            .clipShape(Circle())
    }
}

//#Preview {
//    ProfilePictureView()
//}


