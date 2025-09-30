@echo off
REM Photo Gallery Project Setup Script for Windows
REM Save this as create-project.bat and run it

echo ========================================
echo Photo Gallery Project Setup
echo ========================================
echo.

REM Create project directory
echo Creating project directory...
mkdir photo-gallery
cd photo-gallery

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
echo # Photo Gallery
echo.
echo A beautiful, responsive photo gallery built with React.
echo.
echo ## Setup
echo 1. Add your images to the Assets folders
echo 2. Update filenames in PhotoGallery.jsx
echo 3. Run: python -m http.server 8000
echo 4. Open: http://localhost:8000
echo.
echo ## Structure
echo - Nature photos : Assets/Nature/
echo - City photos   : Assets/City/
echo - Food photos   : Assets/Food/
echo - Travel photos : Assets/Travel/
echo.
echo ## Next Steps
echo 1. Copy styles.css to this folder
echo 2. Copy PhotoGallery.jsx to this folder
echo 3. Add your images to the Assets folders
echo 4. Update the folderStructure in PhotoGallery.jsx
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
echo // Photo Gallery React Component
echo // Please copy the complete PhotoGallery.jsx content here
echo.
echo const { useState, useEffect } = React;
echo.
echo const PhotoGallery = (^) =^> {
echo     // Add complete component code here
echo };
echo.
echo const root = ReactDOM.createRoot(document.getElementById('root'^)^);
echo root.render(^<PhotoGallery /^>^);
) > PhotoGallery.jsx

REM Create a setup instructions file
echo Creating SETUP-INSTRUCTIONS.txt...
(
echo ========================================
echo PHOTO GALLERY SETUP INSTRUCTIONS
echo ========================================
echo.
echo Project structure has been created successfully!
echo.
echo NEXT STEPS:
echo -----------
echo.
echo 1. COPY FILES:
echo    - Replace styles.css with the complete CSS content
echo    - Replace PhotoGallery.jsx with the complete JSX content
echo.
echo 2. ADD IMAGES:
echo    - Add your photos to Assets/Nature/ (name them: nature1.jpg, nature2.jpg, etc.^)
echo    - Add your photos to Assets/City/ (name them: city1.jpg, city2.jpg, etc.^)
echo    - Add your photos to Assets/Food/ (name them: food1.jpg, food2.jpg, etc.^)
echo    - Add your photos to Assets/Travel/ (name them: travel1.jpg, travel2.jpg, etc.^)
echo.
echo 3. UPDATE CONFIGURATION:
echo    - Open PhotoGallery.jsx
echo    - Update the folderStructure object with your actual image filenames
echo.
echo 4. START SERVER:
echo    Option A - Python 3:
echo      python -m http.server 8000
echo.
echo    Option B - Python 2:
echo      python -m SimpleHTTPServer 8000
echo.
echo    Option C - Node.js:
echo      npx http-server -p 8000
echo.
echo    Option D - PHP:
echo      php -S localhost:8000
echo.
echo 5. OPEN BROWSER:
echo    Navigate to: http://localhost:8000
echo.
echo ========================================
echo FOLDER STRUCTURE:
echo ========================================
echo.
echo photo-gallery/
echo ├── index.html
echo ├── styles.css
echo ├── PhotoGallery.jsx
echo ├── README.md
echo ├── SETUP-INSTRUCTIONS.txt
echo └── Assets/
echo     ├── Nature/
echo     ├── City/
echo     ├── Food/
echo     └── Travel/
echo.
echo ========================================
) > SETUP-INSTRUCTIONS.txt

echo.
echo ========================================
echo SUCCESS!
echo ========================================
echo.
echo Project structure created in: photo-gallery/
echo.
echo IMPORTANT: You still need to:
echo 1. Copy the complete styles.css content
echo 2. Copy the complete PhotoGallery.jsx content
echo 3. Add your images to the Assets folders
echo.
echo See SETUP-INSTRUCTIONS.txt for detailed next steps.
echo.
echo Press any key to exit...
pause > nul