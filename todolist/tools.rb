class ParamsCheck
  def check_post(body)
    if !body
      return false
    elsif !body[:task]
      return false
    end
    return true
  end
  def check_put(body)
    if !body
      return false
    elsif !body[:task]
      return false
    elsif !body[:completed]
      return false
    end
    return true
  end
end