module UrlHelper
  def random_phrases
    words = ["Damn Son!", "Woofin'!", "Aww snap!", "Holla!"]
		words[rand(words.size)] 
  end
end
