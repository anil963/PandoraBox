const { useState, useEffect } = React;

const VideoGallery = () => {
    const [videos, setVideos] = useState([]);
    const [selectedVideo, setSelectedVideo] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [activeCategory, setActiveCategory] = useState('All');
    const [loading, setLoading] = useState(true);
    const [categories, setCategories] = useState(['All']);
    const [error, setError] = useState(null);

    useEffect(() => {
        loadVideosFromCSV();
    }, []);

    const loadVideosFromCSV = async () => {
        try {
            setLoading(true);
            setError(null);

            const response = await fetch('videos.csv');
            
            if (!response.ok) {
                throw new Error('Failed to load videos.csv. Make sure the file exists in the same folder.');
            }

            const csvText = await response.text();
            const lines = csvText.split('\n');
            const headers = lines[0].split(',').map(h => h.trim());
            
            const loadedVideos = [];
            const categorySet = new Set();

            for (let i = 1; i < lines.length; i++) {
                const line = lines[i].trim();
                if (!line) continue;

                const values = parseCSVLine(line);
                
                if (values.length >= 7) {
                    const video = {
                        id: parseInt(values[0]) || i,
                        url: values[1].trim(),
                        thumbnail: values[2].trim(),
                        title: values[3].trim(),
                        description: values[4].trim(),
                        category: values[5].trim(),
                        duration: values[6].trim(),
                        type: detectVideoType(values[1].trim())
                    };

                    loadedVideos.push(video);
                    
                    const formattedCategory = video.category.charAt(0).toUpperCase() + 
                                            video.category.slice(1).toLowerCase();
                    categorySet.add(formattedCategory);
                }
            }

            setVideos(loadedVideos);
            const sortedCategories = ['All', ...Array.from(categorySet).sort()];
            setCategories(sortedCategories);
            setLoading(false);
        } catch (error) {
            console.error('Error loading videos from CSV:', error);
            setError(error.message);
            setLoading(false);
        }
    };

    const parseCSVLine = (line) => {
        const result = [];
        let current = '';
        let inQuotes = false;

        for (let i = 0; i < line.length; i++) {
            const char = line[i];
            
            if (char === '"') {
                inQuotes = !inQuotes;
            } else if (char === ',' && !inQuotes) {
                result.push(current);
                current = '';
            } else {
                current += char;
            }
        }
        
        result.push(current);
        return result.map(val => val.replace(/^"|"$/g, '').trim());
    };

    const detectVideoType = (url) => {
        if (url.includes('youtube.com') || url.includes('youtu.be')) {
            return 'youtube';
        } else if (url.includes('vimeo.com')) {
            return 'vimeo';
        } else {
            return 'local';
        }
    };

    const getYouTubeEmbedUrl = (url) => {
        let videoId = '';
        if (url.includes('youtube.com/watch?v=')) {
            videoId = url.split('v=')[1].split('&')[0];
        } else if (url.includes('youtu.be/')) {
            videoId = url.split('youtu.be/')[1].split('?')[0];
        }
        return `https://www.youtube.com/embed/${videoId}?autoplay=1`;
    };

    const getVimeoEmbedUrl = (url) => {
        const videoId = url.split('vimeo.com/')[1].split('?')[0];
        return `https://player.vimeo.com/video/${videoId}?autoplay=1`;
    };

    const filteredVideos = videos.filter(video => {
        const matchesSearch = video.title.toLowerCase().includes(searchTerm.toLowerCase()) || 
                             video.description.toLowerCase().includes(searchTerm.toLowerCase());
        
        const normalizedVideoCategory = video.category.charAt(0).toUpperCase() + 
                                        video.category.slice(1).toLowerCase();
        const normalizedActiveCategory = activeCategory === 'All' ? 'All' : 
                                        activeCategory.charAt(0).toUpperCase() + 
                                        activeCategory.slice(1).toLowerCase();
        
        const matchesCategory = normalizedActiveCategory === 'All' || 
                               normalizedVideoCategory === normalizedActiveCategory;
        
        return matchesSearch && matchesCategory;
    });

    const openModal = (video) => {
        setSelectedVideo(video);
        document.body.style.overflow = 'hidden';
    };

    const closeModal = () => {
        setSelectedVideo(null);
        document.body.style.overflow = 'auto';
    };

    const shareVideo = (video) => {
        if (navigator.share) {
            navigator.share({
                title: video.title,
                text: video.description,
                url: video.url
            }).catch(err => console.log('Error sharing:', err));
        } else {
            navigator.clipboard.writeText(video.url)
                .then(() => alert('Link copied to clipboard!'))
                .catch(err => console.log('Error copying:', err));
        }
    };

    const openInNewTab = (url) => {
        window.open(url, '_blank');
    };

    return (
        <div className="container">
            {/* Sidebar */}
            <aside className="sidebar">
                <h2>Categories</h2>
                <ul className="category-list">
                    {categories.map(category => (
                        <li 
                            key={category}
                            className={`category-item ${activeCategory === category ? 'active' : ''}`}
                            onClick={() => setActiveCategory(category)}
                        >
                            <span>{category}</span>
                            <span className="category-arrow">›</span>
                        </li>
                    ))}
                </ul>
            </aside>

            {/* Main Content */}
            <main className="main-content">
                {/* Header */}
                <div className="header">
                    <h1>Video Gallery</h1>
                    <p>Explore amazing video content from around the world</p>
                </div>

                {/* Controls */}
                <div className="controls">
                    <div className="search-container">
                        <svg className="search-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                            <circle cx="11" cy="11" r="8"></circle>
                            <path d="m21 21-4.35-4.35"></path>
                        </svg>
                        <input
                            type="text"
                            className="search-input"
                            placeholder="Search videos..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                        />
                    </div>
                    <div className="filter-pills">
                        {categories.map(category => (
                            <button
                                key={category}
                                className={`filter-pill ${activeCategory === category ? 'active' : ''}`}
                                onClick={() => setActiveCategory(category)}
                            >
                                {category}
                            </button>
                        ))}
                    </div>
                </div>

                {/* Error State */}
                {error && (
                    <div className="empty-state">
                        <div className="empty-state-icon">⚠️</div>
                        <h3>Error Loading Videos</h3>
                        <p>{error}</p>
                        <p style={{marginTop: '10px', fontSize: '14px'}}>
                            Make sure <strong>videos.csv</strong> exists in the same folder as index.html
                        </p>
                    </div>
                )}

                {/* Video Grid */}
                {!error && loading ? (
                    <div className="loading-state">
                        <p>Loading videos from CSV...</p>
                    </div>
                ) : !error && filteredVideos.length === 0 ? (
                    <div className="empty-state">
                        <div className="empty-state-icon">🎬</div>
                        <h3>No videos found</h3>
                        <p>Try adjusting your search or filter criteria</p>
                    </div>
                ) : !error && (
                    <div className="video-grid">
                        {filteredVideos.map(video => (
                            <div 
                                key={video.id}
                                className="video-card"
                                onClick={() => openModal(video)}
                            >
                                <div className="video-thumbnail-container">
                                    <img 
                                        src={video.thumbnail}
                                        alt={video.title}
                                        className="video-thumbnail"
                                        onError={(e) => {
                                            e.target.src = 'https://via.placeholder.com/640x360?text=Video+Thumbnail';
                                        }}
                                    />
                                    <div className="play-overlay">
                                        <div className="play-icon"></div>
                                    </div>
                                    {video.duration && (
                                        <div className="video-duration">{video.duration}</div>
                                    )}
                                </div>
                                <div className="video-info">
                                    <div className="video-title">{video.title}</div>
                                    <div className="video-description">{video.description}</div>
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </main>

            {/* Modal */}
            {selectedVideo && (
                <div className="modal-overlay" onClick={closeModal}>
                    <div className="modal-content" onClick={(e) => e.stopPropagation()}>
                        <button className="modal-close" onClick={closeModal}>×</button>
                        
                        {/* Left side - Video Player */}
                        <div className="modal-video-section">
                            <div className="modal-video-player">
                                {selectedVideo.type === 'youtube' && (
                                    <iframe
                                        src={getYouTubeEmbedUrl(selectedVideo.url)}
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                        allowFullScreen
                                    ></iframe>
                                )}
                                {selectedVideo.type === 'vimeo' && (
                                    <iframe
                                        src={getVimeoEmbedUrl(selectedVideo.url)}
                                        allow="autoplay; fullscreen; picture-in-picture"
                                        allowFullScreen
                                    ></iframe>
                                )}
                                {selectedVideo.type === 'local' && (
                                    <video controls autoPlay>
                                        <source src={selectedVideo.url} type="video/mp4" />
                                        Your browser does not support the video tag.
                                    </video>
                                )}
                            </div>
                        </div>

                        {/* Right side - Content */}
                        <div className="modal-content-section">
                            <div className="modal-info">
                                <h2 className="modal-title">{selectedVideo.title}</h2>
                                <span className="modal-category">
                                    {selectedVideo.category.charAt(0).toUpperCase() + 
                                     selectedVideo.category.slice(1).toLowerCase()}
                                </span>
                                <p className="modal-description">{selectedVideo.description}</p>
                                
                                <div className="modal-meta">
                                    <div className="meta-item">
                                        <span className="meta-label">Duration</span>
                                        <span className="meta-value">{selectedVideo.duration}</span>
                                    </div>
                                    <div className="meta-item">
                                        <span className="meta-label">Type</span>
                                        <span className="meta-value">{selectedVideo.type}</span>
                                    </div>
                                </div>

                                <div className="modal-actions">
                                    <button 
                                        className="modal-btn modal-btn-primary"
                                        onClick={() => openInNewTab(selectedVideo.url)}
                                    >
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                            <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                                            <polyline points="15 3 21 3 21 9"></polyline>
                                            <line x1="10" y1="14" x2="21" y2="3"></line>
                                        </svg>
                                        Open Video
                                    </button>
                                    <button 
                                        className="modal-btn modal-btn-secondary"
                                        onClick={() => shareVideo(selectedVideo)}
                                    >
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                            <circle cx="18" cy="5" r="3"></circle>
                                            <circle cx="6" cy="12" r="3"></circle>
                                            <circle cx="18" cy="19" r="3"></circle>
                                            <line x1="8.59" y1="13.51" x2="15.42" y2="17.49"></line>
                                            <line x1="15.41" y1="6.51" x2="8.59" y2="10.49"></line>
                                        </svg>
                                        Share
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<VideoGallery />);