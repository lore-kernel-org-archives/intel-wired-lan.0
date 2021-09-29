From: Yang Li <yang.lee@linux.alibaba.com>
Date: Wed, 29 Sep 2021 14:56:26 +0800
Subject: [Intel-wired-lan] [PATCH -next] intel: Simplify bool conversion
Message-ID: <1632898586-96655-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix the following coccicheck warning:
./drivers/net/ethernet/intel/i40e/i40e_xsk.c:229:35-40: WARNING:
conversion to bool not needed here
./drivers/net/ethernet/intel/ice/ice_xsk.c:399:35-40: WARNING:
conversion to bool not needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 6f85879..ea06e95 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -226,7 +226,7 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 	rx_desc->wb.qword1.status_error_len = 0;
 	i40e_release_rx_desc(rx_ring, ntu);
 
-	return count == nb_buffs ? true : false;
+	return count == nb_buffs;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 7682eaa..35b6e81 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -396,7 +396,7 @@ bool ice_alloc_rx_bufs_zc(struct ice_ring *rx_ring, u16 count)
 	rx_desc->wb.status_error0 = 0;
 	ice_release_rx_desc(rx_ring, ntu);
 
-	return count == nb_buffs ? true : false;
+	return count == nb_buffs;
 }
 
 /**
-- 
1.8.3.1

