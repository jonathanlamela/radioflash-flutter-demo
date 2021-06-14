var dominio = "https://www.radioflash.fm";
var defaultCoverUrl =
    "https://admuzzum.xdevel.com/cloud/x/35/im/png/2019/10/11/3e812e02.png-512,512.png";

var onAirNowLink = dominio + "/wp-json/rdf/onair/now";
var ultimaClassificaLink = dominio + "/wp-json/classifica/latest";
var newsLink = dominio + "/wp-json/wp/v2/posts?_embed";

var ultimeUsciteLink =
    "https://api.xdevel.com/streamsolution/web/player/songs/new/48?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce";

var hitsLink =
    "https://api.xdevel.com/streamsolution/web/player/songs/hit/48?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce";

var playlist = [
  {
    "etichettaBreve": "RADIOFLASH",
    "etichettaCompleta": "RadioFlash La Radio Che Funziona",
    "logoUrl": "radioflash.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio5s194-48/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/48/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/48?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  },
  {
    "etichettaBreve": "ROCK",
    "etichettaCompleta": "Rock Station",
    "logoUrl": "rock.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio7s194-50/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/50/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/50?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  },
  {
    "etichettaBreve": "MUSIC GENERATION",
    "etichettaCompleta": "Music Generation",
    "logoUrl": "music_generation.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio2s194-45/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/45/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/45?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  },
  {
    "etichettaBreve": "GOOD TIMES",
    "etichettaCompleta": "Good Times",
    "logoUrl": "good_times.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio4s194-47/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/47/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/47?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  },
  {
    "etichettaBreve": "ITALIA",
    "etichettaCompleta": "Passione Italia",
    "logoUrl": "passione_italia.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio3s194-46/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/46/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&callback",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/46?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  },
  {
    "etichettaBreve": "SANREMO",
    "etichettaCompleta": "Speciale Sanremo",
    "logoUrl": "sanremo.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio1s194-44/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/44/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&callback",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/44?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  },
  {
    "etichettaBreve": "ROYF",
    "etichettaCompleta": "The Rhythm Of Your Life",
    "logoUrl": "rofyl.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio0s194-43/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/43/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/43?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  },
  {
    "etichettaBreve": "XMAS",
    "etichettaCompleta": "XMas",
    "logoUrl": "xmas.png",
    "linkFlusso":
        "https://stream2.xdevel.com/audio6s194-49/stream/icecast.audio",
    "linkOnAirData":
        "https://api.xdevel.com/streamsolution/web/metadata/49/?clientId=2873bb874c81be6550372b7fb222304b93a3ff34",
    "linkUltimiSuonati":
        "https://api.xdevel.com/streamsolution/web/player/songs/history/49?clientId=2873bb874c81be6550372b7fb222304b93a3ff34&key=fbef37c7cb070c7c050c888cce23b04a4bb455ce"
  }
];
