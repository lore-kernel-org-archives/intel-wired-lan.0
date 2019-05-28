From: Young Xiao <92siuyang@gmail.com>
Date: Tue, 28 May 2019 19:58:02 +0800
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix possible divide by zero in
 ixgbevf_update_itr
Message-ID: <1559044682-23446-1-git-send-email-92siuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The next call to ixgbevf_update_itr will continue to dynamically
update ITR.

Copy from commit bdbeefe8ea8c ("ixgbe: fix possible divide by zero in
ixgbe_update_itr")

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d189ed2..d2b41f9 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1423,6 +1423,9 @@ static void ixgbevf_update_itr(struct ixgbevf_q_vector *q_vector,
 	 */
 	/* what was last interrupt timeslice? */
 	timepassed_us = q_vector->itr >> 2;
+	if (timepassed_us == 0)
+		return;
+
 	bytes_perint = bytes / timepassed_us; /* bytes/usec */
 
 	switch (itr_setting) {
-- 
2.7.4

