From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 12 Mar 2021 09:48:40 -0800
Subject: [Intel-wired-lan] [net-next PATCH 06/10] netvsc: Update driver to
 use ethtool_sprintf
In-Reply-To: <161557111604.10304.1798900949114188676.stgit@localhost.localdomain>
References: <161557111604.10304.1798900949114188676.stgit@localhost.localdomain>
Message-ID: <161557132005.10304.543531678348828381.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexanderduyck@fb.com>

Replace instances of sprintf or memcpy with a pointer update with
ethtool_sprintf.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/hyperv/netvsc_drv.c |   33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 15f262b70489..97b5c9b60503 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1612,34 +1612,23 @@ static void netvsc_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0; i < ARRAY_SIZE(netvsc_stats); i++) {
-			memcpy(p, netvsc_stats[i].name, ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < ARRAY_SIZE(netvsc_stats); i++)
+			ethtool_sprintf(&p, netvsc_stats[i].name);
 
-		for (i = 0; i < ARRAY_SIZE(vf_stats); i++) {
-			memcpy(p, vf_stats[i].name, ETH_GSTRING_LEN);
-			p += ETH_GSTRING_LEN;
-		}
+		for (i = 0; i < ARRAY_SIZE(vf_stats); i++)
+			ethtool_sprintf(&p, vf_stats[i].name);
 
 		for (i = 0; i < nvdev->num_chn; i++) {
-			sprintf(p, "tx_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "tx_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "rx_queue_%u_packets", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "rx_queue_%u_bytes", i);
-			p += ETH_GSTRING_LEN;
-			sprintf(p, "rx_queue_%u_xdp_drop", i);
-			p += ETH_GSTRING_LEN;
+			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
+			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
+			ethtool_sprintf(&p, "rx_queue_%u_packets", i);
+			ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
+			ethtool_sprintf(&p, "rx_queue_%u_xdp_drop", i);
 		}
 
 		for_each_present_cpu(cpu) {
-			for (i = 0; i < ARRAY_SIZE(pcpu_stats); i++) {
-				sprintf(p, pcpu_stats[i].name, cpu);
-				p += ETH_GSTRING_LEN;
-			}
+			for (i = 0; i < ARRAY_SIZE(pcpu_stats); i++)
+				ethtool_sprintf(&p, pcpu_stats[i].name, cpu);
 		}
 
 		break;


