const { useState, useEffect, useRef } = React;

const StockGallery = () => {
    const [stocks, setStocks] = useState([]);
    const [selectedStock, setSelectedStock] = useState(null);
    const [searchTerm, setSearchTerm] = useState('');
    const [activeCategory, setActiveCategory] = useState('All');
    const [loading, setLoading] = useState(true);
    const [categories, setCategories] = useState(['All']);
    const [error, setError] = useState(null);
    const chartRef = useRef(null);
    const chartInstance = useRef(null);

    useEffect(() => {
        loadStocksFromCSV();
    }, []);

    useEffect(() => {
        if (selectedStock && chartRef.current) {
            renderChart();
        }
        return () => {
            if (chartInstance.current) {
                chartInstance.current.destroy();
                chartInstance.current = null;
            }
        };
    }, [selectedStock]);

    const loadStocksFromCSV = async () => {
        try {
            setLoading(true);
            setError(null);

            const response = await fetch('stocks.csv');
            
            if (!response.ok) {
                throw new Error('Failed to load stocks.csv. Make sure the file exists in the same folder.');
            }

            const csvText = await response.text();
            const lines = csvText.split('\n');
            
            const loadedStocks = [];
            const categorySet = new Set();

            for (let i = 1; i < lines.length; i++) {
                const line = lines[i].trim();
                if (!line) continue;

                const values = parseCSVLine(line);
                
                if (values.length >= 11) {
                    const historicalData = values[10].split(';').map(price => parseFloat(price));
                    
                    const stock = {
                        id: parseInt(values[0]) || i,
                        symbol: values[1].trim(),
                        name: values[2].trim(),
                        price: parseFloat(values[3]),
                        change: parseFloat(values[4]),
                        changePercent: parseFloat(values[5]),
                        volume: values[6].trim(),
                        marketCap: values[7].trim(),
                        sector: values[8].trim(),
                        description: values[9].trim(),
                        historicalData: historicalData,
                        exchange: values[11] ? values[11].trim() : 'NASDAQ'
                    };

                    loadedStocks.push(stock);
                    
                    const formattedSector = stock.sector.charAt(0).toUpperCase() + 
                                           stock.sector.slice(1).toLowerCase();
                    categorySet.add(formattedSector);
                }
            }

            setStocks(loadedStocks);
            const sortedCategories = ['All', ...Array.from(categorySet).sort()];
            setCategories(sortedCategories);
            setLoading(false);
        } catch (error) {
            console.error('Error loading stocks from CSV:', error);
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

    const renderChart = () => {
        if (!chartRef.current || !selectedStock) return;

        // Destroy existing chart
        if (chartInstance.current) {
            chartInstance.current.destroy();
        }

        const ctx = chartRef.current.getContext('2d');
        const labels = selectedStock.historicalData.map((_, index) => 
            `Day ${selectedStock.historicalData.length - index}`
        ).reverse();
        
        const isPositive = selectedStock.change >= 0;
        
        chartInstance.current = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: selectedStock.symbol,
                    data: selectedStock.historicalData,
                    borderColor: isPositive ? '#10b981' : '#ef4444',
                    backgroundColor: isPositive ? 'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    pointBackgroundColor: '#fff',
                    pointBorderWidth: 2,
                    pointHoverBorderWidth: 3
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        titleFont: {
                            size: 14,
                            weight: 'bold'
                        },
                        bodyFont: {
                            size: 13
                        },
                        callbacks: {
                            label: function(context) {
                                return '$' + context.parsed.y.toFixed(2);
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        ticks: {
                            callback: function(value) {
                                return '$' + value.toFixed(0);
                            },
                            font: {
                                size: 12
                            },
                            color: '#666'
                        },
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        }
                    },
                    x: {
                        ticks: {
                            font: {
                                size: 11
                            },
                            color: '#666',
                            maxRotation: 0
                        },
                        grid: {
                            display: false
                        }
                    }
                },
                interaction: {
                    mode: 'nearest',
                    axis: 'x',
                    intersect: false
                }
            }
        });
    };

    const renderMiniChart = (stockData) => {
        return (
            <svg width="100%" height="80" viewBox="0 0 200 80" preserveAspectRatio="none">
                <polyline
                    fill="none"
                    stroke={stockData.change >= 0 ? '#10b981' : '#ef4444'}
                    strokeWidth="2"
                    points={stockData.historicalData.map((price, index) => {
                        const x = (index / (stockData.historicalData.length - 1)) * 200;
                        const minPrice = Math.min(...stockData.historicalData);
                        const maxPrice = Math.max(...stockData.historicalData);
                        const y = 70 - ((price - minPrice) / (maxPrice - minPrice)) * 60;
                        return `${x},${y}`;
                    }).join(' ')}
                />
            </svg>
        );
    };

    const filteredStocks = stocks.filter(stock => {
        const matchesSearch = stock.symbol.toLowerCase().includes(searchTerm.toLowerCase()) || 
                             stock.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                             stock.description.toLowerCase().includes(searchTerm.toLowerCase());
        
        const normalizedStockSector = stock.sector.charAt(0).toUpperCase() + 
                                      stock.sector.slice(1).toLowerCase();
        const normalizedActiveCategory = activeCategory === 'All' ? 'All' : 
                                        activeCategory.charAt(0).toUpperCase() + 
                                        activeCategory.slice(1).toLowerCase();
        
        const matchesCategory = normalizedActiveCategory === 'All' || 
                               normalizedStockSector === normalizedActiveCategory;
        
        return matchesSearch && matchesCategory;
    });

    const openModal = (stock) => {
        setSelectedStock(stock);
        document.body.style.overflow = 'hidden';
    };

    const closeModal = () => {
        setSelectedStock(null);
        document.body.style.overflow = 'auto';
        if (chartInstance.current) {
            chartInstance.current.destroy();
            chartInstance.current = null;
        }
    };

    const formatNumber = (num) => {
        return new Intl.NumberFormat('en-US').format(num);
    };

    return (
        <div className="container">
            {/* Sidebar */}
            <aside className="sidebar">
                <h2>Sectors</h2>
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
                    <h1>Stock Market Gallery</h1>
                    <p>Track and analyze your favorite stocks in real-time</p>
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
                            placeholder="Search stocks by symbol or name..."
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
                        <h3>Error Loading Stocks</h3>
                        <p>{error}</p>
                        <p style={{marginTop: '10px', fontSize: '14px'}}>
                            Make sure <strong>stocks.csv</strong> exists in the same folder as index.html
                        </p>
                    </div>
                )}

                {/* Stock Grid */}
                {!error && loading ? (
                    <div className="loading-state">
                        <p>Loading stocks from CSV...</p>
                    </div>
                ) : !error && filteredStocks.length === 0 ? (
                    <div className="empty-state">
                        <div className="empty-state-icon">📈</div>
                        <h3>No stocks found</h3>
                        <p>Try adjusting your search or filter criteria</p>
                    </div>
                ) : !error && (
                    <div className="stock-grid">
                        {filteredStocks.map(stock => (
                            <div 
                                key={stock.id}
                                className="stock-card"
                                onClick={() => openModal(stock)}
                            >
                                <div className="stock-header">
                                    <div className="stock-symbol-row">
                                        <span className="stock-symbol">{stock.symbol}</span>
                                        <span className="stock-exchange">{stock.exchange}</span>
                                    </div>
                                    <div className="stock-name">{stock.name}</div>
                                    <div className="stock-price-row">
                                        <span className="stock-price">${stock.price.toFixed(2)}</span>
                                        <span className={`stock-change ${stock.change >= 0 ? 'positive' : 'negative'}`}>
                                            {stock.change >= 0 ? '+' : ''}{stock.changePercent.toFixed(2)}%
                                        </span>
                                    </div>
                                </div>
                                <div className="stock-mini-chart">
                                    {renderMiniChart(stock)}
                                </div>
                                <div className="stock-info">
                                    <div className="stock-metrics">
                                        <div className="metric">
                                            <div className="metric-label">Volume</div>
                                            <div className="metric-value">{stock.volume}</div>
                                        </div>
                                        <div className="metric">
                                            <div className="metric-label">Market Cap</div>
                                            <div className="metric-value">{stock.marketCap}</div>
                                        </div>
                                    </div>
                                    <div className="stock-description">{stock.description}</div>
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </main>

            {/* Modal */}
            {selectedStock && (
                <div className="modal-overlay" onClick={closeModal}>
                    <div className="modal-content" onClick={(e) => e.stopPropagation()}>
                        <button className="modal-close" onClick={closeModal}>×</button>
                        
                        {/* Left side - Chart */}
                        <div className="modal-chart-section">
                            <div className="chart-header">
                                <div className="chart-stock-info">
                                    <span className="chart-symbol">{selectedStock.symbol}</span>
                                    <span className="chart-exchange-badge">{selectedStock.exchange}</span>
                                </div>
                                <div className="chart-name">{selectedStock.name}</div>
                                <div className="chart-price-info">
                                    <span className="chart-price">${selectedStock.price.toFixed(2)}</span>
                                    <span className={`chart-change ${selectedStock.change >= 0 ? 'positive' : 'negative'}`}>
                                        {selectedStock.change >= 0 ? '+' : ''}{selectedStock.change.toFixed(2)} 
                                        ({selectedStock.change >= 0 ? '+' : ''}{selectedStock.changePercent.toFixed(2)}%)
                                    </span>
                                </div>
                            </div>
                            <div className="chart-container">
                                <canvas ref={chartRef}></canvas>
                            </div>
                        </div>

                        {/* Right side - Content */}
                        <div className="modal-content-section">
                            <div className="modal-info">
                                <h2 className="modal-title">{selectedStock.name}</h2>
                                <span className="modal-category">
                                    {selectedStock.sector.charAt(0).toUpperCase() + 
                                     selectedStock.sector.slice(1).toLowerCase()}
                                </span>
                                <p className="modal-description">{selectedStock.description}</p>
                                
                                <div className="stats-grid">
                                    <div className="stat-item">
                                        <div className="stat-label">Current Price</div>
                                        <div className="stat-value">${selectedStock.price.toFixed(2)}</div>
                                    </div>
                                    <div className="stat-item">
                                        <div className="stat-label">Change</div>
                                        <div className="stat-value" style={{color: selectedStock.change >= 0 ? '#10b981' : '#ef4444'}}>
                                            {selectedStock.change >= 0 ? '+' : ''}{selectedStock.change.toFixed(2)}
                                        </div>
                                    </div>
                                    <div className="stat-item">
                                        <div className="stat-label">Volume</div>
                                        <div className="stat-value">{selectedStock.volume}</div>
                                    </div>
                                    <div className="stat-item">
                                        <div className="stat-label">Market Cap</div>
                                        <div className="stat-value">{selectedStock.marketCap}</div>
                                    </div>
                                    <div className="stat-item">
                                        <div className="stat-label">% Change</div>
                                        <div className="stat-value" style={{color: selectedStock.changePercent >= 0 ? '#10b981' : '#ef4444'}}>
                                            {selectedStock.changePercent >= 0 ? '+' : ''}{selectedStock.changePercent.toFixed(2)}%
                                        </div>
                                    </div>
                                    <div className="stat-item">
                                        <div className="stat-label">Exchange</div>
                                        <div className="stat-value">{selectedStock.exchange}</div>
                                    </div>
                                </div>

                                <div className="modal-actions">
                                    <button 
                                        className="modal-btn modal-btn-primary"
                                        onClick={() => window.open(`https://finance.yahoo.com/quote/${selectedStock.symbol}`, '_blank')}
                                    >
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                                            <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
                                            <polyline points="15 3 21 3 21 9"></polyline>
                                            <line x1="10" y1="14" x2="21" y2="3"></line>
                                        </svg>
                                        View Details
                                    </button>
                                    <button 
                                        className="modal-btn modal-btn-secondary"
                                        onClick={() => {
                                            const text = `${selectedStock.symbol} - ${selectedStock.name}: ${selectedStock.price.toFixed(2)} (${selectedStock.changePercent >= 0 ? '+' : ''}${selectedStock.changePercent.toFixed(2)}%)`;
                                            if (navigator.share) {
                                                navigator.share({ text: text })
                                                    .catch(err => console.log('Error sharing:', err));
                                            } else {
                                                navigator.clipboard.writeText(text)
                                                    .then(() => alert('Stock info copied to clipboard!'))
                                                    .catch(err => console.log('Error copying:', err));
                                            }
                                        }}
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
root.render(<StockGallery />);