# require "lrucache"

class Need < ActiveRecord::Base
  has_many :organisation_needs, dependent: :destroy
  has_many :organisations, through: :organisation_needs

  has_many :content_plan_needs, dependent: :destroy
  has_many :content_plans, through: :content_plan_needs

  has_many :content_needs, dependent: :destroy
  has_many :contents, through: :content_needs

  validates :api_id, presence: true

  # cattr_writer :needs
  # attr_accessor :data

  # def self.cache
  #   @cache ||= LRUCache.new(soft_ttl: 2.minutes, ttl: 10.minutes)
  # end

  # def self.reset_cache
  #   @cache = nil
  # end

  # def self.cache_fetch(key)
  #   inner_exception = nil
  #   cache.fetch(key) do
  #     begin
  #       yield
  #     rescue GdsApi::BaseError => e
  #       inner_exception = e
  #       raise RuntimeError.new("use_stale_value")
  #     end
  #   end
  # rescue RuntimeError => e
  #   if e.message == "use_stale_value"
  #     raise inner_exception
  #   else
  #     raise
  #   end
  # end

  # def self.all
  #   cache_fetch("all") do
  #     load_needs
  #   end
  # end

  # def self.load_needs
  #   ContentPlanner.needs_api.needs.with_subsequent_pages.map do |n|
  #     new(n)
  #   end.compact
  # end

  # def self.find(n)
  #   cache_fetch("find_#{n}") do
  #     new(ContentPlanner.needs_api.need(n))
  #   end
  # end

  # def initialize(data)
  #   @data = data
  # end

  # def ==(other)
  #   other.is_a?(self.class) && other.id == id
  # end

  # TODO: need to check this (it should be api_id)
  # def id
  #   @data.id
  # end

  def org_names
    organisations.map(&:abbreviation)
  end

  def to_s
    "[#{api_id}](#{org_names.join(', ')}) #{story}"
  end

  def story
    "As a #{role} I want to #{goal} so that #{benefit}"
  end
end
