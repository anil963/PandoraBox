@echo off
REM Video Gallery Project Setup Script for Windows
REM Save this as create-video-gallery.bat and run it

echo ========================================
echo Video Gallery Project Setup
echo ========================================
echo.

REM Create project directory
echo Creating project directory...
mkdir video-gallery
cd video-gallery

REM Create index.html
echo Creating index.html...
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo     ^<meta charset="UTF-8"^>
echo     ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^>
echo     ^<title^>Video Gallery^</title^>
echo     ^<link rel="stylesheet" href="styles.css"^>
echo     ^<script crossorigin src="https://unpkg.com/react@18/umd/react.production.min.js"^>^</script^>
echo     ^<script crossorigin src="https://unpkg.com/react-dom@18/umd/react-dom.production.min.js"^>^</script^>
echo     ^<script src="https://unpkg.com/@babel/standalone/babel.min.js"^>^</script^>
echo ^</head^>
echo ^<body^>
echo     ^<div id="root"^>^</div^>
echo     ^<script type="text/babel" src="VideoGallery.jsx"^>^</script^>
echo ^</body^>
echo ^</html^>
) > index.html

REM Create sample videos.csv
echo Creating videos.csv...
(
echo id,url,thumbnail,title,description,category,duration
echo 1,https://www.youtube.com/watch?v=dQw4w9WgXcQ,https://img.youtube.com/vi/dQw4w9WgXcQ/maxresdefault.jpg,Sample YouTube Video,Amazing music video with great visuals,music,3:33
echo 2,Videos/Local/nature.mp4,Thumbnails/nature.jpg,Beautiful Nature,Stunning 4K nature documentary footage,documentary,5:24
echo 3,https://www.youtube.com/watch?v=9bZkp7q19f0,https://img.youtube.com/vi/9bZkp7q19f0/maxresdefault.jpg,Gangnam Style,Popular K-pop music video,music,4:13
echo 4,Videos/Local/tutorial.mp4,Thumbnails/tutorial.jpg,Coding Tutorial,Learn React in 10 minutes,education,10:45
echo 5,https://vimeo.com/148751763,https://i.vimeocdn.com/video/540800018.jpg,Vimeo Sample,High quality video on Vimeo,travel,2:30
echo 6,Videos/Local/cooking.mp4,Thumbnails/cooking.jpg,Cooking Demo,How to make perfect pasta,food,8:15
echo 7,https://www.youtube.com/watch?v=jNQXAC9IVRw,https://img.youtube.com/vi/jNQXAC9IVRw/maxresdefault.jpg,Me at the zoo,First YouTube video ever uploaded,history,0:19
echo 8,Videos/Local/fitness.mp4,Thumbnails/fitness.jpg,Workout Routine,30-minute full body workout,fitness,30:00
echo 9,https://www.youtube.com/watch?v=kJQP7kiw5Fk,https://img.youtube.com/vi/kJQP7kiw5Fk/maxresdefault.jpg,Despacito,Luis Fonsi music video,music,4:42
echo 10,Videos/Local/tech-review.mp4,Thumbnails/tech.jpg,Tech Review,Latest smartphone unboxing and review,technology,12:30
echo 11,https://www.youtube.com/watch?v=fJ9rUzIMcZQ,https://img.youtube.com/vi/fJ9rUzIMcZQ/maxresdefault.jpg,Bohemian Rhapsody,Queen official music video,music,5:55
echo 12,Videos/Local/travel-vlog.mp4,Thumbnails/travel.jpg,Paris Travel Vlog,Exploring the city of lights,travel,15:20
) > videos.csv

REM Create folder structure for local videos
echo Creating folder structure...
mkdir Videos
cd Videos
mkdir Local
cd ..
mkdir Thumbnails

REM Create README.md
echo Creating README.md...
(
echo # Video Gallery
echo.
echo A beautiful, responsive video gallery that plays videos from YouTube, Vimeo, and local files.
echo.
echo ## Quick Start
echo 1. Edit videos.csv to add/remove videos
echo 2. Add local video files to Videos/Local/ folder (optional^)
echo 3. Add thumbnail images to Thumbnails/ folder (optional^)
echo 4. Run: python -m http.server 8000
echo 5. Open: http://localhost:8000
echo.
echo ## CSV Format
echo The videos.csv file must have these 7 columns:
echo - id: Unique number
echo - url: Video URL (YouTube/Vimeo/Local path^)
echo - thumbnail: Thumbnail image URL or path
echo - title: Video title
echo - description: Video description
echo - category: Video category
echo - duration: Video length (MM:SS or H:MM:SS^)
echo.
echo ## Supported Video Types
echo - YouTube: https://www.youtube.com/watch?v=VIDEO_ID
echo - Vimeo: https://vimeo.com/VIDEO_ID
echo - Local: Videos/Local/filename.mp4
echo.
echo ## Next Steps
echo 1. Copy styles.css to this folder
echo 2. Copy VideoGallery.jsx to this folder
echo 3. Edit videos.csv with your video information
echo 4. Add video files and thumbnails (if using local videos^)
echo 5. Start a local server and enjoy!
) > README.md

REM Create placeholder files
echo Creating styles.css placeholder...
(
echo /* Video Gallery Styles */
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

echo Creating VideoGallery.jsx placeholder...
(
echo // Video Gallery React Component
echo // Please copy the complete VideoGallery.jsx content here
echo.
echo const { useState, useEffect } = React;
echo.
echo const VideoGallery = (^) =^> {
echo     // This component loads videos from videos.csv file
echo     // Add complete component code here
echo };
echo.
echo const root = ReactDOM.createRoot(document.getElementById('root'^)^);
echo root.render(^<VideoGallery /^>^);
) > VideoGallery.jsx

REM Create setup instructions
echo Creating SETUP-INSTRUCTIONS.txt...
(
echo ========================================
echo VIDEO GALLERY SETUP INSTRUCTIONS
echo ========================================
echo.
echo Project structure has been created successfully!
echo.
echo FILES CREATED:
echo --------------
echo - index.html (complete^)
echo - videos.csv (sample data with 12 videos^)
echo - styles.css (placeholder - NEEDS COMPLETION^)
echo - VideoGallery.jsx (placeholder - NEEDS COMPLETION^)
echo - Videos/Local/ folder (for local video files^)
echo - Thumbnails/ folder (for thumbnail images^)
echo - README.md
echo - SETUP-INSTRUCTIONS.txt
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
echo B. Copy complete VideoGallery.jsx:
echo    - Get the complete JSX content from the artifacts
echo    - Replace the VideoGallery.jsx file in this folder
echo.
echo STEP 2: EDIT videos.csv
echo -----------------------
echo Open videos.csv and customize it with your video data.
echo.
echo For YouTube videos:
echo   - URL format: https://www.youtube.com/watch?v=VIDEO_ID
echo   - Thumbnail: https://img.youtube.com/vi/VIDEO_ID/maxresdefault.jpg
echo.
echo For Vimeo videos:
echo   - URL format: https://vimeo.com/VIDEO_ID
echo   - Get thumbnail from Vimeo page
echo.
echo For Local videos:
echo   - URL format: Videos/Local/filename.mp4
echo   - Thumbnail: Thumbnails/filename.jpg
echo.
echo CSV Format Example:
echo   1,VIDEO_URL,THUMBNAIL_URL,Title,Description,category,5:30
echo.
echo STEP 3: ADD LOCAL VIDEOS (Optional^)
echo ------------------------------------
echo If you want to use local video files:
echo.
echo 1. Add video files (.mp4, .webm, .ogg^) to Videos/Local/ folder
echo 2. Create or add thumbnail images to Thumbnails/ folder
echo 3. Update videos.csv with correct paths
echo.
echo Example:
echo   Videos/Local/my-video.mp4
echo   Thumbnails/my-video.jpg
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
echo video-gallery/
echo ├── index.html              (HTML structure^)
echo ├── styles.css              (All CSS styling^)
echo ├── VideoGallery.jsx        (React component^)
echo ├── videos.csv              (Video data - EDIT THIS!^)
echo ├── README.md               (Documentation^)
echo ├── SETUP-INSTRUCTIONS.txt  (This file^)
echo ├── Videos/                 (Local video files^)
echo │   └── Local/
echo │       ├── nature.mp4
echo │       ├── tutorial.mp4
echo │       └── cooking.mp4
echo └── Thumbnails/             (Thumbnail images^)
echo     ├── nature.jpg
echo     ├── tutorial.jpg
echo     └── cooking.jpg
echo.
echo ========================================
echo KEY FEATURES:
echo ========================================
echo.
echo ✅ Play videos from YouTube, Vimeo, or local files
echo ✅ Beautiful video grid with thumbnails
echo ✅ Play button overlay on hover
echo ✅ Video duration badge
echo ✅ Side-by-side modal video player
echo ✅ Search by title and description
echo ✅ Filter by category
echo ✅ Auto-detect categories from CSV
echo ✅ Responsive design for all devices
echo ✅ Share and open video buttons
echo.
echo ========================================
echo VIDEO TYPES SUPPORTED:
echo ========================================
echo.
echo 1. YouTube Videos
echo    - URL: https://www.youtube.com/watch?v=VIDEO_ID
echo    - Plays in embedded YouTube player
echo.
echo 2. Vimeo Videos
echo    - URL: https://vimeo.com/VIDEO_ID
echo    - Plays in embedded Vimeo player
echo.
echo 3. Local Videos
echo    - URL: Videos/Local/filename.mp4
echo    - Plays in HTML5 video player
echo.
echo ========================================
echo QUICK TIPS:
echo ========================================
echo.
echo • YouTube thumbnails: https://img.youtube.com/vi/VIDEO_ID/maxresdefault.jpg
echo • Keep videos.csv in same folder as index.html
echo • Use forward slashes in paths: Videos/Local/video.mp4
echo • Categories are auto-detected from CSV
echo • Duration format: MM:SS or H:MM:SS
echo • Local videos: MP4 format recommended
echo • Thumbnail size: 1280x720 recommended
echo.
echo ========================================
echo TROUBLESHOOTING:
echo ========================================
echo.
echo Problem: "Error Loading Videos" message
echo Solution: Ensure videos.csv is in the same folder
echo           Make sure you're using a local server
echo.
echo Problem: Videos not playing
echo Solution: Check video URLs in CSV file
echo           For YouTube: Verify video ID is correct
echo           For local: Check file exists at path
echo.
echo Problem: Thumbnails not showing
echo Solution: Check thumbnail URLs are valid
echo           For YouTube: Use img.youtube.com format
echo           For local: Verify thumbnail file exists
echo.
echo Problem: CSV format error
echo Solution: Open in text editor to check format
echo           Ensure 7 columns per row
echo           Check for extra commas
echo.
echo ========================================
echo EXAMPLE WORKFLOW:
echo ========================================
echo.
echo 1. Find a YouTube video you like
echo 2. Copy the video URL
echo 3. Get video ID from URL
echo 4. Open videos.csv in Excel or Notepad
echo 5. Add new row:
echo    13,https://www.youtube.com/watch?v=VIDEO_ID,https://img.youtube.com/vi/VIDEO_ID/maxresdefault.jpg,Video Title,Description,category,5:30
echo 6. Save CSV file
echo 7. Refresh browser - video appears!
echo.
echo ========================================
) > SETUP-INSTRUCTIONS.txt

echo.
echo ========================================
echo SUCCESS!
echo ========================================
echo.
echo ✅ Project structure created: video-gallery/
echo ✅ Sample videos.csv file created (12 videos^)
echo ✅ Folder structure created
echo ✅ Documentation files created
echo.
echo 📋 FILES CREATED:
echo    - index.html (ready to use^)
echo    - videos.csv (sample data^)
echo    - styles.css (needs completion^)
echo    - VideoGallery.jsx (needs completion^)
echo    - Videos/Local/ folder
echo    - Thumbnails/ folder
echo    - README.md
echo    - SETUP-INSTRUCTIONS.txt
echo.
echo ⚠️  IMPORTANT - STILL NEEDED:
echo    1. Copy complete styles.css content
echo    2. Copy complete VideoGallery.jsx content
echo    3. Edit videos.csv with your video URLs
echo    4. Add local video files (optional^)
echo    5. Add thumbnail images (optional^)
echo.
echo 📖 Next: Read SETUP-INSTRUCTIONS.txt for detailed steps
echo.
echo 🎬 Video Types Supported:
echo    - YouTube videos (embedded player^)
echo    - Vimeo videos (embedded player^)
echo    - Local MP4 files (HTML5 player^)
echo.
echo ========================================
echo.
pause