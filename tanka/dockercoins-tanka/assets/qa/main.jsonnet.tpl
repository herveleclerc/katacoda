(import "ksonnet-util/kausal.libsonnet") +
(import "${PROJECT_NAME}/${PROJECT_NAME}.libsonnet")
{
  // Patching #number of replicas
  _config+:{
    ${PROJECT_NAME}+: {
        namespace: "${PROJECT_NAME}-qa"
    }
  },
  _images+:: {
    // we update this one entirely, so we can replace this one (:)
    ${PROJECT_NAME}: {
      worker: "dockercoins/worker:v0.2",
      rng: "dockercoins/rng:v0.2",
      hasher: "dockercoins/hasher:v0.2",
      webui: "dockercoins/webui:v0.2",
      redis: "redis",
    }
  }
}