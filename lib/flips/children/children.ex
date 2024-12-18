defmodule Flips.Children.Children do
  use Ash.Resource, otp_app: :flips, domain: Flips.Children, data_layer: AshPostgres.DataLayer

  postgres do
    table "childrens"
    repo Flips.Repo
  end

  actions do

    create :create do
      primary? true
      accept [:first_name, :last_name, :dob]
    end

    read :read do
      primary? true
    end

  end

  attributes do
    uuid_primary_key :id

    attribute :first_name, :string do
      allow_nil? false
      public? true
    end
    attribute :last_name, :string do
      allow_nil? false
      public? true
    end
    attribute :dob, :date do
      allow_nil? false
      public? true
    end

    timestamps()

  end
end
