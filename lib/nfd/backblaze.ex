defmodule Nfd.BackBlaze do

  def get_file_contents(file_name) do
    IO.inspect 3
    auth_struct = Upstream.B2.Account.authorization()
    IO.inspect 2
    case Upstream.B2.Download.authorize(auth_struct, "", 3600) do
      {:ok, auth} ->
        IO.inspect auth
        url = Upstream.B2.Download.url(auth, file_name)
        IO.inspect url
        url
      {:error, error} ->
        IO.inspect error
        ""
    end
  end

  def get_bucket_name() do

  end
end
