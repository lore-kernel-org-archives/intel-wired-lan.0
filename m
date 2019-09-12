From: David Miller <davem@davemloft.net>
Date: Thu, 12 Sep 2019 13:43:59 +0200 (CEST)
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix secpath usage for IPsec TX
 offload.
In-Reply-To: <20190912110144.GS2879@gauss3.secunet.de>
References: <20190912110144.GS2879@gauss3.secunet.de>
Message-ID: <20190912.134359.345289288863944180.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Steffen Klassert <steffen.klassert@secunet.com>
Date: Thu, 12 Sep 2019 13:01:44 +0200

> The ixgbe driver currently does IPsec TX offloading
> based on an existing secpath. However, the secpath
> can also come from the RX side, in this case it is
> misinterpreted for TX offload and the packets are
> dropped with a "bad sa_idx" error. Fix this by using
> the xfrm_offload() function to test for TX offload.
> 
> Fixes: 592594704761 ("ixgbe: process the Tx ipsec offload")
> Reported-by: Michael Marley <michael@michaelmarley.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

I'll apply this directly and queue it up for -stable, thanks.
