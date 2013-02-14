# More info: https://github.com/tanoku/redcarpet

REDCARPET = Redcarpet::Markdown.new(
  Redcarpet::Render::HTML,
  autolink: true
)

String.class_eval do
  def markdown
    REDCARPET.render self
  end
end