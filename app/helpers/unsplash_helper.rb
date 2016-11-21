module UnsplashHelper
  def unsplash_image_url(keyword, width: 800, height: 600)
    "https://source.unsplash.com/#{ width }x#{ height }?#{ CGI.escape(keyword) }"
  end
end