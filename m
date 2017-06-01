From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  1 Jun 2017 12:06:05 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve cppcheck format string
	warning
Message-ID: <20170601190605.32148-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

cppcheck warns that the format string is incorrect in the function
ixgbe_get_strings().  Since the value cannot be negative, change the
variable to unsigned which matches the format specifier.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2890e92..72c5657 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1277,7 +1277,7 @@ static void ixgbe_get_strings(struct net_device *netdev, u32 stringset,
 			      u8 *data)
 {
 	char *p = (char *)data;
-	int i;
+	unsigned int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-- 
2.9.3

