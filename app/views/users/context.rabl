object :context
if user_signed_in?
  if current_user.user?
    child @gon_context[:boards] => :boards do
      extends "boards/index"
    end
  end
  node :current_user do
    partial('/users/item', object: current_user)
  end
elsif !get_temporary_boards.nil?
  child @gon_context[:boards] => :boards do 
    extends "boards/index"
  end
end
