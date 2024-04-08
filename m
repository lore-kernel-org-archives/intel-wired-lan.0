Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA7DC67861
	for <intel-wired-lan@archiver.kernel.org>; Mon,  8 Apr 2024 10:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C33481F07;
	Mon,  8 Apr 2024 10:26:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7jW4eExUHZZq; Mon,  8 Apr 2024 10:26:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B44EA8186B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712571997;
	bh=K9UGu1eeBfO8Wdstzv4WciRChRijdHvJoCCQ+1rddv0=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=IUJjAUeOJOJYrSCd8QSC1PCQ2zHOeuzpBS8ffAWsMf3bPI8R5aPeEAbyD3SVZH28G
	 3kzcWFtncLHtLEIoFp8wv6wgLGhDXQrCr1K0HX5w9Hn6CrWp8hh5m3oXrwZbpi6Wlt
	 yx9itnadqFxI/l+k1RkredM96wLHDe6BodPGOGuhRxnpMxtreqXttVrUqRq+hfIP2h
	 7VaBegwMZWhv+W4vlhLDB20achCN2JV/tdRwAlbzobBH7vvc/TcYmY70YouCXli18j
	 g2UC9/JpB41ZV+rmeimCTYZ/loQfuSUFZi/Nhdat7mkeSaDgJ0oGkc3ZdOKvO7m1CL
	 bw/k6C2Tkpo8w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B44EA8186B;
	Mon,  8 Apr 2024 10:26:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D052A1BF3CD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Apr 2024 10:26:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BD6B94072E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Apr 2024 10:26:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uddCRwq1KJlq for <intel-wired-lan@lists.osuosl.org>;
 Mon,  8 Apr 2024 10:26:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7ECB34068A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7ECB34068A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7ECB34068A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  8 Apr 2024 10:26:34 +0000 (UTC)
X-CSE-ConnectionGUID: gy4mzT8xQ8SBOBDDOiPKhg==
X-CSE-MsgGUID: SOekcl0rRiuOWvUoc5bodg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7944162"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7944162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 03:26:34 -0700
X-CSE-ConnectionGUID: AsEalNEzQ62iV7+ZRODjVA==
X-CSE-MsgGUID: zNgUswpzRK6NLckmLQMj8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19758590"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com)
 ([10.102.20.192])
 by orviesa009.jf.intel.com with ESMTP; 08 Apr 2024 03:26:32 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  8 Apr 2024 12:30:46 +0200
Message-ID: <20240408103049.19445-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240408103049.19445-1-michal.swiatkowski@linux.intel.com>
References: <20240408103049.19445-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712571994; x=1744107994;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+eYRoyhyJLahMH6dcT0og/m9egngowk5AKNVibDooXE=;
 b=aAZf7W/vVenA3AFyJuMuM74uuykb21ET1NtuUo5ZimBqrfePnU1slybY
 3UmIETNx1H48PjsrYvkMcPXvJmFLNuiDz+Eg1iOkI5JkNSDXIxvm3mSs0
 GvdKQ3Fhl7De5G2Q7UfHjbQ6VnqDWF9tWCY4c3I4s8tT2wyuwh0+Wa16C
 3x7WXjfNwYbeh1ymGaiucI7euswxnSdnZ4g4tnsFah0h/efQiu7Bl0z+W
 T70TG7sGnMoBeVQ0Mm7369+Lfh8if9eSIe13x5upplQLesM0L3xADgJWv
 L5FHG9vZp49G0FVCMgB5kIPcfq6f5N2gW9IMe+Yo9zwyZVI3i6LXgXpe9
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aAZf7W/v
Subject: [Intel-wired-lan] [iwl-next v1 4/7] ice: allocate devlink for
 subfunction
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 jiri@nvidia.com, michal.kubiak@intel.com, pio.raczynski@gmail.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 wojciech.drewek@intel.com, Piotr Raczynski <piotr.raczynski@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Piotr Raczynski <piotr.raczynski@intel.com>

Make devlink allocation function generic to use it for PF and for SF.

Add function for SF devlink port creation. It will be used in next
patch.

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 39 ++++++++++++--
 .../net/ethernet/intel/ice/devlink/devlink.h  |  1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 51 +++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  3 ++
 4 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 661af04c8eef..05a752fec316 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -10,6 +10,7 @@
 #include "ice_eswitch.h"
 #include "ice_fw_update.h"
 #include "ice_dcb_lib.h"
+#include "ice_sf_eth.h"
 
 /* context for devlink info version reporting */
 struct ice_info_ctx {
@@ -1286,6 +1287,8 @@ static const struct devlink_ops ice_devlink_ops = {
 	.port_new = ice_devlink_port_new,
 };
 
+static const struct devlink_ops ice_sf_devlink_ops;
+
 static int
 ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 			    struct devlink_param_gset_ctx *ctx)
@@ -1417,14 +1420,17 @@ static void ice_devlink_free(void *devlink_ptr)
 }
 
 /**
- * ice_allocate_pf - Allocate devlink and return PF structure pointer
+ * ice_devlink_alloc - Allocate devlink and return devlink priv pointer
  * @dev: the device to allocate for
+ * @priv_size: size of the priv memory
+ * @ops: pointer to devlink ops for this device
  *
- * Allocate a devlink instance for this device and return the private area as
- * the PF structure. The devlink memory is kept track of through devres by
- * adding an action to remove it when unwinding.
+ * Allocate a devlink instance for this device and return the private pointer
+ * The devlink memory is kept track of through devres by adding an action to
+ * remove it when unwinding.
  */
-struct ice_pf *ice_allocate_pf(struct device *dev)
+static void *ice_devlink_alloc(struct device *dev, size_t priv_size,
+			       const struct devlink_ops *ops)
 {
 	struct devlink *devlink;
 
@@ -1439,6 +1445,29 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
 	return devlink_priv(devlink);
 }
 
+/**
+ * ice_allocate_pf - Allocate devlink and return PF structure pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for PF.
+ */
+struct ice_pf *ice_allocate_pf(struct device *dev)
+{
+	return ice_devlink_alloc(dev, sizeof(struct ice_pf), &ice_devlink_ops);
+}
+
+/**
+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for SF.
+ */
+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
+{
+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
+				 &ice_sf_devlink_ops);
+}
+
 /**
  * ice_devlink_register - Register devlink interface for this PF
  * @pf: the PF to register the devlink for.
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
index d291c0e2e17b..1b2a5980d5e8 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
@@ -5,6 +5,7 @@
 #define _ICE_DEVLINK_H_
 
 struct ice_pf *ice_allocate_pf(struct device *dev);
+struct ice_sf_priv *ice_allocate_sf(struct device *dev);
 
 void ice_devlink_register(struct ice_pf *pf);
 void ice_devlink_unregister(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index f5e305a71bd0..1b933083f551 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -432,6 +432,57 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 	devlink_port_unregister(&vf->devlink_port);
 }
 
+/**
+ * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
+ * @sf_dev: the subfunction device to create a devlink port for
+ *
+ * Register virtual flavour devlink port for the subfunction auxiliary device
+ * created after activating a dynamically added devlink port.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
+{
+	struct devlink_port_attrs attrs = {};
+	struct devlink_port *devlink_port;
+	struct ice_dynamic_port *dyn_port;
+	struct devlink *devlink;
+	struct ice_vsi *vsi;
+	struct device *dev;
+	struct ice_pf *pf;
+	int err;
+
+	dyn_port = sf_dev->dyn_port;
+	vsi = dyn_port->vsi;
+	pf = dyn_port->pf;
+	dev = ice_pf_to_dev(pf);
+
+	devlink_port = &sf_dev->priv->devlink_port;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+	devlink = priv_to_devlink(sf_dev->priv);
+
+	err = devl_port_register(devlink, devlink_port, vsi->idx);
+	if (err)
+		dev_err(dev, "Failed to create virtual devlink port for auxiliary subfunction device %d",
+			vsi->idx);
+
+	return err;
+}
+
+/**
+ * ice_devlink_destroy_sf_dev_port - Destroy virtual port for a subfunction
+ * @sf_dev: the subfunction device to create a devlink port for
+ *
+ * Unregisters the virtual port associated with this subfunction.
+ */
+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
+{
+	devl_port_unregister(&sf_dev->priv->devlink_port);
+}
+
 /**
  * ice_activate_dynamic_port - Activate a dynamic port
  * @dyn_port: dynamic port instance to activate
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
index 30146fef64b9..1f66705e0261 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -5,6 +5,7 @@
 #define _DEVLINK_PORT_H_
 
 #include "../ice.h"
+#include "ice_sf_eth.h"
 
 /**
  * struct ice_dynamic_port - Track dynamically added devlink port instance
@@ -30,6 +31,8 @@ int ice_devlink_create_pf_port(struct ice_pf *pf);
 void ice_devlink_destroy_pf_port(struct ice_pf *pf);
 int ice_devlink_create_vf_port(struct ice_vf *vf);
 void ice_devlink_destroy_vf_port(struct ice_vf *vf);
+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
+void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev);
 
 #define ice_devlink_port_to_dyn(p) \
 	container_of(port, struct ice_dynamic_port, devlink_port)
-- 
2.42.0

