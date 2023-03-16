//
//  Navbar.swift
//  littlelemon
//
//  Created by Michael Woodard on 16/03/23.
//

import SwiftUI

struct Navbar: View {
    var body: some View {
        HStack {
            if (UserDefaults.standard.bool(forKey: "kIsLoggedIn") == true) {
                Image("logo")
                    .scaledToFit()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.leading, 50)
                Spacer()
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50, alignment: .trailing)
                    .padding(.trailing, 8)
            } else {
                Image("logo")
                    .scaledToFit()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}

struct Navbar_Previews: PreviewProvider {
    static var previews: some View {
        Navbar()
    }
}
