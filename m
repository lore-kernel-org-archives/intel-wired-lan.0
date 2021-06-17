From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Fri, 18 Jun 2021 01:44:02 +0200
Subject: [Intel-wired-lan] [PATCH net-next 01/12] ice: basic support for
 eswitch mode management
In-Reply-To: <20210617234413.104069-1-michal.swiatkowski@linux.intel.com>
References: <20210617234413.104069-1-michal.swiatkowski@linux.intel.com>
Message-ID: <20210617234413.104069-2-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Write set and get eswitch mode functions used by devlink
ops. Use new pf struct member eswitch_mode to track current
eswitch mode in driver.

Changing eswitch mode is only allowed when there are no
VFs created.

Create new file for eswitch related code.

Add config flag ICE_SWITCHDEV to allow user to choose if
switchdev support should be enabled or disabled.

Use case examples:
- show current eswitch mode ('legacy' is the default one)
[root at localhost]# devlink dev eswitch show pci/0000:03:00.1
>pci/0000:03:00.1: mode legacy

- move to 'switchdev' mode
[root at localhost]# devlink dev eswitch set pci/0000:03:00.1 mode
switchdev
[root at localhost]# devlink dev eswitch show pci/0000:03:00.1
>pci/0000:03:00.1: mode switchdev

- create 2 VFs
[root at localhost]# echo 2 > /sys/class/net/ens4f1/device/sriov_numvfs

- unsuccessful attempt to change eswitch mode while VFs are created
[root at localhost]# devlink dev eswitch set pci/0000:03:00.1 mode legacy
>devlink answers: Operation not supported

- destroy VFs
[root at localhost]# echo 0 > /sys/class/net/ens4f1/device/sriov_numvfs

- restore 'legacy' mode
[root at localhost]# devlink dev eswitch set pci/0000:03:00.1 mode legacy
[root at localhost]# devlink dev eswitch show pci/0000:03:00.1
>pci/0000:03:00.1: mode legacy

Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/Kconfig           | 10 ++++
 drivers/net/ethernet/intel/ice/Makefile      |  1 +
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_devlink.c |  3 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 62 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h | 34 +++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_eswitch.h

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 3639cf79cfae..4da8b3930f6e 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -313,6 +313,16 @@ config ICE
 	  To compile this driver as a module, choose M here. The module
 	  will be called ice.
 
+config ICE_SWITCHDEV
+	bool "Switchdev Support"
+	default y
+	depends on ICE && NET_SWITCHDEV
+	help
+	  Say Y here if you want to use Switchdev in the
+	  driver.
+
+	  If unsure, say N.
+
 config FM10K
 	tristate "Intel(R) FM10000 Ethernet Switch Host Interface Support"
 	default n
diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 4f538cdf42c1..0545594c80ba 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -33,3 +33,4 @@ ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o
 ice-$(CONFIG_DCB) += ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
 ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
 ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
+ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f4729caccbe9..729d375fbebc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -430,6 +430,7 @@ struct ice_pf {
 
 	struct ice_vsi **vsi;		/* VSIs created by the driver */
 	struct ice_sw *first_sw;	/* first switch created by firmware */
+	u16 eswitch_mode;		/* current mode of eswitch */
 	/* Virtchnl/SR-IOV config info */
 	struct ice_vf *vf;
 	u16 num_alloc_vfs;		/* actual number of VFs allocated */
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index d69507d57de1..de6d0a8ba1a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -4,6 +4,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_devlink.h"
+#include "ice_eswitch.h"
 #include "ice_fw_update.h"
 
 /* context for devlink info version reporting */
@@ -423,6 +424,8 @@ ice_devlink_flash_update(struct devlink *devlink,
 
 static const struct devlink_ops ice_devlink_ops = {
 	.supported_flash_update_params = DEVLINK_SUPPORT_FLASH_UPDATE_OVERWRITE_MASK,
+	.eswitch_mode_get = ice_eswitch_mode_get,
+	.eswitch_mode_set = ice_eswitch_mode_set,
 	.info_get = ice_devlink_info_get,
 	.flash_update = ice_devlink_flash_update,
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
new file mode 100644
index 000000000000..1370c41b77ab
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019-2021, Intel Corporation. */
+
+#include "ice.h"
+#include "ice_eswitch.h"
+#include "ice_devlink.h"
+
+/**
+ * ice_eswitch_mode_set - set new eswitch mode
+ * @devlink: pointer to devlink structure
+ * @mode: eswitch mode to switch to
+ * @extack: pointer to extack structure
+ */
+int
+ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
+		     struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+	if (pf->eswitch_mode == mode)
+		return 0;
+
+	if (pf->num_alloc_vfs) {
+		dev_info(ice_pf_to_dev(pf), "Changing eswitch mode is allowed only if there is no VFs created");
+		NL_SET_ERR_MSG_MOD(extack, "Changing eswitch mode is allowed only if there is no VFs created");
+		return -EOPNOTSUPP;
+	}
+
+	switch (mode) {
+	case DEVLINK_ESWITCH_MODE_LEGACY:
+		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to legacy",
+			 pf->hw.pf_id);
+		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
+		break;
+	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
+	{
+		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
+			 pf->hw.pf_id);
+		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");
+		break;
+	}
+	default:
+		NL_SET_ERR_MSG_MOD(extack, "Unknown eswitch mode");
+		return -EINVAL;
+	}
+
+	pf->eswitch_mode = mode;
+	return 0;
+}
+
+/**
+ * ice_eswitch_mode_get - get current eswitch mode
+ * @devlink: pointer to devlink structure
+ * @mode: output parameter for current eswitch mode
+ */
+int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+
+	*mode = pf->eswitch_mode;
+	return 0;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
new file mode 100644
index 000000000000..0aa6fb7e0c4e
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019-2021, Intel Corporation. */
+
+#ifndef _ICE_ESWITCH_H_
+#define _ICE_ESWITCH_H_
+#include <net/devlink.h>
+
+#ifdef CONFIG_ICE_SWITCHDEV
+int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode);
+int
+ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
+		     struct netlink_ext_ack *extack);
+bool ice_is_eswitch_mode_switchdev(struct ice_pf *pf);
+#else /* CONFIG_ICE_SWITCHDEV */
+static inline int
+ice_eswitch_mode_get(struct devlink *devlink, u16 *mode)
+{
+	return DEVLINK_ESWITCH_MODE_LEGACY;
+}
+
+static inline int
+ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
+		     struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool
+ice_is_eswitch_mode_switchdev(struct ice_pf *pf)
+{
+	return false;
+}
+#endif /* CONFIG_ICE_SWITCHDEV */
+#endif
-- 
2.30.2

