From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Mar 2017 00:46:06 -0700
Subject: [Intel-wired-lan] [next S65 1/3 v2] i40e: remove client instance on
	driver unload
Message-ID: <20170330074608.52108-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

When the driver is unloaded, we need to remove the client instance,
otherwise we leak memory.

Testing Hints (required if no HSD): On OFED 4.x, do "driverctl
unset-override".

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: If1e7882ac1f6ce15d004722fafbe31afbe0adc9a
---
 drivers/net/ethernet/intel/i40e/i40e_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
index 191028b1489b..d05296a7078e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -459,6 +459,9 @@ int i40e_lan_del_device(struct i40e_pf *pf)
 	struct i40e_device *ldev, *tmp;
 	int ret = -ENODEV;
 
+	/* First, remove any client instance. */
+	i40e_client_del_instance(pf);
+
 	mutex_lock(&i40e_device_mutex);
 	list_for_each_entry_safe(ldev, tmp, &i40e_devices, list) {
 		if (ldev->pf == pf) {
-- 
2.12.0

