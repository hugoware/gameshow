# CSS Lint

Many languages have "Linters" which look for errors and best practices.



#///

# Not Validation?

Linting is different than validation since it's checking for how you're using CSS and not what features you're using.

It's also different from compiler errors, which prevent your code from working. Most results from a linter are simply recommendations.



#///

# Invalid CSS

For example, this is valid CSS, but using an `ID` causes a warning with a linter.

[code:css]
#search input { ... }
[/code]


> Warning: Disallow IDs in selectors


#///

# So, Why Bother?

CSS Lint errors and warnings normally are rooted from some sort of browser compatibility problem or previous maintenance nightmare that caused them to be recommended in the first place.

For example, the following CSS also gives a warning...

[code:css]
.button.submit { ... }
[/code]


Why? Because Internet Explorer 6 doesn't support adjoining classes.


#///

# ... It Depends...

Maybe that warning doesn't matter to you. Maybe you're still supporting *Internet Explorer 6* _( we hope not... for your sake )_

Ultimately, it's up to you to decide which warnings you'll ignore. Most Linters allow you to configure which rules are checked and which ones are ignored.

