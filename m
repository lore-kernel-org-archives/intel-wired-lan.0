From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:48:55 -0700
Subject: [Intel-wired-lan] [PATCH net 3/8] iavf: don't clear a lock we don't
 hold
In-Reply-To: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604164900.33156-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Nicholas Nunley <nicholas.d.nunley@intel.com>

In iavf_configure_clsflower() the function will bail out if it is unable
to obtain the crit_section lock in a reasonable time. However, it will
clear the lock when exiting, so fix this.

Fixes: 640a8af5841f ("i40evf: Reorder configure_clsflower to avoid deadlock on error")
Signed-off-by: Nicholas Nunley <nicholas.d.nunley@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 989de52658dc..58624be64010 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3027,8 +3027,10 @@ static int iavf_configure_clsflower(struct iavf_adapter *adapter,
 
 	while (test_and_set_bit(__IAVF_IN_CRITICAL_TASK,
 				&adapter->crit_section)) {
-		if (--count == 0)
-			goto err;
+		if (--count == 0) {
+			kfree(filter);
+			return err;
+		}
 		udelay(1);
 	}
 
-- 
2.20.1

