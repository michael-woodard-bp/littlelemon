//
//  Menu.swift
//  littlelemon
//
//  Created by Michael Woodard on 15/03/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var searchText: String = ""
    
    func getMenuData(url: String) {
        PersistenceController.shared.clear()
        let urlObject = URL(string: url)!
        let request = URLRequest(url: urlObject)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                let menuList = try! decoder.decode(MenuList.self, from: data)
                let menu = menuList.menu
                for item in menu {
                    let dish = Dish(context: viewContext)
                    dish.title = item.title
                    dish.price = item.price
                    dish.image = item.image
                    dish.info = item.info
                    dish.category = item.category
                    try? viewContext.save()
                }
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate {
        searchText.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
    
    func formatPrice(priceStr: String) -> String {
        if let price = Float(priceStr) {
            let spacing = price < 10 ? " " : ""
            return "$ " + spacing + String(format: "%.2f", price)
        } else {
            return ""
        }
    }
    
    var body: some View {
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
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search menu", text: $searchText)
                }
                .padding()
                .foregroundColor(.black)
                .background()
                .cornerRadius(9)
                .frame(alignment: .center)
                .padding()
            }
            .frame(maxWidth: .infinity)
            .background(Color("Primary1"))
            VStack {
                HStack {
                    Text("ORDER FOR DELIVERY!")
                        .font(.title3.bold())
                        .padding([.leading, .top])
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button("Starters") {
                        
                    }
                    .padding(8)
                    .background(Color("Secondary1"))
                    .cornerRadius(20)
                    Spacer()
                    Button("Mains") {
                        
                    }
                    .padding(8)
                    .background(Color("Secondary1"))
                    .cornerRadius(20)
                    Spacer()
                    Button("Desserts") {
                        
                    }
                    .padding(8)
                    .background(Color("Secondary1"))
                    .cornerRadius(20)
                    Spacer()
                    Button("Drinks") {
                        
                    }
                    .padding(8)
                    .background(Color("Secondary1"))
                    .cornerRadius(20)
                    Spacer()
                }
                Divider()
                    .padding([.top])
            }
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) {(dishes: [Dish]) in
                ScrollView {
                    ForEach(dishes, id: \.self) { dish in
                        NavigationLink(destination: MenuItemDetails(menuItem: dish)) {
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("\(dish.title!)")
                                            .font(.title3.bold())
                                            .frame(alignment: .leading)
                                        Spacer()
                                        Text("\(dish.info!)")
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                        Text("\(formatPrice(priceStr: dish.price!))")
                                            .font(.headline)
                                    }
                                    .foregroundColor(.black)
                                    .padding()
                                    Spacer()
                                    AsyncImage(url: URL(string: dish.image!)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipped()
                                    .cornerRadius(8)
                                    .padding()
                                }
                                Divider()
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear() {
            getMenuData(url: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        return Menu()
    }
}
