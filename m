From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 13 Jan 2018 06:44:10 +0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher-next-queue] i40evf:
 i40evf_print_cloud_filter() can be static
In-Reply-To: <201801130638.l7ZonX3c%fengguang.wu@intel.com>
References: <201801130638.l7ZonX3c%fengguang.wu@intel.com>
Message-ID: <20180112224410.GA47685@xian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Fixes: 2b7317305ce9 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 i40evf_virtchnl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index 3102261..ff3d681 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -1047,8 +1047,8 @@ void i40evf_disable_channels(struct i40evf_adapter *adapter)
  *
  * Print the cloud filter
  **/
-void i40evf_print_cloud_filter(struct i40evf_adapter *adapter,
-			       struct virtchnl_filter f)
+static void i40evf_print_cloud_filter(struct i40evf_adapter *adapter,
+				      struct virtchnl_filter f)
 {
 	switch (f.flow_type) {
 	case VIRTCHNL_TCP_V4_FLOW:
