From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Mon, 30 Aug 2021 08:25:36 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor
 iavf_mac_filter struct memory usage
Message-ID: <20210830082536.274203-1-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

iavf_mac_filter struct contained couple boolean
flags using up more memory than is necessary.
Change the flags to be bitfields in an anonymous struct
so all the flags now fit in one byte.

Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 21c95775509a..3feb9edb8131 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -137,9 +137,13 @@ struct iavf_q_vector {
 struct iavf_mac_filter {
 	struct list_head list;
 	u8 macaddr[ETH_ALEN];
-	bool is_new_mac;	/* filter is new, wait for PF decision */
-	bool remove;		/* filter needs to be removed */
-	bool add;		/* filter needs to be added */
+	struct {
+		u8 is_new_mac:1;    /* filter is new, wait for PF decision */
+		u8 remove:1;        /* filter needs to be removed */
+		u8 add:1;           /* filter needs to be added */
+		u8 is_primary:1;    /* filter is a default VF MAC */
+		u8 padding:4;
+	};
 };
 
 struct iavf_vlan_filter {
-- 
2.27.0

