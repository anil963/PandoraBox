@echo off
REM Stock Gallery Project Setup Script for Windows
REM Save this as create-stock-gallery.bat and run it

echo ========================================
echo Stock Market Gallery Project Setup
echo ========================================
echo.

REM Create project directory
echo Creating project directory...
mkdir stock-gallery
cd stock-gallery

REM Create index.html
echo Creating index.html...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Stock Gallery^</title^>
echo     ^<link rel="stylesheet" href="styles.css"^>
echo     ^<script crossorigin src="https://unpkg.com/react@18/umd/react.production.min.js"^>^</script^>
echo     ^<script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"^>^</script^>
echo     ^<script src="https://unpkg.com/@babel/standalone/babel.min.js"^>^</script^>
echo     ^<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"^>^</script^>
echo ^</head^>
echo ^<body^>
echo     ^<div id="root"^>^</div^>
echo     ^<script type="text/babel" src="StockGallery.jsx"^>^</script^>
echo ^</body^>
echo ^</html^>
) > index.html

REM Create sample stocks.csv
echo Creating stocks.csv...
(
echo id,symbol,name,price,change,changePercent,volume,marketCap,sector,description,historicalData,exchange
echo 1,AAPL,Apple Inc.,182.52,2.45,1.36,52.4M,2.85T,technology,Leading technology company known for iPhone and Mac products,175.20;176.80;178.50;180.20;179.00;181.30;182.52,NASDAQ
echo 2,MSFT,Microsoft Corporation,378.91,-1.23,-0.32,28.3M,2.81T,technology,Global leader in software and cloud computing services,380.50;382.10;381.20;379.80;380.50;377.90;378.91,NASDAQ
echo 3,GOOGL,Alphabet Inc.,139.57,3.21,2.35,32.1M,1.75T,technology,Parent company of Google and various tech ventures,133.40;135.20;136.80;137.50;138.20;137.10;139.57,NASDAQ
echo 4,AMZN,Amazon.com Inc.,151.94,1.87,1.24,45.8M,1.57T,technology,E-commerce and cloud computing giant,148.50;149.20;150.10;151.00;150.50;151.20;151.94,NASDAQ
echo 5,TSLA,Tesla Inc.,248.50,-5.32,-2.10,98.5M,788.5B,automotive,Electric vehicle and clean energy company,255.20;258.40;254.80;252.10;250.60;248.90;248.50,NASDAQ
echo 6,JPM,JPMorgan Chase,158.73,0.95,0.60,12.5M,461.2B,financial,Leading global financial services firm,156.80;157.20;158.10;157.90;158.50;158.20;158.73,NYSE
echo 7,V,Visa Inc.,263.45,2.12,0.81,8.2M,537.8B,financial,Global payments technology company,258.90;260.40;261.80;262.50;263.10;262.90;263.45,NYSE
echo 8,JNJ,Johnson and Johnson,160.23,-0.45,-0.28,7.1M,387.4B,healthcare,Diversified healthcare and pharmaceutical company,161.20;160.80;161.50;160.90;160.50;160.70;160.23,NYSE
echo 9,PFE,Pfizer Inc.,28.94,0.34,1.19,38.4M,162.7B,healthcare,Pharmaceutical and biotechnology corporation,28.20;28.40;28.60;28.50;28.70;28.75;28.94,NYSE
echo 10,XOM,Exxon Mobil,105.67,1.23,1.18,18.9M,435.2B,energy,Multinational oil and gas corporation,103.50;104.20;104.80;105.10;105.30;105.50;105.67,NYSE
echo 11,WMT,Walmart Inc.,165.34,0.87,0.53,9.8M,448.3B,retail,Largest retail corporation in the world,163.80;164.20;164.90;165.10;165.50;165.20;165.34,NYSE
echo 12,DIS,Walt Disney Co.,95.25,-1.12,-1.16,11.2M,174.1B,entertainment,Global entertainment and media conglomerate,96.80;97.20;96.50;96.10;95.80;95.50;95.25,NYSE
) > stocks.csv

REM Create README.md
echo Creating README.md...
(
echo # Stock Market Gallery
echo.
echo A beautiful, responsive stock market gallery with interactive charts.
echo.
echo ## Quick Start
echo 1. Edit stocks.csv to add/update stock data
echo 2. Run: python -m http.server 8000
echo 3. Open: http://localhost:8000
echo.
echo ## CSV Format
echo The stocks.csv file must have these 12 columns:
echo - id: Unique number
echo - symbol: Stock ticker (AAPL, MSFT, etc.^)
echo - name: Company name
echo - price: Current stock price
echo - change: Price change amount
echo - changePercent: Percent change
echo - volume: Trading volume
echo - marketCap: Market capitalization
echo - sector: Market sector (technology, financial, etc.^)
echo - description: Company description
echo - historicalData: Price history (semicolon-separated^)
echo - exchange: Stock exchange (NASDAQ, NYSE^)
echo.
echo ## Features
echo - Interactive stock cards with mini charts
echo - Full Chart.js visualization in modal
echo - Search by symbol, name, or description
echo - Filter by market sector
echo - Side-by-side modal view
echo - Responsive design
echo.
echo ## Next Steps
echo 1. Copy styles.css to this folder
echo 2. Copy StockGallery.jsx to this folder
echo 3. Edit stocks.csv with your stock data
echo 4. Start a local server and enjoy!
) > README.md

REM Create placeholder files
echo Creating styles.css placeholder...
(
echo /* Stock Gallery Styles */
echo /* Please copy the complete styles.css content here */
echo.
echo * {
echo     margin: 0;
echo     padding: 0;
echo     box-sizing: border-box;
echo }
echo.
echo body {
echo     font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
echo     background-color: #f5f5f5;
echo }
echo.
echo /* Add remaining CSS styles from the styles.css file */
) > styles.css

echo Creating StockGallery.jsx placeholder...
(
echo // Stock Gallery React Component with Chart.js
echo // Please copy the complete StockGallery.jsx content here
echo.
echo const { useState, useEffect, useRef } = React;
echo.
echo const StockGallery = (^) =^> {
echo     // This component loads stocks from stocks.csv file
echo     // and displays interactive charts using Chart.js
echo     // Add complete component code here
echo };
echo.
echo const root = ReactDOM.createRoot(document.getElementById('root'^)^);
echo root.render(^<StockGallery /^>^);
) > StockGallery.jsx

REM Create setup instructions
echo Creating SETUP-INSTRUCTIONS.txt...
(
echo ========================================
echo STOCK MARKET GALLERY SETUP
echo ========================================
echo.
echo Project structure has been created successfully!
echo.
echo FILES CREATED:
echo --------------
echo - index.html (complete^)
echo - stocks.csv (sample data with 12 stocks^)
echo - styles.css (placeholder - NEEDS COMPLETION^)
echo - StockGallery.jsx (placeholder - NEEDS COMPLETION^)
echo - README.md
echo - SETUP-INSTRUCTIONS.txt
echo.
echo ========================================
echo NEXT STEPS:
echo ========================================
echo.
echo STEP 1: COPY COMPLETE FILES
echo ---------------------------
echo You need to replace the placeholder files:
echo.
echo A. Copy complete styles.css:
echo    - Get the full CSS content from artifacts
echo    - Replace the styles.css file
echo.
echo B. Copy complete StockGallery.jsx:
echo    - Get the complete JSX content from artifacts
echo    - Replace the StockGallery.jsx file
echo    - IMPORTANT: This version uses Chart.js!
echo.
echo STEP 2: EDIT stocks.csv
echo -----------------------
echo Open stocks.csv and customize with your stock data.
echo.
echo CSV Format (12 columns^):
echo   id,symbol,name,price,change,changePercent,volume,marketCap,sector,description,historicalData,exchange
echo.
echo Example Row:
echo   1,AAPL,Apple Inc.,182.52,2.45,1.36,52.4M,2.85T,technology,Leading tech company,175.20;176.80;178.50,NASDAQ
echo.
echo IMPORTANT NOTES:
echo - historicalData: Semicolon-separated prices (oldest to newest^)
echo - change: Can be positive or negative (2.45 or -1.23^)
echo - changePercent: Percentage change (1.36 or -0.32^)
echo - volume: Use M for millions, B for billions (52.4M^)
echo - marketCap: Use T for trillions, B for billions (2.85T^)
echo.
echo STEP 3: START A LOCAL SERVER
echo ----------------------------
echo IMPORTANT: Must use a local server
echo.
echo Choose one method:
echo.
echo Method A - Python 3 (Recommended^):
echo    python -m http.server 8000
echo.
echo Method B - Python 2:
echo    python -m SimpleHTTPServer 8000
echo.
echo Method C - Node.js:
echo    npx http-server -p 8000
echo.
echo Method D - PHP:
echo    php -S localhost:8000
echo.
echo Method E - VS Code:
echo    1. Install "Live Server" extension
echo    2. Right-click index.html
echo    3. Select "Open with Live Server"
echo.
echo STEP 4: OPEN IN BROWSER
echo -----------------------
echo Navigate to: http://localhost:8000
echo.
echo ========================================
echo FOLDER STRUCTURE:
echo ========================================
echo.
echo stock-gallery/
echo ├── index.html              (HTML structure^)
echo ├── styles.css              (All CSS styling^)
echo ├── StockGallery.jsx        (React component with Chart.js^)
echo ├── stocks.csv              (Stock data - EDIT THIS!^)
echo ├── README.md               (Documentation^)
echo └── SETUP-INSTRUCTIONS.txt  (This file^)
echo.
echo ========================================
echo KEY FEATURES:
echo ========================================
echo.
echo ✅ Stock cards with price and change
echo ✅ Mini charts on each card (SVG^)
echo ✅ Full interactive Chart.js visualization
echo ✅ Color-coded gains (green^) and losses (red^)
echo ✅ Search by symbol, name, or description
echo ✅ Filter by market sector
echo ✅ Side-by-side modal view
echo ✅ Responsive design for all devices
echo ✅ Link to Yahoo Finance for details
echo.
echo ========================================
echo CSV COLUMNS EXPLAINED:
echo ========================================
echo.
echo 1. id: Unique number (1, 2, 3...^)
echo 2. symbol: Stock ticker (AAPL, MSFT, GOOGL^)
echo 3. name: Full company name
echo 4. price: Current stock price (182.52^)
echo 5. change: Dollar change (2.45 or -1.23^)
echo 6. changePercent: Percent change (1.36 or -0.32^)
echo 7. volume: Trading volume (52.4M, 1.2B^)
echo 8. marketCap: Market cap (2.85T, 788.5B^)
echo 9. sector: Market sector (technology, financial^)
echo 10. description: Company description
echo 11. historicalData: Price history separated by semicolons
echo     Example: 175.20;176.80;178.50;180.20;182.52
echo 12. exchange: Stock exchange (NASDAQ, NYSE^)
echo.
echo ========================================
echo SECTORS AVAILABLE:
echo ========================================
echo.
echo - technology: Tech companies
echo - financial: Banks, payment companies
echo - healthcare: Pharma, medical
echo - automotive: Car manufacturers
echo - energy: Oil and gas companies
echo - retail: Retail stores
echo - entertainment: Media, streaming
echo - telecommunications: Phone, internet
echo - consumer: Consumer goods
echo - industrial: Manufacturing
echo.
echo Note: Sectors are auto-detected from CSV
echo.
echo ========================================
echo HISTORICAL DATA FORMAT:
echo ========================================
echo.
echo Format: Semicolon-separated prices (oldest to newest^)
echo Example: 175.20;176.80;178.50;180.20;179.00;181.30;182.52
echo.
echo Recommendations:
echo - Minimum: 7 data points (1 week^)
echo - Optimal: 30 data points (1 month^)
echo - Maximum: 90 data points (3 months^)
echo.
echo Tips for realistic data:
echo - Gradual increase: 100;102;104;106;108;110
echo - Gradual decrease: 110;108;106;104;102;100
echo - Volatile: 100;105;98;103;97;102;100
echo.
echo ========================================
echo TROUBLESHOOTING:
echo ========================================
echo.
echo Problem: "Error Loading Stocks"
echo Solution: Ensure stocks.csv is in same folder
echo           Use local server, not file://
echo.
echo Problem: Charts not displaying
echo Solution: Check browser console for errors
echo           Verify Chart.js CDN is loading
echo           Check historicalData format
echo.
echo Problem: Wrong colors
echo Solution: Check change and changePercent values
echo           Positive = green, Negative = red
echo           Use proper number format (no + sign^)
echo.
echo Problem: CSV format error
echo Solution: Open in text editor, check 12 columns
echo           Ensure no extra commas
echo           Check semicolons in historicalData
echo.
echo ========================================
echo QUICK TIPS:
echo ========================================
echo.
echo • Keep stocks.csv in same folder as index.html
echo • Use lowercase for sectors (technology, financial^)
echo • Historical data: semicolon-separated, no spaces
echo • Volume format: 52.4M, 1.2B
echo • Market cap format: 2.85T, 788.5B
echo • Change can be positive (2.45^) or negative (-1.23^)
echo • At least 7 historical data points recommended
echo.
echo ========================================
echo EXAMPLE WORKFLOW:
echo ========================================
echo.
echo 1. Find stock data from Yahoo Finance or similar
echo 2. Open stocks.csv in Excel or Notepad
echo 3. Add new row with all 12 columns
echo 4. Format historical data with semicolons
echo 5. Save CSV file
echo 6. Refresh browser - stock appears with chart!
echo.
echo ========================================
) > SETUP-INSTRUCTIONS.txt

echo.
echo ========================================
echo SUCCESS!
echo ========================================
echo.
echo ✅ Project structure created: stock-gallery/
echo ✅ Sample stocks.csv file created (12 stocks^)
echo ✅ Documentation files created
echo.
echo 📋 FILES CREATED:
echo    - index.html (ready to use^)
echo    - stocks.csv (sample data^)
echo    - styles.css (needs completion^)
echo    - StockGallery.jsx (needs completion^)
echo    - README.md
echo    - SETUP-INSTRUCTIONS.txt
echo.
echo ⚠️  IMPORTANT - STILL NEEDED:
echo    1. Copy complete styles.css content
echo    2. Copy complete StockGallery.jsx content
echo    3. Edit stocks.csv with your stock data
echo.
echo 📖 Next: Read SETUP-INSTRUCTIONS.txt for detailed steps
echo.
echo 📈 Features Include:
echo    - Interactive stock cards
echo    - Chart.js price charts
echo    - Real-time price display
echo    - Sector-based filtering
echo    - Search functionality
echo.
echo ========================================
echo.
pause