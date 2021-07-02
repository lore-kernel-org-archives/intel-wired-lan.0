From: Aaron Ma <aaron.ma@canonical.com>
Date: Fri,  2 Jul 2021 12:51:20 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] igc: wait for the MAC copy when
 enabled MAC passthrough
In-Reply-To: <20210702045120.22855-1-aaron.ma@canonical.com>
References: <20210702045120.22855-1-aaron.ma@canonical.com>
Message-ID: <20210702045120.22855-2-aaron.ma@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Such as dock hot plug event when runtime, for hardware implementation,
the MAC copy takes less than one second when BIOS enabled MAC passthrough.
After test on Lenovo TBT4 dock, 600ms is enough to update the
MAC address.
Otherwise ethernet fails to work.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 606b72cb6193..c8bc5f089255 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5468,6 +5468,9 @@ static int igc_probe(struct pci_dev *pdev,
 	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
 	memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
 
+	if (pci_is_thunderbolt_attached(pdev))
+		msleep(600);
+
 	/* Initialize skew-specific constants */
 	err = ei->get_invariants(hw);
 	if (err)
-- 
2.30.2

