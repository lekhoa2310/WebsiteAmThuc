class ExampleMailer < ApplicationMailer
  default from: "lienhewebsiteamthuc@gmail.com"

  def contact_email(user, name, email, subject, content)
    if user == "chưa đăng ký"
      @user_id = "chưa đăng ký"
    else
      @user_id = User.find_by_id(user).id
    end

    @name = name
    @email = email
    @subject = subject
    @content = content
    mail to: "lekhoa2310@gmail.com", subject: " #{@subject} "
  end
end
