require 'spec_helper'

APIKEY = ''
SECRETKEY = ''

describe RubyBitbankcc do
  it 'has a version number' do
    expect(RubyBitbankcc::VERSION).not_to be nil
  end

  it 'read transactions' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    res = bbcc.read_transactions('btc_jpy')
    puts res
    res = bbcc.read_transactions('btc_jpy', '20170215')
    puts res
  end

  it 'read ticker' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    res = bbcc.read_ticker('btc_jpy')
    puts res
  end

  it 'read order books' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    res = bbcc.read_order_books('btc_jpy')
    puts res
  end

  it 'generate get signature' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    signature = bbcc.send(:get_get_signature, '/v1/user/assets', 'hogeho', '1492954196103')
    expect(signature).to eq 'e6230395d58ecae37ca0aad261ed278b38dd5751e24b101ef8a843de552674bf'
  end

  it 'generate post signature' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    signature = bbcc.send(:get_post_signature, 'hogeho', '1493006841189', '{"pair": "btc_jpy", "amount": "0.001", "price": 130000, "side": "buy", "type": "limit"}')
    expect(signature).to eq 'b6b62902417156a63c3f2fc0f65d5f82917137f0ea0ec7fbee5c048fd12877dd'
  end

  it 'read balance' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    res = bbcc.read_balance()
    puts res
    sleep(1)
  end

  it 'read active orders' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    res = bbcc.read_active_orders('btc_jpy')
    puts res
    sleep(1)
  end

  it 'create order and cancel order' do
    bbcc = Bitbankcc.new(APIKEY, SECRETKEY)
    res = bbcc.create_order('btc_jpy', "0.001", 130000, 'buy', 'limit')
    order_id = JSON.parse(res)['data']['order_id']
    puts res
    sleep(1)
    res = bbcc.cancel_order('btc_jpy', order_id)
    puts res
    sleep(1)
  end
end
