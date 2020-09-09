From: Wei Xu <xuwei5@hisilicon.com>
Date: Wed, 9 Sep 2020 16:51:11 +0800
Subject: [Intel-wired-lan] [net-next] net: iavf: Use the ARRAY_SIZE macro
 for aq_to_posix
Message-ID: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the ARRAY_SIZE macro to calculate the size of an array.
This code was detected with the help of Coccinelle.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
index baf2fe2..eead12c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
@@ -120,7 +120,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int aq_rc)
 	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
 		return -EAGAIN;
 
-	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
+	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
 		return -ERANGE;
 
 	return aq_to_posix[aq_rc];
-- 
2.8.1

