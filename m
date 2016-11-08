From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:16 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 12/15] i40e/i40evf: napi_poll
	must return the work done
In-Reply-To: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478639119-14656-13-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

Currently the function i40e_napi-poll() returns 0 when it clean completely
the rx rings, but this foul budget accounting in core code.

Fix this by returning the actual work done, capped to budget - 1, since
the core doesn't allow to return the full budget when the driver modifies
the napi status

This is based on a similar change that was made for the ixgbe driver by
Paolo Abeni.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Change-ID: Ic3d93ad2fa2fc8ce3164bc461e69367da0f9173b
---
Testing Hints:
        This may slightly improve the responsiveness of the system, but the
        big gain for us is actually when using i40e to perform busy polling
        since the return value is used to verify if we have received any
        packets.

        For our purposes the best test is probably just an Rx performance
        test to make sure we didn't cause a regression.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5544b50..352cf7c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2027,7 +2027,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	else
 		i40e_update_enable_itr(vsi, q_vector);
 
-	return 0;
+	return min(work_done, budget - 1);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index c4b174a..df67ef3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1490,7 +1490,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 	else
 		i40e_update_enable_itr(vsi, q_vector);
 
-	return 0;
+	return min(work_done, budget - 1);
 }
 
 /**
-- 
2.4.11

