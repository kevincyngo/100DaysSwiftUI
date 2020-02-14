//
//  ContentView.swift
//  Instafilter
//
//  Created by Kevin Ngo on 2020-02-12.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var processedImage: UIImage?
    
    @State private var selectedFilter: String = "Sepia Tone"
    
    @State private var showingErrorMessage = false
    
    let context = CIContext()
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: { self.filterRadius },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )

        let scale = Binding<Double>(
            get: { self.filterScale },
            set: {
                self.filterScale = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    // select an image
                    self.showingImagePicker = true
                }

                VStack {
                    if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                        HStack {
                            Text("Intensity")
                            Slider(value: intensity)
                        }
                    }

                    if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                        HStack {
                            ZStack(alignment: .leading) {
                                Text("Intensity").opacity(0) // force same width
                                Text("Radius")
                            }
                            Slider(value: radius)
                        }
                    }

                    if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                        HStack {
                            ZStack(alignment: .leading) {
                                Text("Intensity").opacity(0) // force same width
                                Text("Scale")
                            }
                            Slider(value: scale)
                        }
                    }
                }
                .padding(.vertical)
                

                HStack {
                    Button("\(selectedFilter)") {
                        self.showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        guard let processedImage = self.processedImage else {
                            self.showingErrorMessage = true
                            return
                            
                        }

                        let imageSaver = ImageSaver()

                        imageSaver.successHandler = {
                            print("Success!")
                        }

                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }

                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) {
                        self.setFilter(CIFilter.crystallize())
                        self.selectedFilter = "Crystallize"
                    },
                    .default(Text("Edges")) {
                        self.setFilter(CIFilter.edges())
                        self.selectedFilter = "Edges"
                    },
                    .default(Text("Gaussian Blur")) {
                        self.selectedFilter = "Gaussian Blur"
                        self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) {
                        self.selectedFilter = "Pixellate"
                        self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) {
                        self.selectedFilter = "Sepia Tone"
                        self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) {
                        self.selectedFilter = "Unsharp Mask"
                        self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) {
                        self.selectedFilter = "Vignette"
                        self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
            .alert(isPresented: $showingErrorMessage) {
                Alert(title: Text("Error cannot save"),
                      message: Text("There is no image to save."),
                      dismissButton: .default(Text("Got it!")))
            }
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
