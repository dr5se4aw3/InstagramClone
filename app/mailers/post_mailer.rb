class PostMailer < ApplicationMailer
  def post_mail(post)
    @post = post
    mail to: "dr5se4aw3@yahoo.com", subject: "投稿通知"
  end
end
