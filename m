From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  4 Jun 2021 09:48:57 -0700
Subject: [Intel-wired-lan] [PATCH net 5/8] iavf: prevent accidental free of
 filter structure
In-Reply-To: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
References: <20210604164900.33156-1-anthony.l.nguyen@intel.com>
Message-ID: <20210604164900.33156-5-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In iavf_config_clsflower, the filter structure could be accidentally
released at the end, if iavf_parse_cls_flower or iavf_handle_tclass ever
return a non-zero but positive value.

In this case, the function continues through to the end, and will call
kfree() on the filter structure even though it has been added to the
linked list.

This can actually happen because iavf_parse_cls_flower will return
a positive IAVF_ERR_CONFIG value instead of the traditional negative
error codes.

Fix this by ensuring that the kfree() check and error checks are
similar. Use the more idiomatic "if (err)" to catch all non-zero error
codes.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ffffb6e0a6c1..bb533e9781ee 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3040,11 +3040,11 @@ static int iavf_configure_clsflower(struct iavf_adapter *adapter,
 	/* start out with flow type and eth type IPv4 to begin with */
 	filter->f.flow_type = VIRTCHNL_TCP_V4_FLOW;
 	err = iavf_parse_cls_flower(adapter, cls_flower, filter);
-	if (err < 0)
+	if (err)
 		goto err;
 
 	err = iavf_handle_tclass(adapter, tc, filter);
-	if (err < 0)
+	if (err)
 		goto err;
 
 	/* add filter to the list */
-- 
2.20.1

