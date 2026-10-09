Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C60FCA6019
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 12:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 024494091F;
	Fri,  9 Oct 2026 12:14:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x86kwRMZDp12; Fri,  9 Oct 2026 12:14:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8B3D40920
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791548095;
	b=QUxqmmUlS2XcEaeo4+/impy+RrRFKsj1UJalPEiH21z00LdSejCeW1qZAwwIDMrYSnTH
	 IoChs5taS7Bgyzf6e7e9MesvhMtSevi9nTuyJe37GzllN2skGHyDDmQUH7xL50SRoGnr1
	 XstTpO2IN2AHM6ADibKuweQD0/6qE6uEIn2bBn5diweOPBCncgthetjER6sgEQKMv9VSY
	 6D9tWmfiwDVSLnschnbhmqJUbahxxsU06uKPYC71FDua7+7ke57IyCTw/BAkERgJj9/JN
	 jsUt1FFaoHNDS9M64+Cs7Jfvi8LDkECkZG2Xtts/QkT70FU/WvHwamC7zE7PCKQjONg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791548095;
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
	bh=JAVnHVyNiXVW+p6M1EckbIsDomzTlIsvous+dSECaz4=;
	b=biJH2czpV7IRdg3DHbEwPTpOGLr9D2CpCeq69zlRdjNPw69xiTbjjVqkrsKN83iBUQir
	 6ey/SJ1TNdSAPNCHCSTKg7E+d2He7x8qgdS1btH6YOzfMRseZZSkuI0Wtqi8Hi2yAIxeY
	 agHDV9oxsXewwm4pPySRdijcqB7m3Kz+kyGQARFJVBMpONWSQo2fZ6FTjZrBD1ht/OGzT
	 JDMbpuz3se+AN9uut8ELnm4+vC6vpT3UMy/Pk3cdqDk0hRGt7pQ6MmdbrCDQV/ycLvZLd
	 Mk3fu1j08EslNitbKKvX41wPl60c02zp0gYQmlK6c4Hn6xR0EuEYisk3alr9IH5l+Hw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WZweDNOL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791548095;
	bh=JAVnHVyNiXVW+p6M1EckbIsDomzTlIsvous+dSECaz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JYbksSu9eJKYFZ+89xmyRi27RApFOJdCyv4K9BgpMwWnI+SDq0GSj7pv5u2byRZFn
	 q5P4nVRtN2KXomkOYFlB3tHTSztfW7NiudykZyMMWclVX9nZ6e9/b8VzYlb6uW+Om9
	 zWWOVtVYPA6q4T4ZYpFax8lfBmDXaWJcxM4xNwsfrZUEcTjtRmGxiRXIRqBlUeJWqJ
	 ufywts0XzaPplEz8DZ6ORBlvboTCwf7cIOCeVF7CKiSWVAYpOCC7Cfvd5hwc6SObMF
	 tuamTUxujtFFZ+gOfs+qssIPlWW3phkt0K2YhM6A0RDMQV9lrscHLMr/uUtFJGhXlt
	 m2ArNJ82vrasw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8B3D40920;
	Fri,  9 Oct 2026 12:14:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5441D2AA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A72740923
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gdGRrgp9mF7R for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 12:14:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E517B4090A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791548093;
 b=LrdKWrbwT23pMiDOuCGDSNKXXLiMy5qYi0POz27xY+3s5ABxmRJea8Mphi6RrIuVK321
 DL5b+qcgmbCI31JuKRPfFrxcjE+R1WnHMyIbRZHp3gfc8lPA5/CbL7Vnd55vuu+ALXTtG
 FOPjF02/VTPBphtvcT3nGTg/lTzyxdVp8exaLY3oXI/0Ur0pNOkwXsHs4mxoB128UmbT/
 XA88dhJtpfdzOIqUjgCj1IXUFMRW/hSiyvEWqcWU1U+xbFeaf3/lR5m44FN+R3oHjln/A
 jUNSXR2nEnWcl9CtJio2zzV3O7AuJc5Wr81E+RO9tD4bBIBPDk/Nc6qvQZrtMR+uEDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791548093;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=JAVnHVyNiXVW+p6M1EckbIsDomzTlIsvous+dSECaz4=;
 b=aTTV1cOStiXGA+vIZwLB60IqCQ0iukqkPQ26tXtfhycxse7Zavj65smCF4ssT2LFDJfu
 JCiW3du+1EFKfwk32WY4pSxySDxmz0Azd5s+EIPYBRg//1FdiFLe+u003Tii+JD7cF7iB
 HWenVjViWufeuTygHNeMyrM1kfHiv3q7qOPYFwKDerf89O7zg45D3YJaVWxxBQV8uff6n
 G8JaJyErBOwyVyySgwEXjBME0rZ4gpJXZBEkco+oceSc8rxpitUkDiHZ8nYWR5NtMohME
 lZfshfS1GEqEtSXv/NcnOLTLHHmhgYnJxRnsNS5FkWPGArkLOh7SWZqjBUOl5MHYEYA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WZweDNOL; 
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WZweDNOL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E517B4090A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791548093; x=1823084093;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uCFe9ZHTSiGZk59zD17DaLB9M5jijws+3lD/CEq7C/Q=;
 b=WZweDNOLWLF3S2VTpfwAF41meqKi6UJDCS8DX8ZJVvkoHZmdTHf7S8VH
 0gxhfgbpRkBtYKFG1N7ceOGAI4ulYBdpPmGx+CVjfXVpI9jT7lRw3jqi1
 Ofg9LBFVgpXvesQed0vRdJK907RthXxHthbAw4Q+GcCfKSVX167uSzAHO
 hoeyyMvDCmdz2/pyphNhOg2EGyPE8VHuyE4bVn3lhB6e9K/Ez/rmbtfrB
 C3TYY5FIyUzBDwllxVT0gj3YUCLpJLpah85mu1kvAdmcZvQO11GqG3y19
 MyzdxMXx4LljptHOcYWE7I6jEEs57UhugbzwBQGw9AizZCWsxJxkaX3fr w==;
X-CSE-ConnectionGUID: 6nPAmpSMQniU55MxlgY8UQ==
X-CSE-MsgGUID: cCxnx4rOR6SvDrF3tgFg/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="251106"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="251106"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 05:14:52 -0700
X-CSE-ConnectionGUID: rp9bcubhQOe/vuUg0qKcpA==
X-CSE-MsgGUID: hQmaq1uSSFCbg6BA61gFyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="420392"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa002.fm.intel.com with ESMTP; 09 Oct 2026 05:14:47 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.238])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 8D2412FC41;
 Fri,  9 Oct 2026 13:14:42 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>,
 skhan@linuxfoundation.org, rdunlap@infradead.org, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 jacob.e.keller@intel.com, jedrzej.jagielski@intel.com, anzaki@gmail.com,
 brett.creeley@amd.com, jtornosm@redhat.com, ohartoov@nvidia.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net-next v2 02/14] ice: use shared devlink to store
 ice_adapters instead of custom xarray
Date: Fri,  9 Oct 2026 14:04:13 +0200
Message-ID: <20261009121433.30347-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

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
 .../net/ethernet/intel/ice/devlink/devlink.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  | 12 +--
 .../net/ethernet/intel/ice/devlink/devlink.c  | 11 ++-
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 99 ++++++-------------
 drivers/net/ethernet/intel/ice/ice_main.c     | 11 ++-
 5 files changed, 57 insertions(+), 78 deletions(-)

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
index 4f695f32da3d..c11d511d7a8e 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -7,7 +7,8 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 #include <linux/spinlock_types.h>
-#include <linux/refcount_types.h>
+
+#include <net/devlink.h>
 
 #include "ice_type.h"
 
@@ -30,31 +31,30 @@ struct ice_port_list {
 
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
index 2dc3629d6d0f..c6301341ccae 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,18 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/cleanup.h>
-#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
-#include <linux/xarray.h>
+
 #include "ice_adapter.h"
 #include "ice.h"
 
-static DEFINE_XARRAY(ice_adapters);
-static DEFINE_MUTEX(ice_adapters_mutex);
-
 #define ICE_ADAPTER_FIXED_INDEX	BIT_ULL(63)
 
 #define ICE_ADAPTER_INDEX_E825C	\
@@ -40,48 +35,40 @@ static u64 ice_adapter_index(struct pci_dev *pdev)
 	}
 }
 
-static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
-{
-	u64 index = ice_adapter_index(pdev);
-
-#if BITS_PER_LONG == 64
-	return index;
-#else
-	return (u32)index ^ (u32)(index >> 32);
-#endif
-}
-
-static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
+static int ice_adapter_init(void *priv, void *init_param)
 {
-	struct ice_adapter *adapter;
+	struct ice_adapter *adapter = priv;
+	struct devlink *devlink;
 
-	adapter = kzalloc_obj(*adapter);
-	if (!adapter)
-		return NULL;
+	devlink = shd_priv_to_devlink(adapter);
+	adapter->devlink = devlink;
 
-	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_init(&adapter->cpi_phy_lock[i]);
-	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.ports);
 
-	return adapter;
+	return 0;
 }
 
-static void ice_adapter_free(struct ice_adapter *adapter)
+static void ice_adapter_fini(void *priv)
 {
+	struct ice_adapter *adapter = priv;
+
 	WARN_ON(!list_empty(&adapter->ports.ports));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
 		mutex_destroy(&adapter->cpi_phy_lock[i]);
 	mutex_destroy(&adapter->ports.lock);
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
@@ -93,59 +80,37 @@ static void ice_adapter_free(struct ice_adapter *adapter)
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
2.51.1

