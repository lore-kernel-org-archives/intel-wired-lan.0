From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu,  7 Nov 2019 14:35:37 -0800
Subject: [Intel-wired-lan] [PATCH net-next 2/2] net: qcom/emac: Demote MTU
 change print to debug
In-Reply-To: <20191107223537.23440-1-f.fainelli@gmail.com>
References: <20191107223537.23440-1-f.fainelli@gmail.com>
Message-ID: <20191107223537.23440-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Changing the MTU can be a frequent operation and it is already clear
when (or not) a MTU change is successful, demote prints to debug prints.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/qualcomm/emac/emac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index c84ab052ef26..98f92268cbaa 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -213,9 +213,9 @@ static int emac_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct emac_adapter *adpt = netdev_priv(netdev);
 
-	netif_info(adpt, hw, adpt->netdev,
-		   "changing MTU from %d to %d\n", netdev->mtu,
-		   new_mtu);
+	netif_dbg(adpt, hw, adpt->netdev,
+		  "changing MTU from %d to %d\n", netdev->mtu,
+		  new_mtu);
 	netdev->mtu = new_mtu;
 
 	if (netif_running(netdev))
-- 
2.17.1

