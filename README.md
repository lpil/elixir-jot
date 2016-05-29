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

A line prefixed with a pipe character (`|`) will be treated as plain text.

```jade
| Plain text can include <strong>html</strong>
p
  | It must always be on its own line
```

```html
Plain text can include <strong>html</strong>
<p>It must always be on its own line</p>
```

# LICENCE

MIT Licence
