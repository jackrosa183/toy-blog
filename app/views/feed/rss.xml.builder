xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Jack's Blog"
    xml.description "A hashrocket apprentice project"
    xml.link root_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description strip_tags(post.rich_content.to_s)
        xml.pubDate post.created_at.to_s(:rfc822)
      end
    end
  end
end