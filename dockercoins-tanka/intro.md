# Tanka / jsonnet

## Why this ?

Helm relies heavily on string templating .yaml files.
At Grafana, they feel this is the wrong way to approach the absence of abstractions inside of yaml, because the templating part of the application has no idea of the structure and syntax of yaml.

This makes debugging very hard. Furthermore, helm is not able to provide an adequate solution for edge cases. If I wanted to set some parameters that are not already implemented by the Chart, I have no choice but to modify the Chart first.

Jsonnet on the other hand got you covered by supporting mixing (patching, deep-merging) objects on top of the libraries output if required.

This is why i've tried tanka from Grafana.

Tanka leverages the Jsonnet language to realize flexible, reusable and concise configuration.

version 0.2.4
