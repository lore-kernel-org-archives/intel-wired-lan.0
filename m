From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  4 Jun 2015 16:23:59 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 5/8] i40evf:
	support virtual channel API version 1.1
In-Reply-To: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433449442-31420-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Store off the PF's API version, then use it to determine whether or not
to send it our capabilities. Change the version checking to allow for PF
drivers with lower API versions than our current version, so we can
still talk to PF drivers over the 1.0 API.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I8edc55d1229c7decf0ed3f285a63032694007c2e
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 6 ++++++
 drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index e2b7bf6..0d0ad3d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2130,6 +2130,12 @@ static void i40evf_init_task(struct work_struct *work)
 		if (err) {
 			if (err == I40E_ERR_ADMIN_QUEUE_NO_WORK)
 				err = i40evf_send_api_ver(adapter);
+			else
+				dev_err(&pdev->dev, "Unsupported PF API version %d.%d, expected %d.%d\n",
+					adapter->pf_version.major,
+					adapter->pf_version.minor,
+					I40E_VIRTCHNL_VERSION_MAJOR,
+					I40E_VIRTCHNL_VERSION_MINOR);
 			goto err;
 		}
 		err = i40evf_send_vf_config_msg(adapter);
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
index a37d56b..52c6959 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c
@@ -125,8 +125,11 @@ int i40evf_verify_api_ver(struct i40evf_adapter *adapter)
 	}
 
 	pf_vvi = (struct i40e_virtchnl_version_info *)event.msg_buf;
-	if ((pf_vvi->major != I40E_VIRTCHNL_VERSION_MAJOR) ||
-	    (pf_vvi->minor != I40E_VIRTCHNL_VERSION_MINOR))
+	adapter->pf_version = *pf_vvi;
+
+	if ((pf_vvi->major > I40E_VIRTCHNL_VERSION_MAJOR) ||
+	    ((pf_vvi->major == I40E_VIRTCHNL_VERSION_MAJOR) &&
+	     (pf_vvi->minor > I40E_VIRTCHNL_VERSION_MINOR)))
 		err = -EIO;
 
 out_alloc:
-- 
1.9.3

