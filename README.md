# raconteur

This is my try to build a basic presentation software because I don’t want to use Keynote.

# Requirements
Tested on Mac OS X 10.9. No guarantee for older OS X versions.

# How does it work
This does not follow a [WYSIWYG](http://en.wikipedia.org/wiki/WYSIWYG) approach. You create your slides in [Markdown](http://en.wikipedia.org/wiki/Markdown), which means raw text.
If you’re finished, you can present your slides within raconteur. No external program needed. When you save your project, it creates a `json` file, which contains information about default slide options (the master slide) and a list of all files which belong to it. A slide is saved as a Markdown file. A Markdown file contains the content itself plus a frontmatter holding style information.

# Files belonging to a project

* `example.json`
* `example-0.md`
* `example-1.md`
* `example-2.md`
* `example-3.md`

# Export
You can export your slides as HTML. It has a JQuery dependency for basic DOM operations. 

It places the following files on your disk:

* `example.html`
* `slideManager.js`
* `jquery-2.1.1.min.js`

# Dependencies

* Underscore.m
* MMMarkdown
* JQuery-2.1.1

