defmodule NfdWeb.DashboardView do
  use NfdWeb, :view

  def check_is_subscribed(subscribed_property) do
    if (subscribed_property == true) do
      "Subscribed"
    else
      "Unsubscribed"
    end
  end


  def course_active_type_to_readable_text(collection) do
    case Map.get(collection, :active_type) do
      "free_active_type" -> "Free"
      "awareness_active_type" -> "Awareness"
      "meditation_active_type" -> "Meditation"
      _ -> "This does not have a type, yo."
    end
  end


  def course_active_type_to_active_type_symbol(collection) do
    case Map.get(collection, :active_type) do
      "free_active_type" -> :free_active
      "awareness_active_type" -> :awareness_active
      "meditation_active_type" -> :meditation_active
      _ -> nil
    end
  end
end
