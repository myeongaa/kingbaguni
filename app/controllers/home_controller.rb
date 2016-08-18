class HomeController < ApplicationController
   before_action :require_login
  def index             #장바구니
      @carts = Cart.all.reverse
      @ca = Cart.where("user_id LIKE ?",current_user.id).reverse
      @fol = Folder.all
      @fol2 = Folder.where("user_id LIKE ?",current_user)
      @book = Bookmark.all
      @book2 = Bookmark.where("user_id LIKE ?",current_user) 
  end

  def in_cart    #장바구니에 담을 때 정보 입력
    @fol = Folder.all
    @fol2 = Folder.where("user_id LIKE ?",current_user)
  end
  
  def in_cart2    #장바구니에 담을 정보가 여기로왔다가 장바구니로 뿅!
     @fol = Folder.all
     f = Folder.find_by_id(params[:fol])
     file = params[:pic]
     
     uploader = KingUploader.new
     uploader.store!(file)
     
     cart = Cart.new     #여기에계속정보가쌓이는거!
      cart.name = params[:name]
      cart.url = params[:url]
      cart.s_name = params[:s_name]
      cart.price = params[:price]
      cart.d_price = params[:d_price]
      cart.image_url = uploader.url
      cart.total = cart.price.to_i + cart.d_price.to_i
      cart.user = current_user
      unless f == nil
        cart.folders << f     #폴더 지정해주기
      end
      cart.save
      
      redirect_to "/home/index"   #장바구니로 뿅!
    
  end
  
  def delete  #장바구니에서 삭제기능
   
    @d = params[:cart_ids]   #체크가된 체크박스의 아이디를 불러와서
   
    @carts = Cart.all
    unless @d==nil
      @d.each do |d|              #아이디가돌면서
        @carts = Cart.where("id LIKE ?",d).destroy_all   #아이디에맞는저장된정보가삭제되는거!
      end
    end
    redirect_to "/home/index"      #바로장바구니로 뿅!
  end
  
  def edit     #수정하려는 정보 입력하는 페이지
    @carts = Cart.all
    @cartna = params[:cart_id]
    @editcart = Cart.find_by_id(@cartna)
    @fol = Folder.all
    @fol2 = Folder.where("user_id LIKE ?",current_user)
    @book = Bookmark.all
    @book2 = Bookmark.where("user_id LIKE ?",current_user)
    
  end
  
  def edit2    #실제로 수정하는 페이지
    @fol = Folder.all
    f = Folder.find_by_id(params[:fol])
    file = params[:pic]
    uploader = KingUploader.new
    uploader.store!(file)
    @cartna = params[:cart_id]
    @editcart = Cart.find_by_id(@cartna)
    
    @editcart.name = params[:name]
    @editcart.s_name = params[:s_name]
    @editcart.price = params[:price]
    @editcart.d_price = params[:d_price]
    unless f == nil
      @editcart.folders.destroy_all
      @editcart.folders << f
    else
      @editcart.folders.destroy_all
    end
    
    unless uploader.url == nil
      @editcart.image_url = uploader.url
    end
    @editcart.save
    
    redirect_to "/home/index"
  end

  def purchase       #구매한물건들목록출력하는곳!
    @pur = Purchase.all.reverse
    @pu = Purchase.where("user_id LIKE ?",current_user.id).reverse
    @fol = Folder.all
    @fol2 = Folder.where("user_id LIKE ?",current_user)
    @book = Bookmark.all
    @book2 = Bookmark.where("user_id LIKE ?",current_user)

  end
  def purchase2       #구매한 물건들 목록을 여기로보내서 purchase로 뿅!
    @pur = params[:cart_ids].reverse       #체크된거 아이디를 여기로보내서
    @carts = Cart.all
    unless @pur == nil
      @pur.each do |p|      #체크된아이디가돌면서
        purchase = Purchase.new        #새로운 구매한 목록을 만들고
        
        purchase.name = Cart.where("id LIKE ?",p)[0].name  #카트에있는정보들을 purchase로 다옮겨
        purchase.url = Cart.where("id LIKE ?",p)[0].url
        purchase.s_name = Cart.where("id LIKE ?",p)[0].s_name
        purchase.price = Cart.where("id LIKE ?",p)[0].price
        purchase.d_price= Cart.where("id LIKE ?",p)[0].d_price
        purchase.total= Cart.where("id LIKE ?",p)[0].total
        purchase.image_url = Cart.where("id LIKE ?",p)[0].image_url
        purchase.folders = Cart.where("id LIKE ?",p)[0].folders
        purchase.user = current_user

        purchase.save
      end
      @pur.each do|p|   #또돌면서
           @carts = Cart.where("id LIKE ?",p).destroy_all      #여기선 카트에있는그정보들을지워!
      end
    end
      redirect_to "/home/purchase"       #바로구매한목록으로가게뿅!
  end
  
  def p_delete         #구매목록에서 삭제하는부분
    @d = params[:cart2_ids]      #구매목록에서 체크된부분의 아이디를 불러옴
    @pur = Purchase.all
    unless @d==nil
      @d.each do |d|                  #체크아이디가돌면서
       @pur = Purchase.where("id LIKE ?",d).destroy_all         #아이디에맞는정보를지워!
      end
    end
    redirect_to "/home/purchase"    #바로구매목록으로!
  end
  
  def to_cart       #장바구니로다시담기를 할 때 거쳐가는곳
    @d = params[:cart2_ids].reverse      #체크된아이디불러와서
    @pur = Purchase.all
    unless @d == nil
    @d.each do |d|      #아이디가돌면서
        cart = Cart.new          #새로운카트만들고
        cart.name = Purchase.where("id LIKE ?",d)[0].name         #purchase의 정보를 cart로
        cart.url = Purchase.where("id LIKE ?",d)[0].url
        cart.s_name = Purchase.where("id LIKE ?",d)[0].s_name
        cart.price = Purchase.where("id LIKE ?",d)[0].price
        cart.d_price = Purchase.where("id LIKE ?",d)[0].d_price
        cart.total = Purchase.where("id LIKE ?",d)[0].total
        cart.image_url = Purchase.where("id LIKE ?",d)[0].image_url
        cart.folders = Purchase.where("id LIKE ?",d)[0].folders
        cart.user = current_user
  
        cart.save
      end
      
      @d.each do |d|           #또 돌면서
        @pur = Purchase.where("id LIKE ?",d).destroy_all     #purchase의 정보를지워
      end
    end
    redirect_to "/home/index"   #바로장바구니로!
  end
  
  def folder   #폴더 관리하는 페이지
    @fol = Folder.all
    @fol2 = Folder.where("user_id LIKE ?",current_user)
  end
  
  def folder2     #장바구니 폴더 별로 보는 곳
    @folid = params[:fol_id]
    @fol = Folder.all
    @carts = Cart.all
    
    @fol2 = Folder.find_by_id(@folid).carts.reverse
    
  end
  
  def folder3     #구매목록 폴더 별로 보는 곳
    @folid = params[:fol_id]
    @fol = Folder.all
    @carts = Cart.all
    
    @fol2 = Folder.find_by_id(@folid).purchases.reverse
  end
  
  def fol_add      #폴더 추가하는 곳
    folder = Folder.new
    folder.name = params[:name]
    folder.user = current_user
    folder.save
    redirect_to "/home/folder"
  end
  
  def fol_del    #폴더 삭제하는 곳
    @f_del = params[:fol]
    @fol = Folder.all
    @carts = Cart.all
    unless @f_del == nil
      @f_del.each do |f|
       @cart3 = Folder.find_by_id(f).carts
        @cart3.each do |c|
          c.delete
        end
        Folder.where("id LIKE ?",f).destroy_all
      end
    end
    redirect_to "/home/folder"
  end
  
  def bookmark
    @book = Bookmark.all
    @book2 = Bookmark.where("user_id LIKE ?",current_user)
  end
  
  def book_add
    book = Bookmark.new
    book.name = params[:name]
    book.url = params[:url]
    book.user = current_user
    book.save
    
    redirect_to "/home/bookmark"
  end
  
  def book_del
    @b_del = params[:book]
    @book = Bookmark.all
    
    unless @b_del == nil
      @b_del.each do |b|
        Bookmark.where("id LIKE ?",b).destroy_all
      end
    end
    redirect_to "/home/bookmark"
  end
  

end
