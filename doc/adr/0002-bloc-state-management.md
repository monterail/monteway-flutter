# 2. BLoC state management

Date: 2021-12-13

## Status

Accepted

## Context

Establish a standard way of managing state in Flutter apps developed by Monterail. 

## Decision

We will go for BLoC, an powerful and elastic state management tool. It's popular among Flutter developers.

## Consequences

*Positive*:

- Proper support with libraries, community posts and IDE extensions,
- A lot of users - fixes arrive quickly.

*Threats*:

- May generate excessive boilerplate in code when implementing small features, this can be mitigated by using Cubits.
