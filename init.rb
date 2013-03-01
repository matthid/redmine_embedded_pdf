# ----------------------------------------------------------------------------
# This file is subject to the terms and conditions defined in
# file 'LICENSE.txt', which is part of this source code package.
# ----------------------------------------------------------------------------

require 'redmine'
require 'rubygems'
require 'nokogiri'

Redmine::Plugin.register :redmine_embedded_pdf do
 name 'Redmine Embedded PDF'
 author 'Matthias Dittrich'
 description 'Embeds attachment pdfs, pdf urls or pdfs of the repository. Usage (as macro): pdf(ID|URL|source:repro/file.pdf).'
 url 'https://github.com/matthid/redmine_pdf_plugin'
 version '0.1.0.1'
end

Redmine::WikiFormatting::Macros.register do
   desc "Wiki pdf embedding"

    macro :pdf do |o, args|
        @height = args[1].gsub(/\D/,'') if args[1]
        @height ||= 800
        @num ||= 0
        @num = @num + 1
                
        # We allow preparsing of redmine with "attachment:", "source:",...
        # That means the file can be a link <a href="/path/to/file">text</a>
        file_link = args[0]
        doc = Nokogiri::HTML.parse(file_link)
        alllinks = doc.css('a').map { |link| link['href'] }
        if alllinks.length > 0
          file_url = alllinks[0]
        else
          # Use what the user provided
          file_url = file_link
        end
out = <<END
  <!-- don't know how to achieve a width parameter AND the setting below (as default) properly -->
  <object width="100%" height="#{@height}" type="application/pdf" data="#{file_url}?#zoom=85&scrollbar=0&toolbar=0&navpanes=0" id="pdf_content">
    <p>Your browser does not support embedded pdf! Click <a href="#{file_url}">here</a> to download the file.</p>
  </object>

END

    out.html_safe
  end
end
