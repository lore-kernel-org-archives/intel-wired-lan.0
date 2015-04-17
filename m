From: Jonathan Toppins <jtoppins@cumulusnetworks.com>
Date: Fri, 17 Apr 2015 13:24:00 -0700
Subject: [Intel-wired-lan] [PATCH v1 net-next 2/2] igb: support SIOCSMIIREG
In-Reply-To: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
Message-ID: <1429302240-654-2-git-send-email-jtoppins@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Liebthal <alanl@cumulusnetworks.com>

Support setting the MII register via SIOCSMIIREG.

Signed-off-by: Alan Liebthal <alanl@cumulusnetworks.com>
Signed-off-by: Jonathan Toppins <jtoppins@cumulusnetworks.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 720b785..1071a71 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7141,6 +7141,11 @@ static int igb_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
 			return -EIO;
 		break;
 	case SIOCSMIIREG:
+		adapter->hw.phy.addr = data->phy_id;
+		if (igb_write_phy_reg(&adapter->hw, data->reg_num & 0x1F,
+				      data->val_in))
+			return -EIO;
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
1.7.10.4

