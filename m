From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 17 Jun 2019 16:10:58 -0700
Subject: [Intel-wired-lan] [net-next ] iavf: Fix up debug print macro
Message-ID: <20190617231058.15343-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This aligns the iavf_debug() macro with the other Intel drivers.

Add the bus number, bus_id field to i40e_bus_info so output shows
each physical port(i.e func) in following format:
  [[[[<domain>]:]<bus>]:][<slot>][.[<func>]]
domains are numbered from 0 to ffff), bus (0-ff), slot (0-1f) and
function (0-7).

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_osdep.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_osdep.h b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
index d39684558597..a452ce90679a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_osdep.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
@@ -44,8 +44,12 @@ struct iavf_virt_mem {
 #define iavf_allocate_virt_mem(h, m, s) iavf_allocate_virt_mem_d(h, m, s)
 #define iavf_free_virt_mem(h, m) iavf_free_virt_mem_d(h, m)
 
-#define iavf_debug(h, m, s, ...)  iavf_debug_d(h, m, s, ##__VA_ARGS__)
-extern void iavf_debug_d(void *hw, u32 mask, char *fmt_str, ...)
-	__printf(3, 4);
+#define iavf_debug(h, m, s, ...)				\
+do {								\
+	if (((m) & (h)->debug_mask))				\
+		pr_info("iavf %02x:%02x.%x " s,			\
+			(h)->bus.bus_id, (h)->bus.device,	\
+			(h)->bus.func, ##__VA_ARGS__);		\
+} while (0)
 
 #endif /* _IAVF_OSDEP_H_ */
-- 
2.21.0

