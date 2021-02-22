From: Coiby Xu <coxu@redhat.com>
Date: Mon, 22 Feb 2021 15:07:01 +0800
Subject: [Intel-wired-lan] [RFC PATCH 4/4] i40e: don't open i40iw client for
 kdump
In-Reply-To: <20210222070701.16416-1-coxu@redhat.com>
References: <20210222070701.16416-1-coxu@redhat.com>
Message-ID: <20210222070701.16416-5-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
for 1GbE while "craskernel=auto" only reserved 160M. With the module
parameter "resource_profile=2", we can reduce the memory usage of i40iw
to ~300M which is still too much for kdump.

Disabling the client registration would spare us the client interface
operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
saved for kdump.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index a2dba32383f6..aafc2587f389 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/net/intel/i40e_client.h>
+#include <linux/crash_dump.h>
 
 #include "i40e.h"
 #include "i40e_prototype.h"
@@ -741,6 +742,12 @@ int i40e_register_client(struct i40e_client *client)
 {
 	int ret = 0;
 
+	/* Don't open i40iw client for kdump because i40iw will consume huge
+	 * amounts of memory.
+	 */
+	if (is_kdump_kernel())
+		return ret;
+
 	if (!client) {
 		ret = -EIO;
 		goto out;
-- 
2.30.1

