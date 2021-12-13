# 4. Flavoring with environment variables

Date: 2021-12-13

## Status

Accepted

## Context

We have to have a way of configuring the app without code changes to support multiple backend and test environments.

## Decision

We have chosen flavoring the app with environmental variables (`--dart-define=APP_VARIABLE=value`).

## Consequences

*Positive*:

- Adding new and editing current flavors is simple
- Easily scriptable with `Makefile`

*Threats*:

- Differences in whitespace handling between OSes and shells can cause weird build errors in remote build machines
