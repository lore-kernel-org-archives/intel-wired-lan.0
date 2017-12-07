From: Vasyl Gomonovych <gomonovych@gmail.com>
Date: Thu,  7 Dec 2017 23:39:02 +0100
Subject: [Intel-wired-lan] [PATCH] net: intel: e100: Fix warning of passing
 zero to 'PTR_ERR'
Message-ID: <1512686342-6920-1-git-send-email-gomonovych@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

fw could be NULL and put into PTR_ERR
also zero in PTR_ERR will be translated into success return statement

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 4d10270..55e399d 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1370,7 +1370,9 @@ static inline int e100_load_ucode_wait(struct nic *nic)
 
 	fw = e100_request_firmware(nic);
 	/* If it's NULL, then no ucode is required */
-	if (!fw || IS_ERR(fw))
+	if (!fw)
+		return -EINVAL;
+	else if (IS_ERR(fw))
 		return PTR_ERR(fw);
 
 	if ((err = e100_exec_cb(nic, (void *)fw, e100_setup_ucode)))
-- 
1.9.1

