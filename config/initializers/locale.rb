# I18nライブラリに訳文の探索場所を指示する
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
 
# アプリで利用可能なロケールをホワイトリスト化する
I18n.available_locales = [:en, :ja]
 
# ロケールを:en以外に変更する
I18n.default_locale = :ja
