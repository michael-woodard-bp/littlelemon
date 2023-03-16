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
        NavigationView {
            VStack {
                Form {
                    Section {
                        Image("profile-image-placeholder")
                    }
                    Section {
                        Text("First Name: \(firstName ?? "")")
                    }
                    Section {
                        Text("Last Name: \(lastName ?? "")")
                    }
                    Section {
                        Text("Email: \(email ?? "")")
                    }
                    Button("Logout") {
                        UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                        self.presentation.wrappedValue.dismiss()
                    }
                    .padding()
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("Primary2"))
                    .cornerRadius(8)
                }
                .navigationTitle(Text("Personal Information"))
                .scrollContentBackground(.hidden)
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
