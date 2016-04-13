From: Brian Walsh <brian@walsh.ws>
Date: Tue, 12 Apr 2016 23:22:31 -0400
Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time reset on
	network interruption
In-Reply-To: <a17942d94a295a0db7ef205060b97313289b1640.1460517387.git.brian@walsh.ws>
References: <a17942d94a295a0db7ef205060b97313289b1640.1460517387.git.brian@walsh.ws>
Message-ID: <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Time is resetting on any interruption of network connectivity. This
causes the clock to jump around by the leapsecond offset. It should
only reset when the device is initialized.

Signed-off-by: Brian Walsh <brian@walsh.ws>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 370b0dc..98f645e 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3580,7 +3580,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	bool is_l4 = false;
 	bool is_l2 = false;
 	u32 regval;
-	s32 ret_val;
 
 	if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP))
 		return -EINVAL;
@@ -3719,16 +3718,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
 	er32(RXSTMPH);
 	er32(TXSTMPH);
 
-	/* Get and set the System Time Register SYSTIM base frequency */
-	ret_val = e1000e_get_base_timinca(adapter, &regval);
-	if (ret_val)
-		return ret_val;
-	ew32(TIMINCA, regval);
-
-	/* reset the ns time counter */
-	timecounter_init(&adapter->tc, &adapter->cc,
-			 ktime_to_ns(ktime_get_real()));
-
 	return 0;
 }
 
@@ -6966,6 +6955,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u16 eeprom_data = 0;
 	u16 eeprom_apme_mask = E1000_EEPROM_APME;
 	s32 ret_val = 0;
+	u32 regval;
 
 	if (ei->flags2 & FLAG2_DISABLE_ASPM_L0S)
 		aspm_disable_flag = PCIE_LINK_STATE_L0S;
@@ -7256,6 +7246,16 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* carrier off reporting is important to ethtool even BEFORE open */
 	netif_carrier_off(netdev);
 
+	/* Get and set the System Time Register SYSTIM base frequency */
+	ret_val = e1000e_get_base_timinca(adapter, &regval);
+	if (ret_val)
+		goto err_register;
+	ew32(TIMINCA, regval);
+
+	/* reset the ns time counter */
+	timecounter_init(&adapter->tc, &adapter->cc,
+			 ktime_to_ns(ktime_get_real()));
+
 	/* init PTP hardware clock */
 	e1000e_ptp_init(adapter);
 
-- 
2.1.4

