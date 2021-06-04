From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:53:24 -0700
Subject: [Intel-wired-lan] [PATCH net-next 04/15] iavf: wrap driver state
 change in crit_section lock
In-Reply-To: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604165335.33329-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

The changes to driver state in iavf_disable_vf() should be made inside
the crit_section lock, not outside of it, since the complete configuration
flow needs to be seen as one atomic operation.

Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f97d04b47292..91818ba7c8a3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2071,9 +2071,9 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 	memset(adapter->vf_res, 0, IAVF_VIRTCHNL_VF_RESOURCE_SIZE);
 	iavf_shutdown_adminq(&adapter->hw);
 	adapter->netdev->flags &= ~IFF_UP;
-	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 	adapter->state = __IAVF_DOWN;
+	clear_bit(__IAVF_IN_CRITICAL_TASK, &adapter->crit_section);
 	wake_up(&adapter->down_waitqueue);
 	dev_info(&adapter->pdev->dev, "Reset task did not complete, VF disabled\n");
 }
-- 
2.20.1

