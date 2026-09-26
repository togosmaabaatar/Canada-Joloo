# Canada Joloo — Alberta Class 7

HTML, CSS and vanilla JavaScript. No package installation or build step.

## Run locally

```sh
ruby server.rb
```

Open **http://localhost:8080**. Use the local server so that the accessible handbook text can load. The server only listens on this computer (127.0.0.1).

## Three sections

- **Суралцах:** the official guide's ten chapters, 28 Mongolian summary lessons, original handbook figures, read progress, and a page-by-page English reader covering printed pages 9–122. Each page can be enlarged or read as selectable text; the full 126-page PDF is also included.
- **Шалгалт:** 54 original practice questions. Choose a chapter, all questions or previous mistakes, and any whole-number count from 1 to the available pool size. Selection is randomized without repeats. Every answer gives Mongolian feedback and a deep link to its lesson and exact source page. Return to the quiz without losing the answer; reload restores the current session. Results include individual review and a retry of just that exam's mistakes.
- **Үг хэллэг:** 50 English–Mongolian terms, searchable in either language, with chapter filtering and lesson links.

Mobile screens have a fixed three-tab bottom navigation with safe-area spacing. The homepage contains three concise entry cards.

## Content and attribution

**Government of Alberta — Driver's Guide: Cars and Light Trucks, Spring 2026.** Publication updated June 15, 2026; retrieved September 25, 2026.

- [Official publication](https://open.alberta.ca/publications/drivers-guide)
- [Original 2026 PDF](https://open.alberta.ca/dataset/387f4e8a-6c0a-456a-ab31-995aadaf1f2b/resource/5babee5c-040d-4e41-981a-04f22e839aac/download/tec-drivers-guide-2026.pdf)
- [Open Government Licence – Alberta](https://open.alberta.ca/licence)
- [Official knowledge-test format](https://www.alberta.ca/drivers-knowledge-test): 30 questions, 25 correct required. This detail is from the current web page, not the handbook's page 11, which describes the test without stating the numeric threshold.

© 2026 Government of Alberta. **Contains information licensed under the Open Government Licence – Alberta.** The project, translations and practice questions are independent and are not endorsed by the Government of Alberta.

No generated SVG or AI illustrations are used. Images are rendered from the original PDF. The figure crop manifest records PDF/printed page numbers and exact crop coordinates. Question illustrations omit explanatory answer captions where necessary; lesson illustrations retain the original source material. No signs or diagrams were redrawn.

Mongolian lessons summarize selected important topics, not the entire guide. The complete English material remains available in the reader and PDF. Questions are authored practice questions, not the official exam bank. Independent language and subject-matter review is still recommended before public release. The quiz uses immediate feedback for learning, so it is not an exact simulation of the official test interface.

## Files

- `content.js` — edition/source metadata, chapters, summaries, glossary
- `questions.js` — questions, answers, explanations, lesson and printed page references
- `app.js` — routing, reader, search, quiz and progress
- `assets/guide/` — original PDF, original rendered pages and selectable page text
- `assets/figures/manifest.json` — original figure crop provenance
- `scripts/extract-guide.js` — macOS PDFKit page rendering (run with `osascript -l JavaScript scripts/extract-guide.js "$PWD" 11 124`)
- `scripts/crop-guide.rb` — repeatable figure extraction from rendered pages
- `tests/smoke.html` — browser integration checks; run on a dedicated test browser profile. The test restores persisted keys afterward.

All UI assets are local; no CDN, font service or package is required. Handbook files are approximately 44 MB on disk, but only the displayed page is loaded. No account, server database, or cross-device synchronization. Read/answer progress uses localStorage; the active quiz uses sessionStorage in the same browser tab. Storage restrictions are handled with an in-memory fallback and a visible notice.

## Browser checks

Open http://localhost:8080/tests/smoke.html in a dedicated browser profile. Checks cover source asset availability, chapter/lesson navigation, image zoom, reader/transcript, bilingual search, arbitrary quiz length, chapter filtering, answer-to-lesson round trips, reload restoration, 25/30 scoring, retrying mistakes, input validation, corrupt storage recovery, and 320/390/768/1280px layout widths.

## Production deployment

The repository/project name is `canada-joloo`.

Build the deployable static site without installing dependencies:

```sh
sh scripts/build.sh
```

`vercel.json` selects the **Other** framework preset, runs that command, and serves `dist/`. This export contains the app and original source assets; the local Ruby server, development scripts and browser tests are not part of the public output. Routes use URL fragments (`#learn`, `#exam`, `#words`), so server-side SPA rewrites are unnecessary.

Connect the GitHub repository to Vercel with `main` as the production branch. Subsequent pushes can then create production deployments automatically. No environment variables are required by the app.

GitHub and Vercel account authorization is required to create the remote repository/project. Local deployment configuration alone does not create either remote resource.
