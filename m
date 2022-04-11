From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Apr 2022 16:29:06 -0700
Subject: [Intel-wired-lan] [PATCH net-next 5/6] ice: add a function comment
 for ice_cfg_mac_antispoof
In-Reply-To: <20220411232907.1022602-1-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
Message-ID: <20220411232907.1022602-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This function definition was missing a comment describing its
implementation. Add one.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 8f875a17755f..cd8e6b50968c 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -657,6 +657,13 @@ struct ice_port_info *ice_vf_get_port_info(struct ice_vf *vf)
 	return vf->pf->hw.port_info;
 }
 
+/**
+ * ice_cfg_mac_antispoof - Configure MAC antispoof checking behavior
+ * @vsi: the VSI to configure
+ * @enable: whether to enable or disable the spoof checking
+ *
+ * Configure a VSI to enable (or disable) spoof checking behavior.
+ */
 static int ice_cfg_mac_antispoof(struct ice_vsi *vsi, bool enable)
 {
 	struct ice_vsi_ctx *ctx;
-- 
2.35.1.456.ga9c7032d4631

