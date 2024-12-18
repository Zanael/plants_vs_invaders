'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"main.dart.js": "8381fa19d1ce6267965c814ba1305bd0",
"assets/FontManifest.json": "fce87c7f19824599b00f38732ba23cd1",
"assets/AssetManifest.bin": "bb58bcef1bbabae9a1a672f15146c1db",
"assets/fonts/RubikBubbles-Regular.ttf": "d679db2357f4dc4c46a82667addeaf83",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/assets/tiles/level.tmx": "b48811b51f8413b418045989593e32f6",
"assets/assets/tiles/plants_vs_invaders.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/plants_vs_invaders.tiled-session": "a3d22261889b59e3022c12429ef56848",
"assets/assets/images/levels_map.png": "e8c7757afb117ce8eb68a97c94150a7b",
"assets/assets/images/main_menu.png": "0cf3854f85cbd54778fbaff953217a85",
"assets/assets/images/levels/score_table/score_table.png": "b46e7e891c4864ba13e512e932817afc",
"assets/assets/images/levels/player/heal/player_heal_right.png": "48b9b33f1c82a3f89a931a7fff13a7b0",
"assets/assets/images/levels/player/heal/player_heal_down.png": "35312923685122e55bdc05dbe3e25228",
"assets/assets/images/levels/player/heal/player_heal_left.png": "23b6862ff6f204808858af57be456190",
"assets/assets/images/levels/player/heal/player_heal_up.png": "bc9afeb7b2d40b50148206192772e9bd",
"assets/assets/images/levels/player/run/player_run_left.png": "faf73fa2025b88a7eb11ed5549c719a2",
"assets/assets/images/levels/player/run/player_run_up.png": "113828ebe1193ff9e520ef99fb8c7045",
"assets/assets/images/levels/player/run/player_run_down.png": "86284790a94ac90e1c63f1fa2e1cd456",
"assets/assets/images/levels/player/run/player_run_right.png": "5b644c5aa40a47fcd7fe9e066af72391",
"assets/assets/images/levels/player/idle/player_idle_left.png": "6f66c6703108f8bd7e9f26930047748f",
"assets/assets/images/levels/player/idle/player_idle_up.png": "86e310d4f465de3964b744caddebcdbd",
"assets/assets/images/levels/player/idle/player_idle_right.png": "87ab2c18731f0638e2b42f646ca6c351",
"assets/assets/images/levels/player/idle/player_idle_down.png": "5ab19dc00bce42eff7c4ce8a099d4a49",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_down.png": "e05df49a7f7e8c24836ef0cd04de1483",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_right.png": "721d238041a05da79deacf85154b490e",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_up.png": "21a16c33412db5a54f4dc1a935ccaf3f",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_left.png": "db5eb5de918866b133e882dda7114eb2",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_up.png": "5fb3919151ecf1450ebf6f8eee23e81b",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_down.png": "42205f3a1b571b61c14cb3d0e77f5e07",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_right.png": "f785d6ed049f1d146f6c4d2e58dc533a",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_left.png": "cc007daaa71eca273e7da4f1179f5ad3",
"assets/assets/images/levels/level_loading_background/level_loading_background_idle.jpg": "4dd5cf074d57c8a8b4ceb52abab97137",
"assets/assets/images/levels/plane_cloud/plane_cloud.png": "0101d4ae803809898df158164c1a92c2",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_attack.png": "5e5e78840770a0da8cf0a3030c5d3f1e",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_run.png": "2b2b70c9f41e2a239868931c0aac61fd",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_idle.png": "2481f2b162cb35f6ceaa234b9db381ad",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_hit.png": "3c9bd7164271adf93403af2a4de31791",
"assets/assets/images/levels/insects/mole/mole_attack.png": "6db0c81065d096d25c729e163999fb2c",
"assets/assets/images/levels/insects/mole/mole_run.png": "36133be7345863725d72bf84fd4fa334",
"assets/assets/images/levels/insects/mole/mole_hit.png": "917e1fbddef3a3174869a8c0f687582a",
"assets/assets/images/levels/insects/mole/mole_idle.png": "56cc577681119e59fe704d4850f5aedf",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_attack.png": "b3ae7ef5a41bbaf064df0b27cbf53eae",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_run.png": "6c3501f714a9e3041b3dcc8f52af5c27",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_hit.png": "501fde1ddd02c02c8bac6460a96faa08",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_idle.png": "4df9faf583d72ff1fc15067fbb45c7df",
"assets/assets/images/levels/insects/slug/slug_run.png": "7a6f20449812b4cdc1b1f974473934be",
"assets/assets/images/levels/insects/slug/slug_idle.png": "9f2864e6b89595fd72e4b142373a03c9",
"assets/assets/images/levels/insects/slug/slug_attack.png": "f54898a07ac6634b138fcc916e994137",
"assets/assets/images/levels/insects/slug/slug_hit.png": "4d09b4cc978b99b79a3bde097fa491fe",
"assets/assets/images/levels/menu/menu_button.png": "8e0b56bffc882b214f11e80a7a5c4438",
"assets/assets/images/levels/flags/red.png": "d860775b8e47175875bf37aeb77671f2",
"assets/assets/images/levels/plants/weeds/dandelion/dandelion_idle.png": "3b98e6536face459620329fa05ec3f62",
"assets/assets/images/levels/plants/weeds/dandelion/dandelion_hit.png": "1ad37b570982023807248ea2cc18db69",
"assets/assets/images/levels/plants/weeds/hogweed/hogweed_hit.png": "21fc72fe63f9214ed49b798a61ddd214",
"assets/assets/images/levels/plants/weeds/hogweed/hogweed_idle.png": "6a6f3f7a144ca4094a9f53487081280a",
"assets/assets/images/levels/plants/weeds/wheatgrass/wheatgrass_hit.png": "74db18710702f17c4446c03d1488ab5d",
"assets/assets/images/levels/plants/weeds/wheatgrass/wheatgrass_idle.png": "400016c70ef43a7c82fe9a77d6e2feff",
"assets/assets/images/levels/plants/weeds/shepherds_purse/shepherds_purse_idle.png": "3000f0f173ba074a55cd9452c065fb7a",
"assets/assets/images/levels/plants/weeds/shepherds_purse/shepherds_purse_hit.png": "7d5b2b0638ae1b9d3098f58496be4d36",
"assets/assets/images/levels/plants/weeds/bindweed/bindweed_hit.png": "3de695830dd4bfa84a9a03278f5d6dc3",
"assets/assets/images/levels/plants/weeds/bindweed/bindweed_idle.png": "c5c8b9b2785bb49b0819ab96d7a83f7c",
"assets/assets/images/levels/plants/base/corn/corn_idle.png": "c4bbc9130afe44fc5140edad365eb584",
"assets/assets/images/levels/plants/base/beet/beet_idle.png": "a6ff5b2a699ea65264976019be295696",
"assets/assets/images/levels/plants/base/carrot/carrot_idle.png": "e4a9b730ca91357e4917171604ed9a80",
"assets/assets/images/levels/plants/base/cabbage/cabbage_idle.png": "e283ff819f45504046a61424c1252b8c",
"assets/assets/images/levels/plants/base/potato/potato_idle.png": "9463bd93a40de0d6a9bf5002375c4d98",
"assets/assets/images/levels/plants/base/wheat/wheat_idle.png": "6d59d441a0880bc9739f9eba0e58cd64",
"assets/assets/images/levels/plants/defenders/peas/peas_hit.png": "3a7d76e600a71c3957c02fe358cfe43a",
"assets/assets/images/levels/plants/defenders/peas/peas_idle.png": "8e0eb578e919093afc015ea05841ab29",
"assets/assets/images/levels/plants/defenders/buckwheat/buckwheat_idle.png": "13413f2552dfe82b3620ec39d966ab34",
"assets/assets/images/levels/plants/defenders/buckwheat/buckwheat_hit.png": "b3b227ca06eaed9dc247dc5bdf493fa6",
"assets/assets/images/levels/plants/defenders/clover/clover_hit.png": "f23b5fd9524659513c07896b4db9100d",
"assets/assets/images/levels/plants/defenders/clover/clover_idle.png": "ed00340654d400a4dbf73d540c3a57af",
"assets/assets/images/levels/plants/defenders/oats/oats_hit.png": "3c912b632cad4bb8418b4d8a45047cf6",
"assets/assets/images/levels/plants/defenders/oats/oats_idle.png": "1898f01e6b9a3dbbb01ea0c5f35b597c",
"assets/assets/images/levels/resources/energy.png": "ab0755e86c580cc8dbb1f3b7c9c8e908",
"assets/assets/images/levels/resources/sun.png": "3be16c69cacb23b76fdf8ea7ae35080f",
"assets/assets/images/levels/wind_generator/wind_generator_idle.png": "bfeff2ac26aa1be290abf216f98ab5d8",
"assets/assets/images/levels/background/level_background.png": "d667ca0ea653c7336a9c7d24c691e8dd",
"assets/assets/images/levels/energy_cards/plane.png": "3994807190822cfacaf63d8ff66a0285",
"assets/assets/images/levels/sun_cards/buckwheat.png": "622b5015b9936a5af7d31c31349c49ee",
"assets/assets/images/levels/sun_cards/peas.png": "affb053d56c169a23a0ddacb76a9062f",
"assets/assets/images/levels/sun_cards/oats.png": "314fb34ca39bbb7f9ec48e041a4fa3fc",
"assets/assets/images/levels/sun_cards/clover.png": "2ae619e73eb0ad8e5adf8c92cac92da9",
"assets/assets/images/levels/fields/carrot.png": "c4b02c833a28d97737d0de6e9ad72c76",
"assets/assets/images/levels/fields/potato.png": "673726bb140c5596ed054194906ec496",
"assets/assets/images/levels/plane/plane.png": "6aaf4b05bcfd4a441528fb7144dd9416",
"assets/assets/images/levels/bullets/peas/peas.png": "4a14a430c47df9114d6b980385f0b521",
"assets/assets/images/levels/bullets/buckwheat/buckwheat.png": "9edbbfaac8ef16999ae659778b5164cb",
"assets/assets/images/levels/bullets/clover/clover.png": "c263a0bb5b27f895454c0430f0a2cd75",
"assets/assets/images/levels/bullets/oats/oats.png": "15fa82bd1e8b9ac5855fbf7cef76c63a",
"assets/assets/images/levels/spell_book/spell_book.png": "8e689312c525824e27532f018e68bf39",
"assets/assets/images/levels/potions/circle/circle_yellow_potion_32.png": "78bc4ea4c6601cc04cb501ee0a763641",
"assets/assets/images/levels/potions/circle/circle_blue_potion_32.png": "3336e4a2487d53733533ccb73164cbd7",
"assets/assets/images/levels/potions/circle/circle_blue_potion_64.png": "3336e4a2487d53733533ccb73164cbd7",
"assets/assets/images/levels/potions/circle/circle_red_potion_32.png": "28352752b0dd9f03917a38d0b30a4129",
"assets/assets/images/levels/potions/circle/circle_yellow_potion_64.png": "78bc4ea4c6601cc04cb501ee0a763641",
"assets/assets/images/levels/potions/circle/circle_red_potion_64.png": "28352752b0dd9f03917a38d0b30a4129",
"assets/assets/images/levels/potions/rect/rect_yellow_potion_32.png": "4f14da55a007bdc40082070bed1090ee",
"assets/assets/images/levels/potions/rect/rect_blue_potion_32.png": "03d2ac852cce78a0dbfdc04b9883467a",
"assets/assets/images/levels/potions/rect/rect_red_potion_32.png": "ebe220dc461f7c0504769e3bc0bddd4c",
"assets/assets/images/levels/potions/rect/rect_yellow_potion_64.png": "4f14da55a007bdc40082070bed1090ee",
"assets/assets/images/levels/potions/rect/rect_red_potion_64.png": "ebe220dc461f7c0504769e3bc0bddd4c",
"assets/assets/images/levels/potions/rect/rect_blue_potion_64.png": "03d2ac852cce78a0dbfdc04b9883467a",
"assets/assets/images/levels/sun_generator/sun_generator_idle.png": "4d2b9df3a2fed667c2d3f5e05789c79d",
"assets/assets/images/levels/sun/sun_clouds.png": "949a3a0374d5750573ac768c3babbba0",
"assets/assets/images/levels/sun/sun_clean.png": "072ecb6fa273f2efccf3dc972b0c529c",
"assets/assets/images/level_preview/carrot.png": "de11ce960ec5b9b0f23c4d3ed42f9f88",
"assets/assets/images/level_preview/potato.png": "e3ce297f849e446d74f084c7805b97c8",
"assets/NOTICES": "5c6b0de129ab71385d2c44fbf7e7347a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "2747ad4ad4b560b824ecdcfe635dffe3",
"assets/AssetManifest.bin.json": "c60569b4964ede7568d32111a0052d71",
"index.html": "b55208b5631f8a788fa0b1eb0ef2f3e1",
"/": "b55208b5631f8a788fa0b1eb0ef2f3e1",
"manifest.json": "beed7d7a596062a185d7d6e488f0e5ad",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "4db9020648129b20632db40555790915",
"flutter_bootstrap.js": "4d01e4f4e64c6660da31eedc06929c57"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
