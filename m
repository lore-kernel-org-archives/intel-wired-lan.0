From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 03 Feb 2017 09:19:40 -0800
Subject: [Intel-wired-lan] [next PATCH] ixgbe: Limit use of 2K buffers on
 architectures with 256B or larger cache lines
Message-ID: <20170203171601.13255.10335.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

On architectures that have a cache line size larger than 64 Bytes we start
running into issues where the amount of headroom for the frame starts
shrinking.

The size of skb_shared_info on a system with a 64B L1 cache line size is
320.  This increases to 384 with a 128B cache line, and 512 with a 256B
cache line.

In addition the NET_SKB_PAD value increases as well consistent with the
cache line size.  As a result when we get to a 256B cache line as seen on
the s390 we end up 768 bytes used by padding and shared info leaving us
with only 1280 bytes to use for data storage.  On architectures such as
this we should default to using 3K Rx buffers out of a 8K page instead of
trying to do 1.5K buffers out of a 4K page.

To take all of this into account I have added one small check so that we
compare the max_frame to the amount of actual data we can store.  This was
already occurring for igb, but I had overlooked it for ixgbe as it doesn't
have strict limits for 82599 once we enable jumbo frames.  By adding this
check we will automatically enable 3K Rx buffers as soon as the maximum
frame size we can handle drops below the standard Ethernet MTU.

I also went through and fixed one small typo that I found where I had left
an IGB in a variable name due to a copy/paste error.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---

Testing Hints:
	If at all possible it would be best to try testing this patch on
	some other architectures such as PPC64.  In lieu of that just build
	testing via the kernel build robot will probably have to do.  The
	only architecture I can identify that might actually have an issue
	that this fixes is s390 which last I knew there was none of in the
	labs at Intel for testing.

	Basic Rx testing will suffice otherwise.

	Also I am okay with this patch just being merged into the earlier
	patch "ixgbe: Add support for padding packet" if you want to go
	that route.  I just figured it wasn't worth the trouble to resend
	the entire set for a minor issue.

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 3537d07b4807..77bf71db85af 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -99,7 +99,7 @@
 #define IXGBE_MAX_FRAME_BUILD_SKB \
 	(SKB_WITH_OVERHEAD(IXGBE_RXBUFFER_2K) - IXGBE_SKB_PAD)
 #else
-#define IGB_MAX_FRAME_BUILD_SKB IXGBE_RXBUFFER_2K
+#define IXGBE_MAX_FRAME_BUILD_SKB IXGBE_RXBUFFER_2K
 #endif
 
 /*
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 787cee9c59d3..bfcdc2fdeae4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4009,7 +4009,8 @@ static void ixgbe_set_rx_buffer_len(struct ixgbe_adapter *adapter)
 		if (adapter->flags2 & IXGBE_FLAG2_RSC_ENABLED)
 			set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
 
-		if (max_frame > (ETH_FRAME_LEN + ETH_FCS_LEN))
+		if ((max_frame > (ETH_FRAME_LEN + ETH_FCS_LEN)) ||
+		    (max_frame > IXGBE_MAX_FRAME_BUILD_SKB))
 			set_bit(__IXGBE_RX_3K_BUFFER, &rx_ring->state);
 #endif
 	}

