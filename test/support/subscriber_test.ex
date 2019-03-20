defmodule Nfd.Factory do
  use Nfd.ConnCase
  # If using Phoenix, import this inside the using block in Nfd.ConnCase
  import Nfd.Factory

  test "shows comments for an article" do
    conn = conn()
    article = insert(:article)
    comment = insert(:comment, article: article)

    conn = get conn, article_path(conn, :show, article.id)

    assert html_response(conn, 200) =~ article.title
    assert html_response(conn, 200) =~ comment.body
  end
end
