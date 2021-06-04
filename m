From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:48:54 -0700
Subject: [Intel-wired-lan] [PATCH net 2/8] iavf: free q_vectors before
 queues in iavf_disable_vf
In-Reply-To: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604164900.33156-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

iavf_free_queues() clears adapter->num_active_queues, which
iavf_free_q_vectors() relies on, so swap the order of these two function
calls in iavf_disable_vf(). This resolves a panic encountered when the
interface is disabled and then later brought up again after PF
communication is restored.

Fixes: 65c7006f234c ("i40evf: assign num_active_queues inside i40evf_alloc_queues")
Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ad3f804f0e14..989de52658dc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2067,8 +2067,8 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 
 	iavf_free_misc_irq(adapter);
 	iavf_reset_interrupt_capability(adapter);
-	iavf_free_queues(adapter);
 	iavf_free_q_vectors(adapter);
+	iavf_free_queues(adapter);
 	memset(adapter->vf_res, 0, IAVF_VIRTCHNL_VF_RESOURCE_SIZE);
 	iavf_shutdown_adminq(&adapter->hw);
 	adapter->netdev->flags &= ~IFF_UP;
-- 
2.20.1

