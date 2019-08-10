From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sat, 10 Aug 2019 12:17:29 +0200
Subject: [Intel-wired-lan] [PATCH v3 14/17] fm10k: no need to check return
 value of debugfs_create functions
In-Reply-To: <20190810101732.26612-1-gregkh@linuxfoundation.org>
References: <20190810101732.26612-1-gregkh@linuxfoundation.org>
Message-ID: <20190810101732.26612-15-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: intel-wired-lan at lists.osuosl.org
Cc: netdev at vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index dca104121c05..1d27b2fb23af 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -160,8 +160,6 @@ void fm10k_dbg_q_vector_init(struct fm10k_q_vector *q_vector)
 	snprintf(name, sizeof(name), "q_vector.%03d", q_vector->v_idx);
 
 	q_vector->dbg_q_vector = debugfs_create_dir(name, interface->dbg_intfc);
-	if (!q_vector->dbg_q_vector)
-		return;
 
 	/* Generate a file for each rx ring in the q_vector */
 	for (i = 0; i < q_vector->tx.count; i++) {
-- 
2.22.0

