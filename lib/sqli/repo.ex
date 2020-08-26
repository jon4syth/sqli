defmodule Sqli.Repo do
  use Ecto.Repo,
    otp_app: :sqli,
    adapter: Ecto.Adapters.Postgres
end
