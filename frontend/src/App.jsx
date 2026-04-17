import { useEffect, useState } from 'react';
import WorldMap     from './components/WorldMap';
import CountryPanel from './components/CountryPanel';
import { getCountries } from './services/api';
import './App.css';

export default function App() {
  const [countries,    setCountries]    = useState([]);
  const [selectedIso3, setSelectedIso3] = useState(null);

  useEffect(() => {
    getCountries().then(res => setCountries(res.data));
  }, []);

  return (
    <div className="app">
      <header className="app-header">
        <h1>🌍 International Trade Relations Database</h1>
        <p>Click on a country to explore its trade data</p>
      </header>

      <div className="app-body">
        <div className="map-container">
          <WorldMap
            countries={countries}
            selectedIso3={selectedIso3}
            onSelect={setSelectedIso3}
          />
        </div>

        <div className="panel-container">
          <CountryPanel iso3={selectedIso3} countries={countries} />
        </div>
      </div>
    </div>
  );
}
