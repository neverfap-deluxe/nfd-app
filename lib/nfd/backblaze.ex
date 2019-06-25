defmodule Nfd.BackBlaze do
  def get_file_contents(file_name) do
    auth_struct = Upstream.B2.Account.authorization()

    case Upstream.B2.Download.authorize(auth_struct, "", 3600) do
      {:ok, auth} ->
        Upstream.B2.Download.url(auth_struct, file_name, auth.authorization_token)
      {:error, error} ->
        IO.inspect error
        ""
    end
  end
end
