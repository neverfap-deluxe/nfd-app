defmodule Nfd.BackBlaze do

  # BACKBLAZE_ACCOUNT_ID
  # BACKBLAZE_API_KEY

  # https://github.com/keichan34/b2_client

  def get_file_contents(bucket_name, file_name) do

    # auth_struct = Upstream.B2.Account.authorization()

    # case Upstream.B2.Download.authorize(auth, prefix, duration) do
    #   {:ok, auth} ->
    #   {:error, error} ->
    # end



    # {:ok, auth} = B2Client.backend.authenticate(System.get_env("BACKBLAZE_ACCOUNT_ID"), System.get_env("BACKBLAZE_API_KEY"))
    # {:ok, bucket} = B2Client.backend.get_bucket(auth, "my-bucket-name")
    # {:ok, file_contents} = B2Client.backend.download(auth, bucket, file_name)

    # file_contents
  end

  def get_bucket_name() do

  end
end
