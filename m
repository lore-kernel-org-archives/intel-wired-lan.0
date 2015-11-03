From: Avargil, Raanan <raanan.avargil@intel.com>
Date: Tue, 3 Nov 2015 15:25:46 +0000
Subject: [Intel-wired-lan] [RFC] e1000e: Add delays after writing
	to	registers
In-Reply-To: <1445973917-22624-1-git-send-email-jonathan.david@ni.com>
References: <1445973917-22624-1-git-send-email-jonathan.david@ni.com>
Message-ID: <8F4C390AFA9F4444A4AA77F4A3BEC78A059E0649@HASMSX110.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

From the coding perspective and implementation aspects the patch looks okay. 
But the solution that is addressed here, raises few questions.
The author tries to solve a memory writes issue ("This problem stems from an issue with the PCI bus where a fabric lock is held during I/O buffer drain"). 
The e1000e driver is not the place to solve it. A more suitable place might be the platform level in the "arch" directory.
It seems that the problem is targeted to RT system ("This process can be detrimental to real-time systems...") and thus should be fixed with RT kernel compilation only.
Someone can enable the suggested configuration on a non RT systems, in such a case  the results can have side effects. 
The problem is not unique to e1000e driver. How would the author solve the problem on other (even non-Intel) drivers? It makes no sense to add a delay to each and every driver.
Also, putting a generic delays like this might solve the problem for existing system, but might have issues as new systems come out with different chipsets.
And the most important question is: how much is "large number of writes"? How many writes generates a problem and how many writes are considered as okay?

For all the above reasons we NACK the patch and look forward for the author to supply a more comprehensive solution that will address the issue for all drivers.

Thanks,
Raanan

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jonathan David
Sent: Tuesday, October 27, 2015 21:25
To: intel-wired-lan@lists.osuosl.org
Cc: josh.cartwright at ni.com; jonathan.david at ni.com; bhelgaas at google.com; tglx at linutronix.de
Subject: [Intel-wired-lan] [RFC] e1000e: Add delays after writing to registers
Importance: High

There is a noticeable impact on determinism when a large number of writes are flushed. Writes to the hardware registers are sent across the PCI bus and take a significant amount of time to complete after a flush, which causes high priority tasks (including interrupts) to be delayed. This problem stems from an issue with the PCI bus where a fabric lock is held during I/O buffer drain. This process can be detrimental to real-time systems and is seen whenever a large number of MMIO writes are issued. In the case of the e1000 drivers, when a device is reset several tables (MTA, VLAN, etc) are rewritten, generating enough MMIO writes over PCI for the latency issues to be seen.

Adding a delay after long series of writes gives them time to complete (drain the I/O buffer), and for higher priority tasks to run unimpeded.

Signed-off-by: Jonathan David <jonathan.david@ni.com>
---
 drivers/net/ethernet/intel/Kconfig            |  9 +++++++++
 drivers/net/ethernet/intel/e1000/e1000.h      |  3 +++
 drivers/net/ethernet/intel/e1000/e1000_main.c |  5 +++++
 drivers/net/ethernet/intel/e1000e/82571.c     |  3 +++
 drivers/net/ethernet/intel/e1000e/e1000.h     |  4 ++++
 drivers/net/ethernet/intel/e1000e/mac.c       |  3 +++
 drivers/net/ethernet/intel/e1000e/netdev.c    | 18 +++++++++++++++++-
 7 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index f4ff465..4c1fba2 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -85,6 +85,15 @@ config E1000E
 	  To compile this driver as a module, choose M here. The module
 	  will be called e1000e.
 
+config E1000_DELAY
+	bool "Add delays to e1000x drivers"
+	default n
+	depends on (E1000E || E1000)
+	---help---
+	  Enable delays after large numbers of MMIO writes to registers.
+	  The delays aid in preventing noticeable impact on real-time
+	  performance when a connection is interrupted.
+
 config IGB
 	tristate "Intel(R) 82575/82576 PCI-Express Gigabit Ethernet support"
 	depends on PCI
diff --git a/drivers/net/ethernet/intel/e1000/e1000.h b/drivers/net/ethernet/intel/e1000/e1000.h
index 6970710..ea405f3 100644
--- a/drivers/net/ethernet/intel/e1000/e1000.h
+++ b/drivers/net/ethernet/intel/e1000/e1000.h
@@ -223,6 +223,9 @@ struct e1000_rx_ring {
 #define E1000_TX_DESC(R, i)		E1000_GET_DESC(R, i, e1000_tx_desc)
 #define E1000_CONTEXT_DESC(R, i)	E1000_GET_DESC(R, i, e1000_context_desc)
 
+/* Time to wait after writing large amount of data to registers */
+#define E1000_WR_DELAY_RNG(val)         usleep_range(val*2, val*4)
+
 /* board specific private data structure */
 
 struct e1000_adapter {
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 983eb4e..eb57148 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -2331,6 +2331,11 @@ static void e1000_set_rx_mode(struct net_device *netdev)
 		 */
 		E1000_WRITE_REG_ARRAY(hw, MTA, i, mcarray[i]);
 	}
+
+#ifdef CONFIG_E1000_DELAY
+	E1000_WR_DELAY_RNG(mta_reg_count);
+#endif
+
 	E1000_WRITE_FLUSH();
 
 	if (hw->mac_type == e1000_82542_rev2_0) diff --git a/drivers/net/ethernet/intel/e1000e/82571.c b/drivers/net/ethernet/intel/e1000e/82571.c
index 32e7775..3e381fe 100644
--- a/drivers/net/ethernet/intel/e1000e/82571.c
+++ b/drivers/net/ethernet/intel/e1000e/82571.c
@@ -998,6 +998,9 @@ static s32 e1000_reset_hw_82571(struct e1000_hw *hw)
 
 	e_dbg("Issuing a global reset to MAC\n");
 	ew32(CTRL, ctrl | E1000_CTRL_RST);
+#ifdef CONFIG_E1000_DELAY
+	E1000_WR_DELAY();
+#endif
 
 	/* Must release MDIO ownership and mutex after MAC reset. */
 	switch (hw->mac.type) {
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 0abc942..48db3df 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -89,6 +89,10 @@ struct e1000_info;
 /* Time to wait before putting the device into D3 if there's no link (in ms). */
 #define LINK_TIMEOUT		100
 
+/* Time to wait after writing large amount of data to registers */
+#define E1000_WR_DELAY()		usleep_range(100, 150)
+#define E1000_WR_DELAY_RNG(val)		usleep_range(val*2, val*4)
+
 /* Count for polling __E1000_RESET condition every 10-20msec.
  * Experimentation has shown the reset can take approximately 210msec.
  */
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 30b74d5..d5ec122 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -353,6 +353,9 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
 	/* replace the entire MTA table */
 	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
 		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
+#ifdef CONFIG_E1000_DELAY
+	E1000_WR_DELAY_RNG(hw->mac.mta_reg_count);
+#endif
 	e1e_flush();
 }
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 68913d1..18112ef 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -3360,6 +3360,9 @@ static int e1000e_write_uc_addr_list(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned int rar_entries;
 	int count = 0;
+#ifdef CONFIG_E1000_DELAY
+	unsigned int rar_count;
+#endif
 
 	rar_entries = hw->mac.ops.rar_get_count(hw);
 
@@ -3391,12 +3394,22 @@ static int e1000e_write_uc_addr_list(struct net_device *netdev)
 			count++;
 		}
 	}
-
+	
+	/* preserve number of remaining RAR entries for delay
+	 * function in order to prevent latency issues caused by
+	 * MMIO writes */
+#ifdef CONFIG_E1000_DELAY
+	rar_count = rar_entries;
+#endif
+	
 	/* zero out the remaining RAR entries not used above */
 	for (; rar_entries > 0; rar_entries--) {
 		ew32(RAH(rar_entries), 0);
 		ew32(RAL(rar_entries), 0);
 	}
+#ifdef CONFIG_E1000_DELAY
+	E1000_WR_DELAY_RNG(rar_count);
+#endif
 	e1e_flush();
 
 	return count;
@@ -3476,6 +3489,9 @@ static void e1000e_setup_rss_hash(struct e1000_adapter *adapter)
 	/* Direct all traffic to queue 0 */
 	for (i = 0; i < 32; i++)
 		ew32(RETA(i), 0);
+#ifdef CONFIG_E1000_DELAY
+	E1000_WR_DELAY();
+#endif
 
 	/* Disable raw packet checksumming so that RSS hash is placed in
 	 * descriptor on writeback.
--
1.9.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

