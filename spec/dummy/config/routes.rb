Rails.application.routes.draw do

  mount ContactSync::Engine => "/contact_sync"
end
