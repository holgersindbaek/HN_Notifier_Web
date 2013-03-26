class StreamsController < ApplicationController
  # 1. Set respond headers
  respond_to :html, :plist

  # 2. Require the hackernews api gem and include it
  require 'ruby-hackernews'
  include RubyHackernews

  # http://localhost:3000/stream/holgersindbaek/followee[]=holgersindbaek&followee[]=pg&followee[]=gkoberger
  def index
    puts "FORMAT"
    puts request.format
    if request.format.plist?
      puts "INSIDE"
      # 1. Define main array to send back, followees and current users
      user = User.new(params[:username])
      followees = params[:followee].map{|followee| User.new(followee)}

      # 2. Define and get followees_submissions
      @followees_submissions = followees.map{|followee| followee.submissions.first(5)}.flatten

      # 3. Find users latest submissions position on the frontpage
      @user_latest_submission = Entry.all(3).detect{|s| s.id == Entry.find(user.submissions.first.id).id}
    end
  end
end
