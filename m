From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  6 Sep 2016 12:39:58 -0700
Subject: [Intel-wired-lan] [next PATCH S45 01/10] i40evf: remove unnecessary
	error checking against i40evf_up_complete
In-Reply-To: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
References: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1473190807-26377-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Function i40evf_up_complete() always returns success. Changed this to a
void type and removed the code that checks the return status and prints
an error message.

Signed-off-by: Bimmy Pujari <bimmy.pujari@intel.com>
Change-ID: I8c400f174786b9c855f679e470f35af292fb50ad
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index f751f7b..2074a8f 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1007,7 +1007,7 @@ static void i40evf_configure(struct i40evf_adapter *adapter)
  * i40evf_up_complete - Finish the last steps of bringing up a connection
  * @adapter: board private structure
  **/
-static int i40evf_up_complete(struct i40evf_adapter *adapter)
+static void i40evf_up_complete(struct i40evf_adapter *adapter)
 {
 	adapter->state = __I40EVF_RUNNING;
 	clear_bit(__I40E_DOWN, &adapter->vsi.state);
@@ -1016,7 +1016,6 @@ static int i40evf_up_complete(struct i40evf_adapter *adapter)
 
 	adapter->aq_required |= I40EVF_FLAG_AQ_ENABLE_QUEUES;
 	mod_timer_pending(&adapter->watchdog_timer, jiffies + 1);
-	return 0;
 }
 
 /**
@@ -1824,9 +1823,7 @@ continue_reset:
 
 		i40evf_configure(adapter);
 
-		err = i40evf_up_complete(adapter);
-		if (err)
-			goto reset_err;
+		i40evf_up_complete(adapter);
 
 		i40evf_irq_enable(adapter, true);
 	} else {
@@ -2056,9 +2053,7 @@ static int i40evf_open(struct net_device *netdev)
 	i40evf_add_filter(adapter, adapter->hw.mac.addr);
 	i40evf_configure(adapter);
 
-	err = i40evf_up_complete(adapter);
-	if (err)
-		goto err_req_irq;
+	i40evf_up_complete(adapter);
 
 	i40evf_irq_enable(adapter, true);
 
-- 
2.4.11

