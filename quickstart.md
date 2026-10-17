# Quickstart

Run your first Lensy audit in under a minute. No account needed.

## 1. Pick a page

Choose one page from your docs, such as a getting-started guide or an API reference page. Lensy audits one page at a time, so start with a page your users visit most.

## 2. Paste the URL

Go to [perseveranceai.com](https://perseveranceai.com), paste the full URL of the page, and start the scan.

```text
https://docs.example.com/getting-started
```

> Your first 100 audits are free. You don't need to sign up.

## 3. Wait a few seconds

Lensy fetches the live page and runs its checks in parallel. Most audits finish in seconds. The AI citation check takes a little longer because it asks an AI search engine real questions about your page.

## 4. Read the results

You'll see:

- an **AI readiness score** out of 100,
- the number of **signals to improve**, grouped by category,
- which **AI crawlers** can reach the page,
- how often the page was **cited** in the test queries,
- a list of **fixes**, with quick wins first.

See [Reading your report](/lensy-docs/reading-your-report) for what each part means.

## 5. Download the report

Download the report as **PDF** to share with your team, or as **Markdown** to hand to your coding agent. See [Fix it with your coding agent](/lensy-docs/fix-with-your-coding-agent).

## What if my docs load with JavaScript?

Some docs sites send an almost empty page and fill in the content with JavaScript. AI crawlers that don't run JavaScript see that empty page too.

If your site publishes a Markdown version of each page, Lensy reads it, either from a `<link rel="alternate" type="text/markdown">` tag or at the page URL with `.md` added. This page is an example: the site loads with JavaScript, and every page has a Markdown version.
