//
//  ContentView.swift
//  StateObjectSample
//
//  Created by 春蔵 on 2023/01/25.
//

import SwiftUI

struct Page1: View {
    @StateObject var viewModel = Page1ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                TextField("Page2へ渡す値", text: $viewModel.page2Value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                NavigationLink(destination: Page2(viewModel: Page2ViewModel(value:viewModel.page2Value))) {
                    Text("Page2へ遷移")
                }
                
                Spacer()
                    .frame(height:100)
                
                TextField("Page3へ渡す値", text: $viewModel.page3Value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                NavigationLink(destination: Page3(argument:viewModel.page3Value)) {
                    Text("Page3へ遷移")
                }
                Spacer()
            }
        }
    }
}

class Page1ViewModel : ObservableObject {
    @Published var page2Value = ""
    @Published var page3Value = ""
}

struct Page2:View {
    @StateObject var viewModel:Page2ViewModel
    
    var body: some View {
        Text(viewModel.value)
    }
}

class Page2ViewModel : ObservableObject {
    init(value: String = "") {
        self.value = value
    }
    
    var value = ""
}

struct Page3:View {
    @StateObject var viewModel = Page3ViewModel()
    var argument = ""
    
    var body: some View {
        Text(viewModel.value)
            .onAppear {
                viewModel.onAppear(argument:argument)
            }
    }
}

class Page3ViewModel : ObservableObject {
    @Published var value = ""

    func onAppear(argument:String) {
        value = argument
    }
}
