require 'spec_helper'

describe WebhookController do
  
  let :gem_payload do
    {
      "name" => "rails",
      "info" => "Rails is a framework for building web-application using CGI, FCGI, mod_ruby,
               or WEBrick on top of either MySQL, PostgreSQL, SQLite, DB2, SQL Server, or 
               Oracle with eRuby- or Builder-based templates.",
      "version" => "2.3.5",
      "version_downloads" => 2451,
      "authors" => "David Heinemeier Hansson",
      "downloads" => 134451,
      "project_uri" => "http://rubygems.org/gems/rails",
      "gem_uri" => "http://rubygems.org/gems/rails-2.3.5.gem",
      "homepage_uri" => "http://www.rubyonrails.org/",
      "wiki_uri" => "http://wiki.rubyonrails.org/",
      "documentation_uri" => "http://api.rubyonrails.org/",
      "mailing_list_uri" => "http://groups.google.com/group/rubyonrails-talk",
      "source_code_uri" => "http://github.com/rails/rails",
      "bug_tracker_uri" => "http://rails.lighthouseapp.com/projects/8994-ruby-on-rails",
      "dependencies" => {
        "runtime" => [
          {
            "name" => "activesupport",
            "requirements" => ">= 2.3.5"
          }
        ],
        "development" => [ ]
      }
    }
  end
  
  def post_gem
    request.env["HTTP_ACCEPT"] = "application/json"
    request.env["RAW_POST_DATA"] = gem_payload.to_json
    post :gem
  end

  it "should receive a payload" do
    post_gem
    response.should be_success
    Rubygem.search(:q => 'rails').results.first.name.should == "rails"
  end

end
