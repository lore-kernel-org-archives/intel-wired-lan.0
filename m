From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 14 Feb 2017 19:40:58 +0000
Subject: [Intel-wired-lan] [next PATCH] ixgbe: Limit use of 2K buffers
 on architectures with 256B or larger cache lines
In-Reply-To: <20170203171601.13255.10335.stgit@localhost.localdomain>
References: <20170203171601.13255.10335.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5E933@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, February 03, 2017 9:20 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH] ixgbe: Limit use of 2K buffers on
> architectures with 256B or larger cache lines
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> On architectures that have a cache line size larger than 64 Bytes we start
> running into issues where the amount of headroom for the frame starts
> shrinking.
> 
> The size of skb_shared_info on a system with a 64B L1 cache line size is 320.
> This increases to 384 with a 128B cache line, and 512 with a 256B cache line.
> 
> In addition the NET_SKB_PAD value increases as well consistent with the
> cache line size.  As a result when we get to a 256B cache line as seen on the
> s390 we end up 768 bytes used by padding and shared info leaving us with
> only 1280 bytes to use for data storage.  On architectures such as this we
> should default to using 3K Rx buffers out of a 8K page instead of trying to do
> 1.5K buffers out of a 4K page.
> 
> To take all of this into account I have added one small check so that we
> compare the max_frame to the amount of actual data we can store.  This was
> already occurring for igb, but I had overlooked it for ixgbe as it doesn't have
> strict limits for 82599 once we enable jumbo frames.  By adding this check we
> will automatically enable 3K Rx buffers as soon as the maximum frame size
> we can handle drops below the standard Ethernet MTU.
> 
> I also went through and fixed one small typo that I found where I had left an
> IGB in a variable name due to a copy/paste error.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> Testing Hints:
> 	If at all possible it would be best to try testing this patch on
> 	some other architectures such as PPC64.  In lieu of that just build
> 	testing via the kernel build robot will probably have to do.  The
> 	only architecture I can identify that might actually have an issue
> 	that this fixes is s390 which last I knew there was none of in the
> 	labs at Intel for testing.
> 
> 	Basic Rx testing will suffice otherwise.
> 
> 	Also I am okay with this patch just being merged into the earlier
> 	patch "ixgbe: Add support for padding packet" if you want to go
> 	that route.  I just figured it wasn't worth the trouble to resend
> 	the entire set for a minor issue.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


