class PageColAdd < ActiveRecord::Migration
  def change
    add_column(:pages, :video_bg_url, :string)
  end
end
