From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Date: Mon, 16 Aug 2021 18:07:14 +0200
Subject: [Intel-wired-lan] [RFC net-next 4/7] net: add ioctl interface for
 recover reference clock on netdev
In-Reply-To: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
References: <20210816160717.31285-1-arkadiusz.kubalewski@intel.com>
Message-ID: <20210816160717.31285-5-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previously there was no similar interface. It is required for
configuration of Synchronous Ethernet (SyncE).

User must be able to enable or disable propagation of its
PHY recovered clock signal onto available output pin.
This allows the signal to be used as frequency reference signal
for different hardware chips.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 include/uapi/linux/net_synce.h | 21 +++++++++++++++++++++
 include/uapi/linux/sockios.h   |  4 ++++
 net/core/dev_ioctl.c           |  6 +++++-
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/net_synce.h

diff --git a/include/uapi/linux/net_synce.h b/include/uapi/linux/net_synce.h
new file mode 100644
index 000000000000..a482a7e43151
--- /dev/null
+++ b/include/uapi/linux/net_synce.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace API for synchronous ethernet configuration
+ *
+ * Copyright (C) 2021 Intel Corporation
+ * Author: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
+ *
+ */
+#ifndef _NET_SYNCE_H
+#define _NET_SYNCE_H
+#include <linux/types.h>
+
+/*
+ * Structure used for passing data with SIOCSSYNCE and SIOCGSYNCE ioctls
+ */
+struct synce_ref_clk_cfg {
+	__u8 pin_id;
+	_Bool enable;
+};
+
+#endif /* _NET_SYNCE_H */
diff --git a/include/uapi/linux/sockios.h b/include/uapi/linux/sockios.h
index 7d1bccbbef78..32c7d4909c31 100644
--- a/include/uapi/linux/sockios.h
+++ b/include/uapi/linux/sockios.h
@@ -153,6 +153,10 @@
 #define SIOCSHWTSTAMP	0x89b0		/* set and get config		*/
 #define SIOCGHWTSTAMP	0x89b1		/* get config			*/
 
+/* synchronous ethernet config per physical function */
+#define SIOCSSYNCE	0x89c0		/* set and get config           */
+#define SIOCGSYNCE	0x89c1		/* get config                   */
+
 /* Device private ioctl calls */
 
 /*
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 0e87237fd871..fe21365c9492 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -406,7 +406,9 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		    cmd == SIOCGMIIREG ||
 		    cmd == SIOCSMIIREG ||
 		    cmd == SIOCSHWTSTAMP ||
-		    cmd == SIOCGHWTSTAMP) {
+		    cmd == SIOCGHWTSTAMP ||
+		    cmd == SIOCSSYNCE ||
+		    cmd == SIOCGSYNCE) {
 			err = dev_eth_ioctl(dev, ifr, cmd);
 		} else if (cmd == SIOCBONDENSLAVE ||
 		    cmd == SIOCBONDRELEASE ||
@@ -577,6 +579,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	case SIOCBRADDIF:
 	case SIOCBRDELIF:
 	case SIOCSHWTSTAMP:
+	case SIOCSSYNCE:
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 		fallthrough;
@@ -605,6 +608,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	default:
 		if (cmd == SIOCWANDEV ||
 		    cmd == SIOCGHWTSTAMP ||
+		    cmd == SIOCGSYNCE ||
 		    (cmd >= SIOCDEVPRIVATE &&
 		     cmd <= SIOCDEVPRIVATE + 15)) {
 			dev_load(net, ifr->ifr_name);
-- 
2.24.0

