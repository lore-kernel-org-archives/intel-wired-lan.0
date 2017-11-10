From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 10 Nov 2017 10:55:51 -0800
Subject: [Intel-wired-lan] [PATCH 1/3] ethtool: correct display of VF when
 showing vf/queue filters
Message-ID: <20171110185553.14657-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The original code that implemented this accidentally had an inverted
check, so it would never show the VF number properly.

Fix this code to correctly display the VF number when we have one.

Fixes: 36ee712b0fbc ("ethtool: support queue and VF fields for rxclass filters", 2017-03-23)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 rxclass.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rxclass.c b/rxclass.c
index ebc3e1a59fb3..144c8e5e76be 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -252,11 +252,11 @@ static void rxclass_print_nfc_rule(struct ethtool_rx_flow_spec *fsp)
 		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
 
 		if (vf)
-			fprintf(stdout, "\tAction: Direct to queue %llu\n",
-				queue);
-		else
 			fprintf(stdout, "\tAction: Direct to VF %llu queue %llu\n",
 				vf, queue);
+		else
+			fprintf(stdout, "\tAction: Direct to queue %llu\n",
+				queue);
 	} else {
 		fprintf(stdout, "\tAction: Drop\n");
 	}
-- 
2.15.0

