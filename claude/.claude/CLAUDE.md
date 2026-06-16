# Global operating principles

Cross-project rules for Claude Code. Project-level `CLAUDE.md` files override these where they conflict.

## Spec is the plan; code is the source of truth for exact identifiers

A written spec (Confluence/Jira/design doc) states the **intent and the plan** — the flow, the
business rules, which systems talk to which. Trust it for *what to build*.

But a spec is **not** authoritative for **exact identifiers**: field/variable names, enum/constant
values, request/response keys, header names, DB column names, and which object a value maps to.
Specs are written/edited by humans and routinely carry copy-paste errors, stale names, and
internally inconsistent tables (e.g. a request says `quoteRateId`, the response says `transactionId`,
the diagram prose says `referenceCode` — all the same field).

**Before integrating against another service, verify every exact identifier against that service's
actual code** (the latest source — handler, model struct, validation, the query that consumes the
value), not against the spec alone. When the spec and the code disagree on an exact name/value:

- The **code wins** for the literal identifier (you must match what the other service actually reads).
- The **spec still wins** for intent — if the code's behavior contradicts the documented plan, that's
  a conflict to **flag**, not silently reconcile.
- Record the discrepancy (e.g. a contradiction entry in the team wiki) so the spec gets fixed.

Concretely, when a spec mapping table tells you to send field `X` with value `Y`: open the target
service and confirm (a) the field is really named `X` on the wire struct, and (b) the receiver keys
its lookup/idempotency/validation off `Y` and not off something else. Cheap to check, expensive to
get wrong in a banking/financial flow where a mis-mapped id corrupts the ledger or breaks idempotency.
