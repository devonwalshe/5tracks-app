module EnqueueButtonComponent
  extend ComponentHelper
  def enqueue_button_text(n, queue)
    if n > 1
      return "Add #{n} tracks to #{queue} queue"
    else
      return "Add track to #{queue} queue"
    end
  end
end
