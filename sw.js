const CACHE_NAME = 'artpop-revive-v4'; // Nouvelle version pour forcer Safari à tout recalculer

// Ressources HTML/JSON à pré-cacher absolument
const STATIC_ASSETS = [
  './',
  './index.html',
  './home.html',
  './welcome.html',
  './onboarding.html',
  './players.html',
  './manifest.json',
  './assets/logo.png',
  './assets/logos/ios/512.png',
  './assets/artworks/artpop.jpg',
  './assets/artworks/bornthisway.jpg',
  './assets/artworks/chromatica.jpg',
  './assets/artworks/joanne.jpg',
  './assets/artworks/mayhem.jpg',
  './assets/artworks/TheFame.jpg',
  './assets/artworks/TheFameMonster2.jpg'
];

// Installation : Mise en cache des pages et artworks clés
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(STATIC_ASSETS);
    })
  );
  self.skipWaiting();
});

// Activation : Suppression des anciens caches obsolètes + prise de contrôle immédiate
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
      );
    }).then(() => self.clients.claim())
  );
});

// Interception : Réseau en premier avec contournement du cache Safari pour le HTML
self.addEventListener('fetch', (event) => {
  if (event.request.method !== 'GET') return;

  // On ignore le cache pour les MP3/MP4 volumineux afin d'éviter de saturer le stockage Safari iOS
  const isMedia = event.request.url.endsWith('.mp3') || event.request.url.endsWith('.mp4');

  if (isMedia) {
    event.respondWith(fetch(event.request));
    return;
  }

  event.respondWith(
    fetch(event.request, { cache: 'reload' })
      .then((response) => {
        if (response.status === 200) {
          const responseClone = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseClone);
          });
        }
        return response;
      })
      .catch(() => caches.match(event.request))
  );
});