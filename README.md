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
p Plain text must always be
  | on its own line, and it can include
  | inline <strong>html</strong>.
```
```html
<p>Plain text must always be on its own line, and it can include inline <strong>html</strong>.</p>
```


### Inline Elixir Code

Jot also gives you ways to write Elixir inside your templates.

Lines prefixed with the dash character (`-`) will have their contents
evaluated, and the return value discarded.

```slim
h1
  - "Hello "
  | world!
```
```html
<h1>world!<h1>
```

Meanwhile lines prefixed with the equals character (`=`) will have their
contents evaluated, and the return value will be inserted into the template.

```slim
h1
  = "Hello"
  | world!
```
```html
<h1>Hello world!<h1>
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
