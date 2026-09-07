Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F5CC79F89
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38BD780C8F;
	Mon,  7 Sep 2026 11:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93mrsHEbq2Fu; Mon,  7 Sep 2026 11:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8AF3980CA7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779074;
	b=lp0heVsWA5QafJ9wxUvjTYHTaChRPPXeeI0Ea4sLj6F795p1gPUWa4ySuDplKUCUFk0g
	 HFErzY6l1Mpq2/U0dc4ERhX9xDMEh9+7JpWIhiOVKVwd1iAo+DzWCcI6WQ3Or6lhGDjjq
	 wkhmSqaYNjk++2jclqkdcVjLPDjxm91e0hg3c1G/Xk1dcwZwju6aXfy+YgvJxQlMpx3hR
	 k13Xq2PBxhIyE4c1V9AymG2dpW4svfAazqxitf8PHJPS7eDonq6Z83dsUrJPIHf+hXfYW
	 Vp6PxeQU3HHBvgUQwP9AcnA0in+d582mixUzUylMKEVHILfCMOSfJwgoO6gLGpSO0vg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779074;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=J4OtAJCnyzBa+6KpSveqVvqB/6aua0XVKABtwukhmVo=;
	b=PELH+kNmprTV2N2wkXdsHgNXNOFeC8PuvhqH/lYOy814ZRznXpp8nmpxlEtoOXtlplIg
	 Nz1SusFflZkp6WriUwJ5T1uHoTEaEC+3S3AZGOVcn5rtnGnTS/FVdsN1jg/OwyddtGy4M
	 4eQE+vxQQjciySG92Gykujh4LYRZGZ1TYZqMFsSHGAJfPjiN+aWlRPFH4uZARDoRkMa4H
	 yGX0wPjIfIENTKlfM/bxMV3lMudf0BbJ2AeuA7VM4LBDl84cFCnDbqdPE35akAAA8d764
	 gFgblZhTzY65oGPiCNlz8nFpmkOnCYL4bEtRW/AJ2oUJBsalXb4bmsi5sQ1l9gBV+0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BS2poRMh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779074;
	bh=J4OtAJCnyzBa+6KpSveqVvqB/6aua0XVKABtwukhmVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b2ZipdfNJH/QlmjZ58t9l7KAki5BOU2vB1EKG3TUDF1XFM/p9wAXzZzTBcRp/KYEz
	 WgoSseLl3CX0UHcm9ABA9mnVjTwb+1IkadA/YVHYUwJqQw6A3sA/oI4hT5m3Cld0B3
	 l4v+9/uxue6xpcOl+RtttrkDD1cHxSzm5nvzuJrtWUE2D8ZoVLnlUsRUvVRbTUyRZR
	 1y4cz5oyebCRAlzhWHV6RxzV7nRQ/WlkrNNKEi1gW6Bbng0jlfyITN7W3oxGeP8gBh
	 7ZG2zv87ZIFxzp6hI+AetIuCDhuwTv9eX100PStYi78sL67wybg4kg6SBETQdSuFae
	 6poXJrC0zCppQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AF3980CA7;
	Mon,  7 Sep 2026 11:04:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 169AA9CF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F17C980CB8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d9vUjhhozif3 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C742280937
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779071;
 b=VAwMoEZpluQc04h5nE3yUdvyouTci6QivUiE/1BaC2V8WsnnWbAIKvDzZSqxyk+AoxDC
 EoJXmGshH4AVgTVFQucBIR0nAYFTvnob3Iq4NGskomjlLPzxvrNB2d+ebD+Uer6lJJacN
 Vnj+94wNJF69dYM0xbBHo6GfTRf/cjDFClTMSZFiO2bd6OK2PSMOP5//jDnN8ZAjAhg/3
 w6kdOP1vWnz+wNOrHWwYLGJ/eNZ/k+g+0rXiZxheCuBcsFL32gN3JlIBz+XgJFMHgfQYR
 YOKP8SKi6ABONreuZfkYCACcDg6VL2vSwBjvof08v4/uoOpk0px38NUxv/OWBSnMpnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779071;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=J4OtAJCnyzBa+6KpSveqVvqB/6aua0XVKABtwukhmVo=;
 b=r8Sdle/w+1rCpp506DJPRPVs0aq5/90BTvt9E2Wm9xzO37ao9jXZrk9QUpBWbTA2FwZ1
 qVvdJtpGt3jm+9+ZMC7X4CUNmQyQ8PSIaJuyq7620jHESOljcdzO1hik7FEZxh76PSoER
 qpZrkjREAg+BxtsrY+XczTJtLUtm9gOG1dB1onwIonjaDLMclyz2iWpoeW8H88JIO6Xd4
 6FUNrAu66ocSf+48nOtnde1jBoDX01v7iAsFXahrGlv26DLeX9kvtIY7nHBxAYm6dH87l
 rVZzzKqGyZIfZfPid1ObKNBuzK6eZ2ywo7ukonfRuI/D/ZhLWpJjqEyYZG63q8nPpGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BS2poRMh; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BS2poRMh
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C742280937
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779071; x=1820315071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VccVfSgeqw1zT8nB/tdgOZLiyAKm0oXa9IdoPuSS70A=;
 b=BS2poRMhfqOYZ03YT2FuX4Gv6gdXfab4QzbbB3F5l0A/VgoKk7T+KaHL
 pbygJRKr+Bnw6yO0a6RudYyXjOOc3Xe6qutcdlQFkpdUrfi8eoMWE3dhO
 /utorGdCLhpR52UvFcubEqzhD/n4SqngUi/pQRQsM3i1qswHDNOJHmvCx
 Lcbo7w6LS3SMKSb0yg3usUMxFFbLCbGOcaOTL/OLCGdgZXLSnFTT7rG/n
 brBtfBjxWV+PCJV+NcqmEwlt+7P8PCepAVMB8s+BZRlgYr4Cs0GJytyYz
 QtLMs08+MVemblW3lExvwJAJ5kahkRv1GxZhn1lwHCzepfPyRg6DgV7gq w==;
X-CSE-ConnectionGUID: 4bWu3vLhTzCe8Vw/lhPYLg==
X-CSE-MsgGUID: +T8KpTDZToyfTFKwYGOYVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214089"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214089"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:31 -0700
X-CSE-ConnectionGUID: eN1TUEGMRgqFwMb1Nn0ONg==
X-CSE-MsgGUID: wQhcqb4DQMO/PePs/4MISw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195487"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:29 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 09/10] ixd: support for getting lan memory regions
Date: Mon,  7 Sep 2026 12:24:16 +0200
Message-ID: <20260907102418.2697317-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
References: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
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

Send and parse get lan memory regions command. Map the regions from
the command response.

It is needed to set number of regions to not zero value even when
just sending the command. Set it to 1 and add comment about that.

It is possible that get lan memory regions isn't supported. Driver
should cover this situation by mapping regions needed for running.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixd/ixd.h          |   3 +
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |   8 ++
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 125 +++++++++++++++---
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  70 ++++++++++
 4 files changed, 184 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index 2a09ccba13d5..4a1590f937b5 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -63,5 +63,8 @@ bool ixd_check_reset_complete(struct ixd_adapter *adapter);
 void ixd_init_task(struct work_struct *work);
 int ixd_init_dflt_mbx(struct ixd_adapter *adapter);
 void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter);
+int ixd_iomap_running_regions(struct ixd_adapter *adapter);
+bool ixd_iomap_is_not_start_region(struct libie_mmio_info *info,
+				   struct libie_pci_mmio_region *reg);
 
 #endif /* _IXD_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
index 58e58c75981b..05f65dff99f6 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
+++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
@@ -39,6 +39,14 @@
 #define PFGEN_CTRL			0x0840700C	/* PFR trigger */
 #define PFGEN_CTRL_PFSWR		BIT(0)
 
+/* Default register mapping */
+#define PF_PCI_0			0x0
+#define PF_PCI_0_SIZE			0x08400000
+#define PF_PCI_1			0x08401000
+#define PF_PCI_1_SIZE			0x6000
+#define PF_PCI_2			0x08408000
+#define PF_PCI_2_SIZE			0x37F8000
+
 /**
  * struct ixd_bar_region - BAR region description
  * @offset: BAR region offset
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 5db992d4f9fb..3f90b26b8989 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -48,42 +48,123 @@ static void ixd_shutdown(struct pci_dev *pdev)
 
 /**
  * ixd_iomap_regions - iomap PCI BARs
- * @adapter: adapter to map memory regions for
+ * @mmio_info: PCI resources info
+ * @num: number of regions to map
+ * @regions: array of regions to map (offset and size)
  *
  * Returns: %0 on success, negative on failure
  */
-static int ixd_iomap_regions(struct ixd_adapter *adapter)
+static int ixd_iomap_regions(struct libie_mmio_info *mmio_info, int num,
+			     const struct ixd_bar_region *regions)
 {
-	const struct ixd_bar_region regions[] = {
-		{
-			.offset = PFGEN_RTRIG,
-			.size = PFGEN_RTRIG_REG_LEN,
-		},
-		{
-			.offset = PF_FW_MBX,
-			.size = PF_FW_MBX_REG_LEN,
-		},
-	};
-
-	for (int i = 0; i < ARRAY_SIZE(regions); i++) {
-		struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	for (int i = 0; i < num; i++) {
 		bool map_ok;
 
 		map_ok = libie_pci_map_mmio_region(mmio_info,
 						   regions[i].offset,
 						   regions[i].size);
-		if (!map_ok) {
-			dev_err(ixd_to_dev(adapter),
-				"Failed to map PCI device MMIO region\n");
-
-			libie_pci_unmap_all_mmio_regions(mmio_info);
+		if (!map_ok)
 			return -EIO;
-		}
 	}
 
 	return 0;
 }
 
+const struct ixd_bar_region ixd_start_regions[] = {
+	{
+		.offset = PFGEN_RTRIG,
+		.size = PFGEN_RTRIG_REG_LEN,
+	},
+	{
+		.offset = PF_FW_MBX,
+		.size = PF_FW_MBX_REG_LEN,
+	},
+};
+
+static const struct ixd_bar_region ixd_running_regions[] = {
+	{
+		.offset = PF_PCI_0,
+		.size = PF_PCI_0_SIZE,
+	},
+	{
+		.offset = PF_PCI_1,
+		.size = PF_PCI_1_SIZE,
+	},
+	{
+		.offset = PF_PCI_2,
+		.size = PF_PCI_2_SIZE,
+	},
+};
+
+/**
+ * ixd_iomap_is_not_start_region - check if it is the start region
+ * @mmio_info: PCI resources info
+ * @reg: region to check
+ *
+ * Return: %true if it isn't start region, %false otherwise
+ *
+ */
+bool ixd_iomap_is_not_start_region(struct libie_mmio_info *info,
+				   struct libie_pci_mmio_region *reg)
+{
+	for (uint i = 0; i < ARRAY_SIZE(ixd_start_regions); i++) {
+		if (reg->bar_idx == 0 &&
+		    reg->offset == ixd_start_regions[i].offset &&
+		    reg->size == ixd_start_regions[i].size)
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * ixd_iomap_start_regions - iomap PCI BARs needed for driver startup
+ * @adapter: adapter to map memory regions for
+ *
+ * Returns: %0 on success, negative on failure
+ */
+static int ixd_iomap_start_regions(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	int err;
+
+	err = ixd_iomap_regions(mmio_info, ARRAY_SIZE(ixd_start_regions),
+				ixd_start_regions);
+	if (err) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to map startup PCI device MMIO region\n");
+
+		libie_pci_unmap_all_mmio_regions(mmio_info);
+	}
+
+	return err;
+}
+
+/**
+ * ixd_iomap_running_regions - iomap PCI BARs needed for driver when running
+ * @adapter: adapter to map memory regions for
+ *
+ * It should be called only if GET_LAN_MEMORY_REGIONS virtchnl message fails.
+ * Returns: %0 on success, negative on failure
+ */
+int ixd_iomap_running_regions(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	int err;
+
+	err = ixd_iomap_regions(mmio_info, ARRAY_SIZE(ixd_running_regions),
+				ixd_running_regions);
+	if (err) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to map running PCI device MMIO region\n");
+
+		libie_pci_unmap_fltr_regs(mmio_info,
+					  ixd_iomap_is_not_start_region);
+	}
+
+	return err;
+}
+
 /**
  * ixd_probe - probe a CPF PCI device
  * @pdev: corresponding PCI device
@@ -109,7 +190,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, adapter);
 
-	err = ixd_iomap_regions(adapter);
+	err = ixd_iomap_start_regions(adapter);
 	if (err)
 		goto free_adapter;
 
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
index fc3b6d2e28c5..ddf0e6bf2368 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -3,6 +3,7 @@
 
 #include "ixd.h"
 #include "ixd_ctlq.h"
+#include "ixd_lan_regs.h"
 #include "ixd_virtchnl.h"
 
 /**
@@ -160,6 +161,66 @@ static int ixd_req_vc_version(struct ixd_adapter *adapter)
 	return ixd_ctlq_do_req(adapter, &req);
 }
 
+static void ixd_fill_lan_mmio_regions(struct ixd_adapter *adapter,
+				      void *send_buff, void *ctx)
+{
+	struct virtchnl2_get_lan_memory_regions *lan = send_buff;
+
+	/* Needed to be parsed correctly, this mem_region doesn't matter. */
+	lan->num_memory_regions = cpu_to_le16(1);
+}
+
+static int ixd_handle_lan_mmio_regions(struct ixd_adapter *adapter,
+				       void *recv_buff, size_t recv_size,
+				       void *ctx)
+{
+	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	struct virtchnl2_get_lan_memory_regions *recv_mmio = recv_buff;
+	int num_regions, err = 0;
+
+	if (recv_size < sizeof(*recv_mmio))
+		return -EBADMSG;
+
+	num_regions = le16_to_cpu(recv_mmio->num_memory_regions);
+	if (!num_regions)
+		return -EBADMSG;
+
+	if (recv_size < sizeof(*recv_mmio) +
+			sizeof(struct virtchnl2_mem_region) * num_regions)
+		return -EBADMSG;
+
+	for (int i = 0; i < num_regions; i++) {
+		struct virtchnl2_mem_region *reg = &recv_mmio->mem_reg[i];
+		bool map_ok;
+
+		map_ok = libie_pci_map_mmio_region(mmio_info,
+						   le64_to_cpu(reg->start_offset),
+						   le64_to_cpu(reg->size));
+		if (!map_ok) {
+			/* Unmap already mapped */
+			libie_pci_unmap_fltr_regs(mmio_info,
+						  ixd_iomap_is_not_start_region);
+			return -EIO;
+		}
+	}
+
+	return err;
+}
+
+static int ixd_req_lan_mmio_regions(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS,
+		.send_size = sizeof(struct virtchnl2_get_lan_memory_regions) +
+			     sizeof(struct virtchnl2_mem_region),
+		.ctx = NULL,
+		.send_buff_init = ixd_fill_lan_mmio_regions,
+		.recv_process = ixd_handle_lan_mmio_regions,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
 /**
  * ixd_vc_dev_init - virtchnl device core initialization
  * @adapter: device information
@@ -186,5 +247,14 @@ int ixd_vc_dev_init(struct ixd_adapter *adapter)
 		return err;
 	}
 
+	/* Error here isn't critical; map running regions in this case */
+	err = ixd_req_lan_mmio_regions(adapter);
+	if (err) {
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting virtchnl LAN mmio regions failed, error=%pe\n",
+			 ERR_PTR(err));
+		err = ixd_iomap_running_regions(adapter);
+	}
+
 	return err;
 }
-- 
2.49.0

