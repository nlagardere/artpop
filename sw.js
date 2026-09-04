const CACHE_NAME = 'artpop-revive-v1';

// Liste des pages et ressources principales à mettre en cache au démarrage
const STATIC_ASSETS = [
  './',
  './index.html',
  './home.html',
  './onboarding.html',
  './welcome.html',
  './manifest.json',
  './Players/selector.html',
  './Players/ArtPop/main.html',
  './Players/BornThisWay/main.html',
  './Players/Chromatica/main.html',
  './Players/Joanne/main.html',
  './Players/Mayhem/main.html',
  './Players/TheFame/main.html',
  './Players/TheFameMonster/main.html'
];

// Installation : Mise en cache des fichiers de base
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(STATIC_ASSETS);
    })
  );
  self.skipWaiting();
});

// Activation : Nettoyage des anciens caches si tu fais des mises à jour
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
      );
    })
  );
  self.clients.claim();
});

// Interception des requêtes : Réseau en premier, et mise en cache automatique des musiques/vidéos lues
self.addEventListener('fetch', (event) => {
  event.respondWith(
    fetch(event.request)
      .then((response) => {
        // Si la requête réussit, on met une copie de la réponse en cache (pour les MP3, MP4, etc.)
        if (response.status === 200) {
          const responseClone = response.clone();
          caches.open(CACHE_NAME).then((cache) => {
            cache.put(event.request, responseClone);
          });
        }
        return response;
      })
      .catch(() => caches.match(event.request)) // Si pas d'accès réseau, on prend depuis le cache
  );
});