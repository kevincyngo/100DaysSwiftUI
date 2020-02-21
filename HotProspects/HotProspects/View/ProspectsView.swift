//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Kevin Ngo on 2020-02-20.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

// Challenge 3
enum SortType {
    case name, recent
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    
    @State private var isShowingScanner = false
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    let filter: FilterType
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    // Challenge 3
    @State private var isShowingSortOptions = false
    @State private var sort: SortType = .name
    
    var filteredSortedProspects: [Prospect] {
        switch sort {
        case .name:
            return filteredProspects.sorted {$0.name < $1.name}
        case .recent:
            return filteredProspects.sorted {$0.date < $1.date}
        }
    }
    
        let testData = ["Brittany Brown\nbrittany.brown@random.com", "Adina Woodward\nadina.woodward@random.com", "Euan Rankin\neuan.rankin@random.com", "Arman Lawrence\narman.lawrence@random.com", "Rumaysa Lang\nrumaysa.lang@random.com", "Pawel Kerr\npawel.kerr@random.com", "Ashlee Reilly\nashlee.reilly@random.com", "Tabitha Monroe\ntabitha.monroe@random.com", "Deen Key\ndeen.key@random.com", "Aasiyah Byrd\naasiyah.byrd@random.com", "Esmee Robinson\n@random.com", "Bill Archer\nbill.archer@random.com", "Umar Whitworth\numar.whitworth@random.com", "Azra Hernandez\nazra.hernandez@random.com", "Nadine Matthams\nnadine.matthams@random.com", "Mateo Pearce\nmateo.pearce@random.com", "Shelbie Santiago\nshelbie.santiago@random.com", "Md Stokes\n@md.stokesrandom.com", "Mathilde Macfarlane\nmathilde.macfarlane@random.com", "Jamila Fernandez\njamila.fernandez@random.com"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSortedProspects) { prospect in
                    HStack {
                        //challenge 1
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted ? "envelope" : "envelope.badge")
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: Button("Sort") {
                self.isShowingSortOptions = true
                }, trailing: Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
            })
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: self.testData.randomElement()!, completion: self.handleScan)
            }
            .actionSheet(isPresented: $isShowingSortOptions) {
                ActionSheet(title: Text("Sort by"), buttons: [
                    .default(Text((self.sort == .name ? "✓ " : "") + "Name"), action: { self.sort = .name }),
                    .default(Text((self.sort == .recent ? "✓ " : "") + "Most recent"), action: { self.sort = .recent }),
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        self.isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            self.prospects.add(person)
            
        case .failure(let error):
            print("Scanning failed with error \(error)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
    
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter : .none)
    }
}
