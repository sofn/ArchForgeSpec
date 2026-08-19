# Error codes

Each bounded context owns an `*ErrorCode` enum implementing the common `ErrorCode` interface.

- Keep numeric ranges per module (do not reuse).
- Admin clients read `code` in the JSON envelope.
- Web clients may also see `code` as a ProblemDetail extension property.
