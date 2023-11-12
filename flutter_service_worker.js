'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"assets/FontManifest.json": "fce87c7f19824599b00f38732ba23cd1",
"assets/AssetManifest.bin": "acd206c2eee4bc47f55f7953fa49dc02",
"assets/assets/tiles/level.tmx": "f1501b5d5452987652fe4a0bf2e3cd3b",
"assets/assets/tiles/plants_vs_invaders.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/plants_vs_invaders.tiled-session": "56116d972b50d328297c80fa8b7d7d74",
"assets/assets/images/level_preview/potato.png": "c976955adcab0bcfe8c89882a040b5c3",
"assets/assets/images/level_preview/carrot.png": "92a7fa89d836ec82af22e6a5ce0a1cf5",
"assets/assets/images/levels_map.png": "94a96ffb0284c91079cadea534b9fa23",
"assets/assets/images/main_menu.png": "11208290cea2a3fd772b64ee0fe2c074",
"assets/assets/images/levels/menu/menu_button.png": "344ecac1c50dd21ecb98e611a14a04ca",
"assets/assets/images/levels/plane/plane.png": "b943f345a33232c80f0d1e78421cc504",
"assets/assets/images/levels/wind_generator/wind_generator_idle.png": "da3945804df2405071043313eafdaf1d",
"assets/assets/images/levels/sun/sun_clouds.png": "6064e12d345151293f63f44ba316c9e1",
"assets/assets/images/levels/sun/sun_clean.png": "243534ee0762be984e6c15489ced1ba8",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_hit.png": "697d4c99ca8d4e26950ba1deede96ccd",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_run.png": "ad166c09138936c20a8457f66397eb71",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_idle.png": "02261d863ed8157ed4e3f697f479814f",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_attack.png": "8ba19b9b8802b181eb7978400c3ad97b",
"assets/assets/images/levels/insects/mole/mole_run.png": "54c43d6d94d17803db87a38964fde844",
"assets/assets/images/levels/insects/mole/mole_hit.png": "b2a65330fed805cf0704a21c74fa693a",
"assets/assets/images/levels/insects/mole/mole_idle.png": "fd7f0135a8932e096c9f7709a58a8d47",
"assets/assets/images/levels/insects/mole/mole_attack.png": "c843ea8d611925bfaace91ccadbed704",
"assets/assets/images/levels/insects/slug/slug_attack.png": "2f31a7035d8b65b2d3a1c9abba5c6d68",
"assets/assets/images/levels/insects/slug/slug_run.png": "de6cd1d51953d4a5468e996ffa3a4685",
"assets/assets/images/levels/insects/slug/slug_hit.png": "97bb42a3636541b4454939743bc65fec",
"assets/assets/images/levels/insects/slug/slug_idle.png": "d5197a4a2556f22ba6f54df50f7a082c",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_attack.png": "5e5e78840770a0da8cf0a3030c5d3f1e",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_run.png": "2b2b70c9f41e2a239868931c0aac61fd",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_hit.png": "3c9bd7164271adf93403af2a4de31791",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_idle.png": "2481f2b162cb35f6ceaa234b9db381ad",
"assets/assets/images/levels/score_table/score_table.png": "f79ce44e151eab7bdb4a103ccf83013e",
"assets/assets/images/levels/fields/potato.png": "673726bb140c5596ed054194906ec496",
"assets/assets/images/levels/fields/carrot.png": "c4b02c833a28d97737d0de6e9ad72c76",
"assets/assets/images/levels/player/idle/player_idle_down.png": "26560b5a960469ae0dbc16f7bd265e07",
"assets/assets/images/levels/player/idle/player_idle_up.png": "95fc563c5148743dc8345d90581ff41b",
"assets/assets/images/levels/player/idle/player_idle_left.png": "34fd1f73e1b34bdfa018605477ec949d",
"assets/assets/images/levels/player/idle/player_idle_right.png": "d135494802bf07077c37b0479953b255",
"assets/assets/images/levels/player/heal/player_heal_right.png": "5e1deff6b188604e8ee761db60c258ff",
"assets/assets/images/levels/player/heal/player_heal_up.png": "5b2f487ed89b1af6cf3921af5d048be8",
"assets/assets/images/levels/player/heal/player_heal_down.png": "385c3e43892aa0eeebbf50311db8dc8c",
"assets/assets/images/levels/player/heal/player_heal_left.png": "7aeb32a9453b166c9c76a4d7139b77c6",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_down.png": "e3265ba3acfc1d4983d4b56be3753b2c",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_right.png": "064dc650d1e114a8da876b5f7ad29ef1",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_up.png": "80c898f464ffed8b054d19b8e74cab51",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_left.png": "bd64f148aa9b22d1954f363066ba5b42",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_right.png": "f60bbb8816f05906b17b68281cac0c95",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_left.png": "cc247939d701e911f8f781122a13ec3a",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_down.png": "93ad932b2b891a96d8bb4bebb5807be1",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_up.png": "08290a3ab954a03f751f663df56255b3",
"assets/assets/images/levels/player/run/player_run_up.png": "b64a28d104d7f9298d17f350ddd02f7b",
"assets/assets/images/levels/player/run/player_run_right.png": "be0fc71b232d20956d60007a8f5af647",
"assets/assets/images/levels/player/run/player_run_left.png": "345eff587b28ddfbacf621a3be908e8c",
"assets/assets/images/levels/player/run/player_run_down.png": "e2b958365504c0d249d0572157daa6f7",
"assets/assets/images/levels/potions/circle/circle_red_potion_64.png": "d9515bbaf47a0d1d45f27125735786ce",
"assets/assets/images/levels/potions/circle/circle_yellow_potion_32.png": "6d3a5463b2c1b97a8a0670db37b53f60",
"assets/assets/images/levels/potions/circle/circle_red_potion_32.png": "f9f33ca29549dc7d78d49eb5e12c16f0",
"assets/assets/images/levels/potions/circle/circle_blue_potion_32.png": "db8e46241115a79a63b033634040a4bc",
"assets/assets/images/levels/potions/circle/circle_yellow_potion_64.png": "7aac4ba0d383bd8c08e6bee2998be64c",
"assets/assets/images/levels/potions/circle/circle_blue_potion_64.png": "259be637d32cd130ebc84439b5361415",
"assets/assets/images/levels/potions/rect/rect_red_potion_64.png": "114493d4941d0c6e04378b9aa6eff0b5",
"assets/assets/images/levels/potions/rect/rect_red_potion_32.png": "705a32d1cc619da9319eed4be2bad2bd",
"assets/assets/images/levels/potions/rect/rect_yellow_potion_32.png": "dc71c32c3eec8726df140cb073e199f7",
"assets/assets/images/levels/potions/rect/rect_yellow_potion_64.png": "77a91212bd93302211c3404f5dad1909",
"assets/assets/images/levels/potions/rect/rect_blue_potion_64.png": "50cedd60283cd960e9653603ad2099fa",
"assets/assets/images/levels/potions/rect/rect_blue_potion_32.png": "e03298ac19aae607abd7e8eff81bff2d",
"assets/assets/images/levels/plane_cloud/plane_cloud.png": "e3ef7b63ef8e2b3c8b45eaae2f3a5f08",
"assets/assets/images/levels/sun_generator/sun_generator_idle.png": "cc19bf4be3e7f72110d6fa24b940d924",
"assets/assets/images/levels/sun_cards/buckwheat.png": "622b5015b9936a5af7d31c31349c49ee",
"assets/assets/images/levels/sun_cards/oats.png": "41bd8dd2949da75ca26a2fab062bb604",
"assets/assets/images/levels/sun_cards/peas.png": "19cfe3f073405cd727a4ece9b153e7c9",
"assets/assets/images/levels/sun_cards/clover.png": "b4550e54a4cbdde74347882e319d0f25",
"assets/assets/images/levels/spell_book/spell_book.png": "76824e90a6cb46610e0a149f9b1fffce",
"assets/assets/images/levels/plants/weeds/bindweed/bindweed_idle.png": "8a23c5f62627b40167a46d6609a86a89",
"assets/assets/images/levels/plants/weeds/bindweed/bindweed_hit.png": "6350877b33e9a461ce203b4405bf77b0",
"assets/assets/images/levels/plants/weeds/shepherds_purse/shepherds_purse_hit.png": "c505c4399466784992f8f8c7a7f0bd60",
"assets/assets/images/levels/plants/weeds/shepherds_purse/shepherds_purse_idle.png": "b47bbd2f040e9edccb3f7e8506da6954",
"assets/assets/images/levels/plants/weeds/hogweed/hogweed_idle.png": "6a6f3f7a144ca4094a9f53487081280a",
"assets/assets/images/levels/plants/weeds/hogweed/hogweed_hit.png": "21fc72fe63f9214ed49b798a61ddd214",
"assets/assets/images/levels/plants/weeds/dandelion/dandelion_hit.png": "1ad37b570982023807248ea2cc18db69",
"assets/assets/images/levels/plants/weeds/dandelion/dandelion_idle.png": "3b98e6536face459620329fa05ec3f62",
"assets/assets/images/levels/plants/weeds/wheatgrass/wheatgrass_hit.png": "7a12c85c7df3ec1b4e97a38e44ad1481",
"assets/assets/images/levels/plants/weeds/wheatgrass/wheatgrass_idle.png": "8e0d28d3dd04ae8536c398e86fe9b2a0",
"assets/assets/images/levels/plants/base/carrot/carrot_idle.png": "e4a9b730ca91357e4917171604ed9a80",
"assets/assets/images/levels/plants/base/beet/beet_idle.png": "a6ff5b2a699ea65264976019be295696",
"assets/assets/images/levels/plants/base/wheat/wheat_idle.png": "6d59d441a0880bc9739f9eba0e58cd64",
"assets/assets/images/levels/plants/base/corn/corn_idle.png": "c4bbc9130afe44fc5140edad365eb584",
"assets/assets/images/levels/plants/base/cabbage/cabbage_idle.png": "e283ff819f45504046a61424c1252b8c",
"assets/assets/images/levels/plants/base/potato/potato_idle.png": "9463bd93a40de0d6a9bf5002375c4d98",
"assets/assets/images/levels/plants/defenders/oats/oats_hit.png": "d4b60c08dfefa34cdf14a092588ac07b",
"assets/assets/images/levels/plants/defenders/oats/oats_idle.png": "8e912ac9153d4fc2986f2cbcdeefb128",
"assets/assets/images/levels/plants/defenders/peas/peas_idle.png": "24f030134a98435083d60349bf5dbd3d",
"assets/assets/images/levels/plants/defenders/peas/peas_hit.png": "176c0a42fb71b5e05a2559ca197d140a",
"assets/assets/images/levels/plants/defenders/clover/clover_idle.png": "97257df914bab1e480ccf37fb8e24467",
"assets/assets/images/levels/plants/defenders/clover/clover_hit.png": "9fabf95e3aacb13e70413ed226c0ceb8",
"assets/assets/images/levels/plants/defenders/buckwheat/buckwheat_hit.png": "771bd0a73585c1522f683a8a84fa32d7",
"assets/assets/images/levels/plants/defenders/buckwheat/buckwheat_idle.png": "38e705f02029906d6bab0e0489a16cf4",
"assets/assets/images/levels/energy_cards/plane.png": "6e1ab04a75df7f68a4ed3c22b0d71465",
"assets/assets/images/levels/background/level_background.png": "16461b263f56b56a4126a7ce7674709b",
"assets/assets/images/levels/flags/red.png": "d860775b8e47175875bf37aeb77671f2",
"assets/assets/images/levels/bullets/oats/oats.png": "ba7745624bed887e2302f294428fbd34",
"assets/assets/images/levels/bullets/peas/peas.png": "7282215e3bfa619dbfb3dd6207a1683a",
"assets/assets/images/levels/bullets/clover/clover.png": "08367e1a5b2f12cf046b6ce5dfd2d3f3",
"assets/assets/images/levels/bullets/buckwheat/buckwheat.png": "5b896e74287bc5d79d71f9be468b2b14",
"assets/assets/images/levels/resources/sun.png": "95d87ffa4dda877c85f24b807c9ba8b2",
"assets/assets/images/levels/resources/energy.png": "6d408cf2a2a418a779977c1dc85a5eeb",
"assets/AssetManifest.json": "e53c6dfd2ce5d74303fc2306ab3e1a0a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/fonts/MaterialIcons-Regular.otf": "32fce58e2acb9c420eab0fe7b828b761",
"assets/fonts/RubikBubbles-Regular.ttf": "d679db2357f4dc4c46a82667addeaf83",
"assets/NOTICES": "0d7edc161d281865f1470025d986c52d",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"index.html": "b7582cd6664189ccbf1d3b745c2607db",
"/": "b7582cd6664189ccbf1d3b745c2607db",
"main.dart.js": "58c3a49da21f234deec91eb95d52d280",
"manifest.json": "beed7d7a596062a185d7d6e488f0e5ad",
"version.json": "4db9020648129b20632db40555790915",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
