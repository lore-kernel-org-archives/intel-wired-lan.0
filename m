From: Haiyue Wang <haiyue.wang@intel.com>
Date: Wed, 31 Mar 2021 10:08:36 +0800
Subject: [Intel-wired-lan] [Patch v1 2/3] iavf: enhance the duplicated FDIR
 list scan handling
In-Reply-To: <20210331020837.3640-1-haiyue.wang@intel.com>
References: <20210331020837.3640-1-haiyue.wang@intel.com>
Message-ID: <20210331020837.3640-2-haiyue.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When the FDIR entry is found, just return the result directly to break
the loop.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_fdir.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 3e687189d737..af872ea3163f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -713,7 +713,6 @@ void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *f
 bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr)
 {
 	struct iavf_fdir_fltr *tmp;
-	bool ret = false;
 
 	list_for_each_entry(tmp, &adapter->fdir_list_head, list) {
 		if (tmp->flow_type != fltr->flow_type)
@@ -724,13 +723,11 @@ bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *
 		    !memcmp(&tmp->ip_data, &fltr->ip_data,
 			    sizeof(fltr->ip_data)) &&
 		    !memcmp(&tmp->ext_data, &fltr->ext_data,
-			    sizeof(fltr->ext_data))) {
-			ret = true;
-			break;
-		}
+			    sizeof(fltr->ext_data)))
+			return true;
 	}
 
-	return ret;
+	return false;
 }
 
 /**
-- 
2.31.1

