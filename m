From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Wed, 23 Mar 2022 13:43:53 +0100
Subject: [Intel-wired-lan] [PATCH net 2/2] ice: don't allow to run
 ice_send_event_to_aux() in atomic ctx
In-Reply-To: <20220323124353.2762181-1-alexandr.lobakin@intel.com>
References: <20220323124353.2762181-1-alexandr.lobakin@intel.com>
Message-ID: <20220323124353.2762181-3-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ice_send_event_to_aux() eventually descends to mutex_lock()
(-> might_sched()), so it must not be called under non-task
context. However, at least two fixes have happened already for the
bug splats occurred due to this function being called from atomic
context.
To make the emergency landings softer, bail out early when executed
in non-task context emitting a warn splat only once. This way we
trade some events being potentially lost for system stability and
avoid any related hangs and crashes.

Fixes: 348048e724a0e ("ice: Implement iidc operations")
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Tested-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_idc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index fc3580167e7b..5559230eff8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -34,6 +34,9 @@ void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_event *event)
 {
 	struct iidc_auxiliary_drv *iadrv;
 
+	if (WARN_ON_ONCE(!in_task()))
+		return;
+
 	if (!pf->adev)
 		return;
 
-- 
2.35.1

