module Api
  module V1
    class TonightController < ApplicationController

      def show
        @tonight = Tonight.find_or_create
      end

      def index
        count = params[:count].to_i
        return @archive = [] if count == 0

        keys = $redis.lrange('tonight:index', 0, count - 1)  # archive is a stack, pull from left
        @archive = keys.map { |key| $redis.hgetall(key) }  # map over keys -> array of attr hashes
      end

    end
  end
end
