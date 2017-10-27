From: Alice Michael <alice.michael@intel.com>
Date: Fri, 27 Oct 2017 11:06:48 -0400
Subject: [Intel-wired-lan] [next PATCH S81-V3 1/9] i40e: display
	priority_xon and priority_xoff stats
Message-ID: <20171027150656.68250-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Display some more stats that were already being counted, to help users
understand when priority xon/xoff packets are being sent/received

Signed-off-by: Alice Michael <alice.michael@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index dc9b8dc..2e5ccdd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -126,6 +126,10 @@ static const struct i40e_stats i40e_gstrings_stats[] = {
 	I40E_PF_STAT("link_xoff_rx", stats.link_xoff_rx),
 	I40E_PF_STAT("link_xon_tx", stats.link_xon_tx),
 	I40E_PF_STAT("link_xoff_tx", stats.link_xoff_tx),
+	I40E_PF_STAT("priority_xon_rx", stats.priority_xon_rx),
+	I40E_PF_STAT("priority_xoff_rx", stats.priority_xoff_rx),
+	I40E_PF_STAT("priority_xon_tx", stats.priority_xon_tx),
+	I40E_PF_STAT("priority_xoff_tx", stats.priority_xoff_tx),
 	I40E_PF_STAT("rx_size_64", stats.rx_size_64),
 	I40E_PF_STAT("rx_size_127", stats.rx_size_127),
 	I40E_PF_STAT("rx_size_255", stats.rx_size_255),
-- 
2.9.5

