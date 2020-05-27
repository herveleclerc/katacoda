(import "ksonnet-util/kausal.libsonnet") +
(import "./config.libsonnet") +
{
  local deployment = $.apps.v1.deployment,
  local container = $.core.v1.container,
  local port = $.core.v1.containerPort,
  local service = $.core.v1.service,
  local namespace = $.core.v1.namespace,
  // alias our params, too long to type every time
  local c = $._config.${PROJECT_NAME},
  ${PROJECT_NAME}: {
    namespace: namespace.new(c.namespace),
    hasher: {
      deployment: deployment.new(
        name=c.hasher.name, replicas=1,
        containers=[
          container.new(c.hasher.name, $._images.${PROJECT_NAME}.hasher)
          + container.withPorts([port.new("hasher", c.hasher.port)]),
        ],
      ),
      service: $.util.serviceFor(self.deployment),
    },
    redis: {
      deployment: deployment.new(
        name=c.redis.name, replicas=1,
        containers=[
          container.new(c.redis.name, $._images.${PROJECT_NAME}.redis)
          + container.withPorts([port.new("redis", c.redis.port)]),
        ],
      ),
      service: $.util.serviceFor(self.deployment),
    },
    rng: {
      deployment: deployment.new(
        name=c.rng.name, replicas=1,
        containers=[
          container.new(c.rng.name, $._images.${PROJECT_NAME}.rng)
          + container.withPorts([port.new("rng", c.rng.port)]),
        ],
      ),
      service: $.util.serviceFor(self.deployment),
    },
    webui: {
      deployment: deployment.new(
        name=c.webui.name, replicas=1,
        containers=[
          container.new(c.webui.name, $._images.${PROJECT_NAME}.webui)
          + container.withPorts([port.new("webui", c.webui.port)]),
        ],
      ),
      service: $.util.serviceFor(self.deployment) + service.mixin.spec.withType("NodePort"),
    },
    worker: {
      deployment: deployment.new(
        name=c.worker.name, replicas=1,
        containers=[
          container.new(c.worker.name, $._images.${PROJECT_NAME}.worker),
        ],
      ),
    },
  }
}