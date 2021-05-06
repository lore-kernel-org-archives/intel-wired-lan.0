From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu,  6 May 2021 08:40:00 -0700
Subject: [Intel-wired-lan] [PATCH S59 05/13] ice: (re)initialize NVM fields
 when rebuilding
In-Reply-To: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
Message-ID: <20210506154008.12880-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

After performing a flash update, a device EMP reset may occur. This
reset will cause the newly downloaded firmware to be initialized. When
this happens, the driver still reports the previous NVM version
information.

This is because the NVM versions are cached within the hw structure.
This can be confusing, as the new firmware is in fact running in this
case.

Handle this by calling ice_init_nvm when rebuilding the driver state.
This will update the flash version information and ensures that the
current values are displayed when reporting the NVM versions to the
stack.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9ae9197c12a9..a7c359335cb0 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6151,6 +6151,12 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ice_clear_pxe_mode(hw);
 
+	ret = ice_init_nvm(hw);
+	if (ret) {
+		dev_err(dev, "ice_init_nvm failed %s\n", ice_stat_str(ret));
+		goto err_init_ctrlq;
+	}
+
 	ret = ice_get_caps(hw);
 	if (ret) {
 		dev_err(dev, "ice_get_caps failed %s\n", ice_stat_str(ret));
-- 
2.20.1

