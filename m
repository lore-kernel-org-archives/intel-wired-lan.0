From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:20 -0700
Subject: [Intel-wired-lan] [PATCH 03/19] fm10k: reduce the scope of qv local
 variable
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-4-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reduce the scope of the qv vector pointer local variable in the
fm10k_set_coalesce function.

This was detected by cppcheck and resolves the following style warning
produced by that tool:

[fm10k_ethtool.c:658]: (style) The scope of the variable 'qv' can be
reduced.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index 7b9440c0aee1..1f7e4a8f4557 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -650,7 +650,6 @@ static int fm10k_set_coalesce(struct net_device *dev,
 			      struct ethtool_coalesce *ec)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	struct fm10k_q_vector *qv;
 	u16 tx_itr, rx_itr;
 	int i;
 
@@ -676,7 +675,8 @@ static int fm10k_set_coalesce(struct net_device *dev,
 
 	/* update q_vectors */
 	for (i = 0; i < interface->num_q_vectors; i++) {
-		qv = interface->q_vector[i];
+		struct fm10k_q_vector *qv = interface->q_vector[i];
+
 		qv->tx.itr = tx_itr;
 		qv->rx.itr = rx_itr;
 	}
-- 
2.22.0.214.g8dca754b1e87

