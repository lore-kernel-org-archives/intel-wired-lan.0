From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 Nov 2017 07:00:45 -0500
Subject: [Intel-wired-lan] [next PATCH S82-V4 2/9] i40evf: Clean-up flags
 for promisc mode to avoid high polling rate
In-Reply-To: <20171114120052.86665-1-alice.michael@intel.com>
References: <20171114120052.86665-1-alice.michael@intel.com>
Message-ID: <20171114120052.86665-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

If you enabled and disabled promiscuous mode on a VF you could easily put
it into a state where it would start firing interrupts on all queues at a
rate of 50+ interrupts per second even though there was no traffic present.
The issue seems to have been a stray admin queue feature flag set that was
leaving us in a high polling rate for the adminq task.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 2719a05..feb95b6 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -739,8 +739,10 @@ void i40evf_set_promiscuous(struct i40evf_adapter *adapter, int flags)
 	}
 
 	if (!flags) {
-		adapter->flags &= ~I40EVF_FLAG_PROMISC_ON;
-		adapter->aq_required &= ~I40EVF_FLAG_AQ_RELEASE_PROMISC;
+		adapter->flags &= ~(I40EVF_FLAG_PROMISC_ON |
+				    I40EVF_FLAG_ALLMULTI_ON);
+		adapter->aq_required &= ~(I40EVF_FLAG_AQ_RELEASE_PROMISC |
+					  I40EVF_FLAG_AQ_RELEASE_ALLMULTI);
 		dev_info(&adapter->pdev->dev, "Leaving promiscuous mode\n");
 	}
 
-- 
2.9.5

