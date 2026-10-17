# Fix it with your coding agent

A score doesn't fix anything. The Markdown report is written so a coding agent such as Claude Code, Cursor or GitHub Copilot can work through the fixes for you.

## 1. Download the Markdown report

When the audit finishes, choose **Download** and pick **Markdown**. You get a single `.md` file.

## 2. Put it in your docs repository

Save the file in the repository that holds your docs source, for example:

```text
docs-repo/
├── docs/
├── lensy-report-docs.example.com-2026-10-14.md
└── ...
```

## 3. Ask your agent to work through it

Open your coding agent in that repository and give it a short instruction:

```text
Read lensy-report-docs.example.com-2026-10-14.md and apply the open fixes, top to bottom.
```

You don't need to explain the format. The report starts with instructions written for the agent.

## What the agent is told

Every Markdown report begins with a **How to use this file** section that tells the agent to:

1. Work through the open items under **Fixes**, top to bottom. Quick wins come first.
2. Apply each fix to the docs **source**, not to generated output.
3. Leave anything marked **PASS** alone.

Each fix is a checklist item naming the check, what Lensy found, and the fix, with a code sample where it helps.

## What's in the file

The report also includes front matter your tools can read:

```yaml
---
url: "https://docs.example.com/getting-started"
scanned_at: "2026-10-14T13:22:22.252Z"
readiness_score: 72
citations: "3/5"
generator: "Lensy (perseveranceai.com)"
---
```

## Check the result

After your agent's changes are deployed, run Lensy again on the same page and compare the scores.

## Prefer PDF?

Choose **PDF** instead to share the report with people who won't open it in an editor.
