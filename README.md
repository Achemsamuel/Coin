Coin is an iOS app that helps users track cryptocurrency prices, view historical performance charts, and manage favorite coins. The app fetches data from **CoinRanking API**, offering a smooth and interactive experience using **SwiftUI** and **Combine**.  

---

## 🚀 Features  
✅ Display the **top 100 cryptocurrencies** with real-time updates  
✅ View **detailed information** about each coin, including rank, price, and market trends  
✅ **Interactive charts** to analyze price history  
✅ **Favorite coins** for quick access  
✅ **Pagination and filtering** for an optimized browsing experience  

---

## 🛠 Tech Stack  
- **UIKit** – For Programmatic UI  
- **SwiftUI** – For modern declarative UI  
- **Combine** – For managing asynchronous data streams  
- **Charts** – For interactive data visualization  
- **CoinRanking API** – Fetches real-time cryptocurrency data  

---

## Run the App
- Download the source file
- Click to open and run it with Xcode 
- Build the application and test it.

## Challenges 
- **Loading SVG in Swift:**
  
- This was solved by utilizing the powerful Swift WKWebViw to load the SVG.
- Firstly, the SVG is downloaded using the URLSessionDataTask and then the data is conveted into a String(data: svgData, encoding: .utf8).
- This string is then loaded inside a <div>svgString<\div> and loaded into the WKWebView.

## Screenshots
![Coin List View](https://github.com/user-attachments/assets/00d178b4-d123-46df-8f60-ada106a2b773 |width=100)
![Coin List View (Dark)](https://github.com/user-attachments/assets/8a93cdbd-aa79-4959-a24a-f67283b0a0d3 |width=100)
![Coin Favorites View](https://github.com/user-attachments/assets/6b6fdbb4-8536-4d72-9fd6-88a33360cf2e |width=100)
![Coin Detail View](https://github.com/user-attachments/assets/f54612a4-d7cb-48a9-85c1-cf2efd2e5d61 |width=100)



