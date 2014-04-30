class UsersController < ApplicationController
  expose(:user)
  expose(:users)
  expose(:comments) {
    user.comments.roots.page(params[:page])
  }
  expose(:content_plans) {
    user.content_plans
  }
  expose(:contents) {
    user.contents
  }
end
