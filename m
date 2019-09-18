From: Navid Emamdoost <navid.emamdoost@gmail.com>
Date: Tue, 17 Sep 2019 19:00:12 -0500
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: release the local packet
 buffer
Message-ID: <20190918000013.32083-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In e100_loopback_test the buffer allocated for the local packet needs to
be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index a65d5a9ba7db..4de7dca341fc 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2394,6 +2394,7 @@ static int e100_loopback_test(struct nic *nic, enum loopback loopback_mode)
 	e100_hw_reset(nic);
 err_clean_rx:
 	e100_rx_clean_list(nic);
+	dev_kfree_skb(skb);
 	return err;
 }
 
-- 
2.17.1

