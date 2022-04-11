From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Apr 2022 16:29:02 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/6] ice: add newline to dev_dbg
 in ice_vf_fdir_dump_info
In-Reply-To: <20220411232907.1022602-1-jacob.e.keller@intel.com>
References: <20220411232907.1022602-1-jacob.e.keller@intel.com>
Message-ID: <20220411232907.1022602-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The debug print in ice_vf_fdir_dump_info don't end in newlines. This can
look confusing when reading the kernel log, as the next print will
immediately continue on the same line.

Fix this.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 8e38ee2faf58..dbc1965c0609 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -1349,7 +1349,7 @@ static void ice_vf_fdir_dump_info(struct ice_vf *vf)
 
 	fd_size = rd32(hw, VSIQF_FD_SIZE(vsi_num));
 	fd_cnt = rd32(hw, VSIQF_FD_CNT(vsi_num));
-	dev_dbg(dev, "VF %d: space allocated: guar:0x%x, be:0x%x, space consumed: guar:0x%x, be:0x%x",
+	dev_dbg(dev, "VF %d: space allocated: guar:0x%x, be:0x%x, space consumed: guar:0x%x, be:0x%x\n",
 		vf->vf_id,
 		(fd_size & VSIQF_FD_CNT_FD_GCNT_M) >> VSIQF_FD_CNT_FD_GCNT_S,
 		(fd_size & VSIQF_FD_CNT_FD_BCNT_M) >> VSIQF_FD_CNT_FD_BCNT_S,
-- 
2.35.1.456.ga9c7032d4631

