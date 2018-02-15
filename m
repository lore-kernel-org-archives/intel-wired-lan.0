From: Dayanand, Avinash <avinash.dayanand@intel.com>
Date: Thu, 15 Feb 2018 21:33:43 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: check that pointer vsi is not
 null before dereferencing it
In-Reply-To: <20180215195052.29037-1-colin.king@canonical.com>
References: <20180215195052.29037-1-colin.king@canonical.com>
Message-ID: <475EF86EA1AC844AA3BA8EE1F912AD6938BFAAE4@ORSMSX111.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Colin King
Sent: Thursday, February 15, 2018 11:51 AM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
Subject: [Intel-wired-lan] [PATCH] i40e: check that pointer vsi is not null before dereferencing it

From: Colin Ian King <colin.king@canonical.com>

Function i40e_find_vsi_from_id can potentially return null, hence vsi may be null, so defensively check it is non-null before dereferencing it to check the seid.

Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Avinash Dayanand <avinash.dayanand@intel.com>

---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 5cca083da93c..14bbd5c1db78 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3062,7 +3062,7 @@ static struct i40e_vsi *i40e_find_vsi_from_seid(struct i40e_vf *vf, u16 seid)
 
 	for (i = 0; i < vf->num_tc ; i++) {
 		vsi = i40e_find_vsi_from_id(pf, vf->ch[i].vsi_id);
-		if (vsi->seid == seid)
+		if (vsi && vsi->seid == seid)
 			return vsi;
 	}
 	return NULL;
--
2.15.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
