From: Gangfeng <gangfeng.huang@ni.com>
Date: Thu, 25 Feb 2016 13:35:03 +0800
Subject: [Intel-wired-lan] [PATCH 4/4] igb: fix error code in
	igb_add_ethtool_nfc_entry()
In-Reply-To: <1456378503-19463-1-git-send-email-gangfeng.huang@ni.com>
References: <1456378503-19463-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1456378503-19463-4-git-send-email-gangfeng.huang@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use error "rmgr: Cannot insert RX class rule: Operation not supported" is
more meaningful than "rmgr: Cannot insert RX class rule: Unknown error 524"

CC: Brown, Aaron F <aaron.f.brown@intel.com>
Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index e0b37c0..40d3a1e 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -3027,7 +3027,7 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	int err = 0;
 
 	if (!(netdev->hw_features & NETIF_F_NTUPLE))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* Don't allow programming if the action is a queue greater than
 	 * the number of online Rx queues.
-- 
1.7.9.5

