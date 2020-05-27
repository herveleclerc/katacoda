(import "ksonnet-util/kausal.libsonnet") +
(import "${PROJECT_NAME}/${PROJECT_NAME}.libsonnet")
{
  // NameSpace
  _config+:{
    ${PROJECT_NAME}+: {
        namespace: "${PROJECT_NAME}"
    }
  },
  // Patching #number of replicas and namespace
  ${PROJECT_NAME}+:{
    worker+:{
      deployment+:{
        spec+:{
          replicas: 4
        }
      }
    }
  },
  // again, we only want to patch, not replace, thus +::
  _images+:: {
    // we update this one entirely, so we can replace this one (:)
    ${PROJECT_NAME}: {
      worker: "dockercoins/worker:v0.1",
      rng: "dockercoins/rng:v0.1",
      hasher: "dockercoins/hasher:v0.1",
      webui: "dockercoins/webui:v0.1",
      redis: "redis",
    }
  }
}