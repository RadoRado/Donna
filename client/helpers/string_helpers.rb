class String
  def demodulize
    split('::').last
  end
end
