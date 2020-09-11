From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 10 Sep 2020 18:23:34 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 08/11]
 drivers/net/ethernet: handle one warning explicitly
In-Reply-To: <20200911012337.14015-1-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
Message-ID: <20200911012337.14015-9-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While fixing the W=1 builds, this warning came up because the
developers used a very tricky way to get structures initialized
to a non-zero value, but this causes GCC to warn about an
override. In this case the override was intentional, so just
disable the warning for this code with a #pragma.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 586642c33d2b..659530f9c117 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -45,6 +45,13 @@
 #define SH_ETH_OFFSET_DEFAULTS			\
 	[0 ... SH_ETH_MAX_REGISTER_OFFSET - 1] = SH_ETH_OFFSET_INVALID
 
+/* use some intentionally tricky logic here to initialize the whole struct to
+ * 0xffff, but then override certain fields, requiring us to indicate that we
+ * "know" that there are overrides in this structure, and we'll need to disable
+ * that warning from W=1 builds
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Woverride-init"
 static const u16 sh_eth_offset_gigabit[SH_ETH_MAX_REGISTER_OFFSET] = {
 	SH_ETH_OFFSET_DEFAULTS,
 
@@ -332,6 +339,7 @@ static const u16 sh_eth_offset_fast_sh3_sh2[SH_ETH_MAX_REGISTER_OFFSET] = {
 
 	[TSU_ADRH0]	= 0x0100,
 };
+#pragma GCC diagnostic pop
 
 static void sh_eth_rcv_snd_disable(struct net_device *ndev);
 static struct net_device_stats *sh_eth_get_stats(struct net_device *ndev);
-- 
2.27.0

