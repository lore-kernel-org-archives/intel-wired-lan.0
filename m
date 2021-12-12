From: Jason Wang <wangborong@cdjrlc.com>
Date: Sun, 12 Dec 2021 16:10:01 +0800
Subject: [Intel-wired-lan] [PATCH] iavf: remove an unneeded variable
Message-ID: <20211212081001.368126-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The variable `ret_code' used for returning is never changed in function
`iavf_shutdown_adminq'. So that it can be removed and just return its
initial value 0 at the end of `iavf_shutdown_adminq' function.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
index 9fa3fa99b4c2..cd4e6a22d0f9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -551,15 +551,13 @@ enum iavf_status iavf_init_adminq(struct iavf_hw *hw)
  **/
 enum iavf_status iavf_shutdown_adminq(struct iavf_hw *hw)
 {
-	enum iavf_status ret_code = 0;
-
 	if (iavf_check_asq_alive(hw))
 		iavf_aq_queue_shutdown(hw, true);
 
 	iavf_shutdown_asq(hw);
 	iavf_shutdown_arq(hw);
 
-	return ret_code;
+	return 0;
 }
 
 /**
-- 
2.34.1

