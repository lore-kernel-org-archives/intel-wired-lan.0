From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 30 Jan 2017 12:29:36 -0800
Subject: [Intel-wired-lan] [next PATCH S59 5/6] i40e: Allow untrusted VFs to
	have more filters
In-Reply-To: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1485808177-6333-6-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Our original filter limit of 8 was based on behavior that we saw from
Linux VMs. Now we're running Other Operating Systems under KVM and we
see that they commonly use more MAC filters. Since it seems weird to
require people to enable trusted VFs just to boot their OS, bump the
number of filters allowed by default.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I76b2dcb2ad6017e39231ad3096c3fb6f065eef5e
---
Testing Hints : Boot Windows Server 2016 in a VM and
make sure the host doesn't complain about untrusted VFs.

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 0a5a05b..a970ba3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2189,7 +2189,7 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg, u16 msglen)
 }
 
 /* If the VF is not trusted restrict the number of MAC/VLAN it can program */
-#define I40E_VC_MAX_MAC_ADDR_PER_VF 8
+#define I40E_VC_MAX_MAC_ADDR_PER_VF 12
 #define I40E_VC_MAX_VLAN_PER_VF 8
 
 /**
-- 
2.4.11

