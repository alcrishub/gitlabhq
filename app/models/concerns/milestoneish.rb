module Milestoneish
  def closed_items_count(user)
    issues_visible_to_user(user).closed.size + merge_requests.closed_and_merged.size
  end

  def total_items_count(user)
    issues_visible_to_user(user).size + merge_requests.size
  end

  def complete?(user)
    total_items_count(user) > 0 && total_items_count(user) == closed_items_count(user)
  end

  def percent_complete(user)
    ((closed_items_count(user) * 100) / total_items_count(user)).abs
  rescue ZeroDivisionError
    0
  end

  def remaining_days
    return 0 if !due_date || expired?

    (due_date - Date.today).to_i
  end

  def issues_visible_to_user(user)
    IssuesFinder.new(user).execute.where(id: issues)
  end
end
