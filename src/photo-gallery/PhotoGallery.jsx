const { useState, useEffect } = React;

const PhotoGallery = () => {
    const [photos, setPhotos] = useState([]);
    const [selectedPhoto, setSelectedPhoto] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [activeCategory, setActiveCategory] = useState('All');
    const [loading, setLoading] = useState(true);
    const [categories, setCategories] = useState(['All']);
    const [error, setError] = useState(null);

    useEffect(() => {
        loadPhotosFromCSV();
    }, []);

    const loadPhotosFromCSV = async () => {
        try {
            setLoading(true);
            setError(null);

            // Fetch the CSV file from local folder
            const response = await fetch('photos.csv');
            
            if (!response.ok) {
                throw new Error('Failed to load photos.csv. Make sure the file exists in the same folder.');
            }

            const csvText = await response.text();
            
            // Parse CSV manually (simple parser)
            const lines = csvText.split('\n');
            const headers = lines[0].split(',').map(h => h.trim());
            
            const loadedPhotos = [];
            const categorySet = new Set();

            // Process each line (skip header)
            for (let i = 1; i < lines.length; i++) {
                const line = lines[i].trim();
                if (!line) continue; // Skip empty lines

                // Split by comma but handle commas in quotes
                const values = parseCSVLine(line);
                
                if (values.length >= 5) {
                    const photo = {
                        id: parseInt(values[0]) || i,
                        url: values[1].trim(),
                        title: values[2].trim(),
                        description: values[3].trim(),
                        category: values[4].trim(),
                        filename: values[2].trim().replace(/\s+/g, '_') + '.jpg'
                    };

                    loadedPhotos.push(photo);
                    
                    // Capitalize first letter of category
                    const formattedCategory = photo.category.charAt(0).toUpperCase() + 
                                            photo.category.slice(1).toLowerCase();
                    categorySet.add(formattedCategory);
                }
            }

            // Set photos and categories
            setPhotos(loadedPhotos);
            
            // Create categories array with 'All' first, then sorted categories
            const sortedCategories = ['All', ...Array.from(categorySet).sort()];
            setCategories(sortedCategories);
            
            setLoading(false);
        } catch (error) {
            console.error('Error loading photos from CSV:', error);
            setError(error.message);
            setLoading(false);
        }
    };

    // Helper function to parse CSV line (handles commas in quotes)
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

    const filteredPhotos = photos.filter(photo => {
        // Search matches against title and description from CSV
        const matchesSearch = photo.title.toLowerCase().includes(searchTerm.toLowerCase()) || 
                             photo.description.toLowerCase().includes(searchTerm.toLowerCase());
        
        // Normalize category comparison - compare normalized values
        const normalizedPhotoCategory = photo.category.charAt(0).toUpperCase() + 
                                       photo.category.slice(1).toLowerCase();
        const normalizedActiveCategory = activeCategory === 'All' ? 'All' : 
                                        activeCategory.charAt(0).toUpperCase() + 
                                        activeCategory.slice(1).toLowerCase();
        
        const matchesCategory = normalizedActiveCategory === 'All' || 
                               normalizedPhotoCategory === normalizedActiveCategory;
        
        return matchesSearch && matchesCategory;
    });

    const openModal = (photo) => {
        setSelectedPhoto(photo);
        document.body.style.overflow = 'hidden';
    };

    const closeModal = () => {
        setSelectedPhoto(null);
        document.body.style.overflow = 'auto';
    };

    const downloadPhoto = (photo) => {
        const link = document.createElement('a');
        link.href = photo.url;
        link.download = photo.filename;
        link.target = '_blank';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };

    const sharePhoto = (photo) => {
        if (navigator.share) {
            navigator.share({
                title: photo.title,
                text: photo.description,
                url: photo.url
            }).catch(err => console.log('Error sharing:', err));
        } else {
            // Fallback: copy link to clipboard
            navigator.clipboard.writeText(photo.url)
                .then(() => alert('Link copied to clipboard!'))
                .catch(err => console.log('Error copying:', err));
        }
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
                    <h1>Photo Gallery</h1>
                    <p>Discover beautiful moments captured in time</p>
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
                            placeholder="Search photos..."
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
                        <h3>Error Loading Photos</h3>
                        <p>{error}</p>
                        <p style={{marginTop: '10px', fontSize: '14px'}}>
                            Make sure <strong>photos.csv</strong> exists in the same folder as index.html
                        </p>
                    </div>
                )}

                {/* Photo Grid */}
                {!error && loading ? (
                    <div className="loading-state">
                        <p>Loading photos from CSV...</p>
                    </div>
                ) : !error && filteredPhotos.length === 0 ? (
                    <div className="empty-state">
                        <div className="empty-state-icon">📷</div>
                        <h3>No photos found</h3>
                        <p>Try adjusting your search or filter criteria</p>
                    </div>
                ) : !error && (
                    <div className="photo-grid">
                        {filteredPhotos.map(photo => (
                            <div 
                                key={photo.id}
                                className="photo-card"
                                onClick={() => openModal(photo)}
                            >
                                <div className="photo-image-container">
                                    <img 
                                        src={photo.url}
                                        alt={photo.title}
                                        className="photo-image"
                                        onError={(e) => {
                                            e.target.src = 'https://via.placeholder.com/800x600?text=Image+Not+Found';
                                        }}
                                    />
                                </div>
                                <div className="photo-info">
                                    <div className="photo-title">{photo.title}</div>
                                    <div className="photo-description">{photo.description}</div>
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </main>

            {/* Modal */}
            {selectedPhoto && (
                <div className="modal-overlay" onClick={closeModal}>
                    <div className="modal-content" onClick={(e) => e.stopPropagation()}>
                        <button className="modal-close" onClick={closeModal}>×</button>
                        <img 
                            src={selectedPhoto.url}
                            alt={selectedPhoto.title}
                            className="modal-image"
                            onError={(e) => {
                                e.target.src = 'https://via.placeholder.com/900x500?text=Image+Not+Found';
                            }}
                        />
                        <div className="modal-info">
                            <h2 className="modal-title">{selectedPhoto.title}</h2>
                            <span className="modal-category">
                                {selectedPhoto.category.charAt(0).toUpperCase() + 
                                 selectedPhoto.category.slice(1).toLowerCase()}
                            </span>
                            <p className="modal-description">{selectedPhoto.description}</p>
                            <div className="modal-actions">
                                <button 
                                    className="modal-btn modal-btn-primary"
                                    onClick={() => downloadPhoto(selectedPhoto)}
                                >
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                        <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                                        <polyline points="7 10 12 15 17 10"></polyline>
                                        <line x1="12" y1="15" x2="12" y2="3"></line>
                                    </svg>
                                    Download
                                </button>
                                <button 
                                    className="modal-btn modal-btn-secondary"
                                    onClick={() => sharePhoto(selectedPhoto)}
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
            )}
        </div>
    );
};

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<PhotoGallery />);