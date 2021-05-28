#
# Quick and hacky script to migrate content from old PHP/Postgres driven blog
# to this new shiny static awesomeness!
#

require 'sequel'
require 'yaml'

connection_str = 'postgres://postgres:postgres@localhost:5434/ij_blog'
DB = Sequel.connect(connection_str)

### Models for legacy tables
class Category < Sequel::Model(DB[:ij_category]); end

class Note < Sequel::Model(DB[:ij_note])
  many_to_many :tags, join_table: :ij_tag2post
end

class Post < Sequel::Model(DB[:ij_post])
  many_to_one :category
  many_to_many :tags, join_table: :ij_tag2post
end

class Tag < Sequel::Model(DB[:ij_tags]); end
###

def generate_post_frontmatter(post)
  tags = post.tags.map(&:name) + [post.category.title_en]

  #TODO Add Meta tags override where exist

  {
    'title' => post.title,
    'date' => post.create_date.strftime('%Y-%m-%d'),
    'status' => post.status == 1 ? 'published' : 'draft',
    'tags' => tags,
  }
end

Post.each do |post|
  date = post.create_date.strftime('%Y-%m-%d')
  file = File.new("./content/posts/#{post.lang}/#{date}-#{post.seo_url}.md", 'w+')
  content = "#{generate_post_frontmatter(post).to_yaml}---\n#{post.short_text}"
  unless(post.full_text.empty?)
    content = "#{content}<!--more-->\n#{post.full_text}"
  end
  file << content
  file.close
end

def generate_note_frontmatter(note)
  tags = note.tags.map(&:name)
  {
    'date' => note.create_date.strftime('%Y-%m-%d'),
    'status' => 'published',
    'tags' => tags,
  }
end

Note.each do |note|
  date = note.create_date.strftime('%Y-%m-%d')

  if(note.text_en && !note.text_en.empty?)
    file = File.new("./content/notes/#{date}-#{note.id}.md", 'w+')
    content = "#{generate_note_frontmatter(note).to_yaml}---\n#{note.text_en}"
    file << content
    file.close
  end
end

