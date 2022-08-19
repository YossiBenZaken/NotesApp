//
//  ContentView.swift
//  Shared
//
//  Created by Yosef Ben Zaken on 19/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
			.buttonStyle(.borderless)
			.textFieldStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
