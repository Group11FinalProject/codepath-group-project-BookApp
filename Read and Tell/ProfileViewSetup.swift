//
//  ProfileViewSetup.swift
//  Read and Tell
//
//  Created by Tasneem Hasanat on 11/7/22.
//

import SwiftUI
import UIKit

struct ProfileViewSetup: View {
    
    var body: some View {
        VStack {
            VStack {
                Image("me_illustration_tasneem")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                Text("Tasneem")
                    .font(.title)
                    .bold()
            }
            Spacer().frame(height: 30)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "envelope")
                    Text("tasneemhasanat97@icloud.com")
                }
                HStack {
                    Image(systemName: "phone")
                    Text("212-111-2234")
                }
                HStack {
                    Image(systemName: "network")
                    Text("thqio.com")
                }
            }
            Spacer().frame(height: 30)
            
            HStack {
                Button() {
                    print("Button Tapped")
                } label: {
                    Text("Update Profile Picture")
                        .bold()
                        .frame(width: 260, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            HStack {
                Button() {
                    print("Button Tapped")
                } label: {
                    Text("Update Profile Bio")
                        .bold()
                        .frame(width: 260, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
    }
    struct ProfileViewSetup_Previews: PreviewProvider {
        static var previews: some View {
            ProfileViewSetup()
        }
    }
    
    
}
