From: Andre Guedes <andre.guedes@intel.com>
Date: Fri,  3 Apr 2020 11:17:42 -0700
Subject: [Intel-wired-lan] [PATCH 3/4] igc: Return -EOPNOTSUPP when VLAN
 mask doesn't match
In-Reply-To: <20200403181743.23447-1-andre.guedes@intel.com>
References: <20200403181743.23447-1-andre.guedes@intel.com>
Message-ID: <20200403181743.23447-4-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The I225 controller supports rx queue assignment based on VLAN priority
only. Other Tag Control Information (TCI) are valid, but not supported
by the driver. So this patch changes the returning code from igc_add_
ethtool_nfc_entry() to -EOPNOTSUPP in order to provide more meaningful
information on why the function failed.

It also adds a debug messages to give the user a hint about what went
wrong with the NFC setup.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index dfc21908347d..036a2244b76c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1446,7 +1446,8 @@ static int igc_add_ethtool_nfc_entry(struct igc_adapter *adapter,
 
 	if ((fsp->flow_type & FLOW_EXT) && fsp->m_ext.vlan_tci) {
 		if (fsp->m_ext.vlan_tci != htons(VLAN_PRIO_MASK)) {
-			err = -EINVAL;
+			netdev_dbg(netdev, "VLAN mask not supported");
+			err = -EOPNOTSUPP;
 			goto err_out;
 		}
 		input->filter.vlan_tci = fsp->h_ext.vlan_tci;
-- 
2.26.0

