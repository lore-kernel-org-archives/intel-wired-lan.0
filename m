From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:15 -0700
Subject: [Intel-wired-lan] [PATCH v3 12/16] fm10k: use spinlock to implement
	mailbox lock
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <20170710202319.22110-12-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Lets not re-invent the locking wheel. Remove our bitlock and use
a proper spinlock instead.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k.h     | 15 +++++----------
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |  3 +++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k.h b/drivers/net/ethernet/intel/fm10k/fm10k.h
index ba70c58ca920..74542e9d63c7 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k.h
+++ b/drivers/net/ethernet/intel/fm10k/fm10k.h
@@ -276,7 +276,6 @@ enum fm10k_state_t {
 	__FM10K_SERVICE_SCHED,
 	__FM10K_SERVICE_REQUEST,
 	__FM10K_SERVICE_DISABLE,
-	__FM10K_MBX_LOCK,
 	__FM10K_LINK_DOWN,
 	__FM10K_UPDATING_STATS,
 	/* This value must be last and determines the BITMAP size */
@@ -346,6 +345,8 @@ struct fm10k_intfc {
 
 	struct fm10k_hw_stats stats;
 	struct fm10k_hw hw;
+	/* Mailbox lock */
+	spinlock_t mbx_lock;
 	u32 __iomem *uc_addr;
 	u32 __iomem *sw_addr;
 	u16 msg_enable;
@@ -386,23 +387,17 @@ struct fm10k_intfc {
 
 static inline void fm10k_mbx_lock(struct fm10k_intfc *interface)
 {
-	/* busy loop if we cannot obtain the lock as some calls
-	 * such as ndo_set_rx_mode may be made in atomic context
-	 */
-	while (test_and_set_bit(__FM10K_MBX_LOCK, interface->state))
-		udelay(20);
+	spin_lock(&interface->mbx_lock);
 }
 
 static inline void fm10k_mbx_unlock(struct fm10k_intfc *interface)
 {
-	/* flush memory to make sure state is correct */
-	smp_mb__before_atomic();
-	clear_bit(__FM10K_MBX_LOCK, interface->state);
+	spin_unlock(&interface->mbx_lock);
 }
 
 static inline int fm10k_mbx_trylock(struct fm10k_intfc *interface)
 {
-	return !test_and_set_bit(__FM10K_MBX_LOCK, interface->state);
+	return spin_trylock(&interface->mbx_lock);
 }
 
 /* fm10k_test_staterr - test bits in Rx descriptor status and error fields */
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 0e2bf18cc335..c6e8868f6fce 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1921,6 +1921,9 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 	netdev_rss_key_fill(rss_key, sizeof(rss_key));
 	memcpy(interface->rssrk, rss_key, sizeof(rss_key));
 
+	/* Initialize the mailbox lock */
+	spin_lock_init(&interface->mbx_lock);
+
 	/* Start off interface as being down */
 	set_bit(__FM10K_DOWN, interface->state);
 	set_bit(__FM10K_UPDATING_STATS, interface->state);
-- 
2.13.0.615.gb09ed6e59a40

