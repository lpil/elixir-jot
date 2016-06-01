Jot
===

Jot, yo.

```jade
html(lang="en")
  head
    title Jot
  body
    h1#question Why?
    .col
      p Because this is slightly more fun than HTML.
```

## Reference

### Plain Text

A line starting with a pipe character (`|`) will be treated as plain text.

```jade
| Plain text can include <strong>html</strong>
p
  | It must always be on its own line
```
```html
Plain text can include <strong>html</strong>
<p>It must always be on its own line</p>
```

### Comments

A line starting with a slash (`/`) is a comment, and thus it outputs nothing.

```slim
p Hi there
  / Can't see me!
```
```html
<p>Hi there</p>
```

The exception is for lines starting with a slash-bang (`/!`) which output HTML
comments.

```slim
/! Stop viewing my source!
```
```html
<!-- Stop viewing my source! -->
```

### Line Continuations

If you feel the need to wrap content onto another line you can end the line
with the backslash character (`\`) to make the Jot compiler discard the
newline.

```slim
p One line, \
two lines!
```
```html
<p>One line, two lines!</p>
```

# LICENCE

MIT Licence
