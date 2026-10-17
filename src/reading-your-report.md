# Reading your report

Every Lensy report has the same sections. This page explains each one.

## Summary

The top of the report gives you four numbers:

| Item | Example | Meaning |
| --- | --- | --- |
| AI readiness | 72/100, 4 signals to improve | Overall score and how many signals need work. |
| AI citations | Cited in 3 of 5 tested queries | How often an AI search engine cited the page. |
| Page check | Documentation page | Whether Lensy recognized the page as documentation. |
| Bot access | 10 / 10 allowed | How many AI crawlers can reach the page. |

## Status words

Each signal gets one status:

| Status | Meaning |
| --- | --- |
| **PASS** | Good. Leave it as it is. |
| **WARN** | Works, but could be better. |
| **FAIL** | Missing or blocking. Fix these first. |
| **INFO** | Optional. Not counted in the score. |

## Signals

Signals are grouped into three categories.

### Structured data

Machine-readable information about the page, such as JSON-LD, OpenGraph tags and breadcrumbs. AI search engines use it to understand what the page is and where it sits in your docs.

### Discoverability

How AI tools find your content:

- **Site level:** `llms.txt`, `llms-full.txt` and canonical URLs.
- **Page level:** whether a Markdown version of the page exists, whether the page is listed in `llms.txt`, and whether the server returns Markdown when asked for it (content negotiation).

### Content quality

How readable the page is to a machine: text-to-HTML ratio, heading structure and word count. A page that is mostly scripts and navigation is hard for crawlers to extract.

## Fixes

Each fix shows its **impact** (high, medium, low), its **effort** (low, medium) and its **category**. Fixes are split into:

- **Quick wins:** high impact, low effort. Start here.
- **Deeper improvements:** everything else, in priority order.

Where it helps, a fix includes a code sample, such as a starter `llms.txt` or the tag that points to your Markdown version.

## AI bot access

Lists the AI crawlers Lensy checked and whether each one is allowed to reach the page. A blocked crawler can't read or cite the page.

## AI citations

Lensy asks an AI search engine questions your page should answer and records whether the page was cited. This shows whether AI tools actually use your docs, not just whether they could.

> Lensy is in beta. Results are generated automatically and may not always be accurate. Treat them as guidance, not a definitive audit.
