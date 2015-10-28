From: Nicholas Krause <xerofoify@gmail.com>
Date: Tue, 27 Oct 2015 23:03:00 -0400
Subject: [Intel-wired-lan] [PATCH] i40evf:Add missing error check in the
	function i40evf_init_task
Message-ID: <1446001380-27744-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This adds the missing error check in the function i40evf_init_task
for checking the return value of the call to the function
i40evf_map_rings_to_vectors and if this function call does indeed
return a error code jump immediately to the goto label err_sw_init
in order to cleanup before returning to the caller rather then
continuing the function, i40evf_map_rings_to_vector's intended work
after this non recoverable failed function call.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index e85849b..cf1f3fd 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2264,7 +2264,9 @@ static void i40evf_init_task(struct work_struct *work)
 	err = i40evf_init_interrupt_scheme(adapter);
 	if (err)
 		goto err_sw_init;
-	i40evf_map_rings_to_vectors(adapter);
+	err = i40evf_map_rings_to_vectors(adapter);
+	if (err)
+		goto err_sw_init;
 	if (!RSS_AQ(adapter))
 		i40evf_configure_rss(adapter);
 	err = i40evf_request_misc_irq(adapter);
-- 
2.1.4

