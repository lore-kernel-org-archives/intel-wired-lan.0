From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Thu, 23 Jun 2016 10:30:55 +0530
Subject: [Intel-wired-lan] [PATCH] i40e: Remove redundant memset
Message-ID: <20160623050055.GA15082@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove redundant call to memset before a call to memcpy.

The Coccinelle semantic patch used to make this change is as follows:
@@
expression e1,e2,e3,e4;
@@

- memset(e1,e2,e3);
  memcpy(e1,e4,e3);

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3449129..45c1671 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7961,7 +7961,6 @@ static int i40e_config_rss_aq(struct i40e_vsi *vsi, const u8 *seed,
 	u8 *rss_lut;
 	int ret, i;
 
-	memset(&rss_key, 0, sizeof(rss_key));
 	memcpy(&rss_key, seed, sizeof(rss_key));
 
 	rss_lut = kzalloc(pf->rss_table_size, GFP_KERNEL);
-- 
1.9.1

