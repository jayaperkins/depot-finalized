require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "Amazing Bookstore has received your order", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["skandar1234567@gmail.com"], mail.from
    assert_match /1 x The Lord of the Rings/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Amazing Bookstore order has shipped!", mail.subject
    assert_equal ["dave@example.org"], mail.to
    assert_equal ["skandar1234567@gmail.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>The Lord of the Rings<\/td>/, mail.body.encoded
  end

end
