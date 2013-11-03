module ApplicationHelper
  def twitter_bootstrap_form_for(record_or_name_or_array, *args, &proc)
    options = args.extract_options!
    form_for(record_or_name_or_array, *(args << options.merge(:builder => TwitterBootstrapFormBuilder)), &proc)
  end

  def markdown_to_html(markdown)
    return "" unless markdown
    engine = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true)
    engine.render(markdown).html_safe
  end

  def js_app_object(data)
    content_for :additional_page_header_content do
      javascript_tag do
        render template: 'shared/js_app_object', formats: :js, locals: data
      end
    end
  end
end
