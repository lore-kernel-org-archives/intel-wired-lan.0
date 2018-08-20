From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:31 -0700
Subject: [Intel-wired-lan] [next PATCH S95 10/12] i40evf: set
 IFF_UNICAST_FLT flag for the vf
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <20180820151233.14629-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lihong Yang <lihong.yang@intel.com>

Set IFF_UNICAST_FLT flag for the vf to prevent it from entering
promiscuous mode when macvlan is added to the vf.

Signed-off-by: Lihong Yang <lihong.yang@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 5906c1c..07f187b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -3358,6 +3358,8 @@ int i40evf_process_config(struct i40evf_adapter *adapter)
 	if (vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_VLAN)
 		netdev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+
 	/* Do not turn on offloads when they are requested to be turned off.
 	 * TSO needs minimum 576 bytes to work correctly.
 	 */
-- 
2.9.5

