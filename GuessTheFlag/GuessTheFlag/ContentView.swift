//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kevin Ngo on 2020-01-05.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        ("AD", "Andorra"),
        ("AE", "United Arab Emirates"),
        ("AF", "Afghanistan"),
        ("AG", "Antigua and Barbuda"),
        ("AI", "Anguilla"),
        ("AL", "Albania"),
        ("AM", "Armenia"),
        ("AN", "Netherlands Antilles"),
        ("AO", "Angola"),
        ("AQ", "Antarctica"),
        ("AR", "Argentina"),
        ("AS", "American Samoa"),
        ("AT", "Austria"),
        ("AU", "Australia"),
        ("AW", "Aruba"),
        ("AX", "Aland Islands"),
        ("AZ", "Azerbaijan"),
        ("BA", "Bosnia and Herzegovina"),
        ("BB", "Barbados"),
        ("BD", "Bangladesh"),
        ("BE", "Belgium"),
        ("BF", "Burkina Faso"),
        ("BG", "Bulgaria"),
        ("BH", "Bahrain"),
        ("BI", "Burundi"),
        ("BJ", "Benin"),
        ("BL", "Saint Barthélemy"),
        ("BM", "Bermuda"),
        ("BN", "Brunei Darussalam"),
        ("BO", "Bolivia"),
        ("BQ", "Caribbean Netherlands"),
        ("BR", "Brazil"),
        ("BS", "Bahamas"),
        ("BT", "Bhutan"),
        ("BV", "Bouvet Island"),
        ("BW", "Botswana"),
        ("BY", "Belarus"),
        ("BZ", "Belize"),
        ("CA", "Canada"),
        ("CC", "Cocos (Keeling) Islands"),
        ("CD", "Democratic Republic of the Congo"),
        ("CF", "Central African Republic"),
        ("CG", "Congo"),
        ("CH", "Switzerland"),
        ("CI", "Cote d'Ivoire"),
        ("CK", "Cook Islands"),
        ("CL", "Chile"),
        ("CM", "Cameroon"),
        ("CN", "China"),
        ("CO", "Colombia"),
        ("CR", "Costa Rica"),
        ("CU", "Cuba"),
        ("CV", "Cape Verde"),
        ("CW", "Curacao"),
        ("CX", "Christmas Island"),
        ("CY", "Cyprus"),
        ("CZ", "Czech Republic"),
        ("DE", "Germany"),
        ("DJ", "Djibouti"),
        ("DK", "Denmark"),
        ("DM", "Dominica"),
        ("DO", "Dominican Republic"),
        ("DZ", "Algeria"),
        ("EC", "Ecuador"),
        ("EE", "Estonia"),
        ("EG", "Egypt"),
        ("EH", "Western Sahara"),
        ("ER", "Eritrea"),
        ("ES", "Spain"),
        ("ET", "Ethiopia"),
        ("EU", "Europe"),
        ("FI", "Finland"),
        ("FJ", "Fiji"),
        ("FK", "Falkland Islands (Malvinas)"),
        ("FM", "Federated States of Micronesia"),
        ("FO", "Faroe Islands"),
        ("FR", "France"),
        ("GA", "Gabon"),
        ("GB-ENG", "England"),
        ("GB-NIR", "Northern Ireland"),
        ("GB-SCT", "Scotland"),
        ("GB-WLS", "Wales"),
        ("GB", "United Kingdom"),
        ("GD", "Grenada"),
        ("GE", "Georgia"),
        ("GF", "French Guiana"),
        ("GG", "Guernsey"),
        ("GH", "Ghana"),
        ("GI", "Gibraltar"),
        ("GL", "Greenland"),
        ("GM", "Gambia"),
        ("GN", "Guinea"),
        ("GP", "Guadeloupe"),
        ("GQ", "Equatorial Guinea"),
        ("GR", "Greece"),
        ("GS", "South Georgia and the South Sandwich Islands"),
        ("GT", "Guatemala"),
        ("GU", "Guam"),
        ("GW", "Guinea-Bissau"),
        ("GY", "Guyana"),
        ("HK", "Hong Kong"),
        ("HM", "Heard Island and McDonald Islands"),
        ("HN", "Honduras"),
        ("HR", "Croatia"),
        ("HT", "Haiti"),
        ("HU", "Hungary"),
        ("ID", "Indonesia"),
        ("IE", "Ireland"),
        ("IL", "Israel"),
        ("IM", "Isle of Man"),
        ("IN", "India"),
        ("IO", "British Indian Ocean Territory"),
        ("IQ", "Iraq"),
        ("IR", "Islamic Republic of Iran"),
        ("IS", "Iceland"),
        ("IT", "Italy"),
        ("JE", "Jersey"),
        ("JM", "Jamaica"),
        ("JO", "Jordan"),
        ("JP", "Japan"),
        ("KE", "Kenya"),
        ("KG", "Kyrgyzstan"),
        ("KH", "Cambodia"),
        ("KI", "Kiribati"),
        ("KM", "Comoros"),
        ("KN", "Saint Kitts and Nevis"),
        ("KP", " Democratic People's Republic of Korea"),
        ("KR", "Republic of Korea"),
        ("KW", "Kuwait"),
        ("KY", "Cayman Islands"),
        ("KZ", "Kazakhstan"),
        ("LA", "Lao People's Democratic Republic"),
        ("LB", "Lebanon"),
        ("LC", "Saint Lucia"),
        ("LI", "Liechtenstein"),
        ("LK", "Sri Lanka"),
        ("LR", "Liberia"),
        ("LS", "Lesotho"),
        ("LT", "Lithuania"),
        ("LU", "Luxembourg"),
        ("LV", "Latvia"),
        ("LY", "Libya"),
        ("MA", "Morocco"),
        ("MC", "Monaco"),
        ("MD", "Republic of Moldova"),
        ("ME", "Montenegro"),
        ("MF", "Saint Martin"),
        ("MG", "Madagascar"),
        ("MH", "Marshall Islands"),
        ("MK", "North Macedonia"),
        ("ML", "Mali"),
        ("MM", "Myanmar"),
        ("MN", "Mongolia"),
        ("MO", "Macao"),
        ("MP", "Northern Mariana Islands"),
        ("MQ", "Martinique"),
        ("MR", "Mauritania"),
        ("MS", "Montserrat"),
        ("MT", "Malta"),
        ("MU", "Mauritius"),
        ("MV", "Maldives"),
        ("MW", "Malawi"),
        ("MX", "Mexico"),
        ("MY", "Malaysia"),
        ("MZ", "Mozambique"),
        ("NA", "Namibia"),
        ("NC", "New Caledonia"),
        ("NE", "Niger"),
        ("NF", "Norfolk Island"),
        ("NG", "Nigeria"),
        ("NI", "Nicaragua"),
        ("NL", "Netherlands"),
        ("NO", "Norway"),
        ("NP", "Nepal"),
        ("NR", "Nauru"),
        ("NU", "Niue"),
        ("NZ", "New Zealand"),
        ("OM", "Oman"),
        ("PA", "Panama"),
        ("PE", "Peru"),
        ("PF", "French Polynesia"),
        ("PG", "Papua New Guinea"),
        ("PH", "Philippines"),
        ("PK", "Pakistan"),
        ("PL", "Poland"),
        ("PM", "Saint Pierre and Miquelon"),
        ("PN", "Pitcairn"),
        ("PR", "Puerto Rico"),
        ("PS", "Palestine"),
        ("PT", "Portugal"),
        ("PW", "Palau"),
        ("PY", "Paraguay"),
        ("QA", "Qatar"),
        ("RE", "Réunion"),
        ("RO", "Romania"),
        ("RS", "Serbia"),
        ("RU", "Russian Federation"),
        ("RW", "Rwanda"),
        ("SA", "Saudi Arabia"),
        ("SB", "Solomon Islands"),
        ("SC", "Seychelles"),
        ("SD", "Sudan"),
        ("SE", "Sweden"),
        ("SG", "Singapore"),
        ("SH", "Saint Helena, Ascension and Tristan da Cunha"),
        ("SI", "Slovenia"),
        ("SJ", "Svalbard and Jan Mayen Islands"),
        ("SK", "Slovakia"),
        ("SL", "Sierra Leone"),
        ("SM", "San Marino"),
        ("SN", "Senegal"),
        ("SO", "Somalia"),
        ("SR", "Suriname"),
        ("SS", "South Sudan"),
        ("ST", "Sao Tome and Principe"),
        ("SV", "El Salvador"),
        ("SX", "Sint Maarten (Dutch part)"),
        ("SY", "Syrian Arab Republic"),
        ("SZ", "Swaziland"),
        ("TC", "Turks and Caicos Islands"),
        ("TD", "Chad"),
        ("TF", "French Southern Territories"),
        ("TG", "Togo"),
        ("TH", "Thailand"),
        ("TJ", "Tajikistan"),
        ("TK", "Tokelau"),
        ("TL", "Timor-Leste"),
        ("TM", "Turkmenistan"),
        ("TN", "Tunisia"),
        ("TO", "Tonga"),
        ("TR", "Turkey"),
        ("TT", "Trinidad and Tobago"),
        ("TV", "Tuvalu"),
        ("TW", "Taiwan"),
        ("TZ", "United Republic of Tanzania"),
        ("UA", "Ukraine"),
        ("UG", "Uganda"),
        ("UM", "US Minor Outlying Islands"),
        ("US", "United States"),
        ("UY", "Uruguay"),
        ("UZ", "Uzbekistan"),
        ("VA", "Holy See (Vatican City State)"),
        ("VC", "Saint Vincent and the Grenadines"),
        ("VE", "Bolivarian Republic of Venezuela"),
        ("VG", "Virgin Islands, British"),
        ("VI", "Virgin Islands, U.S."),
        ("VN", "Viet Nam"),
        ("VU", "Vanuatu"),
        ("WF", "Wallis and Futuna Islands"),
        ("XK", "Kosovo"),
        ("WS", "Samoa"),
        ("YE", "Yemen"),
        ("YT", "Mayotte"),
        ("ZA", "South Africa"),
        ("ZM", "Zambia"),
        ("ZW", "Zimbabwe")
    ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var incorrectAnswer = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    
    //states for animation
    @State private var flagAngle = [0.0, 0.0, 0.0]
    @State private var flagOpacity = [1.0, 1.0, 1.0]
    @State private var flagBlur: [CGFloat] = [0, 0, 0]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer].1)
                        .foregroundColor(.white)
                        .fontWeight(.black)
                }.padding(.top, 30)
                
                ForEach(0 ..< 3) {number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(image: self.countries[number].0.lowercased())
                    }
                    .rotation3DEffect(.degrees(self.flagAngle[number]), axis:(x:0, y:1, z:0))
                    .opacity(self.flagOpacity[number])
                    .blur(radius: self.flagBlur[number])
                    .animation(.default)
                }
                
                Spacer()
                Text("Score: \(String(score))")
                    .foregroundColor(.white)
                    .fontWeight(.black)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("That's the flag of \(String(countries[incorrectAnswer].1))"),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestions()
                })
        }
        
        

        
    }
    
    func askQuestions() {
        countries.shuffle()
//        flagAngle = [0.0, 0.0, 0.0]
        flagOpacity = [1.0, 1.0, 1.0]
        flagBlur = [0.0, 0.0, 0.0]
        correctAnswer = Int.random(in: 0...2)
        
        
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
//            scoreTitle = "Correct"
            score += 1
            showingScore = false
//            animateCorrectAnswer()
            askQuestions()
        } else {
            scoreTitle = "Incorrect"
            incorrectAnswer = number
            showingScore = true
            score = 0
            animateGuess()
        }
        
        
    }
    
//    func animateCorrectAnswer() {
//        for flag in 0...2 {
//            if flag == correctAnswer {
//                flagAngle[flag] = 360.0
//            } else {
////                flagOpacity[flag] = 0.25
//            }
//        }
//    }
    
    func animateGuess() {
        //only animate when we get answer wrong
        for flag in 0...2 {
            if flag != correctAnswer {
                flagBlur[flag] = 6
                flagOpacity[flag] = 0.25
            } else {
                flagAngle[flag] += 360.0
            }
        }
    }
}

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image).resizable()
            .renderingMode(.original)
            .clipShape(Rectangle())
            .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 0)
            .frame(width:250, height: 150)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
