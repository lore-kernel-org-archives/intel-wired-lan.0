From: Andre Guedes <andre.guedes@intel.com>
Date: Mon,  9 Mar 2020 16:10:40 -0700
Subject: [Intel-wired-lan] [PATCH] igc: Fix default MAC address filter
 override
Message-ID: <20200309231040.20873-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a bug when the user adds the first MAC address filter
via ethtool NFC mechanism.

When the first MAC address filter is added, it overwrites the default
MAC address filter configured at RAL[0] and RAH[0]. As consequence,
frames addressed to the interface MAC address are not sent to host
anymore.

This patch fixes the bug by calling igc_set_default_mac_filter() during
adapter init so the position 0 of adapter->mac_table[] is assigned to
the default MAC address.

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 025f2e439aef..3ddea16ec1da 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2350,7 +2350,9 @@ static void igc_configure(struct igc_adapter *adapter)
 	igc_setup_mrqc(adapter);
 	igc_setup_rctl(adapter);
 
+	igc_set_default_mac_filter(adapter);
 	igc_nfc_filter_restore(adapter);
+
 	igc_configure_tx(adapter);
 	igc_configure_rx(adapter);
 
-- 
2.25.0

