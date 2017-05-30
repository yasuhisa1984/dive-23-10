module UsersHelper
  # ログインしているユーザーのユーザー詳細画面かどうかを判定する
  def is_current_user?(comparison_user)
    if user_signed_in?
      if current_user.id == comparison_user.id
        true
      end
    end
  end
end
