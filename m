From: Nathan Chancellor <natechancellor@gmail.com>
Date: Fri, 21 Sep 2018 03:13:59 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Use proper enum in
 i40e_ndo_set_vf_link_state
Message-ID: <20180921101359.23911-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Clang warns when one enumerated type is converted implicitly to another.

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:4214:42: warning:
implicit conversion from enumeration type 'enum i40e_aq_link_speed' to
different enumeration type 'enum virtchnl_link_speed'
      [-Wenum-conversion]
                pfe.event_data.link_event.link_speed = I40E_LINK_SPEED_40GB;
                                                     ~ ^~~~~~~~~~~~~~~~~~~~
1 warning generated.

Use the proper enum from virtchnl_link_speed, which has the same value
as I40E_LINK_SPEED_40GB, VIRTCHNL_LINK_SPEED_40GB. This appears to be
missed by commit ff3f4cc267f6 ("virtchnl: finish conversion to virtchnl
interface").

Link: https://github.com/ClangBuiltLinux/linux/issues/81
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3e707c7e6782..916a98e6c0e6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4211,7 +4211,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 		vf->link_forced = true;
 		vf->link_up = true;
 		pfe.event_data.link_event.link_status = true;
-		pfe.event_data.link_event.link_speed = I40E_LINK_SPEED_40GB;
+		pfe.event_data.link_event.link_speed = VIRTCHNL_LINK_SPEED_40GB;
 		break;
 	case IFLA_VF_LINK_STATE_DISABLE:
 		vf->link_forced = true;
-- 
2.19.0

