From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Apr 2022 16:29:05 -0700
Subject: [Intel-wired-lan] [PATCH net-next 4/6] ice: fix wording in comment
 for ice_reset_vf
In-Reply-To: <20220411232907.1022602-1-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
Message-ID: <20220411232907.1022602-5-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The comment explaining ice_reset_vf has an extraneous "the" with the "if
the resets are disabled". Remove it.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 24cf6a5b49fe..8f875a17755f 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -477,8 +477,8 @@ static void ice_notify_vf_reset(struct ice_vf *vf)
  *   ICE_VF_RESET_NOTIFY - Send VF a notification prior to reset
  *   ICE_VF_RESET_LOCK - Acquire VF cfg_lock before resetting
  *
- * Returns 0 if the VF is currently in reset, if the resets are disabled, or
- * if the VF resets successfully. Returns an error code if the VF fails to
+ * Returns 0 if the VF is currently in reset, if resets are disabled, or if
+ * the VF resets successfully. Returns an error code if the VF fails to
  * rebuild.
  */
 int ice_reset_vf(struct ice_vf *vf, u32 flags)
-- 
2.35.1.456.ga9c7032d4631

