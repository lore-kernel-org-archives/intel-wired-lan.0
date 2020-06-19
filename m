From: Gustavo A. R. Silva <gustavoars@kernel.org>
Date: Fri, 19 Jun 2020 12:56:11 -0500
Subject: [Intel-wired-lan] [PATCH][next] ice: Use struct_size() helper
Message-ID: <20200619175611.GA27719@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 4420fc02f7e7..d92c4d70dbcd 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1121,8 +1121,7 @@ static enum ice_status ice_get_pkg_info(struct ice_hw *hw)
 	u16 size;
 	u32 i;
 
-	size = sizeof(*pkg_info) + (sizeof(pkg_info->pkg_info[0]) *
-				    (ICE_PKG_CNT - 1));
+	size = struct_size(pkg_info, pkg_info, ICE_PKG_CNT - 1);
 	pkg_info = kzalloc(size, GFP_KERNEL);
 	if (!pkg_info)
 		return ICE_ERR_NO_MEMORY;
-- 
2.27.0

