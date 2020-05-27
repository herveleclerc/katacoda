{
// +:: is important (we don't want to override the
// _config object, just add to it)
  _config+:: {
  // define a namespace for this library
   ${PROJECT_NAME}: {
     namespace: "${PROJECT_NAME}",
     webui: {
       port: 80,
       name: "webui",
     },
     hasher: { 
      port: 80,
      name: "hasher",
     },
     redis: {
      port: 6379,
      name: "redis",
     },
     rng: {
      port: 80,
      name: "rng",
     },
     worker: {
      name: "worker",
     },
   }
  },
  // again, make sure to use +::
  _images+:: {
    ${PROJECT_NAME}: {
      webui: "dockercoins/webui:v0.2",
      hasher: "dockercoins/hasher:v0.2",
      redis: "redis",
      rng: "dockercoins/rng:v0.4",
      worker: "dockercoins/worker:v0.2",
    }
  }
}
        