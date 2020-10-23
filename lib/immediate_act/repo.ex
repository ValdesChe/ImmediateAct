defmodule ImmediateAct.Repo do
  use Ecto.Repo,
    otp_app: :immediate_act,
    adapter: Ecto.Adapters.Postgres
end
