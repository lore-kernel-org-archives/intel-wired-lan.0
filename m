From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 12 Sep 2019 08:57:44 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix secpath usage for IPsec TX
 offload.
In-Reply-To: <20190912.134359.345289288863944180.davem@davemloft.net>
References: <20190912110144.GS2879@gauss3.secunet.de>
 <20190912.134359.345289288863944180.davem@davemloft.net>
Message-ID: <2783711bae4ed87e2210894bcd980f8a3f052e94.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-09-12 at 13:43 +0200, David Miller wrote:
> From: Steffen Klassert <steffen.klassert@secunet.com>
> Date: Thu, 12 Sep 2019 13:01:44 +0200
> 
> > The ixgbe driver currently does IPsec TX offloading
> > based on an existing secpath. However, the secpath
> > can also come from the RX side, in this case it is
> > misinterpreted for TX offload and the packets are
> > dropped with a "bad sa_idx" error. Fix this by using
> > the xfrm_offload() function to test for TX offload.
> > 
> > Fixes: 592594704761 ("ixgbe: process the Tx ipsec offload")
> > Reported-by: Michael Marley <michael@michaelmarley.com>
> > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> I'll apply this directly and queue it up for -stable, thanks.

Thanks Dave!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190912/16161466/attachment.asc>
