# Video Gallery

A beautiful, responsive video gallery that plays videos from YouTube, Vimeo, and local files.

## Quick Start
1. Edit videos.csv to add/remove videos
2. Add local video files to Videos/Local/ folder (optional)
3. Add thumbnail images to Thumbnails/ folder (optional)
4. Run: python -m http.server 8000
5. Open: http://localhost:8000

## CSV Format
The videos.csv file must have these 7 columns:
- id: Unique number
- url: Video URL (YouTube/Vimeo/Local path)
- thumbnail: Thumbnail image URL or path
- title: Video title
- description: Video description
- category: Video category
- duration: Video length (MM:SS or H:MM:SS)

## Supported Video Types
- YouTube: https://www.youtube.com/watch?v=VIDEO_ID
- Vimeo: https://vimeo.com/VIDEO_ID
- Local: Videos/Local/filename.mp4

## Next Steps
1. Copy styles.css to this folder
2. Copy VideoGallery.jsx to this folder
3. Edit videos.csv with your video information
4. Add video files and thumbnails (if using local videos)
5. Start a local server and enjoy!
