require "cuba"
require "cuba/safe"
require "tilt/erb"
require "cuba/render"
require "ost"

Dir["./lib/**/*.rb"].each { |rb| require rb }

Ost.redis = Redic.new(ENV["REDIS_URL"] || "redis://127.0.0.1:6379")

Cuba.plugin Cuba::Safe
Cuba.plugin Cuba::Render
Cuba.settings[:render][:layout] = "layout.html"

Cuba.use Rack::Static, urls: ["/css"], root: "public"
Cuba.use Rack::MethodOverride

Cuba.define do
  on get, root do
    backups, queues = Ost::Web.queues.partition(&:backup?)
    render "index.html", queues: queues, backups: backups
  end

  on get, "queues/:id" do |id|
    render "queue.html", name: id, queue: Ost::Web[id]
  end

  on get, "backups/:id" do |id|
    render "backup.html", name: id, queue: Ost::Web[id]
  end

  on post, "backups/:id", param("item") do |id, item|
    backup = Ost::Web[id]
    queue = Ost[backup.name]

    queue << item

    res.redirect "/"
  end

  on delete, "backups/:id", param("item") do |id, item|
    backup = Ost::Web[id]
    Ost.redis.call("LREM", backup.key, 1, item)

    res.redirect "/"
  end
end
