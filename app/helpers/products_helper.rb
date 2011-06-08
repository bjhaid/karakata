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
  def facebook_like
    content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(request.url)}&layout=standard&show_faces=true&width=450&action=like&font=arial&colorscheme=light&height=80", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
  end
  
end
