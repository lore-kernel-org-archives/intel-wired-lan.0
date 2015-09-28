From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 28 Sep 2015 14:12:42 -0400
Subject: [Intel-wired-lan] [next PATCH S16 13/15] i40evf: relax and stagger
	init timing a bit
In-Reply-To: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443463964-148204-14-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

On some devices, in some systems, in some configurations, the VFs would
fail to initialize the first time you loaded the driver.

To correct this, increase the delay time for the init task slightly, and
wait longer before giving up.

If we enable VFs and load the VF driver in the same kernel as the PF
driver, we can totally overwhelm the PF driver with AQ requests because
all of the instances try to initialize at the same time.

To help alleviate this, stagger the initial scheduling of the init task
using the PCIe function as a multiplier. We mask off the function to
only three bits so no instance has to wait too long.

With these two changes, initializing 128 VFs on a single device goes
from four minutes to just a few seconds.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: If3d8720c1c4e838ab36d8781d9ec295a62380936
---
 drivers/net/ethernet/intel/i40evf/i40evf.h      | 2 +-
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index e18e413..d6cd2c8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -87,7 +87,7 @@ struct i40e_vsi {
 #define I40EVF_MAX_RXBUFFER   16384  /* largest size for single descriptor */
 #define I40EVF_MAX_AQ_BUF_SIZE    4096
 #define I40EVF_AQ_LEN             32
-#define I40EVF_AQ_MAX_ERR         10 /* times to try before resetting AQ */
+#define I40EVF_AQ_MAX_ERR         20 /* times to try before resetting AQ */
 
 #define MAXIMUM_ETHERNET_VLAN_SIZE (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 9e754d0..b943d93 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2344,7 +2344,7 @@ static void i40evf_init_task(struct work_struct *work)
 	}
 	return;
 restart:
-	schedule_delayed_work(&adapter->init_task, msecs_to_jiffies(20));
+	schedule_delayed_work(&adapter->init_task, msecs_to_jiffies(30));
 	return;
 
 err_register:
@@ -2361,7 +2361,7 @@ err:
 		adapter->flags |= I40EVF_FLAG_PF_COMMS_FAILED;
 		return; /* do not reschedule */
 	}
-	schedule_delayed_work(&adapter->init_task, HZ / 2);
+	schedule_delayed_work(&adapter->init_task, HZ);
 }
 
 /**
-- 
1.9.3

