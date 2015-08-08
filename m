From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Sat, 08 Aug 2015 16:18:48 -0700
Subject: [Intel-wired-lan] [PATCH V5 13/19] ixgbe: Limit SFP polling rate
In-Reply-To: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
References: <20150808231450.94784.49531.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150808231848.94784.92209.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the frequency of polling for SFP modules. Because the
service task sometimes runs at high rates, we can poll for
SFPs too often. When an SFP is not present, the I2C timeouts
that result are very costly. So, prevent SFP polling from
being done more than once every two seconds. To reduce latency,
the poll time is cleared in a couple of cases to permit the
next service task execution to poll the SFP module.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 17250ef87883..8eafe467e558 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -603,6 +603,7 @@ struct ixgbe_mac_addr {
 
 /* default to trying for four seconds */
 #define IXGBE_TRY_LINK_TIMEOUT (4 * HZ)
+#define IXGBE_SFP_POLL_JIFFIES (2 * HZ)		/* SFP poll every 2 seconds */
 
 /* board specific private data structure */
 struct ixgbe_adapter {
@@ -716,6 +717,7 @@ struct ixgbe_adapter {
 
 	u32 link_speed;
 	bool link_up;
+	unsigned long sfp_poll_time;
 	unsigned long link_check_timeout;
 
 	struct timer_list service_timer;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index d289449a9b83..af5e49a4e95c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2509,6 +2509,7 @@ static void ixgbe_check_sfp_event(struct ixgbe_adapter *adapter, u32 eicr)
 		IXGBE_WRITE_REG(hw, IXGBE_EICR, eicr_mask);
 		if (!test_bit(__IXGBE_DOWN, &adapter->state)) {
 			adapter->flags2 |= IXGBE_FLAG2_SFP_NEEDS_RESET;
+			adapter->sfp_poll_time = 0;
 			ixgbe_service_event_schedule(adapter);
 		}
 	}
@@ -4804,6 +4805,7 @@ static void ixgbe_sfp_link_config(struct ixgbe_adapter *adapter)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
 
 	adapter->flags2 |= IXGBE_FLAG2_SFP_NEEDS_RESET;
+	adapter->sfp_poll_time = 0;
 }
 
 /**
@@ -6709,10 +6711,16 @@ static void ixgbe_sfp_detection_subtask(struct ixgbe_adapter *adapter)
 	    !(adapter->flags2 & IXGBE_FLAG2_SFP_NEEDS_RESET))
 		return;
 
+	if (adapter->sfp_poll_time &&
+	    time_after(adapter->sfp_poll_time, jiffies))
+		return; /* If not yet time to poll for SFP */
+
 	/* someone else is in init, wait until next service event */
 	if (test_and_set_bit(__IXGBE_IN_SFP_INIT, &adapter->state))
 		return;
 
+	adapter->sfp_poll_time = jiffies + IXGBE_SFP_POLL_JIFFIES - 1;
+
 	err = hw->phy.ops.identify_sfp(hw);
 	if (err == IXGBE_ERR_SFP_NOT_SUPPORTED)
 		goto sfp_out;

