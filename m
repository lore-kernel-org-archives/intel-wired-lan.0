From: Nicholas Nunley <nicholas.d.nunley@intel.com>
Date: Mon,  4 Feb 2019 13:12:04 -0800
Subject: [Intel-wired-lan] [PATCH v2 2/6] ethtool: move cmdline_coalesce out
 of do_scoalesce
In-Reply-To: <20190204211208.57516-1-nicholas.d.nunley@intel.com>
References: <20190204211208.57516-1-nicholas.d.nunley@intel.com>
Message-ID: <20190204211208.57516-2-nicholas.d.nunley@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Move the definition of cmdline_coalesce out of do_scoalesce and into a
macro so it can be resused across functions.

No behavior change.

Based on patch by Kan Liang <kan.liang@intel.com>

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
---
 ethtool.c | 142 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 74 insertions(+), 68 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 8b7c224..af266c5 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -2098,78 +2098,84 @@ static int do_gcoalesce(struct cmd_context *ctx)
 	return 0;
 }
 
+#define DECLARE_COALESCE_OPTION_VARS()		\
+	s32 coal_stats_wanted = -1;		\
+	int coal_adaptive_rx_wanted = -1;	\
+	int coal_adaptive_tx_wanted = -1;	\
+	s32 coal_sample_rate_wanted = -1;	\
+	s32 coal_pkt_rate_low_wanted = -1;	\
+	s32 coal_pkt_rate_high_wanted = -1;	\
+	s32 coal_rx_usec_wanted = -1;		\
+	s32 coal_rx_frames_wanted = -1;		\
+	s32 coal_rx_usec_irq_wanted = -1;	\
+	s32 coal_rx_frames_irq_wanted = -1;	\
+	s32 coal_tx_usec_wanted = -1;		\
+	s32 coal_tx_frames_wanted = -1;		\
+	s32 coal_tx_usec_irq_wanted = -1;	\
+	s32 coal_tx_frames_irq_wanted = -1;	\
+	s32 coal_rx_usec_low_wanted = -1;	\
+	s32 coal_rx_frames_low_wanted = -1;	\
+	s32 coal_tx_usec_low_wanted = -1;	\
+	s32 coal_tx_frames_low_wanted = -1;	\
+	s32 coal_rx_usec_high_wanted = -1;	\
+	s32 coal_rx_frames_high_wanted = -1;	\
+	s32 coal_tx_usec_high_wanted = -1;	\
+	s32 coal_tx_frames_high_wanted = -1
+
+#define COALESCE_CMDLINE_INFO(__ecoal)					\
+{									\
+	{ "adaptive-rx", CMDL_BOOL, &coal_adaptive_rx_wanted,		\
+	  &__ecoal.use_adaptive_rx_coalesce },				\
+	{ "adaptive-tx", CMDL_BOOL, &coal_adaptive_tx_wanted,		\
+	  &__ecoal.use_adaptive_tx_coalesce },				\
+	{ "sample-interval", CMDL_S32, &coal_sample_rate_wanted,	\
+	  &__ecoal.rate_sample_interval },				\
+	{ "stats-block-usecs", CMDL_S32, &coal_stats_wanted,		\
+	  &__ecoal.stats_block_coalesce_usecs },			\
+	{ "pkt-rate-low", CMDL_S32, &coal_pkt_rate_low_wanted,		\
+	  &__ecoal.pkt_rate_low },					\
+	{ "pkt-rate-high", CMDL_S32, &coal_pkt_rate_high_wanted,	\
+	  &__ecoal.pkt_rate_high },					\
+	{ "rx-usecs", CMDL_S32, &coal_rx_usec_wanted,			\
+	  &__ecoal.rx_coalesce_usecs },					\
+	{ "rx-frames", CMDL_S32, &coal_rx_frames_wanted,		\
+	  &__ecoal.rx_max_coalesced_frames },				\
+	{ "rx-usecs-irq", CMDL_S32, &coal_rx_usec_irq_wanted,		\
+	  &__ecoal.rx_coalesce_usecs_irq },				\
+	{ "rx-frames-irq", CMDL_S32, &coal_rx_frames_irq_wanted,	\
+	  &__ecoal.rx_max_coalesced_frames_irq },			\
+	{ "tx-usecs", CMDL_S32, &coal_tx_usec_wanted,			\
+	  &__ecoal.tx_coalesce_usecs },					\
+	{ "tx-frames", CMDL_S32, &coal_tx_frames_wanted,		\
+	  &__ecoal.tx_max_coalesced_frames },				\
+	{ "tx-usecs-irq", CMDL_S32, &coal_tx_usec_irq_wanted,		\
+	  &__ecoal.tx_coalesce_usecs_irq },				\
+	{ "tx-frames-irq", CMDL_S32, &coal_tx_frames_irq_wanted,	\
+	  &__ecoal.tx_max_coalesced_frames_irq },			\
+	{ "rx-usecs-low", CMDL_S32, &coal_rx_usec_low_wanted,		\
+	  &__ecoal.rx_coalesce_usecs_low },				\
+	{ "rx-frames-low", CMDL_S32, &coal_rx_frames_low_wanted,	\
+	  &__ecoal.rx_max_coalesced_frames_low },			\
+	{ "tx-usecs-low", CMDL_S32, &coal_tx_usec_low_wanted,		\
+	  &__ecoal.tx_coalesce_usecs_low },				\
+	{ "tx-frames-low", CMDL_S32, &coal_tx_frames_low_wanted,	\
+	  &__ecoal.tx_max_coalesced_frames_low },			\
+	{ "rx-usecs-high", CMDL_S32, &coal_rx_usec_high_wanted,		\
+	  &__ecoal.rx_coalesce_usecs_high },				\
+	{ "rx-frames-high", CMDL_S32, &coal_rx_frames_high_wanted,	\
+	  &__ecoal.rx_max_coalesced_frames_high },			\
+	{ "tx-usecs-high", CMDL_S32, &coal_tx_usec_high_wanted,		\
+	  &__ecoal.tx_coalesce_usecs_high },				\
+	{ "tx-frames-high", CMDL_S32, &coal_tx_frames_high_wanted,	\
+	  &__ecoal.tx_max_coalesced_frames_high },			\
+}
+
 static int do_scoalesce(struct cmd_context *ctx)
 {
 	struct ethtool_coalesce ecoal;
 	int gcoalesce_changed = 0;
-	s32 coal_stats_wanted = -1;
-	int coal_adaptive_rx_wanted = -1;
-	int coal_adaptive_tx_wanted = -1;
-	s32 coal_sample_rate_wanted = -1;
-	s32 coal_pkt_rate_low_wanted = -1;
-	s32 coal_pkt_rate_high_wanted = -1;
-	s32 coal_rx_usec_wanted = -1;
-	s32 coal_rx_frames_wanted = -1;
-	s32 coal_rx_usec_irq_wanted = -1;
-	s32 coal_rx_frames_irq_wanted = -1;
-	s32 coal_tx_usec_wanted = -1;
-	s32 coal_tx_frames_wanted = -1;
-	s32 coal_tx_usec_irq_wanted = -1;
-	s32 coal_tx_frames_irq_wanted = -1;
-	s32 coal_rx_usec_low_wanted = -1;
-	s32 coal_rx_frames_low_wanted = -1;
-	s32 coal_tx_usec_low_wanted = -1;
-	s32 coal_tx_frames_low_wanted = -1;
-	s32 coal_rx_usec_high_wanted = -1;
-	s32 coal_rx_frames_high_wanted = -1;
-	s32 coal_tx_usec_high_wanted = -1;
-	s32 coal_tx_frames_high_wanted = -1;
-	struct cmdline_info cmdline_coalesce[] = {
-		{ "adaptive-rx", CMDL_BOOL, &coal_adaptive_rx_wanted,
-		  &ecoal.use_adaptive_rx_coalesce },
-		{ "adaptive-tx", CMDL_BOOL, &coal_adaptive_tx_wanted,
-		  &ecoal.use_adaptive_tx_coalesce },
-		{ "sample-interval", CMDL_S32, &coal_sample_rate_wanted,
-		  &ecoal.rate_sample_interval },
-		{ "stats-block-usecs", CMDL_S32, &coal_stats_wanted,
-		  &ecoal.stats_block_coalesce_usecs },
-		{ "pkt-rate-low", CMDL_S32, &coal_pkt_rate_low_wanted,
-		  &ecoal.pkt_rate_low },
-		{ "pkt-rate-high", CMDL_S32, &coal_pkt_rate_high_wanted,
-		  &ecoal.pkt_rate_high },
-		{ "rx-usecs", CMDL_S32, &coal_rx_usec_wanted,
-		  &ecoal.rx_coalesce_usecs },
-		{ "rx-frames", CMDL_S32, &coal_rx_frames_wanted,
-		  &ecoal.rx_max_coalesced_frames },
-		{ "rx-usecs-irq", CMDL_S32, &coal_rx_usec_irq_wanted,
-		  &ecoal.rx_coalesce_usecs_irq },
-		{ "rx-frames-irq", CMDL_S32, &coal_rx_frames_irq_wanted,
-		  &ecoal.rx_max_coalesced_frames_irq },
-		{ "tx-usecs", CMDL_S32, &coal_tx_usec_wanted,
-		  &ecoal.tx_coalesce_usecs },
-		{ "tx-frames", CMDL_S32, &coal_tx_frames_wanted,
-		  &ecoal.tx_max_coalesced_frames },
-		{ "tx-usecs-irq", CMDL_S32, &coal_tx_usec_irq_wanted,
-		  &ecoal.tx_coalesce_usecs_irq },
-		{ "tx-frames-irq", CMDL_S32, &coal_tx_frames_irq_wanted,
-		  &ecoal.tx_max_coalesced_frames_irq },
-		{ "rx-usecs-low", CMDL_S32, &coal_rx_usec_low_wanted,
-		  &ecoal.rx_coalesce_usecs_low },
-		{ "rx-frames-low", CMDL_S32, &coal_rx_frames_low_wanted,
-		  &ecoal.rx_max_coalesced_frames_low },
-		{ "tx-usecs-low", CMDL_S32, &coal_tx_usec_low_wanted,
-		  &ecoal.tx_coalesce_usecs_low },
-		{ "tx-frames-low", CMDL_S32, &coal_tx_frames_low_wanted,
-		  &ecoal.tx_max_coalesced_frames_low },
-		{ "rx-usecs-high", CMDL_S32, &coal_rx_usec_high_wanted,
-		  &ecoal.rx_coalesce_usecs_high },
-		{ "rx-frames-high", CMDL_S32, &coal_rx_frames_high_wanted,
-		  &ecoal.rx_max_coalesced_frames_high },
-		{ "tx-usecs-high", CMDL_S32, &coal_tx_usec_high_wanted,
-		  &ecoal.tx_coalesce_usecs_high },
-		{ "tx-frames-high", CMDL_S32, &coal_tx_frames_high_wanted,
-		  &ecoal.tx_max_coalesced_frames_high },
-	};
+	DECLARE_COALESCE_OPTION_VARS();
+	struct cmdline_info cmdline_coalesce[] = COALESCE_CMDLINE_INFO(ecoal);
 	int err, changed = 0;
 
 	parse_generic_cmdline(ctx, &gcoalesce_changed,
-- 
2.14.4

