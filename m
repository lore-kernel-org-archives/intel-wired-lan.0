From: Alan Brady <alan.brady@intel.com>
Date: Thu,  5 Oct 2017 14:53:33 -0700
Subject: [Intel-wired-lan] [PATCH v3 03/14 net-next] i40e: add function
	header for i40e_get_rxfh
In-Reply-To: <20171005215344.2886-1-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
Message-ID: <20171005215344.2886-4-alan.brady@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Someone left this poor little function naked with no header.  This
dresses it up in a proper function header it deserves.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 4fda529a464b..43294b6567c2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3966,6 +3966,16 @@ static u32 i40e_get_rxfh_indir_size(struct net_device *netdev)
 	return I40E_HLUT_ARRAY_SIZE;
 }
 
+/**
+ * i40e_get_rxfh - get the rx flow hash indirection table
+ * @netdev: network interface device structure
+ * @indir: indirection table
+ * @key: hash key
+ * @hfunc: hash function
+ *
+ * Reads the indirection table directly from the hardware. Returns 0 on
+ * success.
+ **/
 static int i40e_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
 			 u8 *hfunc)
 {
-- 
2.14.1

