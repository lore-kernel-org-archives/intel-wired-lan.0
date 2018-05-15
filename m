From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 15 May 2018 11:01:55 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/2] ena: Fix settings/advertising for
 ethtool
In-Reply-To: <20180515180155.19164-1-jeffrey.t.kirsher@intel.com>
References: <20180515180155.19164-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180515180155.19164-2-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It appears that the Amazon Ethernet driver was setting bits in the
'settings' field twice.  Almost certainly this was supposed to set bits in
the 'advertising' field instead.

CC: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 0a4de911e6cc..2f5e4cf84934 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -283,7 +283,7 @@ static int ena_get_link_ksettings(struct net_device *netdev,
 
 	if (link->flags & ENA_ADMIN_GET_FEATURE_LINK_DESC_AUTONEG_MASK) {
 		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
-		ethtool_ks_add_mode(link_ksettings, supported, Autoneg);
+		ethtool_ks_add_mode(link_ksettings, advertising, Autoneg);
 	}
 
 	link_ksettings->base.autoneg =
-- 
2.17.0

