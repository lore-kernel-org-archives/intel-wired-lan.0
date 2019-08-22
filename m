From: David Miller <davem@davemloft.net>
Date: Thu, 22 Aug 2019 16:23:39 -0700 (PDT)
Subject: [Intel-wired-lan] 
 =?iso-2022-jp?b?W1BBVENIXSBldGhlcm5ldDogRGVs?=
 =?iso-2022-jp?b?ZXRlIHVubmVjZXNzYXJ5IGNoZWNrcyBiZWZvcmUgdGhlIG1hY3JvIGNh?=
 =?iso-2022-jp?b?bGwgGyRCIUgbKEJkZXZfa2ZyZWVfc2tiGyRCIUkbKEI=?=
In-Reply-To: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
References: <af1ae1cf-4a01-5e3a-edc2-058668487137@web.de>
Message-ID: <20190822.162339.831735149510227752.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Markus Elfring <Markus.Elfring@web.de>
Date: Thu, 22 Aug 2019 20:30:15 +0200

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 22 Aug 2019 20:02:56 +0200
> 
> The dev_kfree_skb() function performs also input parameter validation.
> Thus the test around the shown calls is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied.
