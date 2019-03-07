From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 10:29:57 +0100
Subject: [Intel-wired-lan] [PATCH] igc: remove unused igc_priv_flags_strings
 array
Message-ID: <20190307093014.3293229-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

clang points out that the igc_priv_flags_strings[] array is never
referenced, aside from being used for calculating its length:

drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: error: variable 'igc_priv_flags_strings' is not needed and will not
      be emitted [-Werror,-Wunneeded-internal-declaration]
static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {

A similar array is present in several other intel ethernet drivers,
but all the others use it in their .get_strings() callback, which
igc does not implement (yet).

Probably it should be implemented, but as I have no way of testing
it, this does the simpler alternative of removing the array to
get rid of the warning.

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index eff37a6c0afa..9e352c2be644 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -6,12 +6,9 @@
 
 #include "igc.h"
 
-static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IGC_PRIV_FLAGS_LEGACY_RX	BIT(0)
-	"legacy-rx",
-};
 
-#define IGC_PRIV_FLAGS_STR_LEN ARRAY_SIZE(igc_priv_flags_strings)
+#define IGC_PRIV_FLAGS_STR_LEN		1
 
 static void igc_get_drvinfo(struct net_device *netdev,
 			    struct ethtool_drvinfo *drvinfo)
-- 
2.20.0

