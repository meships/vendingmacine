vm = VendingMacine.new　　初期設定
vm.stoks　　　　　　　　　 現在自販機に入っている在庫を確認
vm.slot_money(投入金額)　 自販機にお金を入れる
vm.current_slot_money    現在自販機に入っている金額を確認
vm.buy_list              現在の投入してある金額と在庫の状況で買えるものを教えてくれる
vm.buy                   買う
vm.return_money          残額を返金
vm.sales                 自販機の売上金を表示

クラスを2つに分けた理由
- オブジェクト指向を現実の物として置き換えたときに
  自販機　飲み物　購入者　お金　の4つになると想定
  購入者は自分たち　お金はサンプルに入っている　自販機はサンプルはサンプルに入っている
  飲み物をクラスとして追加

自分たちのコードで工夫をしたところ
- lighting_list
  実際の自販機のように購入可能な物が点灯している状態をあらわすので
  選択肢を限定している（実際の自販機も買える状態のものが条件で限定されている）

- juicd_setup
  vm = VendingMacine.new を行ったときに飲み物のセットが終わるようにしている
  juicd_setup内で使っている refill(juice,number) と Juice は
  private にして外で使えないようにしている

保守　増設を行いやすくするため
- 特異メソッドでインスタンスしているためでクラス間の関係性が薄い状態を保っていられる