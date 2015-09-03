From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:19:01 -0400
Subject: [Intel-wired-lan] [next PATCH S15 14/15] i40evf: speed up init
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-15-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Shorten up the delays in the init task, allowing the VF driver to
initialize faster. This aids performance in load/unload tests and
mitigates DMAR errors in VF enable/disable tests with absurdly short
delays. In the real world, the VF driver will come up more quickly.

The original values were set conservatively based on what we expected
from the firmware in terms of performance. Now that the driver is in use
and we know how well firmware responds to our requests, we can shorten
these delays.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Ibead77d34b19e8170e667c3f58bc14748bbc5bc9
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index f156226..bccca50 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2315,7 +2315,7 @@ static void i40evf_init_task(struct work_struct *work)
 	}
 	return;
 restart:
-	schedule_delayed_work(&adapter->init_task, msecs_to_jiffies(30));
+	schedule_delayed_work(&adapter->init_task, msecs_to_jiffies(20));
 	return;
 
 err_register:
@@ -2332,7 +2332,7 @@ err:
 		adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
 		return; /* do not reschedule */
 	}
-	schedule_delayed_work(&adapter->init_task, HZ * 3);
+	schedule_delayed_work(&adapter->init_task, HZ / 2);
 }
 
 /**
-- 
1.9.3

