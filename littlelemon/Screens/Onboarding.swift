//
//  Onboarding.swift
//  littlelemon
//
//  Created by Michael Woodard on 15/03/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Navbar()
                VStack {
                    HStack {
                        Text("Little Lemon")
                            .font(.largeTitle.bold())
                            .foregroundColor(Color("Primary2"))
                            .padding([.leading, .top])
                        Spacer()
                    }
                    HStack {
                        VStack {
                            HStack {
                                Text("Chicago")
                                    .font(.title.bold())
                                    .padding([.leading])
                                Spacer()
                            }
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .font(.callout)
                        }
                        .foregroundColor(Color.white)
                        Image("hero-image")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipped()
                            .cornerRadius(8)
                            .padding([.leading, .trailing])
                    }
                    .padding([.bottom])
                }
                .frame(maxWidth: .infinity)
                .background(Color("Primary1"))
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Form {
                    Section(header: Text("First Name *")) {
                        TextField("First Name", text: $firstName)                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("Primary1"), style: StrokeStyle(lineWidth: 1.0)))
                    }
                    Section(header: Text("Last Name *")) {
                        TextField("Last Name", text: $lastName)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("Primary1"), style: StrokeStyle(lineWidth: 1.0)))
                    }
                    Section(header: Text("Email *")) {
                        TextField("Email", text: $email)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color("Primary1"), style: StrokeStyle(lineWidth: 1.0)))
                    }
                    Section {
                        Button("Register") {
                            if (!firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && isValidEmail(email)) {
                                UserDefaults.standard.set(firstName, forKey: kFirstName)
                                UserDefaults.standard.set(lastName, forKey: kLastName)
                                UserDefaults.standard.set(email, forKey: kEmail)
                                UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                                isLoggedIn = true
                            }
                        }
                        .padding()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color("Primary1"))
                        .cornerRadius(8)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .onAppear() {
                if (UserDefaults.standard.bool(forKey: "kIsLoggedIn") == true) {
                    isLoggedIn = true
                }
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
