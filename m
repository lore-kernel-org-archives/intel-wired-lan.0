From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Thu, 18 Feb 2021 21:55:35 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: Fix oops at i40e_rebuild()
Message-ID: <20210218215535.277482-1-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Setup TC before the i40e_setup_pf_switch() call.
Memory must be inititalized for all the queues
before using its resources.

Previously it could be possible that a call:
xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
rx_ring->queue_index, rx_ring->q_vector->napi.napi_id);
was made with q_vector being null.

Oops could show up with the following sequence:
- no driver loaded
- FW LLDP agent is on (flag disable-fw-lldp:off)
- link is up
- DCB configured with number of Traffic Classes that will not divide
  completely the default number of queues (usually cpu cores)
- driver load
- set private flag: disable-fw-lldp:on

Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based DCB")
Fixes: b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 65fed08..a9fdaee 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -10574,12 +10574,6 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 		goto end_core_reset;
 	}
 
-	if (!lock_acquired)
-		rtnl_lock();
-	ret = i40e_setup_pf_switch(pf, reinit);
-	if (ret)
-		goto end_unlock;
-
 #ifdef CONFIG_I40E_DCB
 	/* Enable FW to write a default DCB config on link-up
 	 * unless I40E_FLAG_TC_MQPRIO was enabled or DCB
@@ -10608,6 +10602,11 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
 	}
 
 #endif /* CONFIG_I40E_DCB */
+	if (!lock_acquired)
+		rtnl_lock();
+	ret = i40e_setup_pf_switch(pf, reinit);
+	if (ret)
+		goto end_unlock;
 
 	/* The driver only wants link up/down and module qualification
 	 * reports from firmware.  Note the negative logic.

base-commit: acad41d948db537ceac9d50c132653d82222343c
-- 
2.18.4

