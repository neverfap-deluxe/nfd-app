defmodule NfdWeb.Redirects do
  use NfdWeb, :controller

  def redirect_content(conn, slug, type) do
    case type do
      "page" -> redirect_page(conn, slug)
      "article" -> redirect_article(conn, slug)
      "practice" -> redirect_practice(conn, slug)
      "course" -> redirect_course(conn, slug)
      "podcast" -> redirect_podcast(conn, slug)
      "quote" -> redirect_quote(conn, slug)
      "meditation" -> redirect_meditation(conn, slug)
      "blog" -> redirect_blog(conn, slug)
      "update" -> redirect_update(conn, slug)

      "seven_day_kickstarter_single" -> redirect_seven_day_kickstarter_single(conn, slug)
      "ten_day_meditation_single" -> redirect_ten_day_meditation_single(conn, slug)
      "twenty_eight_day_awareness_single" -> redirect_twenty_eight_day_awareness_single(conn, slug)
      
      "seven_week_awareness_vol_1_single" -> redirect_seven_week_awareness_vol_1_single(conn, slug)
      "seven_week_awareness_vol_2_single" -> redirect_seven_week_awareness_vol_2_single(conn, slug)
      "seven_week_awareness_vol_3_single" -> redirect_seven_week_awareness_vol_3_single(conn, slug)
      "seven_week_awareness_vol_4_single" -> redirect_seven_week_awareness_vol_4_single(conn, slug)
      _ -> slug
    end
  end

  def redirect_page(_conn, slug) do
    case slug do
      _ -> slug
    end
  end

  def redirect_article(_conn, slug) do
    case slug do
      _ -> slug
    end
  end

  def redirect_practice(conn, slug) do
    IO.inspect slug
    case slug do
      "observe-it-all" -> conn |> redirect(to: Routes.content_path(conn, :practice, "observe-your-senses"))
      "dissolve-it-down" -> conn |> redirect(to: Routes.content_path(conn, :practice, "dissolve-your-visual-field"))
      "focus-it-forward" -> conn |> redirect(to: Routes.content_path(conn, :practice, "focus-your-attention"))
      "slow-it-down" -> conn |> redirect(to: Routes.content_path(conn, :practice, "slow-down-time"))
      "point-to-point" -> conn |> redirect(to: Routes.content_path(conn, :practice, "identify-points-of-awareness-throughout-your-day"))
      "stop-it-all" -> conn |> redirect(to: Routes.content_path(conn, :practice, "stop-absolutely-everything-you-are-doing"))
      "observe-it-all" -> conn |> redirect(to: Routes.content_path(conn, :practice, "observe-your-senses"))
      "relax-it-out" -> conn |> redirect(to: Routes.content_path(conn, :practice, "relax-everything"))
      "catch-it-out" -> conn |> redirect(to: Routes.content_path(conn, :practice, "catch-out-your-judgements"))
      "see-not-feel" -> conn |> redirect(to: Routes.content_path(conn, :practice, "separate-your-seeing-from-your-feeling"))
      "the-odd-judge-out" -> conn |> redirect(to: Routes.content_path(conn, :practice, "catching-the-odd-judge-out"))
      _ -> slug
    end
  end

  def redirect_course(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_podcast(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_quote(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_meditation(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_blog(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_update(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_seven_day_kickstarter_single(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_ten_day_meditation_single(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_twenty_eight_day_awareness_single(_conn, slug) do 
    case slug do
      _ -> slug
    end
  end

  def redirect_seven_week_awareness_vol_1_single(_conn, slug) do
    case slug do
      _ -> slug
    end
  end

  def redirect_seven_week_awareness_vol_2_single(_conn, slug) do
    case slug do
      _ -> slug
    end
  end

  def redirect_seven_week_awareness_vol_3_single(_conn, slug) do
    case slug do
      _ -> slug
    end
  end

  def redirect_seven_week_awareness_vol_4_single(_conn, slug) do
    case slug do
      _ -> slug
    end
  end
  
end