//
//  BlurView.swift
//  Notes (iOS)
//
//  Created by Yosef Ben Zaken on 19/08/2022.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
	var style: UIBlurEffect.Style
	func makeUIView(context: Context) -> some UIVisualEffectView {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
		return view
	}
	func updateUIView(_ uiView: UIViewType, context: Context) {
		
	}
}
