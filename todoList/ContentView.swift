import SwiftUI

struct ContentView: View {
	var body: some View {
		TabView {
			TodoListView()
				.tabItem {
					Image(systemName: "house.fill")
					Text("Home")
				}

			Text("Map")
				.font(.system(size: 30, weight: .bold, design: .rounded))
				.tabItem {
					Image(systemName: "bookmark.circle.fill")
					Text("Bookmark")
				}

			Text("Video Tab")
				.font(.system(size: 30, weight: .bold, design: .rounded))
				.tabItem {
					Image(systemName: "video.circle.fill")
					Text("Video")
				}

			Text("Profile Tab")
				.font(.system(size: 30, weight: .bold, design: .rounded))
				.tabItem {
					Image(systemName: "person.crop.circle")
					Text("Profile")
				}
		}
	}
}

#Preview {
    ContentView()
}
