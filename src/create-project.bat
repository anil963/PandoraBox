@echo off
REM Photo Gallery Project Setup Script for Windows (CSV Version)
REM Save this as create-project-csv.bat and run it

echo ========================================
echo Photo Gallery Project Setup (CSV Version)
echo ========================================
echo.

REM Create project directory
echo Creating project directory...
mkdir photo-gallery-csv
cd photo-gallery-csv

REM Create index.html
echo Creating index.html...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Photo Gallery^</title^>
echo     ^<link rel="stylesheet" href="styles.css"^>
echo     ^<script crossorigin src="https://unpkg.com/react@18/umd/react.production.min.js"^>^</script^>
echo     ^<script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"^>^</script^>
echo     ^<script src="https://unpkg.com/@babel/standalone/babel.min.js"^>^</script^>
echo ^</head^>
echo ^<body^>
echo     ^<div id="root"^>^</div^>
echo     ^<script type="text/babel" src="PhotoGallery.jsx"^>^</script^>
echo ^</body^>
echo ^</html^>
) > index.html

REM Create sample photos.csv
echo Creating photos.csv...
(
echo id,url,title,description,category
echo 1,Assets/Nature/nature1.jpg,Sunset View,Beautiful sunset over mountains with vibrant colors,nature
echo 2,Assets/City/city1.jpg,City Lights,Night view of downtown with illuminated skyscrapers,cityscape
echo 3,Assets/Nature/nature2.jpg,Forest Path,Serene walking path through dense green forest,nature
echo 4,Assets/Food/food1.jpg,Gourmet Dish,Exquisitely plated fine dining experience,food
echo 5,Assets/Travel/travel1.jpg,Beach Paradise,Crystal clear waters and white sandy beaches,travel
echo 6,Assets/City/city2.jpg,Urban Architecture,Modern buildings with striking geometric designs,cityscape
echo 7,Assets/Nature/nature3.jpg,Mountain Peak,Majestic snow-capped mountain against blue sky,nature
echo 8,Assets/Food/food2.jpg,Fresh Salad,Colorful healthy salad with fresh vegetables,food
echo 9,Assets/Travel/travel2.jpg,Historic Temple,Ancient temple with intricate architectural details,travel
echo 10,Assets/City/city3.jpg,Street Art,Vibrant murals and graffiti in urban setting,cityscape
echo 11,Assets/Food/food3.jpg,Dessert Delight,Decadent chocolate cake with artistic presentation,food
echo 12,Assets/Travel/travel3.jpg,Mountain Trail,Scenic hiking trail with breathtaking valley views,travel
) > photos.csv

REM Create Assets folder structure
echo Creating Assets folder structure...
mkdir Assets
cd Assets
mkdir Nature
mkdir City
mkdir Food
mkdir Travel
cd ..

REM Create README.md
echo Creating README.md...
(
echo # Photo Gallery - CSV Version
echo.
echo A beautiful, responsive photo gallery that reads data from CSV files.
echo.
echo ## Quick Start
echo 1. Edit photos.csv to add/remove photos
echo 2. Add your images to the Assets folders
echo 3. Run: python -m http.server 8000
echo 4. Open: http://localhost:8000
echo.
echo ## CSV Format
echo The photos.csv file must have these columns:
echo - id: Unique number
echo - url: Path to image file
echo - title: Photo title
echo - description: Photo description
echo - category: Photo category
echo.
echo ## Structure
echo - Nature photos   : Assets/Nature/
echo - City photos     : Assets/City/
echo - Food photos     : Assets/Food/
echo - Travel photos   : Assets/Travel/
echo.
echo ## Next Steps
echo 1. Copy styles.css to this folder
echo 2. Copy PhotoGallery.jsx (CSV version^) to this folder
echo 3. Edit photos.csv with your photo details
echo 4. Add your images to the Assets folders
echo 5. Start a local server and enjoy!
) > README.md

REM Create a sample styles.css placeholder
echo Creating styles.css placeholder...
(
echo /* Photo Gallery Styles */
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

REM Create a sample PhotoGallery.jsx placeholder
echo Creating PhotoGallery.jsx placeholder...
(
echo // Photo Gallery React Component (CSV Version^)
echo // Please copy the complete PhotoGallery.jsx (CSV version^) content here
echo.
echo const { useState, useEffect } = React;
echo.
echo const PhotoGallery = (^) =^> {
echo     // This version loads photos from photos.csv file
echo     // Add complete CSV version component code here
echo };
echo.
echo const root = ReactDOM.createRoot(document.getElementById('root'^)^);
echo root.render(^<PhotoGallery /^>^);
) > PhotoGallery.jsx

REM Create CSV editing guide
echo Creating CSV-GUIDE.txt...
(
echo ========================================
echo CSV FILE EDITING GUIDE
echo ========================================
echo.
echo The photos.csv file contains all your photo data.
echo.
echo COLUMNS:
echo --------
echo 1. id          - Unique number for each photo (1, 2, 3, etc.^)
echo 2. url         - Path to image file (e.g., Assets/Nature/photo.jpg^)
echo 3. title       - Photo title (e.g., "Beautiful Sunset"^)
echo 4. description - Photo description (e.g., "Sunset over mountains"^)
echo 5. category    - Category name (nature, cityscape, food, travel, etc.^)
echo.
echo EXAMPLE ROW:
echo ------------
echo 1,Assets/Nature/sunset.jpg,Sunset View,Beautiful sunset over mountains,nature
echo.
echo EDITING OPTIONS:
echo ----------------
echo.
echo Option 1: Text Editor
echo   - Open photos.csv in Notepad or any text editor
echo   - Add new rows following the format above
echo   - Save the file
echo.
echo Option 2: Excel
echo   - Open photos.csv in Microsoft Excel
echo   - Edit data in spreadsheet format
echo   - Save as "CSV (Comma delimited^)"
echo   - Make sure filename is still photos.csv
echo.
echo Option 3: Google Sheets
echo   - Import photos.csv to Google Sheets
echo   - Edit your data
echo   - Download as CSV
echo   - Rename to photos.csv
echo.
echo TIPS:
echo -----
echo - Keep the header row (first line^) unchanged
echo - Use forward slashes / for paths (not backslashes \^)
echo - Don't use commas in titles/descriptions (or wrap in quotes^)
echo - Categories are case-insensitive (nature = Nature = NATURE^)
echo - Add new categories by just using a new name
echo.
echo ADDING NEW PHOTOS:
echo ------------------
echo 1. Add image file to appropriate Assets folder
echo 2. Open photos.csv
echo 3. Add a new row with id, url, title, description, category
echo 4. Save the file
echo 5. Refresh browser - new photo appears automatically!
echo.
echo TROUBLESHOOTING:
echo ---------------
echo - If photos don't load: Check file paths in url column
echo - If CSV error: Check for extra commas or missing fields
echo - If categories missing: Check category column spelling
echo.
echo ========================================
) > CSV-GUIDE.txt

REM Create setup instructions
echo Creating SETUP-INSTRUCTIONS.txt...
(
echo ========================================
echo PHOTO GALLERY SETUP (CSV VERSION^)
echo ========================================
echo.
echo Project structure has been created successfully!
echo.
echo FILES CREATED:
echo --------------
echo - index.html (complete^)
echo - photos.csv (sample data^)
echo - styles.css (placeholder - NEEDS COMPLETION^)
echo - PhotoGallery.jsx (placeholder - NEEDS COMPLETION^)
echo - Assets/ folder structure
echo - README.md
echo - CSV-GUIDE.txt
echo.
echo ========================================
echo NEXT STEPS:
echo ========================================
echo.
echo STEP 1: COPY COMPLETE FILES
echo ---------------------------
echo You need to replace the placeholder files with complete content:
echo.
echo A. Copy complete styles.css:
echo    - Get the full CSS content from the artifacts
echo    - Replace the styles.css file in this folder
echo.
echo B. Copy complete PhotoGallery.jsx (CSV VERSION^):
echo    - Get the CSV version JSX content from the artifacts
echo    - Replace the PhotoGallery.jsx file in this folder
echo    - IMPORTANT: Use the CSV version, not the original!
echo.
echo STEP 2: ADD YOUR IMAGES
echo -----------------------
echo Add your photo files to the Assets folders:
echo    Assets/Nature/   - Add nature photos
echo    Assets/City/     - Add city photos
echo    Assets/Food/     - Add food photos
echo    Assets/Travel/   - Add travel photos
echo.
echo Supported formats: .jpg, .jpeg, .png, .gif, .webp
echo.
echo STEP 3: EDIT photos.csv
echo -----------------------
echo Open photos.csv and customize it with your photo data:
echo.
echo Option A - Text Editor:
echo    1. Open photos.csv in Notepad
echo    2. Edit the rows with your photo details
echo    3. Keep the format: id,url,title,description,category
echo    4. Save the file
echo.
echo Option B - Excel:
echo    1. Right-click photos.csv ^> Open With ^> Excel
echo    2. Edit the data in spreadsheet format
echo    3. File ^> Save As ^> CSV (Comma delimited^)
echo    4. Make sure it saves as photos.csv
echo.
echo CSV Format Example:
echo    1,Assets/Nature/sunset.jpg,Sunset,Beautiful sunset,nature
echo    2,Assets/City/skyline.jpg,City View,Urban skyline,cityscape
echo.
echo See CSV-GUIDE.txt for detailed CSV editing instructions.
echo.
echo STEP 4: START A LOCAL SERVER
echo ----------------------------
echo IMPORTANT: Must use a local server, not file:// protocol
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
echo STEP 5: OPEN IN BROWSER
echo -----------------------
echo Navigate to: http://localhost:8000
echo.
echo ========================================
echo FOLDER STRUCTURE:
echo ========================================
echo.
echo photo-gallery-csv/
echo ├── index.html              (HTML structure^)
echo ├── styles.css              (All CSS styling^)
echo ├── PhotoGallery.jsx        (React component - CSV version^)
echo ├── photos.csv              (Photo data - EDIT THIS!^)
echo ├── README.md               (Documentation^)
echo ├── CSV-GUIDE.txt           (CSV editing guide^)
echo ├── SETUP-INSTRUCTIONS.txt  (This file^)
echo └── Assets/                 (Your images^)
echo     ├── Nature/
echo     ├── City/
echo     ├── Food/
echo     └── Travel/
echo.
echo ========================================
echo KEY FEATURES (CSV VERSION^):
echo ========================================
echo.
echo ✅ Easy photo management - just edit CSV file
echo ✅ No coding required - use Excel or text editor
echo ✅ Auto-detect categories from CSV
echo ✅ Add/remove photos without touching code
echo ✅ Search and filter functionality
echo ✅ Responsive design for mobile/tablet
echo ✅ Modal lightbox for viewing photos
echo ✅ Download and share buttons
echo.
echo ========================================
echo ADVANTAGES OF CSV VERSION:
echo ========================================
echo.
echo 📊 Edit photos in spreadsheet (Excel/Sheets^)
echo 🚀 No JavaScript knowledge needed
echo 📝 Easy to add hundreds of photos
echo 🔄 Categories auto-update from CSV
echo 💾 Easy to backup (just save CSV file^)
echo 🔍 Use Excel to search/sort photos
echo.
echo ========================================
echo QUICK TIPS:
echo ========================================
echo.
echo • Keep photos.csv in same folder as index.html
echo • Use relative paths: Assets/Nature/photo.jpg
echo • Categories are auto-detected from CSV
echo • To add new category, just use it in CSV
echo • Excel users: Save as CSV (Comma delimited^)
echo • Test in browser after editing CSV
echo.
echo ========================================
echo TROUBLESHOOTING:
echo ========================================
echo.
echo Problem: "Error Loading Photos" message
echo Solution: Ensure photos.csv is in the same folder
echo           Make sure you're using a local server
echo.
echo Problem: Photos not showing
echo Solution: Check URL paths in CSV file
echo           Use forward slashes: Assets/City/photo.jpg
echo.
echo Problem: Wrong categories
echo Solution: Check spelling in category column
echo           Categories are case-insensitive
echo.
echo Problem: CSV format error
echo Solution: Open in text editor to check format
echo           Ensure no extra commas
echo.
echo ========================================
echo EXAMPLE WORKFLOW:
echo ========================================
echo.
echo 1. Take/collect photos
echo 2. Copy photos to Assets/Nature/ folder
echo 3. Open photos.csv in Excel
echo 4. Add rows:
echo    13,Assets/Nature/lake.jpg,Lake View,Beautiful lake,nature
echo    14,Assets/Nature/tree.jpg,Old Tree,Ancient oak tree,nature
echo 5. Save CSV file
echo 6. Refresh browser - photos appear!
echo.
echo ========================================
echo.
echo For more help, see:
echo - README.md (general information^)
echo - CSV-GUIDE.txt (CSV editing details^)
echo.
echo ========================================
) > SETUP-INSTRUCTIONS.txt

echo.
echo ========================================
echo SUCCESS!
echo ========================================
echo.
echo ✅ Project structure created: photo-gallery-csv/
echo ✅ Sample photos.csv file created
echo ✅ Assets folders created
echo ✅ Documentation files created
echo.
echo 📋 FILES CREATED:
echo    - index.html (ready to use^)
echo    - photos.csv (sample data^)
echo    - styles.css (needs completion^)
echo    - PhotoGallery.jsx (needs completion^)
echo    - README.md
echo    - CSV-GUIDE.txt
echo    - SETUP-INSTRUCTIONS.txt
echo.
echo ⚠️  IMPORTANT - STILL NEEDED:
echo    1. Copy complete styles.css content
echo    2. Copy complete PhotoGallery.jsx (CSV VERSION^) content
echo    3. Add your images to Assets folders
echo    4. Edit photos.csv with your photo details
echo.
echo 📖 Next: Read SETUP-INSTRUCTIONS.txt for detailed steps
echo.
echo ========================================
echo.
pause