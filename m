From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:25 -0700
Subject: [Intel-wired-lan] [PATCH net-next 05/15] iavf: untangle any pending
 iavf_open() operations from iavf_close()
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

When the iavf interface is opened some of the steps necessary to
configure the hardware require communication with the PF driver. Since
these operations involve waiting for a response from the PF driver they can
be time-consuming, so the iavf driver schedules them for later and
proceeds with the remaining configuration. If the interface is closed
immediately after it is opened then some of these operations may still be
pending, although the iavf_close() routine assumes they have all
completed. In rare cases this can lead to iavf_open() configuration
operations completing after iavf_close(), which can mean the device
interrupts and/or DMA engine are active on a disabled interface.

To fix this:
1. In iavf_close() any pending unsent operations from iavf_open() are
canceled.
2. If the operation was already sent by the time iavf_close() is called,
but the driver is still awaiting the response back from the PF driver, then
ignore the response if it is received when the interface is down instead of
handling it in the usual manner.
3. Place a lock around the handling of all PF driver responses to ensure
that these can't conflict with concurrent processing of iavf_open() and
iavf_close(), or the other configuration tasks. In essence change (2)
above protects against unexpected responses received after iavf_close(),
and this change protects against responses received during iavf_close().

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 10 ++++++++++
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 91818ba7c8a3..eda8ebb8e7b8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1025,6 +1025,12 @@ void iavf_down(struct iavf_adapter *adapter)
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
 		adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
+		/* In case the queue configure or enable operations are still
+		 * pending from when the interface was opened, make sure
+		 * they're canceled here.
+		 */
+		adapter->aq_required &= ~IAVF_FLAG_AQ_ENABLE_QUEUES;
+		adapter->aq_required &= ~IAVF_FLAG_AQ_CONFIGURE_QUEUES;
 	}
 
 	mod_delayed_work(iavf_wq, &adapter->watchdog_task, 0);
@@ -2325,8 +2331,12 @@ static void iavf_adminq_task(struct work_struct *work)
 		if (ret || !v_op)
 			break; /* No event to process or error cleaning ARQ */
 
+		while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
+					&adapter->crit_section))
+			usleep_range(500, 1000);
 		iavf_virtchnl_completion(adapter, v_op, v_ret, event.msg_buf,
 					 event.msg_len);
+		clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 		if (pending != 0)
 			memset(event.msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);
 	} while (pending);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 0eab3c43bdc5..69e479eb5534 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1685,7 +1685,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
-		iavf_irq_enable(adapter, true);
+		if (adapter->state == __IAVF_RUNNING)
+			iavf_irq_enable(adapter, true);
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
-- 
2.20.1

