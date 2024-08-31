RailsAdmin.config do |config|
  config.asset_source = :webpacker
  config.asset_source = :sprockets

  config.model 'Hotel' do
    edit do
      field :name
      field :description do
        partial 'description_with_ai'
      end
      field :hotel_type
      field :user
      field :total_rooms
      field :available_rooms
      field :images
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    # show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
