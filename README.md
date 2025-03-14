# 🪙 Coin – iOS Cryptocurrency Tracker  

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
![Coin List View]([(https://i.postimg.cc/G3Ggn0JV/temp-Imagehh-QGg3.avif)])
![Coin List View (Dark)]([https://i.postimg.cc/wTzf6Wwv/temp-Image-P1i45-X.avif])
![Coin Detail View]([(https://i.postimg.cc/brc6SL8m/temp-Image7-Qz4gz.avif)])
![Coin Favorites View]([(https://i.postimg.cc/sxYTYSgs/temp-Image-BJet-NN.avif)])
