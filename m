Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9008606D827
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=6SNw13U5;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PEEXYBaB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC5E260841;
	Tue,  3 Nov 2026 14:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wT3ETYXtK3od; Tue,  3 Nov 2026 14:39:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C0F18607BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716794;
	b=CIfYP3gBp0t40V+73vhIcaSROxrzpgq7M3HmyBzWmW21YmcLOIqfBtlA98eVShMuGOKH
	 kQxxzHSVG5/DrWpKaaepuVahJIk1d305ypoykmMsGPnv+lRT0jgVsK4eSl99tj8sSPRBu
	 gvuQ2gfWLh+BlDJv7kgllyPAjoHpFZgDh5mwRtGX8LDb2x1I3Z5DK90tZYJ9tyRk+eP7F
	 r1TI+wzbZdqGgpO2BpKXpOSFWwJYNnrYMOyA+o0mL4hrxdgcKedu0Cp3i7zArylukN+Ne
	 p3sWPAKsiCd8Up4aVTL94XPc7EYUSA+EATOfxvy5yRH1+CROos9ZLkGvIP+B/d/RpKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716794;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=KNzQRlqQm5MpoUtIBb/pVv9eXGoBbxC+11RPAIam9fk=;
	b=bdsO48wYpreN/S7TvGfrgYiS5YTQXzMltIu1jnI7zD0swghsz6UHoUvJ4ZsD9eXgsbrF
	 jb/3oNU4Luc7cUYl0J/uiz5pREIVzcV5gZPJpRFql+LtgmvCqSsjeEy6rfAQM7zIxFQT6
	 PrZC0Q5Pkm4oGmhDEpeaDjtNA65aiyoWdGIVtpDLiB85XljRmTOwD0rhaALlPiZ3Ko3cD
	 kO3LKAfX2nK7rJnizEvdLoYRS7ocTd9Vb2Npf1itjDS22GduWkQTfiLi4y3dywPW1dmQe
	 +Rg46JqQRFIbLBI2xEB6KU10oBNqQczN1JeSQzobKT6z1Zx5PaVfMgZtCZJ/t6vDBvg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716794;
	bh=KNzQRlqQm5MpoUtIBb/pVv9eXGoBbxC+11RPAIam9fk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6SNw13U5rdACto2/fA3+/QKDP50A0pLhcsWL5ly6tR27Xk4Mk+ZAOZ+VUIFdJeNHx
	 TLyoVPl0nMA+2mAzf5JeQV0oi+lg9ej9PAPk6ARC0Jl7vDjuHEuOuf/lOb4cyaRk5W
	 VHupnknDwY4G4dttBc+49K2W/Yh5psB6tFiKxiaYbSbPNxCeRIHIFY4MMXVvF70hPf
	 bEYgEsQIvtCFlyCERW7LfE8DE8AzB2g0SevgON6N2XUpJcKTJDJikHPOcpSJox/jUj
	 iNjL3uJINJemqRsXIzjphiLSTSgxc6RzoqUnNbQTsXX14Y4BEdzN7DsVw0X24dnrej
	 ypTOuttxlWAzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0F18607BE;
	Tue,  3 Nov 2026 14:39:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE89235
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82B02406FA
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nD8IDXQTenfg for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:39:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 41FBB4070A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716791;
 b=Sp+bxMO+BCU65nZKbCS9blrW++1UIU3SQ+1KmE2uMqBCL1DoN2ZKKsJtvBmkD9cgy+Xk
 elI55u1gp4P3E4ss9aRViV+F5x2dbh0IZNWiLdxPPu8vogple+6rUvtTm7ObKOn3n2t1q
 UihfUDs02kYYbB8lqFqPIdekt5DUuSGJ/1Ink9OdZJ3t/8BSOBIjPCOl6QYox5Uu+rihA
 5wA3DRfjL8D7OZEfFeVOqCtJqQQydjdua3ouCj7WuIcJDz/oBBrCVMtoSTpWCKhoPy6ak
 9EcdxXeSkj0oe2vjFVcXkkxbTU5d7K1zuWiKi0/+SWXVXo1UAH2SlDIHYfGJHjH7y+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716791;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=KNzQRlqQm5MpoUtIBb/pVv9eXGoBbxC+11RPAIam9fk=;
 b=qFolzIG5bUV0XDaeVu8e9Wtz+mtlP/hp6yJCxKXIC4ZFXe5Y/G7LfxWjywCTxzC88Sqx
 2XIX8lruu/njcZitCNaGsjpfYLXCCuhiNWN/r2PprU2X6RyyEsurC75XSsLTgPp5NyJAI
 osjll7/enXbDt4tgxpaB+UgV+GGI+Ebo+2E9Qi+xGf6WwutkUaLUxniC+odhg3fGryNSD
 lOQiI52kRW+X99tpk3Gaoc37AZbhjSKQ0GxK5J4C10Ol14UDs86IFKJM6XMESiZoXClxE
 SLLb5rq73UcS1cgeyiCmQOA7vjEaFePk0Gvp1mkvqMXBayJmTzeMSf7HgHYpY/9CCnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PEEXYBaB; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PEEXYBaB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41FBB4070A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716791; x=1825252791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UCQ/iBpx7rr25JaoOqKtihqOvNZtNeX2zAy5GzhxztY=;
 b=PEEXYBaBPdzQYhLJVJN8ErgJIV6rvbqY6cc1+ab+7cGK/W9sGvgUVnkL
 M2Y/DJrW5Onx7V3TpxhZTRYu4g/Ycl9XtnqUy+f4dhOKoODwmlnmpUAaQ
 7G1A1FdmT/D6xgxe029nWa1S8/h99O0MKyZ9VOWdQ8pB3XYPiHWZH/2J3
 zbpsstKeVh1f9h/FRWv3sTjvNRPH0H+gZve+PdBxwUgjOzhXcLHtEIMwL
 jEa2lPi7+S1Ku/BMXADTV4nemjrlAgQEYG7bPozyiwHF3ah91L6AoWtQR
 UVWOnd1/sr4B6Y1w3MI6EpichrP8NiNMumUnGO0aLIsLl0cJfxQpKvtvl g==;
X-CSE-ConnectionGUID: PtRRSI3AQLi3DEGM3O99Mw==
X-CSE-MsgGUID: 2OYewhUNSi+BfjAHVla0MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324001"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324001"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:39:49 -0800
X-CSE-ConnectionGUID: LU864/xPQECCQEKcmbn9Qg==
X-CSE-MsgGUID: vKKE43I3TIacxtdzmSOqDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289856"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:43 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 3D8E6312EA;
 Tue,  3 Nov 2026 14:39:39 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v4 02/15] ice: use shared devlink to store
 ice_adapters instead of custom xarray
Date: Tue,  3 Nov 2026 15:14:43 +0100
Message-ID: <20261103141646.303620-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Refactor our storage and deduplication logic of ice_adapters by moving
it to be handled by shared devlink instance, recently added by
Jiri Pirko [1].

We wanted the devlink instance for whole device anyway - later in the
series I will add devlink resources under it.

Make the shared devlink a parent (wrt. nesting) of the actual PF devices.

[1] commit 411ad0605875 ("Merge branch 'devlink-introduce-shared-devlink-instance-for-pfs-on-same-chip'")
[1] https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us

Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
CC: Grzegorz Nitka <grzegorz.nitka@intel.com>

v2:
 * propagate the error from devlink_shd_get() with ERR_CAST()
 * minor kdoc updates
 * check devl_nested_devlink_set() return value, ice_devlink_register()
   returns int now (Sashiko)
 * prefix the shared devlink id with "ice:", to avoid collisions with
   ids used by other drivers (Sashiko)

Sashiko suggestions I don't want to apply:
 S: all PFs without DSN get index 0, and so share one instance
 me: pre-existing, and DSN 0 is only on pre-production samples
---
 .../net/ethernet/intel/ice/devlink/devlink.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  12 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  11 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 106 ++++++------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  11 +-
 5 files changed, 57 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.h b/drivers/net/ethernet/intel/ice/devlink/devlink.h
index 1af3b0763fbb..62af38d11fd9 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.h
@@ -7,7 +7,7 @@
 struct ice_pf *ice_allocate_pf(struct device *dev);
 struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf);
 
-void ice_devlink_register(struct ice_pf *pf);
+int ice_devlink_register(struct ice_pf *pf);
 void ice_devlink_unregister(struct ice_pf *pf);
 int ice_devlink_register_params(struct ice_pf *pf);
 void ice_devlink_unregister_params(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index c61bd645e460..cdad45e8e81b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -8,7 +8,8 @@
 #include <linux/mutex.h>
 #include <linux/srcu.h>
 #include <linux/spinlock_types.h>
-#include <linux/refcount_types.h>
+
+#include <net/devlink.h>
 
 #include "ice_type.h"
 
@@ -35,31 +36,30 @@ struct ice_port_list {
 
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
- * @refcount: Reference count. struct ice_pf objects hold the references.
+ * @devlink: ice adapter's devlink (whole dev devlink)
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
  * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
- * @index: 64-bit index cached for collision detection on 32bit systems
  */
 struct ice_adapter {
-	refcount_t refcount;
+	struct devlink *devlink;
+
 	/* For access to the GLTSYN_TIME register */
 	spinlock_t ptp_gltsyn_time_lock;
 	/* For access to GLCOMM_QTX_CNTX_CTL register */
 	spinlock_t txq_ctx_lock;
 	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
 	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
-	u64 index;
 };
 
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
-void ice_adapter_put(struct pci_dev *pdev);
+void ice_adapter_put(struct ice_adapter *adapter);
 
 #endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index 8c2b63eef82b..fa64b9744779 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1747,11 +1747,20 @@ struct ice_sf_priv *ice_allocate_sf(struct device *dev, struct ice_pf *pf)
  *
  * Return: zero on success or an error code on failure.
  */
-void ice_devlink_register(struct ice_pf *pf)
+int ice_devlink_register(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	struct ice_adapter *adapter = pf->adapter;
+	int err;
 
+	if (adapter) {
+		err = devl_nested_devlink_set(adapter->devlink, devlink);
+		if (err)
+			return err;
+	}
 	devl_register(devlink);
+
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 536923b6ae97..0cdb13e7bd89 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,19 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/cleanup.h>
-#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
-#include <linux/xarray.h>
+
 #include "ice_adapter.h"
 #include "ice.h"
 
-static DEFINE_XARRAY(ice_adapters);
-static DEFINE_MUTEX(ice_adapters_mutex);
-
 #define ICE_ADAPTER_FIXED_INDEX	BIT_ULL(63)
 
 #define ICE_ADAPTER_INDEX_E825C	\
@@ -41,56 +36,41 @@ static u64 ice_adapter_index(struct pci_dev *pdev)
 	}
 }
 
-static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
+static int ice_adapter_init(void *priv, void *init_param)
 {
-	u64 index = ice_adapter_index(pdev);
-
-#if BITS_PER_LONG == 64
-	return index;
-#else
-	return (u32)index ^ (u32)(index >> 32);
-#endif
-}
+	struct ice_adapter *adapter = priv;
+	struct devlink *devlink;
 
-static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
-{
-	struct ice_adapter *adapter;
-	int err;
+	devlink = shd_priv_to_devlink(adapter);
+	adapter->devlink = devlink;
 
-	adapter = kzalloc_obj(*adapter);
-	if (!adapter)
-		return NULL;
-
-	err = init_srcu_struct(&adapter->ports.srcu);
-	if (err) {
-		kfree(adapter);
-		return NULL;
-	}
-
-	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
-	refcount_set(&adapter->refcount, 1);
 
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
 
-	return adapter;
+	return init_srcu_struct(&adapter->ports.srcu);
 }
 
-static void ice_adapter_free(struct ice_adapter *adapter)
+static void ice_adapter_fini(void *priv)
 {
+	struct ice_adapter *adapter = priv;
+
 	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 
 	cleanup_srcu_struct(&adapter->ports.srcu);
-
-	kfree(adapter);
 }
 
+static const struct devlink_ops ice_adapter_devlink_ops = {
+	.shd_init = ice_adapter_init,
+	.shd_fini = ice_adapter_fini,
+};
+
 /**
  * ice_adapter_get - Get a shared ice_adapter structure.
  * @pdev: Pointer to the pci_dev whose driver is getting the ice_adapter.
@@ -102,59 +82,37 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  *
  * Context: Process, may sleep.
  * Return:  Pointer to ice_adapter on success.
- *          ERR_PTR() on error. -ENOMEM is the only possible error.
+ *          ERR_PTR() on error.
  */
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
 	struct ice_adapter *adapter;
-	unsigned long index;
-	int err;
-
-	index = ice_adapter_xa_index(pdev);
-	scoped_guard(mutex, &ice_adapters_mutex) {
-		adapter = xa_load(&ice_adapters, index);
-		if (adapter) {
-			refcount_inc(&adapter->refcount);
-			WARN_ON_ONCE(adapter->index != ice_adapter_index(pdev));
-			return adapter;
-		}
-		err = xa_reserve(&ice_adapters, index, GFP_KERNEL);
-		if (err)
-			return ERR_PTR(err);
-
-		adapter = ice_adapter_new(pdev);
-		if (!adapter) {
-			xa_release(&ice_adapters, index);
-			return ERR_PTR(-ENOMEM);
-		}
-		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
-	}
+	struct devlink *devlink;
+	char devlink_id[32];
+	u64 index;
+
+	index = ice_adapter_index(pdev);
+	snprintf(devlink_id, sizeof(devlink_id), "ice:%llx", index);
+	devlink = devlink_shd_get(devlink_id, &ice_adapter_devlink_ops,
+				  sizeof(*adapter), NULL, pdev->dev.driver);
+	if (IS_ERR(devlink))
+		return ERR_CAST(devlink);
+
+	adapter = devlink_shd_get_priv(devlink);
+
 	return adapter;
 }
 
 /**
  * ice_adapter_put - Release a reference to the shared ice_adapter structure.
- * @pdev: Pointer to the pci_dev whose driver is releasing the ice_adapter.
+ * @adapter: the ice_adapter to release reference to
  *
  * Releases the reference to ice_adapter previously obtained with
  * ice_adapter_get.
  *
  * Context: Process, may sleep.
  */
-void ice_adapter_put(struct pci_dev *pdev)
+void ice_adapter_put(struct ice_adapter *adapter)
 {
-	struct ice_adapter *adapter;
-	unsigned long index;
-
-	index = ice_adapter_xa_index(pdev);
-	scoped_guard(mutex, &ice_adapters_mutex) {
-		adapter = xa_load(&ice_adapters, index);
-		if (WARN_ON(!adapter))
-			return;
-		if (!refcount_dec_and_test(&adapter->refcount))
-			return;
-
-		WARN_ON(xa_erase(&ice_adapters, index) != adapter);
-	}
-	ice_adapter_free(adapter);
+	devlink_shd_put(adapter->devlink);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 454fba07d4ec..6373cd5ac288 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4946,7 +4946,12 @@ static int ice_init_devlink(struct ice_pf *pf)
 		return err;
 
 	ice_devlink_init_regions(pf);
-	ice_devlink_register(pf);
+	err = ice_devlink_register(pf);
+	if (err) {
+		ice_devlink_destroy_regions(pf);
+		ice_devlink_unregister_params(pf);
+		return err;
+	}
 	ice_health_init(pf);
 
 	return 0;
@@ -5291,7 +5296,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 unroll_dev_init:
 	need_dev_deinit = true;
 unroll_adapter:
-	ice_adapter_put(pdev);
+	ice_adapter_put(adapter);
 unroll_hw_init:
 	ice_deinit_hw(hw);
 	if (need_dev_deinit)
@@ -5404,7 +5409,7 @@ static void ice_remove(struct pci_dev *pdev)
 	ice_setup_mc_magic_wake(pf);
 	ice_set_wake(pf);
 
-	ice_adapter_put(pdev);
+	ice_adapter_put(pf->adapter);
 	ice_deinit_hw(&pf->hw);
 
 	ice_deinit_dev(pf);
-- 
2.54.0

