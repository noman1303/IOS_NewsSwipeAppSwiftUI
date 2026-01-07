
import SwiftUI

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let imageName: String
    let TapToKnow: String
}

struct ContentView: View {
    @State private var newsList = [
        NewsItem(title: "As Deepinder Goyal generates buzz with ‘Temple’ device on forehead, experts advice caution: ‘The biggest worry is that", content: "Deepinder Goyal’s recent appearance on a podcast drew public attention and sparked curiosity, as he was seen wearing a small device — named Temple — fixed near the temple region of the head. According to several reports, the experimental wearable health gadget, developed by a private research initiative backed by the Zomato founder and CEO, continuously measures brain oxygenation, which indirectly reflects blood flow to the brain when the person is upright and moving, or sitting for long durations.", imageName: "Dipendar" , TapToKnow: "Lockheed Martin Agreement"),
        NewsItem(title: "I spent a week with Motorola’s Edge 70, an absolutely thin smartphone that is too hard to ignore ", content: "The Motorola Edge 70 focuses on sleek design and comfort while still delivering all-day battery life. Priced at Rs 29,999, it offers a premium build, bright display, reliable everyday performance, and strong durability, but compromises on camera quality and flagship-level power.", imageName: "Moto" , TapToKnow: "noman"),
        NewsItem(title: "Foreign tourist dances around ‘protective’ circle on New Year’s Eve in Shillong, video wins hearts: ‘the respect for personal space and dignity’", content: "Amid several incidents of concern over women’s safety in India, a video of a foreign tourist dancing in Shillong during New Year celebrations has caught the Internet’s attention, drawing widespread appreciation on social media.", imageName: "Dance" , TapToKnow: "noman"),
        NewsItem(title: "Can govt freeze bank account forever? Uttarakhand High Court ends 6-year ordeal for non-accused in corruption probe", content: "Written by Ashish ShajiNew Delhi | Updated: January 7, 2026 06:27 PM IST clock_logo 3 min read google-preferred-btn Uttarakhand High Court held that mere pendency of a criminal trial cannot justify indefinite freezing of property belonging to a person who is not facing trial.Uttarakhand High Court held that mere pendency of a criminal trial cannot justify indefinite freezing of property belonging to a person who is not facing trial. The Uttarakhand High Court recently ordered the unfreezing of a man’s bank account that had remained frozen since 2018 owing to a corruption probe and said that the mere pendency of a criminal trial doesn’t justify the indefinite freezing of property of someone not facing trial. ", imageName: "Lock" , TapToKnow: "see more for freeze accounts"),
        NewsItem(title: "Vicky Kaushal and Katrina Kaif name their son Vihaan (it has an URI connect), share first pic: ‘Our Ray of Light", content: "Vicky Kaushal and Katrina Kaif have announced the name of their newborn baby boy in their latest Instagram post. Katrina and Vicky, in a joint post, revealed that their son’s name is Vihaan Kaushal. The actors also shared the first glimpse of their little munchkin along with the announcement. The name Vihaan is of Sanskrit origin and means “dawn,” “sunrise,” “morning” or “beginning of a new era.”", imageName: "Kaif" , TapToKnow: "see more for kaif "),
        NewsItem(title: "Fund manager, 47, dies of sudden cardiac arrest while on holiday", content: "Maverick fund manager Siddhartha Bhaiya, who passed away due to cardiac arrest on December 31 while on holiday in New Zealand, not only points to the growing statistics of sudden deaths among young Indians but also prods us to look beyond other aspects of heart health than just heart attacks. Death caused by a sudden cardiac arrest, a condition when the heart stops because of an electrical malfunction and irregularity of its rhythms, accounts for approximately four to five million deaths annually worldwide and nearly 10 per cent of all cardiac deaths in India, according to the European Journal of Cardiovascular Medicine.", imageName: "Attack" , TapToKnow: "see more for Attack "),
        NewsItem(title: "Thalapathy Vijay’s Jana Nayagan to be reviewed by fresh CBFC committee", content: "From “what all box office records will Vijay’s Jana Nayagan smash?” the conversation has suddenly veered to “will the political actioner hit the screens on the scheduled date?” owing to an inordinate delay in the movie getting a green signal from the Central Board of Film Certification (CBFC). Although Jana Nayagan’s makers moved the Madras High Court on Tuesday, January 6, they did not receive relief, and the hearing was adjourned until Wednesday afternoon.", imageName: "Vijay" , TapToKnow: "see more for Attack ")
    ]
    @State private var currentIndex: Int = 0
    @State private var dragOffset: CGFloat = 0
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ForEach(0..<newsList.count, id: \.self) { index in
                // Only render the current, the next, AND the previous card
                if index >= currentIndex - 1 && index <= currentIndex + 1 {
                    NewsCardView(news: newsList[index])
                        .offset(y: calculateOffset(for: index))
                        .zIndex(calculateZIndex(for: index))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let dragHeight = value.translation.height
                                    
                                    // 1. Swiping UP (to next) - only if not on last card
                                    if dragHeight < 0 && currentIndex < newsList.count - 1 {
                                        dragOffset = dragHeight
                                    }
                                    // 2. Swiping DOWN (to previous) - only if not on first card
                                    else if dragHeight > 0 && currentIndex > 0 {
                                        dragOffset = dragHeight
                                    }
                                }
                                .onEnded { value in
                                    let dragHeight = value.translation.height
                                    let screenHeight = UIScreen.main.bounds.height
                                    
                                    // Swipe UP logic
                                    if dragHeight < -100 && currentIndex < newsList.count - 1 {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                            currentIndex += 1
                                            dragOffset = 0
                                        }
                                    }
                                    // Swipe DOWN logic
                                    else if dragHeight > 100 && currentIndex > 0 {
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                            currentIndex -= 1
                                            dragOffset = 0
                                        }
                                    }
                                    // Snap back
                                    else {
                                        withAnimation(.interactiveSpring()) {
                                            dragOffset = 0
                                        }
                                    }
                                }
                        )
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func calculateOffset(for index: Int) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        
        // The card before the current one (sitting above the screen)
        if index == currentIndex - 1 {
            return -screenHeight + (dragOffset > 0 ? dragOffset : 0)
        }
        // The current card
        if index == currentIndex {
            return dragOffset < 0 ? dragOffset : 0
        }
        // The card after (stays still behind)
        return 0
    }
    
    private func calculateZIndex(for index: Int) -> Double {
        // The previous card must have the highest ZIndex when pulling down
        if index == currentIndex - 1 { return 2.0 }
        // The current card is middle
        if index == currentIndex { return 1.0 }
        // The next card is bottom
        return 0.0
    }
}

#Preview {
    ContentView()
}
