From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 22 May 2018 03:51:00 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] i40iw/i40e:
 i40iw_open_inc_ref() can be static
In-Reply-To: <201805220348.Z5yGrkGk%fengguang.wu@intel.com>
References: <201805220348.Z5yGrkGk%fengguang.wu@intel.com>
Message-ID: <20180521195100.GA37206@lkp-sb05>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 34a1361d548d ("i40iw/i40e: Remove link dependency on i40e")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 i40iw_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index 65e1269..f4c5be1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -107,7 +107,7 @@ static struct notifier_block i40iw_netdevice_notifier = {
 /**
  * i40iw_open_inc_ref - Increment ref count for a open
  */
-void i40iw_open_inc_ref(void)
+static void i40iw_open_inc_ref(void)
 {
 	atomic_inc(&peer_drv.peer.ref_count);
 }
@@ -115,7 +115,7 @@ void i40iw_open_inc_ref(void)
 /**
  * i40iw_open_dec_ref - Decrement ref count for a open
  */
-void i40iw_open_dec_ref(void)
+static void i40iw_open_dec_ref(void)
 {
 	struct i40iw_peer *peer;
 
