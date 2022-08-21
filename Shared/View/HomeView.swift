//
//  HomevView.swift
//  Notes (iOS)
//
//  Created by Yosef Ben Zaken on 19/08/2022.
//

import SwiftUI



struct HomeView: View {
	
	@State var showColors: Bool = false
	@State var animateBtn: Bool = false
	@State private var notes = [Note]()
	var body: some View {
		HStack(spacing: 0.0) {
			// MARK: Sidebar
			if isMacOs() {
				Group {
					Sidebar()
					
					Rectangle()
						.fill(.gray.opacity(0.1))
						.frame(width:1)
				}
			}
			// MARK: Main Content
			MainContent()
		}
		.task {
			await loadData()
		}
		#if os(macOS)
		.ignoresSafeArea()
		#endif
		.frame(width: isMacOs() ? getRect().width/1.7:nil, height: isMacOs() ? getRect().height - 180 : nil, alignment: .leading)
		.background(Color("BG").ignoresSafeArea())
		#if os(iOS)
		.overlay(Sidebar())
		#endif
		.preferredColorScheme(.light)
	}
	
	@ViewBuilder
	func MainContent() -> some View {
		VStack(spacing: 6) {
			// MARK: Search bar
			HStack(spacing: 8) {
				Image(systemName: "magnifyingglass")
					.font(.title3)
					.foregroundColor(.gray)
				TextField("Search", text: .constant(""))
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.bottom, isMacOs() ? 0 : 10)
			.overlay(
				Rectangle()
					.fill(.gray.opacity(0.15))
					.frame(height:1)
					.padding(.horizontal,-25)
					.offset(y: 6)
					.opacity(isMacOs() ? 0 : 1)
				,
				alignment: .bottom
			)
			
			ScrollView(.vertical,showsIndicators: false) {
				VStack(spacing:15) {
					Text("Notes")
						.font(isMacOs() ? .system(size: 33, weight: .bold) : .largeTitle.bold())
						.frame(maxWidth:.infinity, alignment: .leading)
					let columns = Array(repeating: GridItem(.flexible(), spacing: isMacOs() ? 25 : 15), count: isMacOs() ? 3 : 1)
					LazyVGrid(columns: columns, spacing: 25) {
						ForEach(notes, id:\._id) { note in
							CardView(note)
						}
					}
					.padding(.top,30)
				}
				.padding(.top, isMacOs() ? 45:30)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.padding(.top,isMacOs() ? 40 : 15)
		.padding(.horizontal,25)
	}
	
	@ViewBuilder
	func CardView(_ note: Note) -> some View {
		VStack {
			Text(note.note)
				.font(isMacOs() ? .title3 :.body)
				.multilineTextAlignment(.leading)
				.frame(maxWidth: .infinity, alignment: .leading)
			HStack {
				Text(note.getDate, style: .date)
					.foregroundColor(.black)
					.opacity(0.8)
				Spacer(minLength: 0)
				Button {
					
				} label: {
					Image(systemName: "pencil")
						.font(.system(size: 15,weight: .bold))
						.padding(8)
						.foregroundColor(.white)
						.background(.black)
						.clipShape(Circle())
				}
			}
			.padding(.top,55)
		}
		.padding()
		.background(Color(note.color))
		.cornerRadius(18)
	}
	
	@ViewBuilder
	func Sidebar() -> some View {
		VStack {
			if isMacOs() {
				
				Text("Pocket")
					.font(.title2)
					.fontWeight(.semibold)
			}
			
			// MARK: Add Button
			if isMacOs() {
				AddButton()
					.zIndex(1)
			}
			
			VStack(spacing: 15) {
				let colors = [Color("Skin"),Color("Orange"),Color("Purple"),Color("Blue"),Color("Green")]
				ForEach(colors, id:
							\.self) { color in
					Circle()
						.fill(color)
						.frame(width: isMacOs() ? 20 : 25, height: isMacOs() ? 20 : 25)
				}
			}
			.padding(.top, 20)
			.frame(height: showColors ? nil : 0)
			.opacity(showColors ? 1 : 0)
			.zIndex(0)
			if !isMacOs() {
				AddButton()
					.zIndex(1)
			}
		}
		#if os(macOS)
		.frame(maxHeight: .infinity, alignment: .top)
		.padding(.vertical)
		.padding(.horizontal,22)
		.padding(.top, 35)
		#else
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
		.padding()
		.background(BlurView(style: .systemUltraThinMaterialDark)
			.opacity(showColors ? 1 : 0)
			.ignoresSafeArea())
		#endif
	}
	
	@ViewBuilder
	func AddButton() -> some View {
		Button {
			withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
				showColors.toggle()
				animateBtn.toggle()
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
					animateBtn.toggle()
				}
			}
		} label: {
			Image(systemName: "plus")
				.font(.title2)
				.foregroundColor(.white)
				.scaleEffect(animateBtn ? 1.1 : 1)
				.padding(isMacOs() ? 12 : 15)
				.background(.black)
				.clipShape(Circle())
		}
		.scaleEffect(animateBtn ? 1.1 : 1)
		.padding(.top,30)
	}
	
	func loadData() async {
		guard let url = URL(string: "https://hidden-cliffs-36996.herokuapp.com/api/notes") else {
			return
		}
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			let decodedResponse = try JSONDecoder().decode([Note].self, from: data)
			notes = decodedResponse
		} catch {
			print(error)
		}
	}
}

struct HomeView_Previews: PreviewProvider {
	static var previews: some View {
		HomeView()
	}
}

extension View {
	func getRect() -> CGRect {
#if os(iOS)
		return UIScreen.main.bounds
#else
		return NSScreen.main!.visibleFrame
#endif
	}
	
	func isMacOs() -> Bool {
#if os(iOS)
		return false
#endif
		return true
	}
}

#if os(macOS)
extension NSTextField {
	open override var focusRingType: NSFocusRingType {
		get{.none}
		set{}
	}
}
#endif
