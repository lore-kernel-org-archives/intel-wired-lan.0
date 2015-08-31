From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:51 -0400
Subject: [Intel-wired-lan] [next PATCH S14 11/15] i40evf: don't blow away
	MAC address
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Under certain circumstances, we can get an extra VF_RESOURCES message
from the PF driver at runtime. When this happens, we need to parse it
because our VSI may have changed out from underneath us, and that will
affect our relationship with the PF driver.

However, parsing the resources message also blows away our current MAC
address in the hardware struct, usually with all zeros. When this
happens, the next time the interface is opened, it will have no MAC
address and will a) not work and b) complain.

Fix this issue by restoring the current MAC address from the netdev
struct after we parse the resource message.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I6cd1b624fc20432f81dc901166c8de195b8e0e65
---
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 317e240..4f056ef 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -751,6 +751,8 @@ void i40evf_virtchnl_completion(struct i40evf_adapter *adapter,
 			  sizeof(struct i40e_virtchnl_vsi_resource);
 		memcpy(adapter->vf_res, msg, min(msglen, len));
 		i40e_vf_parse_hw_config(&adapter->hw, adapter->vf_res);
+		/* restore current mac address */
+		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
 		i40evf_process_config(adapter);
 		}
 		break;
-- 
1.9.3

