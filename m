From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Sun, 31 Jul 2016 11:39:28 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] net: i10e: use matching format
	indentifiers
Message-ID: <1469957968-726-1-git-send-email-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i is defined as int but output as %u several times.
Change the definition to unsigned.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c912e04..8b08a69 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1532,7 +1532,7 @@ static void i40e_get_strings(struct net_device *netdev, u32 stringset,
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 	char *p = (char *)data;
-	int i;
+	unsigned int i;
 
 	switch (stringset) {
 	case ETH_SS_TEST:
-- 
2.8.1

