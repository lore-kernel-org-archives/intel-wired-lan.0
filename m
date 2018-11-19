From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 19 Nov 2018 20:48:19 +0800
Subject: [Intel-wired-lan] [PATCH net-next] e100: Fix passing zero to
 'PTR_ERR' warning in e100_load_ucode_wait
Message-ID: <20181119124819.15860-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix a static code checker warning:
drivers/net/ethernet/intel/e100.c:1349
 e100_load_ucode_wait() warn: passing zero to 'PTR_ERR'

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/intel/e100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 7c4b554..736115b 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1345,8 +1345,8 @@ static inline int e100_load_ucode_wait(struct nic *nic)
 
 	fw = e100_request_firmware(nic);
 	/* If it's NULL, then no ucode is required */
-	if (!fw || IS_ERR(fw))
-		return PTR_ERR(fw);
+	if (IS_ERR_OR_NULL(fw))
+		return PTR_ERR_OR_ZERO(fw);
 
 	if ((err = e100_exec_cb(nic, (void *)fw, e100_setup_ucode)))
 		netif_err(nic, probe, nic->netdev,
-- 
2.7.0


