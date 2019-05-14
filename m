From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 May 2019 10:37:08 -0700
Subject: [Intel-wired-lan] [next PATCH S5 iavf 10/11] iavf: add call to
 iavf_[add|del]_cloud_filter
In-Reply-To: <20190514173709.62431-1-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
Message-ID: <20190514173709.62431-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Add call to iavf_add_cloud_filter and iavf_del_cloud_filter from
iavf_process_aq_command to clear aq_required
IAVF_FLAG_AQ_ADD_CLOUD_FILTER and IAVF_FLAG_AQ_DEL_CLOUD_FILTER bits.

aq_required IAVF_FLAG_AQ_DEL_CLOUD_FILTER bit is being set in
iavf_down and iavf_delete_clsflower, and are never cleared.

aq_required IAVF_FLAG_AQ_ADD_CLOUD_FILTER bit is being set in
iavf_handle_reset and iavf_configure_clsflower, and are never
cleared.

Since the aq_required is not zero, iavf_watchdog_task is setting the
queue_delayed_work to 20 msec instead of the longer delay.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 8763486ff2b2..a833219c62d0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1658,7 +1658,14 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		iavf_del_cloud_filter(adapter);
 		return 0;
 	}
-
+	if (adapter->aq_required & IAVF_FLAG_AQ_DEL_CLOUD_FILTER) {
+		iavf_del_cloud_filter(adapter);
+		return 0;
+	}
+	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_CLOUD_FILTER) {
+		iavf_add_cloud_filter(adapter);
+		return 0;
+	}
 	return -EAGAIN;
 }
 
-- 
2.19.2

