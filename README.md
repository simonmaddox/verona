Verona is a simple gem for verifying Google Play In-App Purchase tokens, and retrieving the information associated with the purchase.

There are two reasons why you should verify in-app purchase receipts on the server: First, it allows you to keep your own records of past purchases, which is useful for up-to-the-minute metrics and historical analysis. Second, server-side verification over SSL is the most reliable way to determine the authenticity of purchasing records.

Verona is based on [@mattt's](http://twitter.com/mattt) [Venice](https://github.com/nomad/venice) gem for iOS In-App Purchase verification.

## Installation

    $ gem install verona

## Usage

First, ensure that you have a valid the following environment variables set up:

- `GOOGLE_PLAY_CLIENT_ID`
- `GOOGLE_PLAY_CLIENT_SECRET`
- `GOOGLE_PLAY_REFRESH_TOKEN`

You can get these from The [Google Developer Website](https://developers.google.com/android-publisher/authorization).

```ruby
require 'verona'

if receipt = Verona::Receipt.verify({
            :package_name => "com.mycompany.app",
            :product_id => "com.mycompany.app.iap",
            :token => "token"
        })
  p receipt.to_h
end
```

## Contact

Simon Maddox

- http://github.com/simonmaddox
- http://twitter.com/simonmaddox
- simon@simonmaddox.com

## License

Verona is available under the MIT license. See the LICENSE file for more info.
