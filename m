From: Alice Michael <alice.michael@intel.com>
Date: Thu, 28 Feb 2019 09:52:53 -0800
Subject: [Intel-wired-lan] [next PATCH S3 7/9] i40e: remove out-of-range
 comparisions in i40e_validate_cloud_filter
In-Reply-To: <20190228175255.54754-1-alice.michael@intel.com>
References: <20190228175255.54754-1-alice.michael@intel.com>
Message-ID: <20190228175255.54754-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The function i40e_validate_cloud_filter checks that the destination and
source port numbers are valid by attempting to ensure that the number is
non-zero and no larger than 0xFFFF. However, the types for the dst_port
and src_port variable are __be16 which by definition cannot be larger
than 0xFFFF

Since these values cannot be larger than 2 bytes, the check to see if
they exceed 0xFFFF is meaningless.

One might consider these checks as some sort of defensive coding, in
case the type was later changed. However, these checks also byte-swap
the value before comparision using be16_to_cpu, which will truncate the
values to 16bits anyways. Additionally, changing the type would require
updating the opcodes to support new data layout of these virtchnl
commands.

Remove the check to silence the -Wtype-limits warning that was added to
GCC 8.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 24628de8e624..925ca880bea3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3129,7 +3129,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	}
 
 	if (mask.dst_port & data.dst_port) {
-		if (!data.dst_port || be16_to_cpu(data.dst_port) > 0xFFFF) {
+		if (!data.dst_port) {
 			dev_info(&pf->pdev->dev, "VF %d: Invalid Dest port\n",
 				 vf->vf_id);
 			goto err;
@@ -3137,7 +3137,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 	}
 
 	if (mask.src_port & data.src_port) {
-		if (!data.src_port || be16_to_cpu(data.src_port) > 0xFFFF) {
+		if (!data.src_port) {
 			dev_info(&pf->pdev->dev, "VF %d: Invalid Source port\n",
 				 vf->vf_id);
 			goto err;
-- 
2.19.2

