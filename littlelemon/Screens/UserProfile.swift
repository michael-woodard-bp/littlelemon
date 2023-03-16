//
//  UserProfile.swift
//  littlelemon
//
//  Created by Michael Woodard on 15/03/23.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: "first name key")
    let lastName = UserDefaults.standard.string(forKey: "last name key")
    let email = UserDefaults.standard.string(forKey: "email key")
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName ?? "")
            Text(lastName ?? "")
            Text(email ?? "")
            Button("Logout") {
                UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
