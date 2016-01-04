From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:10 -0800
Subject: [Intel-wired-lan] [next PATCH S26 10/12] i40e: count allocation
	errors
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-11-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Driver already counted allocation errors, so print
them as part of the ethtool -S output.  Useful for debugging
if your system is having trouble making memory available for
the driver.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I83839fa86e81e6d80f03b917c88dd3ef9a64dde0
---
Testing-Hints:
Look for rx_alloc_fail andi rx_pg_alloc_fail in the ethtool -S output.
Memory pressure or the kernel allocation failure simulator are
necessary to get the counters to increment.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 4549591..4a89cc9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -89,6 +89,8 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("rx_unknown_protocol", eth_stats.rx_unknown_protocol),
 	I40E_VSI_STAT("tx_linearize", tx_linearize),
 	I40E_VSI_STAT("tx_force_wb", tx_force_wb),
+	I40E_VSI_STAT("rx_alloc_fail", rx_buf_failed),
+	I40E_VSI_STAT("rx_pg_alloc_fail", rx_page_failed),
 };
 
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
-- 
2.1.0

