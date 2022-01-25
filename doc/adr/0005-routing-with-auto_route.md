# 5. Routing with auto_route

Date: 2022-01-21

## Status

Accepted

Supercedes [3. Routing with routemaster](0003-routing-with-routemaster.md)

## Context

Because of routemaster's unexpected approach to page popping and overall path management we've decided to change router used in the app to one that does operate in historic stack manner rather than path levels.

## Decision

We've agreed to switch to auto_route, as it has feature-rich support for historic stack routing.

## Consequences

1. Because auto_route uses code-generation to work it's adding a bit of time to code generation step when building the app.
2. Replacing routemaster with auto_route requires parameter parsing logic to be rewritten and moved to route widgets rather than managed in routemaster page wrappers.
3. A lot of code will be generated, reducing boilerplate written by developers.
