namespace :purge do
  
  desc "Purge unused has_and_belongs_to_many associations (one of the associated record is nil)"
  task :associations => :environment do
    puts "Purging unused boards_categories"
    current_nb = BoardsCategory.count
    BoardsCategory.all.each do |board_cat|
      check_board(board_cat.board_id)
      check_model(Category, board_cat.category_id)
    end
    purged = current_nb - BoardsCategory.count
    puts "Purged #{purged} boards_categories lines"
    
    puts "Purging unused boards_tags"
    current_nb = BoardsTag.count
    BoardsTag.all.each do |board_tag|
      check_board(board_tag.board_id)
      check_model(Tag, board_tag.tag_id)
    end
    purged = current_nb - BoardsTag.count
    puts "Purged #{purged} boards_tags lines"
    
    puts "Purging unused user_follows"
    current_nb = UserFollow.count
    UserFollow.all.each do |user_fol|
      check_model(User, user_fol.user_id)
      check_model(Store, user_fol.store_id)
    end
    purged = current_nb - UserFollow.count
    puts "Purged #{purged} UserFollow lines"
    
    puts "Purging unused Product Wishlist"
    current_nb = ProductsWishlist.count
    ProductsWishlist.all.each do |prod_wish|
      check_model(Wishlist, prod_wish.wishlist_id)
      #check_model(Product, prod_wish.product_id)
    end
    purged = current_nb - ProductsWishlist.count
    puts "Purged #{purged} ProductsWishlist lines"
    
    puts "Purging unused deals_wishlists"
    current_nb = DealsWishlist.count
    DealsWishlist.all.each do |deal_wish|
      check_model(Wishlist, deal_wish.wishlist_id)
      #check_model(Deal, deal_wish.deal_id)
    end
    purged = current_nb - DealsWishlist.count
    puts "Purged #{purged} DealsWishlist lines"
    
    puts "Purging unused boards"
    Board.all.each do |board|
      if board.user.nil?
        puts "Destroying board"
        board.destroy
      end
    end
    
    puts "Purging too many boards for user"
    User.all.each do |user|
      board_count = user.boards.count
      if board_count > 3
        puts "Purging too many boards"
        user.boards.limit(4..board_count).destroy_all
      end
    end
  end
  
  def check_board(board_id)
    b = Board.where(:id => board_id).first_or_initialize()
    if b.new_record?
      puts "New board => cleaning associations"
      b.user_id = User.first.id
      b.title = "toto"
      b.district_ids = Board.first.district_ids
      if b.save
        puts "Cleaning associations"
        b.destroy
      else
        puts "Error"
        User.first.boards.delete_all
        puts b.errors.full_messages
      end
    end
  end
  
  def check_model(model, id)
    m = model.where(:id => id).first_or_initialize()
    if m.new_record?
      puts "New #{model.to_s} => cleaning associations"
      m = model.last.dup
      m.id = id
      if m.save(:validate => false)
        puts "Clear association"
        m.destroy
      else
        puts "Errors during save"
        puts m.errors.full_messages
        return false
      end
    end
  end
end