//
//  ContentView.swift
//  DiceRoll
//
//  Created by Kevin Ngo on 2020-02-26.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import CoreHaptics
import SwiftUI

struct MainConstants {
    static let lightDisabledOpacity = 0.6
    static let darkDisabledOpacity = 0.4

    static let pickerDefaultOpacity = 0.8
    static let rollButtonDefaultOpacity = 0.8

    static let lightDividerOpacity = 0.1
    static let darkDividerOpacity = 0.3

    static let numbersSaturation = 0.7
    static let numbersBrightness = 0.8

    static let maxDiceNumber = 6
}

struct ContentView<GenericRolls>: View where GenericRolls: Rolls {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @ObservedObject var rolls: GenericRolls

    // MARK:- Private properties

    @State private var diceNumber = 6
    @State private var dieSides = 6

    @State private var selectedSides =
        Array<Int>(repeating: 0, count: MainConstants.maxDiceNumber)
    
    @State private var animationDurations =
        Array<Double>(repeating: 0, count: MainConstants.maxDiceNumber)

    @State private var rollDisabled = false

    @State private var coloredNumbers = true

    @State private var showingAction = false

    @State private var engine: CHHapticEngine?

    private var pickerOpacity: Double {
        if rollDisabled {
            return colorScheme == .light ?
                MainConstants.lightDisabledOpacity :
                MainConstants.darkDisabledOpacity
        }

        return MainConstants.pickerDefaultOpacity
    }

    private var rollButtonOpacity: Double {
        if rollDisabled {
            return colorScheme == .light ?
                MainConstants.lightDisabledOpacity :
                MainConstants.darkDisabledOpacity
        }

        return MainConstants.rollButtonDefaultOpacity
    }

    private var dividerOpacity: Double {
        colorScheme == .light ?
            MainConstants.lightDividerOpacity :
            MainConstants.darkDividerOpacity
    }

    private var slotsBackground: Color {
        colorScheme == .light ? .white : .black
    }

    private var total: Int {
        var total = 0

        for i in 0..<diceNumber {
            total += selectedSides[i]
        }

        return total
    }

    // MARK:- View

    var body: some View {
        let diceNumberWithCallback = Binding<Int>(
            get: { self.diceNumber },
            set: {
                self.diceNumber = $0
                self.resetPositions()
            }
        )

        let dieSidesWithCallback = Binding<Int>(
            get: { self.dieSides },
            set: {
                self.dieSides = $0
                self.resetPositions()
            }
        )

        return VStack {

            // MARK:- Number of dice

            HStack {
                Text("Dice")
                    .font(.caption)

                Spacer()
            }
            .padding([.horizontal, .top])
            .padding(.leading, 2)

            Picker("", selection: diceNumberWithCallback) {
                ForEach(1...6, id: \.self) { i in
                    Text("\(i)").tag(i)

                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .disabled(self.rollDisabled)
            .background(Color.green.opacity(pickerOpacity))
            .cornerRadius(8)
            .animation(.linear(duration: 0.1))
            .padding(.horizontal)

            // MARK:- Number of sides

            HStack {
                Text("Sides")
                    .font(.caption)

                Spacer()
            }
            .padding([.horizontal, .top])
            .padding(.leading, 2)

            Picker("", selection: dieSidesWithCallback) {
                Text("4").tag(4)
                Text("6").tag(6)
                Text("8").tag(8)
                Text("10").tag(10)
                Text("12").tag(12)
                Text("20").tag(20)
                Text("100").tag(100)
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.green.opacity(pickerOpacity))
            .cornerRadius(8)
            .disabled(self.rollDisabled)
            .animation(.linear(duration: 0.1))
            .padding([.horizontal, .bottom])

            // MARK:- Slots

            ZStack {
                Divider()
                    .background(Color.green.opacity(dividerOpacity))

                HStack {
                    Spacer(minLength: 0)

                    ForEach(0..<self.diceNumber) { i in
                        DieView(sides: self.$dieSides,
                                selectedSide: self.$selectedSides[i],
                                animationDuration: self.$animationDurations[i])
                            .foregroundColor(self.dieColor(for: i))

                        Spacer(minLength: 0)
                    }
                    .id(self.diceNumber)
                }
            }
            .background(slotsBackground)
            .padding(.vertical)

            // MARK:- Results

            ZStack {
                GeometryReader { listProxy in
                    List {
                        ForEach(self.rolls.all) { roll in
                            GeometryReader { itemProxy in
                                ZStack {
                                    HStack {
                                        Text("\(roll.dieSides)")
                                        Text("⚁")
                                            .rotationEffect(.radians(.pi / 8))

                                        Spacer()

                                        HStack(alignment: .lastTextBaseline) {
                                            Text("Σ")
                                                .font(.caption)
                                            Text("\(roll.total)")
                                        }
                                    }
                                    .padding(.horizontal)

                                    HStack {
                                        Spacer()

                                        ForEach(roll.result, id: \.self) { side in
                                            Text("\(side)")
                                        }

                                        Spacer()
                                    }
                                }
                                .frame(height: itemProxy.size.height)
                                .background(self.rollColor(for: roll))
                                .opacity(self.itemOpacity(listProxy: listProxy, itemProxy: itemProxy))
                            }
                            .listRowInsets(EdgeInsets())
                        }
                    }
                    .foregroundColor(.gray)
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor.clear
                    }
                    .onDisappear {
                        UITableView.appearance().separatorStyle = .singleLine
                        UITableView.appearance().backgroundColor = UIColor.systemBackground
                    }
                    // without onTapGesture, onLongPressGesture will break scroll
                    .onTapGesture {}
                    .onLongPressGesture {
                        if !self.rolls.all.isEmpty {
                            self.showingAction = true
                        }
                    }
                }
                .padding(.top)
                .edgesIgnoringSafeArea(.bottom)

                // MARK:- Roll button

                VStack {
                    Spacer()

                    ZStack {
                        // dummy button over the list that acts as a solid background
                        // for the roll button. Allows modifying roll button's opacity
                        // without the list below showing through
                        Button(action: {}, label: {
                                HStack {
                                    Spacer()
                                    Text(" ").font(.largeTitle)
                                    Spacer()
                                }
                            }
                        )
                        .padding(.vertical, 8)
                        .background(Color(UIColor.systemBackground))
                        .cornerRadius(8)
                        .padding()
                        .allowsHitTesting(false)

                        Button(
                            action: {
                                self.prepareHaptics()
                                self.rollDisabled = true

                                for i in 0..<self.diceNumber {
                                    let duration = Double(i + 2) / 2

                                    // reset position
                                    self.animationDurations[i] = 0.2
                                    self.selectedSides[i] = 0

                                    // for a smoother animation, don't wait until reset end
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        self.animationDurations[i] = duration
                                        self.selectedSides[i] = Int.random(in: 1...self.dieSides)
                                    }
                                }

                                let lastDieIndex = self.diceNumber - 1
                                let duration = Double(lastDieIndex + 2) / 2
                                let endTime = duration + 0.1

                                DispatchQueue.main.asyncAfter(deadline: .now() + endTime) {
                                    var result = [Int]()
                                    result += self.selectedSides[0..<self.diceNumber]
                                    let total = result.reduce(0, +)

                                    self.rolls.insert(roll: Roll(dieSides: self.dieSides, result: result, total: total))

                                    self.playCompletionHaptics()
                                    self.rollDisabled = false
                                }
                            },
                            label: {
                                HStack{
                                    Spacer()
                                    Text("⚁")
                                        .font(.largeTitle)
                                        .rotationEffect(.radians(.pi / 8))
                                    Text("ROLL")
                                        .font(.title)
                                        .padding(.horizontal)
                                    Text("⚄")
                                        .font(.largeTitle)
                                        .rotationEffect(.radians(.pi / 8))
                                    Spacer()
                                }
                            }
                        )
                        .foregroundColor(.primary)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .opacity(self.rollButtonOpacity)
                        .animation(.linear(duration: 0.1))
                        .cornerRadius(8)
                        .padding()
                        .disabled(self.rollDisabled)
                    }
                }
            }
        }
        .actionSheet(isPresented: self.$showingAction, content: {
            ActionSheet(title: Text("Delete history?"), buttons: [
                .destructive(Text("Delete all")) {
                    self.rolls.removeAll()
                },
                .cancel()
            ])
        })
    }

    // MARK:- Private functions

    private func dieColor(for index: Int) -> Color {
        if self.coloredNumbers {
            return Color(
                hue: Double(index) / Double(diceNumber),
                saturation: MainConstants.numbersSaturation,
                brightness: MainConstants.numbersBrightness
            )
        }

        return .primary
    }

    private func rollColor(for roll: Roll) -> Color {
        if colorScheme == .light {
            return index(for: roll) % 2 == 0 ?
                Color.green.opacity(0.05) :
                Color.green.opacity(0.15)
        }

        // dark scheme
        return index(for: roll) % 2 == 0 ?
            Color.white.opacity(0.125) :
            Color.white.opacity(0.075)
    }

    private func index(for roll: Roll) -> Int {
        rolls.all.firstIndex(where: { roll.id == $0.id }) ?? 0
    }

    private func itemOpacity(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> Double {
        let itemMinY = itemProxy.frame(in: .global).minY
        let listMinY = listProxy.frame(in: .global).minY

        let positionInList = itemMinY - listMinY
        let ratio = positionInList / listProxy.size.height

        return 1 - Double(ratio * ratio)

        // other possible fading speeds
        //return 1 - Double(ratio)
        //return 0 - log(Double(ratio))
    }

    private func resetPositions() {
        for i in 0..<self.diceNumber {
            self.animationDurations[i] = 0
            self.selectedSides[i] = 0
        }
    }

    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    private func playCompletionHaptics() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one extremely light, blurry tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.3)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let rolls = [
        Roll(dieSides: 20, result: [18, 15, 19, 17, 16, 19], total: 104),
        Roll(dieSides: 6, result: [1, 3, 4], total: 8),
        Roll(dieSides: 100, result: [95, 45, 21, 21, 32], total: 214),
        Roll(dieSides: 8, result: [4, 8, 3], total: 15),
        Roll(dieSides: 4, result: [1, 1, 3, 2, 4], total: 11),
        Roll(dieSides: 6, result: [4, 5, 2, 6, 3, 3], total: 23),
        Roll(dieSides: 6, result: [2, 1, 2, 6, 5, 4], total: 20),
        Roll(dieSides: 6, result: [5, 5, 5, 1, 4, 2], total: 22),
        Roll(dieSides: 6, result: [5, 3, 5, 4, 4], total: 21)
    ]

    class PreviewRolls: Rolls {
        @Published private(set) var all: [Roll]
        var allPublished: Published<[Roll]> { _all }
        var allPublisher: Published<[Roll]>.Publisher { $all }
        init(rolls: [Roll]) { self.all = rolls }
        func insert(roll: Roll) { }
        func removeAll() { }
    }

    static let previewRolls = PreviewRolls(rolls: rolls)

    static var previews: some View {
        Group {
            ContentView(rolls: previewRolls).environment(\.colorScheme, .light)

            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                ContentView(rolls: previewRolls).environment(\.colorScheme, .dark)
            }

//            MainView(rolls: previewRolls).previewDevice(PreviewDevice(rawValue: "iPhone SE"))
//            MainView(rolls: previewRolls).previewDevice(PreviewDevice(rawValue: "iPhone 8 Plus"))
//            MainView(rolls: previewRolls).previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (3rd generation)"))
        }
    }
}
