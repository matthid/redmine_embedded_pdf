redmine_embedded_pdf
======================

Tested with redmine 1.4.5 and ruby 1.8.7_p370.

Install: 

- git clone into redmine to plugins directory
- gem install nokogiri
- rake redmine:plugins:migrate RAILS_ENV=production
- restart redmine

Usage:

* `{{pdf(pdfspecifier[,<height>])}}`

For external urls use the complete http url:
* `{{pdf(http://website.de/sample.pdf)}}`
 
But you can also use the wiki specifiers (http://www.redmine.org/help/wiki_syntax_detailed.html):
* `{{pdf(export:some/file.pdf)}}`
* `{{pdf(attachment:file.pdf)}}`


Any other wiki syntax like source:some/file.pdf doesn't really make sense as they are not pointing to the raw pdf file.


