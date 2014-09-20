# raconteur

This is my try to build a basic presentation software.
I used to use Keynote or Powerpoint (when I was a Windows user), but it always took very long until I finished something. I am not used anymore to use WYSIWYG software to build my slides. Always I thought “Hmm, would be so much faster when I just could write down my stuff and compile this to HTML or something”. There are many HTML5 presentation tools available, but I wanted to focus on writing down my slides. In many cases I needed to write my stuff directly into HTML, which is okay, but I didn’t feel comfortable.
This combines best of both:

- I can write down slides in Markdown and don’t need to focus on styling yet
- I can compile my slides to HTML later on *after* I am finished

# Requirements
Tested on Mac OS X 10.9. No guarantee for older OS X versions.

# How does it work
This does not follow a [WYSIWYG](http://en.wikipedia.org/wiki/WYSIWYG) approach. You create your slides in [Markdown](http://en.wikipedia.org/wiki/Markdown), which means raw text.
If you’re finished, you can present your slides within raconteur. No external program needed. When you save your project, it creates a folder structure.

- `src` <- Holds slides
- `build` <- Slides exported to html
- `assets` <- Pictures, other media files, ...

There is a `json` file, which contains information about default slide options (the master slide) and a list of all files which belong to it. A slide is saved as a Markdown file. A Markdown file contains the content itself plus a frontmatter holding style information.

# Files belonging to a project

* `example.json`
* `example-0.md`
* `example-1.md`
* `example-2.md`
* `example-3.md`

# Export
Slides are exported automatically as HTML and are placed in the `build`
folder.
It has a JQuery dependency for basic DOM operations.

It places the following files on your disk:

* `example.html`
* `slideManager.js`
* `jquery-2.1.1.min.js`

# Dependencies

* Underscore.m
* MMMarkdown
* JQuery-2.1.1
* [CINSColor](https://github.com/faceleg/CINSColor-Hex)
