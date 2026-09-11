Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF2CC88E58
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E1684081F;
	Fri, 11 Sep 2026 13:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zIn2NSjL4gVx; Fri, 11 Sep 2026 13:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 46A1340820
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133468;
	b=jcP29F6yIlxI+C9PdjPdPavvEP4uPIL/h3swuxvQF4EtULa1o/ro4SZbu13f0zqJEHRY
	 PgPvrCu5biTj9nPyiuR/Pl01XL6ALO7GPk7A5oiLreyRqwLM2WD+g1zkWPAKc6lCdfWIh
	 rp4SbZXWVbkK+0dSEPqiRGiQSAbbm0Je7+aWS6AQU+BFpBhFI7W8RfonR7Nlcf8Wv3RpL
	 0SbtJ+8fRG8A2XJIcMHYKqrqXixfsQQ452DQbTN88f9qK+TbJwn+oA8f1HZOB9pQH3lBh
	 dz0NtLjRxmGhouugDMh4uik3kDXlDimk8OryEjBFFdoel6B4SY2rZjPjiNuMhkZxdlQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wSUSg4YeAkx9AUgDdlM4pmD79qBOZpRJo3WywrNqLK4=;
	b=XfT022HqwCbWRn4hJk7gbtGO56rwdSGLzQ+GWoEpSEZnWOIZPxilp41ejM2DoUS8ZVIN
	 bB8kKo55XsUSzmRQjQe+dR4ks/ZFjRAppbUedo96i0kL8BRAsuPss6vJ35JB0OEYEEyin
	 X8NEBjMTesEd3DT4GxPTYAEJPQaTr/5cpXMVmW6Fks81VZ4NqnDnnAxUaNc2cGAbQgIBz
	 yFGdg9AwhyduKBhIjLouGf6J7YyHrXIrjLOpSeQpp5cXErKQtjXLXY5djYU0BVmyIe9pH
	 hH370/lvft92SOocb9r/7MYwRC4gOjOBHRceYt3pmtyukCsTX/dXPMJe4OF3JJ9pzxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NLbq1SBV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789133468;
	bh=wSUSg4YeAkx9AUgDdlM4pmD79qBOZpRJo3WywrNqLK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0q12MDt3uicGbOYysHe60eTEkQSpoa/S5WyyyEin6EWdU+DGRRjp54wH7lXpErmLU
	 IvTF8KiDJXm2gJLo6iAWiutLhqz2y9zq4ix5keR3iWaYpz19b1bNAPNBwI7IbxZ4E+
	 F/f/IWMRthfuQBQMXgmgI1qyL87bPpGB+y4qhMo6U4GOHQizWd35n79nIBLixB3pGN
	 wYY9NgDjY6Zkzfj9KWXjBxsqLejzmpV1u92CZL/nNC0hDpx4idfgC4VNWeKmS0KsLG
	 U/vvyKUmJjR7uviSj/Fx3VlpsNKJJlFXKNTZGAPBk+tHJFjNYq851ohRWb4qPSuYsT
	 X3Y8pJq/GxMiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46A1340820;
	Fri, 11 Sep 2026 13:31:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C24832F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 121B84082F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nFf0Yo7_ujWf for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 13:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org F195F40827
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133465;
 b=UQwnnEwtyjh23aUuUJYLlJNddOBnyzbJIDTj4Yq/qJFdeAdrxzLXBbWlg7tRKedJJmxh
 SHm9Bht65If4mixBagD8QQUdxzyguVVyn7hpH3AOrLA9hwWqExhmSyYI0uaPWh8UdrgaM
 227GG8iQq9kEdiwOenShbAuT7xSfwChtMvcLDrrH0p2RIZIS6SCa/GiGlGn58g/76Rn3o
 sYhi5+Ot0eCSYoEZsoRBx9O3Tkx/6HFp3L2oGwQ1kSJOZAZuOw/f2qLc+i5cQYRzRM1fX
 oYhUbN6hNl/LXQqSg6ZF88Mc50B2nEYfECmJtjiVqF6o/WduZQ9ls8KKhohzY+o/7wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133465;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wSUSg4YeAkx9AUgDdlM4pmD79qBOZpRJo3WywrNqLK4=;
 b=QRBL3106xj79tkb4b1Bw+XH2SaZqD/3rfRjjDxl57l0276rmT8L0JfBXxjYBmOOatK5w
 NV2xdCVhPweTSh5S+lNUIPLQ1cz4EiUpvO6o0oaP7Vzj7Eh7RsMV6/UIZm4dbLzpHZe14
 SMb2Ychw0MchBtjy+q5rziw6qDTnIJKIQrxM6l5bZ/tXNN6n1G8k+2S5yqY4EI6cNkExh
 Cjn0kuk76CDs8diyykvmxZtqQ/2FEL4dj1kZVtNzfiOATofClZaNRQStHbbgTmRmi2OUj
 rqPqUKiTvwZsKM3xE425v5wjdPobsIEUzY98M9+ezxk4IMTPK9eYqnuxhOtUsqpVvQw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NLbq1SBV; 
 arc=none smtp.remote-ip=192.198.163.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.4;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NLbq1SBV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F195F40827
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789133465; x=1820669465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qHS1b2tjdRdvqr4P/sS38v3L3WhD2s8Lh9q0gj/hIiw=;
 b=NLbq1SBVgrK+p9IfmDDU2CB+iXcOlG//Wjf/T7LJmKZy9sdA5BIHXJhz
 895oXPQhZeYJdipeiR904D9ixivvIUwg1XkMxI9keLCclJGArpDWzbAoK
 4PD4/f0VLCOr3/v2zcMWTY57P2V2iDg0T1cvfFoEnwqMEfSOaGAzyjVXv
 FidRPk2zB35YuuIcCe+b8eaUjclVLcAEPE9XngWeHelmBJBLXM38cTENv
 EXOe3OOG6GgiPxwbWlDOqPj2vazwQY5PlV4wll8JJMZD9GmshfhUF2WFr
 jKCNY9mtSKhQzyLOArothput7tCvYHzbnqQkazuD4XOe0KVvjrpQCN1te g==;
X-CSE-ConnectionGUID: BCy1bl3+QFe8PSlkw3rbzg==
X-CSE-MsgGUID: 5g/ZIpiYQtaQns7QEHr+nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="107546"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="107546"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 06:30:04 -0700
X-CSE-ConnectionGUID: 47hF93LsR8mgeD/zGZZk9A==
X-CSE-MsgGUID: RJ7LK1itTGehIeud5m0z6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270541296"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa010.jf.intel.com with ESMTP; 11 Sep 2026 06:30:03 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 09/10] ixd: support for getting lan memory regions
Date: Fri, 11 Sep 2026 14:49:20 +0200
Message-ID: <20260911124921.2881348-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
References: <20260911124921.2881348-1-michal.swiatkowski@linux.intel.com>
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
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 131 +++++++++++++++---
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  90 +++++++++++-
 3 files changed, 201 insertions(+), 23 deletions(-)

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
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 5db992d4f9fb..488a919f3b1b 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -48,37 +48,124 @@ static void ixd_shutdown(struct pci_dev *pdev)
 
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
+	}
+
+	return 0;
+}
+
+/* Regions needed to reset the device and to talk to the control plane.
+ * They are mapped in probe and stay mapped for the whole driver life.
+ */
+static const struct ixd_bar_region ixd_start_regions[] = {
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
+/**
+ * ixd_iomap_is_not_start_region - check if the region isn't a start region
+ * @info: PCI resources info, unused
+ * @reg: region to check
+ *
+ * Return: %true if it isn't a start region, %false otherwise
+ */
+bool ixd_iomap_is_not_start_region(struct libie_mmio_info *info,
+				   struct libie_pci_mmio_region *reg)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ixd_start_regions); i++) {
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
+ * It should be called only when the GET_LAN_MEMORY_REGIONS virtchnl command
+ * isn't supported. Calculate the offsets and sizes for the regions before,
+ * in between, and after the start regions (mailbox and reset registers) and
+ * map those ranges.
+ *
+ * Returns: %0 on success, negative on failure
+ */
+int ixd_iomap_running_regions(struct ixd_adapter *adapter)
+{
+	struct libie_mmio_info *mmio_info = &adapter->cp_ctx.mmio_info;
+	resource_size_t start, size;
+	bool ok = true;
+
+	/* Region preceding the mailbox */
+	size = PF_FW_MBX;
+	ok &= !size || libie_pci_map_mmio_region(mmio_info, 0, size);
+
+	/* Region between the mailbox and the reset registers */
+	start = PF_FW_MBX + PF_FW_MBX_REG_LEN;
+	size = PFGEN_RTRIG - start;
+	ok &= !size || libie_pci_map_mmio_region(mmio_info, start, size);
+
+	/* Region after the reset registers */
+	start = PFGEN_RTRIG + PFGEN_RTRIG_REG_LEN;
+	size = pci_resource_len(mmio_info->pdev, 0) - start;
+	ok &= !size || libie_pci_map_mmio_region(mmio_info, start, size);
+
+	if (!ok) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to map running PCI device MMIO region\n");
+
+		libie_pci_unmap_fltr_regs(mmio_info,
+					  ixd_iomap_is_not_start_region);
+
+		return -EIO;
 	}
 
 	return 0;
@@ -109,7 +196,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, adapter);
 
-	err = ixd_iomap_regions(adapter);
+	err = ixd_iomap_start_regions(adapter);
 	if (err)
 		goto free_adapter;
 
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
index fc3b6d2e28c5..3487183b49c9 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -3,6 +3,7 @@
 
 #include "ixd.h"
 #include "ixd_ctlq.h"
+#include "ixd_lan_regs.h"
 #include "ixd_virtchnl.h"
 
 /**
@@ -62,6 +63,14 @@ static int ixd_handle_caps(struct ixd_adapter *adapter, void *recv_buff,
 	return 0;
 }
 
+static void ixd_fill_caps(struct ixd_adapter *adapter, void *send_buff,
+			  void *ctx)
+{
+	struct virtchnl2_get_capabilities *caps = send_buff;
+
+	caps->other_caps = cpu_to_le64(VIRTCHNL2_CAP_LAN_MEMORY_REGIONS);
+}
+
 /**
  * ixd_req_vc_caps - Request and save device capability
  * @adapter: The adapter to get the capabilities for
@@ -74,13 +83,18 @@ static int ixd_req_vc_caps(struct ixd_adapter *adapter)
 		.opcode = VIRTCHNL2_OP_GET_CAPS,
 		.send_size = sizeof(struct virtchnl2_get_capabilities),
 		.ctx = NULL,
-		.send_buff_init = NULL,
+		.send_buff_init = ixd_fill_caps,
 		.recv_process = ixd_handle_caps,
 	};
 
 	return ixd_ctlq_do_req(adapter, &req);
 }
 
+static bool ixd_is_cap_ena(struct ixd_adapter *adapter, u64 cap)
+{
+	return (le64_to_cpu(adapter->caps.other_caps) & cap) == cap;
+}
+
 /**
  * ixd_get_vc_ver - Get version info from adapter
  *
@@ -160,6 +174,69 @@ static int ixd_req_vc_version(struct ixd_adapter *adapter)
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
+	int num_regions;
+
+	if (recv_size < sizeof(*recv_mmio))
+		return -EBADMSG;
+
+	num_regions = le16_to_cpu(recv_mmio->num_memory_regions);
+	if (!num_regions)
+		return -EBADMSG;
+
+	if (recv_size < struct_size(recv_mmio, mem_reg, num_regions))
+		return -EBADMSG;
+
+	for (int i = 0; i < num_regions; i++) {
+		struct virtchnl2_mem_region *reg = &recv_mmio->mem_reg[i];
+		resource_size_t offset, size;
+
+		offset = le64_to_cpu(reg->start_offset);
+		size = le64_to_cpu(reg->size);
+
+		/* Empty regions are used as a padding, skip them. */
+		if (!size)
+			continue;
+
+		if (!libie_pci_map_mmio_region(mmio_info, offset, size)) {
+			/* Unmap already mapped */
+			libie_pci_unmap_fltr_regs(mmio_info,
+						  ixd_iomap_is_not_start_region);
+			return -EIO;
+		}
+	}
+
+	return 0;
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
@@ -186,5 +263,16 @@ int ixd_vc_dev_init(struct ixd_adapter *adapter)
 		return err;
 	}
 
+	if (ixd_is_cap_ena(adapter, VIRTCHNL2_CAP_LAN_MEMORY_REGIONS))
+		err = ixd_req_lan_mmio_regions(adapter);
+	else
+		/* Fallback to mapping the remaining regions of the whole BAR */
+		err = ixd_iomap_running_regions(adapter);
+
+	if (err)
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting LAN mmio regions failed, error=%pe\n",
+			 ERR_PTR(err));
+
 	return err;
 }
-- 
2.49.0

