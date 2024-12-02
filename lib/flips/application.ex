defmodule Flips.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FlipsWeb.Telemetry,
      Flips.Repo,
      {DNSCluster, query: Application.get_env(:flips, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Flips.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Flips.Finch},
      # Start a worker by calling: Flips.Worker.start_link(arg)
      # {Flips.Worker, arg},
      # Start to serve requests, typically the last entry
      FlipsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Flips.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FlipsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
