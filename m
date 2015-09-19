From: =?unknown-8bit?q?J=CE=B5an?= Sacren <sakiwit@gmail.com>
Date: Sat, 19 Sep 2015 05:08:40 -0600
Subject: [Intel-wired-lan] [next-queue v2 1/8] e1000: clean up the checking
	logic
Message-ID: <1442660927-30431-1-git-send-email-sakiwit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jean Sacren <sakiwit@gmail.com>

The checking logic needed some clean-up work, so we rewrite it by
checking for break first. With that change in place, we can even move
the second check for goto statement outside of the loop.

As this is merely a cleanup, no functional change is involved. The
questionable 'tmp != 0xFF' is intentionally left alone.

Mark Rustad and Alexander Duyck contributed to this patch.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
Cc: "Rustad, Mark D" <mark.d.rustad@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
---
v2:

1) Update the changelog to reflect the rewrite of the checking logic and
   others' contributions;
2) Update the changelog title accordingly;
3) Add credits and cc the pertinent parties.

 drivers/net/ethernet/intel/e1000/e1000_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 97e38cee649f..5ba8d13a068c 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1199,13 +1199,13 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		for (i = 0; i < 32; i++) {
 			hw->phy_addr = i;
 			e1000_read_phy_reg(hw, PHY_ID2, &tmp);
-			if (tmp == 0 || tmp == 0xFF) {
-				if (i == 31)
-					goto err_eeprom;
-				continue;
-			} else
+
+			if (tmp != 0 && tmp != 0xFF)
 				break;
 		}
+
+		if (i >= 32)
+			goto err_eeprom;
 	}
 
 	/* reset the hardware with the new settings */
