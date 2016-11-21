module ListingsHelper
  def adult_faces_emoji(count)
    emoji_count(count, ['👨','👩'])
  end

  def bedroom_emoji(count)
    emoji_count(count, ['🚪'])
  end

  def bed_emoji(count)
    emoji_count(count, ['🛌'])
  end

  private
    def emoji_count(count, source)
      count.times.map{ source.sample }.join(' ')
    end
end
