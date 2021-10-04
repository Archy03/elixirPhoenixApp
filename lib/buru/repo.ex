defmodule Buru.Repo do
  use Ecto.Repo,
    otp_app: :buru,
    adapter: Ecto.Adapters.Postgres
end
