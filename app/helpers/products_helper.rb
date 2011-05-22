module ProductsHelper
  def add_asset(form_builder)
    link_to_function "add", :id  => "add_asset" do |page|
      form_builder.fields_for :assets, asset.new, :child_index => 'NEW_RECORD' do |asset_form|
        html = render(:partial => 'asset', :locals => { :f => asset_form })
        page << "$('add_asset').insert({ before: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end
  def delete_asset(form_builder)
    if form_builder.object.new_record?
      link_to_function("Remove this asset", "this.up('fieldset').remove()")
    else
      form_builder.hidden_field(:_delete) +
      link_to_function("Remove this asset", "this.up('fieldset').hide(); $(this).previous().value = '1'")
    end
  end
end
