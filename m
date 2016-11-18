From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 17 Nov 2016 21:53:30 -0800
Subject: [Intel-wired-lan] [net-next PATCH] ixgbe/ixgbevf: Enables TSO
 for MPLS encapsulated packets
In-Reply-To: <1479236637.26945.70.camel@intel.com>
References: <1479236637.26945.70.camel@intel.com>
Message-ID: <1479448410.2420.92.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-11-15 at 19:03 +0000, Peterson, Scott D wrote:
> This patch advertises TSO & GSO features in netdev->mpls_features.?
> In ixgbe(vf)_tso() where we set up segmentation offload, the IP?
> header will be the inner network header when eth_p_mpls() indicates
> the Ethernet protocol is MPLS (UC or MC).
> 
> We're submitting this upstream first, because it depends on related
> upstream changes not yet present in the OOT drivers.
> 
> Suggested-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
> ---
> 
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c?????| 12 ++++++++++--
> ?drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
> ?2 files changed, 20 insertions(+), 4 deletions(-)

Not sure what is going on, but your patch does not apply. ?I tried
downloading your patch from patchworks and it says the patch is corrupt.

I will look at this later tonight to see if your patch can be applied by
hand for testing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161117/83a698f6/attachment.asc>
