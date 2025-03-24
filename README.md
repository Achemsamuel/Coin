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
- You can choose to run just te test via the run script or build.sh file

## Challenges 
- **Loading SVG in Swift:**
  
- This was solved by utilizing the powerful Swift WKWebViw to load the SVG.
- Firstly, the SVG is downloaded using the URLSessionDataTask and then the data is conveted into a String(data: svgData, encoding: .utf8).
- This string is then loaded inside a <div>svgString<\div> and loaded into the WKWebView.

## Screenshots
![dark](https://github.com/user-attachments/assets/e83aa625-20d0-4353-9bf4-5ddaf493398a)


![light](https://github.com/user-attachments/assets/8817d299-e5df-489c-84b2-1d8119f2cb42)


