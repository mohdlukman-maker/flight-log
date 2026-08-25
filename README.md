# Flight Log ✈️

An animated travel-route map — a single-file React component that plots your trip stops on a stylized vintage-world-map and flies a plane between them.

## Current features

- Add destinations via built-in city list (~100 cities worldwide) or free-text geocoding ([Nominatim](https://nominatim.openstreetmap.org/))
- Stops ordered by date, with bowed route arcs between them
- Animated flight playback: play / pause / restart, 0.5×–4× speed
- Trip stats: total distance (haversine, km), trip duration, leg count
- Hover / click pins for tooltips; chips list with remove
- Persistence via host `window.storage` API (with graceful no-op if absent)

## Roadmap

- [ ] Attach media (photos / video) to each stop, with EXIF-based auto-tagging
- [ ] Cinematic MP4 export (WebCodecs + canvas renderer)
- [ ] Optional dates + drag-to-reorder stops
- [ ] Camera-follow zoom and great-circle arcs
- [ ] Shareable trip links / JSON import-export
- [x] Runnable Vite app + multi-stage Dockerfile (nginx)

## Usage

**Run the dev server:**

```bash
npm install
npm run dev        # http://localhost:5173
```

**Build for production:**

```bash
npm run build      # static files in dist/
npm run preview    # serve the build locally
```

**Run with Docker:**

```bash
docker build -t flight-log .
docker run -p 8080:80 flight-log     # http://localhost:8080
```

**Use the component directly** — drop `flight-log.jsx` into any React app. Dependencies: `react`, `react-dom`, `lucide-react`.

```jsx
import TravelRouteMap from './flight-log';

function App() {
  return <TravelRouteMap />;
}
```

Persistence expects a host-provided `window.storage` API (`get`/`set` with `{value}` shape); without it, the map still works, it just won't remember stops between sessions.

## References / prior art

- [TripTrail](https://github.com/Fangyuan025/triptrail) — browser trip-map video studio (MapLibre + WebCodecs)
- [Travelback](https://github.com/Open330/travelback) — GPX/Location-History to cinematic video
- [GPX Animator](https://github.com/gpx-animator/gpx-animator) — the classic desktop tool
- [OpenFlights](https://github.com/jpatokal/openflights) — flight-history mapping
