import { ComposableMap, Geographies, Geography, ZoomableGroup } from 'react-simple-maps';

const GEO_URL = 'https://cdn.jsdelivr.net/npm/world-atlas@2/countries-110m.json';

// Map ISO numeric codes to ISO alpha-3
const NUM_TO_ISO3 = {
  '004':'AFG','008':'ALB','012':'DZA','024':'AGO','032':'ARG','036':'AUS','040':'AUT',
  '050':'BGD','056':'BEL','068':'BOL','076':'BRA','100':'BGR','116':'KHM','120':'CMR',
  '124':'CAN','152':'CHL','156':'CHN','170':'COL','188':'CRI','191':'HRV','192':'CUB',
  '203':'CZE','208':'DNK','214':'DOM','218':'ECU','818':'EGY','222':'SLV','231':'ETH',
  '246':'FIN','250':'FRA','276':'DEU','288':'GHA','300':'GRC','320':'GTM','332':'HTI',
  '348':'HUN','356':'IND','360':'IDN','364':'IRN','368':'IRQ','372':'IRL','376':'ISR',
  '380':'ITA','388':'JAM','392':'JPN','400':'JOR','398':'KAZ','404':'KEN','408':'PRK',
  '410':'KOR','414':'KWT','418':'LAO','422':'LBN','430':'LBR','434':'LBY','442':'LUX',
  '458':'MYS','484':'MEX','496':'MNG','504':'MAR','508':'MOZ','524':'NPL','528':'NLD',
  '554':'NZL','566':'NGA','578':'NOR','586':'PAK','591':'PAN','604':'PER','608':'PHL',
  '616':'POL','620':'PRT','630':'PRI','634':'QAT','642':'ROU','643':'RUS','682':'SAU',
  '688':'SRB','694':'SLE','706':'SOM','710':'ZAF','724':'ESP','144':'LKA','752':'SWE',
  '756':'CHE','760':'SYR','158':'TWN','762':'TJK','764':'THA','768':'TGO','780':'TTO',
  '788':'TUN','792':'TUR','800':'UGA','804':'UKR','784':'ARE','826':'GBR','840':'USA',
  '858':'URY','860':'UZB','862':'VEN','704':'VNM','887':'YEM','894':'ZMB','716':'ZWE',
};

export default function WorldMap({ countries, selectedIso3, onSelect }) {
  const countrySet = new Set(countries.map(c => c.iso_alpha3));

  return (
    <ComposableMap projectionConfig={{ scale: 160 }} style={{ width: '100%', height: '100%' }}>
      <ZoomableGroup>
        <Geographies geography={GEO_URL}>
          {({ geographies }) =>
            geographies.map(geo => {
              const iso3     = NUM_TO_ISO3[geo.id] || '';
              const inDB     = countrySet.has(iso3);
              const selected = iso3 === selectedIso3;

              return (
                <Geography
                  key={geo.rsmKey}
                  geography={geo}
                  onClick={() => inDB && onSelect(iso3)}
                  style={{
                    default: {
                      fill:    selected ? '#f59e0b' : inDB ? '#3b82f6' : '#d1d5db',
                      stroke:  '#fff',
                      strokeWidth: 0.5,
                      outline: 'none',
                    },
                    hover: {
                      fill:    inDB ? '#2563eb' : '#d1d5db',
                      outline: 'none',
                      cursor:  inDB ? 'pointer' : 'default',
                    },
                    pressed: { outline: 'none' },
                  }}
                />
              );
            })
          }
        </Geographies>
      </ZoomableGroup>
    </ComposableMap>
  );
}
