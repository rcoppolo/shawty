module UrlHelper
  def random_phrases
    words = ["Damn Son!", "You woofin'!", "Aww snap!", "Holla!"]
		words[rand(words.size)] 
  end
end
