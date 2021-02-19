From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Date: Sat, 20 Feb 2021 00:36:48 +0800
Subject: [Intel-wired-lan] [PATCH net v1 2/2] igc: Fix Supported Pause Frame
 Link Setting
In-Reply-To: <20210219163648.14581-1-muhammad.husaini.zulkifli@intel.com>
References: <20210219163648.14581-1-muhammad.husaini.zulkifli@intel.com>
Message-ID: <20210219163648.14581-3-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The Supported Pause Frame always display "No" eventhough the Advertised
pause frame showing the correct setting based on the pause parameters via
ethtool. Set bit in link_ksettings to "Supported" for Pause Frame.

Before output:
Supported pause frame use: No

Expected output:
Supported pause frame use: Symmetric

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Reviewed-by: Malli C <mallikarjuna.chilakala@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 67a4aed45fc2..8722294ab90c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1711,6 +1711,9 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 						     Autoneg);
 	}
 
+	/* Set pause flow control settings */
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
+
 	switch (hw->fc.requested_mode) {
 	case igc_fc_full:
 		ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
-- 
2.17.1

