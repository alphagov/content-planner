class UsersController < ApplicationController
  expose(:user)
  expose(:users)
  expose(:content_plans) { user.content_plans.order(:ref_no) }
  expose(:contents) { user.contents.order(:ref_no) }
  expose(:comments) { user.comments.roots.page(params[:page]) }
  expose(:tasks) { user.tasks }
end
