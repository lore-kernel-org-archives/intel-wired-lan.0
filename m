From: Nabil S. Alramli <dev@nalramli.com>
Date: Thu, 24 Mar 2022 20:03:38 +0000
Subject: [Intel-wired-lan] [next-queue] Add vsi.tx_restart to i40e ethtool
 stats
Message-ID: <20220324200338.121394-1-dev@nalramli.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add vsi.tx_restart to the i40e driver ethtool statistics

Signed-off-by: Nabil S. Alramli <dev@nalramli.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index e484996..a9c2ce9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -299,6 +299,7 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_cache_alloc", rx_page_alloc),
 	I40E_VSI_STAT("rx_cache_waive", rx_page_waive),
 	I40E_VSI_STAT("rx_cache_busy", rx_page_busy),
+	I40E_VSI_STAT("tx_restart", tx_restart),
 };
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
-- 
2.7.4

