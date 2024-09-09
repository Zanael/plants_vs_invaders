'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"main.dart.js": "5f4dc354dfc88c3824ae9fe8072a38df",
"index.html": "b55208b5631f8a788fa0b1eb0ef2f3e1",
"/": "b55208b5631f8a788fa0b1eb0ef2f3e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"manifest.json": "beed7d7a596062a185d7d6e488f0e5ad",
"version.json": "4db9020648129b20632db40555790915",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/fonts/RubikBubbles-Regular.ttf": "d679db2357f4dc4c46a82667addeaf83",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "2ab76d314cc9f912fa831492c86fb0bd",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/assets/images/main_menu.png": "c74b663549023cdc57a0ed03b0745c7d",
"assets/assets/images/level_preview/potato.png": "517cc0265512dcc0d63de81bcf60ff7c",
"assets/assets/images/level_preview/carrot.png": "77d337fa33af22213a8325e07111a223",
"assets/assets/images/levels_map.png": "2daca2a0cac99cac9a43fabb0b4d7f6f",
"assets/assets/images/levels/wind_generator/wind_generator_idle.png": "830e6cfe4afa2b81154a810a78efd474",
"assets/assets/images/levels/score_table/score_table.png": "b46e7e891c4864ba13e512e932817afc",
"assets/assets/images/levels/bullets/oats/oats.png": "15fa82bd1e8b9ac5855fbf7cef76c63a",
"assets/assets/images/levels/bullets/clover/clover.png": "c263a0bb5b27f895454c0430f0a2cd75",
"assets/assets/images/levels/bullets/peas/peas.png": "4a14a430c47df9114d6b980385f0b521",
"assets/assets/images/levels/bullets/buckwheat/buckwheat.png": "9edbbfaac8ef16999ae659778b5164cb",
"assets/assets/images/levels/flags/red.png": "d860775b8e47175875bf37aeb77671f2",
"assets/assets/images/levels/potions/circle/circle_red_potion_32.png": "d7c633d545f62750007146a7aa968491",
"assets/assets/images/levels/potions/circle/circle_red_potion_64.png": "d7c633d545f62750007146a7aa968491",
"assets/assets/images/levels/potions/circle/circle_yellow_potion_64.png": "75a1c8bcb71201e0c4c18b55a9937840",
"assets/assets/images/levels/potions/circle/circle_blue_potion_32.png": "7aed4b5dce07eff6bc3c1800e7edea77",
"assets/assets/images/levels/potions/circle/circle_yellow_potion_32.png": "75a1c8bcb71201e0c4c18b55a9937840",
"assets/assets/images/levels/potions/circle/circle_blue_potion_64.png": "7aed4b5dce07eff6bc3c1800e7edea77",
"assets/assets/images/levels/potions/rect/rect_yellow_potion_64.png": "bd23381b4af754a01f5c6e09a4fb818f",
"assets/assets/images/levels/potions/rect/rect_red_potion_32.png": "fa44c224e362a68dea9bf481488fe828",
"assets/assets/images/levels/potions/rect/rect_red_potion_64.png": "fa44c224e362a68dea9bf481488fe828",
"assets/assets/images/levels/potions/rect/rect_yellow_potion_32.png": "bd23381b4af754a01f5c6e09a4fb818f",
"assets/assets/images/levels/potions/rect/rect_blue_potion_32.png": "78c9178b7b3190242f7183fb6894ee0a",
"assets/assets/images/levels/potions/rect/rect_blue_potion_64.png": "78c9178b7b3190242f7183fb6894ee0a",
"assets/assets/images/levels/resources/sun.png": "e1f6dd35b3841266091223edab76b045",
"assets/assets/images/levels/resources/energy.png": "8f1cd8ed346bb624e48511b41cf17fd3",
"assets/assets/images/levels/sun/sun_clean.png": "072ecb6fa273f2efccf3dc972b0c529c",
"assets/assets/images/levels/sun/sun_clouds.png": "949a3a0374d5750573ac768c3babbba0",
"assets/assets/images/levels/plants/base/cabbage/cabbage_idle.png": "e283ff819f45504046a61424c1252b8c",
"assets/assets/images/levels/plants/base/carrot/carrot_idle.png": "e4a9b730ca91357e4917171604ed9a80",
"assets/assets/images/levels/plants/base/wheat/wheat_idle.png": "6d59d441a0880bc9739f9eba0e58cd64",
"assets/assets/images/levels/plants/base/corn/corn_idle.png": "c4bbc9130afe44fc5140edad365eb584",
"assets/assets/images/levels/plants/base/potato/potato_idle.png": "9463bd93a40de0d6a9bf5002375c4d98",
"assets/assets/images/levels/plants/base/beet/beet_idle.png": "a6ff5b2a699ea65264976019be295696",
"assets/assets/images/levels/plants/defenders/oats/oats_hit.png": "b43a93c7262b38fe97be989bcc1d3c2b",
"assets/assets/images/levels/plants/defenders/oats/oats_idle.png": "434a7edabc3028f7fca16b4c63e4bd23",
"assets/assets/images/levels/plants/defenders/clover/clover_idle.png": "f5f6d11789fda06f1ee50d4513aaf6b8",
"assets/assets/images/levels/plants/defenders/clover/clover_hit.png": "f9cc6010068129b6da881cc8d63c69ac",
"assets/assets/images/levels/plants/defenders/peas/peas_hit.png": "da59351e2146e9370890f3262c62e3ac",
"assets/assets/images/levels/plants/defenders/peas/peas_idle.png": "a2ad94d112d89b8584392e44afc5d8cc",
"assets/assets/images/levels/plants/defenders/buckwheat/buckwheat_idle.png": "dccfa812d2313f204f6eedd20f48b183",
"assets/assets/images/levels/plants/defenders/buckwheat/buckwheat_hit.png": "84498e547955be817d346014d727db43",
"assets/assets/images/levels/plants/weeds/hogweed/hogweed_hit.png": "21fc72fe63f9214ed49b798a61ddd214",
"assets/assets/images/levels/plants/weeds/hogweed/hogweed_idle.png": "6a6f3f7a144ca4094a9f53487081280a",
"assets/assets/images/levels/plants/weeds/shepherds_purse/shepherds_purse_idle.png": "02de1f4f0d8b2e310ab338bdbc27ccf8",
"assets/assets/images/levels/plants/weeds/shepherds_purse/shepherds_purse_hit.png": "dfe53295b16f0033833df79f2fe5dbde",
"assets/assets/images/levels/plants/weeds/wheatgrass/wheatgrass_hit.png": "ec9a7ae6ea9492aa6569da9ce53d27ea",
"assets/assets/images/levels/plants/weeds/wheatgrass/wheatgrass_idle.png": "a20b11d064058dbe1f656a8a5ce71ba5",
"assets/assets/images/levels/plants/weeds/dandelion/dandelion_idle.png": "3b98e6536face459620329fa05ec3f62",
"assets/assets/images/levels/plants/weeds/dandelion/dandelion_hit.png": "1ad37b570982023807248ea2cc18db69",
"assets/assets/images/levels/plants/weeds/bindweed/bindweed_idle.png": "549f42d024878625d882904c5e441e61",
"assets/assets/images/levels/plants/weeds/bindweed/bindweed_hit.png": "8037d25e8e2ba7186301e09f78f48311",
"assets/assets/images/levels/energy_cards/plane.png": "ac15dd40db5cea411736d35e541dbb90",
"assets/assets/images/levels/spell_book/spell_book.png": "8e689312c525824e27532f018e68bf39",
"assets/assets/images/levels/plane/plane.png": "325e2c11125e38107f1d9d9e1c89837f",
"assets/assets/images/levels/level_loading_background/level_loading_background_idle.jpg": "4dd5cf074d57c8a8b4ceb52abab97137",
"assets/assets/images/levels/plane_cloud/plane_cloud.png": "3545acf016f43ac015ed43e4a236ef50",
"assets/assets/images/levels/fields/potato.png": "673726bb140c5596ed054194906ec496",
"assets/assets/images/levels/fields/carrot.png": "c4b02c833a28d97737d0de6e9ad72c76",
"assets/assets/images/levels/player/idle/player_idle_right.png": "79c2e8bc3ac5547241c8dbc28f670533",
"assets/assets/images/levels/player/idle/player_idle_left.png": "a6b2afcf9dd16ba80797599db89e4455",
"assets/assets/images/levels/player/idle/player_idle_up.png": "c2927b834e3748057a14c88ee194eedc",
"assets/assets/images/levels/player/idle/player_idle_down.png": "3acdb99f3cc6a61a0f7cf9d894e31e65",
"assets/assets/images/levels/player/heal/player_heal_left.png": "d26f9f71cae1c832570acc3a58c68d50",
"assets/assets/images/levels/player/heal/player_heal_up.png": "ef17d9d650185529afd5953565315dd9",
"assets/assets/images/levels/player/heal/player_heal_down.png": "7bbed71cbd273864cbc3eef8a2350a4c",
"assets/assets/images/levels/player/heal/player_heal_right.png": "1b491cfbb6384dede0366baa9e7ca6b8",
"assets/assets/images/levels/player/run/player_run_right.png": "8a657e8dba9cc12571b20603dc7ddaba",
"assets/assets/images/levels/player/run/player_run_left.png": "3913f3770b9259e1addc2057020e11c3",
"assets/assets/images/levels/player/run/player_run_up.png": "fd6a9567d21374860301d4e6cb5c817d",
"assets/assets/images/levels/player/run/player_run_down.png": "d73afa7065e5145c4f24145c8a271a41",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_down.png": "17e697f9c2f15d276c9f3d1a91f5d0b6",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_up.png": "079ca8e91aa62372d4095fbcbd6d23dc",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_left.png": "bd8a9923463920ee31bb8b790df95b67",
"assets/assets/images/levels/player/attack/plants/player_attack_plants_right.png": "8b69f1b82d89828f4cbd30013b27c862",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_down.png": "dc158efe42a98813157dcb83b8aa7ba4",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_right.png": "011c9f42820e283b9638948d641ca917",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_up.png": "4c9a1b02c49019257bd632aaa659ec70",
"assets/assets/images/levels/player/attack/insects/player_attack_insects_left.png": "118c06b39bc66004470b0d28a5236595",
"assets/assets/images/levels/menu/menu_button.png": "8e0b56bffc882b214f11e80a7a5c4438",
"assets/assets/images/levels/background/level_background.png": "6ec8a6c5fb0c473bb8828030ba095190",
"assets/assets/images/levels/insects/slug/slug_run.png": "0b735ae83c64791b96a460c12b133898",
"assets/assets/images/levels/insects/slug/slug_idle.png": "dd079fadfaf7b200b1450d508041b260",
"assets/assets/images/levels/insects/slug/slug_attack.png": "dcd24ea1af361cab7055ab84cf5efc07",
"assets/assets/images/levels/insects/slug/slug_hit.png": "2eb3728dc40ecb482d7e9b9c3282a37f",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_run.png": "84c818c62ae28454bebc3bd2c391d795",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_hit.png": "544d445bef306c8019f0d82800c9ec76",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_attack.png": "da5ff391b96cfe8b58efd8573bbd15e8",
"assets/assets/images/levels/insects/colorado_beetle/colorado_beetle_idle.png": "ed708183657f5ad77a864b05a907c590",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_idle.png": "2481f2b162cb35f6ceaa234b9db381ad",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_attack.png": "5e5e78840770a0da8cf0a3030c5d3f1e",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_run.png": "2b2b70c9f41e2a239868931c0aac61fd",
"assets/assets/images/levels/insects/mole_cricket/mole_cricket_hit.png": "3c9bd7164271adf93403af2a4de31791",
"assets/assets/images/levels/insects/mole/mole_hit.png": "f52c61d987958343447abec011101836",
"assets/assets/images/levels/insects/mole/mole_attack.png": "287dda45c44f0c3a7acd89a79dd3812a",
"assets/assets/images/levels/insects/mole/mole_run.png": "985f209ad32ea92281333bcf3976f1ad",
"assets/assets/images/levels/insects/mole/mole_idle.png": "1cc4b4981e6bf69cb4b36df660623471",
"assets/assets/images/levels/sun_generator/sun_generator_idle.png": "b5b856d25aa615d281c13f4162d17c2d",
"assets/assets/images/levels/sun_cards/buckwheat.png": "622b5015b9936a5af7d31c31349c49ee",
"assets/assets/images/levels/sun_cards/clover.png": "a03c9255d49f67c8210c1ea7c0dd5aa2",
"assets/assets/images/levels/sun_cards/oats.png": "30808fdc829324d6d979970209b32556",
"assets/assets/images/levels/sun_cards/peas.png": "a8e3c8584bd051008c84b352ec0fae1e",
"assets/assets/tiles/plants_vs_invaders.tiled-project": "97165873765b29a5041f09e541be15d5",
"assets/assets/tiles/plants_vs_invaders.tiled-session": "a3d22261889b59e3022c12429ef56848",
"assets/assets/tiles/level.tmx": "b48811b51f8413b418045989593e32f6",
"assets/AssetManifest.json": "2747ad4ad4b560b824ecdcfe635dffe3",
"assets/FontManifest.json": "fce87c7f19824599b00f38732ba23cd1",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/AssetManifest.bin.json": "c60569b4964ede7568d32111a0052d71",
"assets/AssetManifest.bin": "bb58bcef1bbabae9a1a672f15146c1db",
"flutter_bootstrap.js": "3bb958c44e427c8159f4416475140d75",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"flutter.js": "f393d3c16b631f36852323de8e583132"};
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
