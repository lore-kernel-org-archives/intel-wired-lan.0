From: Gangfeng <gangfeng.huang@ni.com>
Date: Wed, 6 Jul 2016 13:22:57 +0800
Subject: [Intel-wired-lan] [net-next v6 4/4] igb: fix error code in
	igb_add_ethtool_nfc_entry()
In-Reply-To: <1467782577-25659-1-git-send-email-gangfeng.huang@ni.com>
References: <1467782577-25659-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1467782577-25659-5-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Gangfeng Huang <gangfeng.huang@ni.com>

Use error "rmgr: Cannot insert RX class rule: Operation not supported" is
more meaningful than "rmgr: Cannot insert RX class rule: Unknown error 524"

CC: Brown Aaron F <aaron.f.brown@intel.com>
Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 5ebaca8..03c88df 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2851,7 +2851,7 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	int err = 0;
 
 	if (!(netdev->hw_features & NETIF_F_NTUPLE))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* Don't allow programming if the action is a queue greater than
 	 * the number of online Rx queues.
-- 
2.7.2

