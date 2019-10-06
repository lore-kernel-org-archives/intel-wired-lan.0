From: Joe Perches <joe@perches.com>
Date: Sun, 06 Oct 2019 10:19:10 -0700
Subject: [Intel-wired-lan] i40e_pto.c: Odd use of strlcpy converted from
 strncpy
Message-ID: <edf91d8284a2a19d956eb8b7e8b6c4984ceaa1ab.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This got converted from strncpy to strlcpy but it's
now not necessary to use one character less than the
actual size.

Perhaps the sizeof() - 1 is now not correct and it
should use strscpy and a normal sizeof.

from:

commit 7eb74ff891b4e94b8bac48f648a21e4b94ddee64
Author: Mitch Williams <mitch.a.williams@intel.com>
Date:   Mon Aug 20 08:12:30 2018 -0700

    i40e: use correct length for strncpy

and

commit 4ff2d8540321324e04c1306f85d4fe68a0c2d0ae
Author: Patryk Ma?ek <patryk.malek@intel.com>
Date:   Tue Oct 30 10:50:44 2018 -0700

    i40e: Replace strncpy with strlcpy to ensure null termination
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 9bf1ad4319f5..627b1c02bb4b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -700,8 +700,8 @@ static long i40e_ptp_create_clock(struct i40e_pf *pf)
 	if (!IS_ERR_OR_NULL(pf->ptp_clock))
 		return 0;
 
-	strlcpy(pf->ptp_caps.name, i40e_driver_name,
-		sizeof(pf->ptp_caps.name) - 1);
+	strscpy(pf->ptp_caps.name, i40e_driver_name, sizeof(pf->ptp_caps.name));
+
 	pf->ptp_caps.owner = THIS_MODULE;
 	pf->ptp_caps.max_adj = 999999999;
 	pf->ptp_caps.n_ext_ts = 0;


