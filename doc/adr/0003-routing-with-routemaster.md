# 3. Routing with routemaster

Date: 2021-12-13

## Status

Accepted

## Context

We have to manage direct web paths and mobile deeplinks.

## Decision

We have picked `routemaster` library for managing routes. It supports parameters and queries, which is crucial for supporting web applications.

## Consequences

*Positive*:

- It's lightweight and easy to setup
- Easily replaceable

*Threats*:

- Passes params as strings, other param datatypes must be formatted which can be error-prone.
