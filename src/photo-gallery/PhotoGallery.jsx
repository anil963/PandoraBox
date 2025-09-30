const { useState, useEffect } = React;

const PhotoGallery = () => {
    const [photos, setPhotos] = useState([]);
    const [selectedPhoto, setSelectedPhoto] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [activeCategory, setActiveCategory] = useState('All');
    const [loading, setLoading] = useState(true);
    const [categories, setCategories] = useState(['All']);

    useEffect(() => {
        loadPhotosFromAssets();
    }, []);

    const loadPhotosFromAssets = async () => {
        try {
            // Define the folder structure
            const folderStructure = {
                'Nature': ['nature1.jpg', 'nature2.jpg', 'nature3.jpg'],
                'City': ['city1.jpg', 'city2.jpg', 'city3.jpg'],
                'Food': ['food1.jpg', 'food2.jpg', 'food3.jpg'],
                'Travel': ['travel1.jpg', 'travel2.jpg', 'travel3.jpg']
            };

            const loadedPhotos = [];
            let photoId = 1;

            // Extract categories
            const allCategories = ['All', ...Object.keys(folderStructure)];
            setCategories(allCategories);

            // Load photos from each category folder
            for (const [category, files] of Object.entries(folderStructure)) {
                for (const filename of files) {
                    const photoPath = `Assets/${category}/${filename}`;
                    
                    // Extract photo name without extension
                    const photoName = filename.replace(/\.[^/.]+$/, '');
                    const formattedName = photoName
                        .replace(/([a-z])([0-9])/gi, '$1 $2')
                        .replace(/([A-Z])/g, ' $1')
                        .trim()
                        .split(' ')
                        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
                        .join(' ');

                    loadedPhotos.push({
                        id: photoId++,
                        title: formattedName,
                        description: `Beautiful ${category.toLowerCase()} photo`,
                        category: category,
                        url: photoPath,
                        filename: filename
                    });
                }
            }

            setPhotos(loadedPhotos);
            setLoading(false);
        } catch (error) {
            console.error('Error loading photos:', error);
            setLoading(false);
        }
    };

    const filteredPhotos = photos.filter(photo => {
        const matchesSearch = photo.title.toLowerCase().includes(searchTerm.toLowerCase()) || 
                             photo.description.toLowerCase().includes(searchTerm.toLowerCase());
        const matchesCategory = activeCategory === 'All' || photo.category === activeCategory;
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
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
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

                {/* Photo Grid */}
                {loading ? (
                    <div className="loading-state">
                        <p>Loading photos...</p>
                    </div>
                ) : filteredPhotos.length === 0 ? (
                    <div className="empty-state">
                        <div className="empty-state-icon">📷</div>
                        <h3>No photos found</h3>
                        <p>Try adjusting your search or filter criteria</p>
                    </div>
                ) : (
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
                        />
                        <div className="modal-info">
                            <h2 className="modal-title">{selectedPhoto.title}</h2>
                            <span className="modal-category">{selectedPhoto.category}</span>
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
                                <button className="modal-btn modal-btn-secondary">
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