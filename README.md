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

### Doctype

There are shortcuts for commonly used doctypes:

```jade
doctype html
doctype xml
doctype transitional
doctype strict
doctype frameset
doctype 1.1
doctype basic
doctype mobile
```
```html
<!DOCTYPE html>
<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd">
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.2//EN" "http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd">
```

You can also use your own literal custom doctype:

```jade
doctype html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN"
```
```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.1//EN">
```


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
