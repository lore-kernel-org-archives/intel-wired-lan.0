From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Thu, 22 Jun 2017 11:36:51 -0400
Subject: [Intel-wired-lan] [PATCH] ethtool: Add DMA Coalescing support
Message-ID: <1498145811-7465-1-git-send-email-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add support for DMA Coalescing (DMAC) hardware feature. The feature
allows synchronization of port DMA activity across ports in order to
optimize power consumption. DMAC is supported on igb and ixgbe
devices.

Support for enabling and configuring the DMAC watchdog timer is via
the ethtool coalesce [-c|-C] dmac option added with this patch.
Since DMAC is disabled when interrupt moderation is disabled, placing
the dmac option in the coalesce command provides related -c 'show'
information with a single command. The dmac option allows the users
to disable DMAC, or enable and set the DMAC watchdog timer. When in
coalescing mode, this timer starts counting down when the first
transaction is batched. The controller moves to the not coalescing
state when the watchdog timer reaches zero.

Set usage: ethtool -C DEVNAME dmac [0 | N]

Where 0 disables DMAC, and N is watchdog timer interval in usecs.
The device driver will check that N is within a valid range.

Example:
Enable and configure DMAC watchdog timer to 1000 usecs:
 # ethtool -C dmac 1000

Disable DMAC:
 # ethtool -C dmac 0

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 ethtool-copy.h | 2 ++
 ethtool.8.in   | 1 +
 ethtool.c      | 8 +++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ethtool-copy.h b/ethtool-copy.h
index 06fc04c..4bb91eb 100644
--- a/ethtool-copy.h
+++ b/ethtool-copy.h
@@ -400,6 +400,7 @@ struct ethtool_modinfo {
  *	a TX interrupt, when the packet rate is above @pkt_rate_high.
  * @rate_sample_interval: How often to do adaptive coalescing packet rate
  *	sampling, measured in seconds.  Must not be zero.
+ * @dmac: How many usecs to store packets before moving to host memory.
  *
  * Each pair of (usecs, max_frames) fields specifies that interrupts
  * should be coalesced until
@@ -450,6 +451,7 @@ struct ethtool_coalesce {
 	__u32	tx_coalesce_usecs_high;
 	__u32	tx_max_coalesced_frames_high;
 	__u32	rate_sample_interval;
+	__u32	dmac;
 };
 
 /**
diff --git a/ethtool.8.in b/ethtool.8.in
index 5bb3ae2..ed9ba7b 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -165,6 +165,7 @@ ethtool \- query or control network driver and hardware settings
 .BN tx\-usecs\-high
 .BN tx\-frames\-high
 .BN sample\-interval
+.BN dmac
 .HP
 .B ethtool \-g|\-\-show\-ring
 .I devname
diff --git a/ethtool.c b/ethtool.c
index 94b75a7..b62fa4e 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -1337,6 +1337,7 @@ static int dump_coalesce(const struct ethtool_coalesce *ecoal)
 		"sample-interval: %u\n"
 		"pkt-rate-low: %u\n"
 		"pkt-rate-high: %u\n"
+		"dmac: %u\n"
 		"\n"
 		"rx-usecs: %u\n"
 		"rx-frames: %u\n"
@@ -1362,6 +1363,7 @@ static int dump_coalesce(const struct ethtool_coalesce *ecoal)
 		ecoal->rate_sample_interval,
 		ecoal->pkt_rate_low,
 		ecoal->pkt_rate_high,
+		ecoal->dmac,
 
 		ecoal->rx_coalesce_usecs,
 		ecoal->rx_max_coalesced_frames,
@@ -2068,6 +2070,7 @@ static int do_scoalesce(struct cmd_context *ctx)
 	int coal_adaptive_rx_wanted = -1;
 	int coal_adaptive_tx_wanted = -1;
 	s32 coal_sample_rate_wanted = -1;
+	s32 coal_dmac_wanted = -1;
 	s32 coal_pkt_rate_low_wanted = -1;
 	s32 coal_pkt_rate_high_wanted = -1;
 	s32 coal_rx_usec_wanted = -1;
@@ -2093,6 +2096,8 @@ static int do_scoalesce(struct cmd_context *ctx)
 		  &ecoal.use_adaptive_tx_coalesce },
 		{ "sample-interval", CMDL_S32, &coal_sample_rate_wanted,
 		  &ecoal.rate_sample_interval },
+		{ "dmac", CMDL_S32, &coal_dmac_wanted,
+		  &ecoal.dmac },
 		{ "stats-block-usecs", CMDL_S32, &coal_stats_wanted,
 		  &ecoal.stats_block_coalesce_usecs },
 		{ "pkt-rate-low", CMDL_S32, &coal_pkt_rate_low_wanted,
@@ -4815,7 +4820,8 @@ static const struct option {
 	  "		[rx-frames-high N]\n"
 	  "		[tx-usecs-high N]\n"
 	  "		[tx-frames-high N]\n"
-	  "		[sample-interval N]\n" },
+	  "		[sample-interval N]\n"
+	  "		[dmac N]\n" },
 	{ "-g|--show-ring", 1, do_gring, "Query RX/TX ring parameters" },
 	{ "-G|--set-ring", 1, do_sring, "Set RX/TX ring parameters",
 	  "		[ rx N ]\n"
-- 
2.7.4

