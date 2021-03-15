From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Mon, 15 Mar 2021 07:18:47 +0530
Subject: [Intel-wired-lan] [PATCH] net: ethernet: intel: igb: Typo fix in
 the file igb_main.c
Message-ID: <20210315014847.1021209-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


s/structue/structure/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 03f78fdb0dcd..afc8ab9046a5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3115,7 +3115,7 @@ static s32 igb_init_i2c(struct igb_adapter *adapter)
 		return 0;

 	/* Initialize the i2c bus which is controlled by the registers.
-	 * This bus will use the i2c_algo_bit structue that implements
+	 * This bus will use the i2c_algo_bit structure that implements
 	 * the protocol through toggling of the 4 bits in the register.
 	 */
 	adapter->i2c_adap.owner = THIS_MODULE;
--
2.30.2

