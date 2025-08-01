# Irvington CSA Website

This repository contains code for the Irvington CSA websites.

## You Are Here

In this directory you will see:

```
├── docs - The folder that gets published to the website
└── README.md - This is the document you're reading right now, it shows on the github.com repository's home page
```

## Local Development

The website content is generated HTML that is then modified using a LLM like GitHub Copilot. It's not structured, so be mindful of edits. Here is a suggestion for how to make changes:

1. Install VSCode with GitHub Copilot
2. Have it make changes
3. `python -m http.server 8000 --directory docs/`
4. Go to `http://localhost:8000` and view the content
5. Commit and push using Git and Github will publish the changes


