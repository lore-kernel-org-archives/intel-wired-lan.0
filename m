From: David Laight <David.Laight@ACULAB.COM>
Date: Mon, 21 Mar 2022 15:47:28 +0000
Subject: [Intel-wired-lan] [PATCH] ice: use min() to make code cleaner
 in ice_gnss
In-Reply-To: <20220321115412.844440-1-alexandr.lobakin@intel.com>
References: <20220318094629.526321-1-wanjiabing@vivo.com>
 <8822dfa2-bdb8-fceb-e920-94afb50881e8@intel.com>
 <20220321115412.844440-1-alexandr.lobakin@intel.com>
Message-ID: <ff90ebe7eed741829dc03b2bf92a41f7@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Use `min_t(typeof(bytes_left), ICE_MAX_I2C_DATA_SIZE)` to avoid
> this. Plain definitions are usually treated as `unsigned long`
> unless there's a suffix (u, ull etc.).

I suspect they are 'int'.
And the compiler will convert to 'unsigned int' in any
arithmetic.
And the 'signed v unsigned' compare warning is supressed
to integer constants.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

