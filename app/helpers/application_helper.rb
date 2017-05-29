module ApplicationHelper
  require "redcarpet"
  require "coderay"

  def profile_img(user)
    if user.avatar?
      image_tag(user.avatar, alt: user.name, :size => "164x164")
    else
      img_url = 'no_image.png'
      image_tag(img_url, alt: user.name, :size => "164x164")
    end
  end

  class HTMLwithCoderay < Redcarpet::Render::HTML
      def block_code(code, language)
          if language != nil
            language = language.split(":")[0]
          elsif
            language = ''
          end

          case language.to_s
          when 'rb'
              lang = 'ruby'
          when 'yml'
              lang = 'yaml'
          when 'css'
              lang = 'css'
          when 'html'
              lang = 'html'
          when ''
              lang = 'md'
          else
              lang = language
          end

          CodeRay.scan(code, lang).div
      end
  end

  def markdown(text)
      html_render = HTMLwithCoderay.new(filter_html: true, hard_wrap: true)
      options = {
          autolink: true,
          space_after_headers: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          tables: true,
          hard_wrap: true,
          xhtml: true,
          lax_html_blocks: true,
          strikethrough: true
      }
      markdown = Redcarpet::Markdown.new(html_render, options)
      markdown.render(text)
  end
end
