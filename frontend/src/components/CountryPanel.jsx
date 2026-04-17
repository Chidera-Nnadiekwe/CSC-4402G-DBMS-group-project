import { useEffect, useState } from 'react';
import { getCountryTrade, getCountryBalance, getCountrySanctions } from '../services/api';

export default function CountryPanel({ iso3, countries }) {
  const [tab,       setTab]       = useState('trade');
  const [trade,     setTrade]     = useState([]);
  const [balance,   setBalance]   = useState([]);
  const [sanctions, setSanctions] = useState([]);
  const [loading,   setLoading]   = useState(false);

  const country = countries.find(c => c.iso_alpha3 === iso3);

  useEffect(() => {
    if (!iso3) return;
    setLoading(true);
    Promise.all([
      getCountryTrade(iso3),
      getCountryBalance(iso3),
      getCountrySanctions(iso3),
    ]).then(([t, b, s]) => {
      setTrade(t.data);
      setBalance(b.data);
      setSanctions(s.data);
      setLoading(false);
    });
  }, [iso3]);

  if (!iso3) return (
    <div className="panel empty">
      <p>Click a country on the map to explore its trade data.</p>
    </div>
  );

  return (
    <div className="panel">
      {country && (
        <div className="panel-header">
          <h2>{country.country_name}</h2>
          <div className="panel-meta">
            <span>{country.region_name}</span>
            <span>GDP: ${(country.gdp_usd / 1e12).toFixed(2)}T</span>
            <span>Pop: {(country.population / 1e6).toFixed(1)}M</span>
            <span>{country.wto_member ? '✓ WTO Member' : '✗ Non-WTO'}</span>
          </div>
        </div>
      )}

      <div className="tabs">
        {['trade', 'balance', 'sanctions'].map(t => (
          <button key={t} className={tab === t ? 'active' : ''} onClick={() => setTab(t)}>
            {t.charAt(0).toUpperCase() + t.slice(1)}
          </button>
        ))}
      </div>

      {loading ? <p className="loading">Loading...</p> : (
        <>
          {tab === 'trade' && (
            <div className="table-wrap">
              <table>
                <thead>
                  <tr>
                    <th>Exporter</th><th>Importer</th><th>Product</th>
                    <th>Year</th><th>Value (B$)</th>
                  </tr>
                </thead>
                <tbody>
                  {trade.map((r, i) => (
                    <tr key={i}>
                      <td>{r.exporter}</td>
                      <td>{r.importer}</td>
                      <td>{r.product_name}</td>
                      <td>{r.year}</td>
                      <td>${r.trade_value_bn_usd}B</td>
                    </tr>
                  ))}
                  {trade.length === 0 && <tr><td colSpan={5}>No trade data found.</td></tr>}
                </tbody>
              </table>
            </div>
          )}

          {tab === 'balance' && (
            <div className="table-wrap">
              <table>
                <thead>
                  <tr><th>Year</th><th>Exports (B$)</th><th>Imports (B$)</th><th>Balance (B$)</th></tr>
                </thead>
                <tbody>
                  {balance.map((r, i) => (
                    <tr key={i}>
                      <td>{r.year}</td>
                      <td>${(r.exports_usd / 1e9).toFixed(1)}B</td>
                      <td>${(Math.abs(r.imports_neg_usd) / 1e9).toFixed(1)}B</td>
                      <td className={r.trade_balance_usd > 0 ? 'surplus' : 'deficit'}>
                        {r.trade_balance_usd > 0 ? '▲' : '▼'} ${(Math.abs(r.trade_balance_usd) / 1e9).toFixed(1)}B
                      </td>
                    </tr>
                  ))}
                  {balance.length === 0 && <tr><td colSpan={4}>No balance data found.</td></tr>}
                </tbody>
              </table>
            </div>
          )}

          {tab === 'sanctions' && (
            <div className="table-wrap">
              <table>
                <thead>
                  <tr><th>Imposing</th><th>Target</th><th>Type</th><th>Start</th><th>End</th></tr>
                </thead>
                <tbody>
                  {sanctions.map((r, i) => (
                    <tr key={i}>
                      <td>{r.imposing_country}</td>
                      <td>{r.target_country}</td>
                      <td>{r.sanction_type}</td>
                      <td>{r.start_date?.split('T')[0]}</td>
                      <td>{r.end_date ? r.end_date.split('T')[0] : 'Active'}</td>
                    </tr>
                  ))}
                  {sanctions.length === 0 && <tr><td colSpan={5}>No sanctions found.</td></tr>}
                </tbody>
              </table>
            </div>
          )}
        </>
      )}
    </div>
  );
}
