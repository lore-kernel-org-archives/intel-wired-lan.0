From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 26 May 2021 13:23:13 -0700
Subject: [Intel-wired-lan] [PATCH] fixup! ice: add support for sideband
 messages
Message-ID: <20210526202313.3354027-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The check in ice_clean_sbq_subtask for whether to exit early
accidentally checked for if the sbq was supported. This check should be
negated, so that we only try to clean the sideband queue on devices
which support it. Otherwise without this fix, on devices that do not
support the sideband queue, the following message may get spammed into
the log:

ice 0000:af:00.0: Sideband Receive Queue event error ICE_ERR_AQ_EMPTY

Additionally, on devices which do support the sideband queue, the
receive portion will never be properly cleaned.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tony, if you wouldn't mind squashing this into the noted patch in the
description before we send this to netdev.

 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3cc1237a2ebe..ca80b858ef20 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1430,7 +1430,8 @@ static void ice_clean_sbq_subtask(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
 
-	if (ice_is_sbq_supported(hw)) {
+	/* Nothing to do here if sideband queue is not supported */
+	if (!ice_is_sbq_supported(hw)) {
 		clear_bit(ICE_SIDEBANDQ_EVENT_PENDING, pf->state);
 		return;
 	}

base-commit: 80e0251735737d53ea5dc85e2cf5596df721ddc5
-- 
2.31.1.331.gb0c09ab8796f

