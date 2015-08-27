From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:31 -0400
Subject: [Intel-wired-lan] [next PATCH S12 03/15] i40evf: propagate
	interrupt allocation failure
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Lower level functions are properly reporting errors, and higher-level
functions are correctly responding to errors, but the errors aren't
actually getting through. Typically, the middle-manager function seems
to want to shield its boss from any bad news.

This change fixes a panic if the driver is unable to enable MSI-X or is
unable to acquire enough vectors.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ifd5787ce92519a5d97e4b465902db930d97b71a1
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index a98fa20..eccf80c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1085,7 +1085,7 @@ static int i40evf_set_interrupt_capability(struct i40evf_adapter *adapter)
 	for (vector = 0; vector < v_budget; vector++)
 		adapter->msix_entries[vector].entry = vector;
 
-	i40evf_acquire_msix_vectors(adapter, v_budget);
+	err = i40evf_acquire_msix_vectors(adapter, v_budget);
 
 out:
 	adapter->netdev->real_num_tx_queues = pairs;
-- 
1.9.3

