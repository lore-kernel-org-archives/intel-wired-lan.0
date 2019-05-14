From: Alice Michael <alice.michael@intel.com>
Date: Tue, 14 May 2019 10:37:03 -0700
Subject: [Intel-wired-lan] [next PATCH S5 iavf 05/11] iavf: Fix the math for
 valid length for ADq enable
In-Reply-To: <20190514173709.62431-1-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
Message-ID: <20190514173709.62431-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

There was a calculation error in virtchnl regarding the valid
length which was fixed recently and a corresponding change needs
to go into the code while we enable ADq.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 3eea35cee25a..dd97509e2da1 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -983,7 +983,7 @@ void iavf_enable_channels(struct iavf_adapter *adapter)
 		return;
 	}
 
-	len = (adapter->num_tc * sizeof(struct virtchnl_channel_info)) +
+	len = ((adapter->num_tc - 1) * sizeof(struct virtchnl_channel_info)) +
 	       sizeof(struct virtchnl_tc_info);
 
 	vti = kzalloc(len, GFP_KERNEL);
-- 
2.19.2

