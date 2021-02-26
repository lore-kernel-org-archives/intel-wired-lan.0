From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 26 Feb 2021 13:19:28 -0800
Subject: [Intel-wired-lan] [PATCH net 09/13] ice: remove DCBNL_DEVRESET bit
 from PF state
In-Reply-To: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
References: <20210226211932.46683-1-anthony.l.nguyen@intel.com>
Message-ID: <20210226211932.46683-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

The original purpose of the ICE_DCBNL_DEVRESET was to protect
the driver during DCBNL device resets.  But, the flow for
DCBNL device resets now consists of only calls up the stack
such as dev_close() and dev_open() that will result in NDO calls
to the driver.  These will be handled with state changes from the
stack.  Also, there is a problem of the dev_close and dev_open
being blocked by checks for reset in progress also using the
ICE_DCBNL_DEVRESET bit.

Since the ICE_DCBNL_DEVRESET bit is not necessary for protecting
the driver from DCBNL device resets and it is actually blocking
changes coming form the DCBNL interface, remove the bit from the
PF state and don't block driver function based on DCBNL reset in
progress.

Fixes: b94b013eb626 ("ice: Implement DCBNL support")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        | 1 -
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c | 2 --
 drivers/net/ethernet/intel/ice/ice_lib.c    | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ae1c3a3b0780..522c7aa61cc7 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -193,7 +193,6 @@ enum ice_state {
 	__ICE_NEEDS_RESTART,
 	__ICE_PREPARED_FOR_RESET,	/* set by driver when prepared */
 	__ICE_RESET_OICR_RECV,		/* set by driver after rcv reset OICR */
-	__ICE_DCBNL_DEVRESET,		/* set by dcbnl devreset */
 	__ICE_PFR_REQ,			/* set by driver and peers */
 	__ICE_CORER_REQ,		/* set by driver and peers */
 	__ICE_GLOBR_REQ,		/* set by driver and peers */
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index 468a63f7eff9..4180f1f35fb8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -18,12 +18,10 @@ static void ice_dcbnl_devreset(struct net_device *netdev)
 	while (ice_is_reset_in_progress(pf->state))
 		usleep_range(1000, 2000);
 
-	set_bit(__ICE_DCBNL_DEVRESET, pf->state);
 	dev_close(netdev);
 	netdev_state_change(netdev);
 	dev_open(netdev, NULL);
 	netdev_state_change(netdev);
-	clear_bit(__ICE_DCBNL_DEVRESET, pf->state);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 638304abef73..d5b9ac620b06 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3080,7 +3080,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
 bool ice_is_reset_in_progress(unsigned long *state)
 {
 	return test_bit(__ICE_RESET_OICR_RECV, state) ||
-	       test_bit(__ICE_DCBNL_DEVRESET, state) ||
 	       test_bit(__ICE_PFR_REQ, state) ||
 	       test_bit(__ICE_CORER_REQ, state) ||
 	       test_bit(__ICE_GLOBR_REQ, state);
-- 
2.20.1

