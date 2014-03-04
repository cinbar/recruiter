require 'recruiter/settings'

module Recruiter
  def self.settings
    @settings ||= Recruiter::Settings.new
  end
end