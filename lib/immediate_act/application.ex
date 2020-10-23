defmodule ImmediateAct.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ImmediateAct.Repo,
      # Start the Telemetry supervisor
      ImmediateActWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ImmediateAct.PubSub},
      # Start the Endpoint (http/https)
      ImmediateActWeb.Endpoint
      # Start a worker by calling: ImmediateAct.Worker.start_link(arg)
      # {ImmediateAct.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ImmediateAct.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ImmediateActWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
