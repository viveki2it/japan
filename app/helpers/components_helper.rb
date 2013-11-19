# -*- encoding : utf-8 -*-
module ComponentsHelper

  def modal_window(id, title, buttons=[], &block)
    render 'shared/modal', id: id, title: title, buttons: buttons, content: capture(&block)
  end

  def lightbox_link_to(*args, &block)
    args << {} unless args.last.is_a? Hash
    args.last[:rel] = 'lightbox'
    args.last[:target] = 'blank'
    link_to *args, &block
  end

  def contact_form_url
    "//support.jangalamarket.com/customer/widget/emails/new"
  end

  def twi_follow_button
    btn = <<btn
      <a href="https://twitter.com/JangalaMarket" class="twitter-follow-button" data-show-count="false" data-lang="fr" data-show-screen-name="false">Suivre @JangalaMarket</a>
      <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="//platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
btn
    render inline: btn
  end

  def fb_like_button
    btn = <<btn
      <iframe src="//www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fpages%2FJangala-Market%2F156397884499845&amp;send=false&amp;layout=button_count&amp;width=450&amp;show_faces=true&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21&amp;appId=285493054860713" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:80px; height:21px;" allowTransparency="true"></iframe>
btn
    render inline: btn
  end
end
