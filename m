From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri,  8 Feb 2019 12:50:37 -0800
Subject: [Intel-wired-lan] [PATCH S11 10/16] ice: don't spam VFs with link
 messages
In-Reply-To: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190208205043.11975-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Don't send a link message to the VFs unless link actually changes state.
This avoids a small timing hole in some VF drivers that can cause an
apparent TX hang if they receive a link status message at the wrong time.

Although we have fixed the timing hole in the current VF driver, there
are still lots of drivers in the field that have this timing hole. Let's
not fall into it if we can avoid it.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fb04a5ebdc0b..47cc3f905b7f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -609,7 +609,8 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi)
 		}
 	}
 
-	ice_vc_notify_link_state(pf);
+	if (!new_link_same_as_old && pf->num_alloc_vfs)
+		ice_vc_notify_link_state(pf);
 
 	return 0;
 }
-- 
2.14.5

