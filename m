Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F35A606A31D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=90YMPjlo;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aNSIm8Ru
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DE53606D7;
	Tue, 27 Oct 2026 17:45:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VR8uHF5My9Pw; Tue, 27 Oct 2026 17:45:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 09993606CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793123112;
	b=h2EBIGLFDNwI6NCWdcQueBXsrYGoSIPQy0olgKH8/7ZB+hzjnqP95o7fpUQZ2QUfit9X
	 fC9Nz3a1zPzIcWE3X99FQ3x1AYUF9kdbpdUpl05sYwtiG2JpmnAW+QJqmO8Ey2wXSCHAl
	 OLtKRPU7F8izqC58kCWi2SiENfCmJ9WI6VSPuq7R4pFbyumiRb4OcekHvpng5kYIMJhZh
	 Xn0fGaqSslSLLZaixHmwrTG3yK+e222tthL4o6ZCiwxfPV69QGS+7o3XJywhHWh1IJxhh
	 HboJModlW0Q1e8Y7lVJOzEnOVldcQb0kqWTFkgzWYAT4GgEE5r21j8DFKvscSHPZs+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793123112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qClkIxJz71roGtycngBWsdRRTModrXLMED0mwiynaAM=;
	b=UklgZMxZFrBUOm+dU1vTu1Ba0rKe0Xv5GMy/lbX6g0gTlFwYtEoVApQOwfjwh0CMPkrt
	 wqR28Q1YMajrzugpHnFlDhreQrJAiWF7+mvc88Mn0/alWXT01fNDyl8OOV6Jo1vOqsrmv
	 dZ9TzmcS12NYojLHr8R8GUGszu21HrOHVjKLcy07iu+hY5pliCtHL9Lfqx9xJsIF29fSK
	 RuHvoc8zSoKxKJ/3pf3VlBvyazBL4IznP+ccQ9RtqsTW9FhdDMS+mBTOp4TsspJlIB2Dv
	 vWVAj+8NO4GD7TYsZECLx5mZ+gOZHjp2BYvMdoBWyvounc6ptEPcskH/SzS9Mu/4xMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793123112;
	bh=qClkIxJz71roGtycngBWsdRRTModrXLMED0mwiynaAM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=90YMPjlo5andKkS2ZsCbxRnsd7YXLb1Gx1HQw0AjCKwS/arP2LetfdupemZOuvTU2
	 8BTv0sSnsHSu5v4xgF2GyTH8HfC9Y4wLmZoaZqjQb9je240CZp6I3OxzwHsODhQqg0
	 IaNnlH/eMEHMCwHyqVTdRf30PVaOtKfgSs3hLgaJeiSyFPrEm7hMcCtRJlt17baFBu
	 AvJ9KG0B5leUVGbcZDHWeNg404uHQPyEOxuXzrnpmwIevxQ9srdfrsBbfYhszeo1cz
	 4soxyE3crZlmMSVbtGGMBfPS9REf260y9r0N3mnY8bF4aL5OD9kFkZyRKIY6CoitLo
	 7UyZJhLrDiSJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09993606CB;
	Tue, 27 Oct 2026 17:45:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A8D1235
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6086E407EE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rjihYXLmK208 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 17:45:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A5D94066C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793123108;
 b=tbTGzwVs69mImkstgHoZhI4CUz59FanZF0UaaM5gyJicSu6yYIX/dpN2Cbj4QnUGQtQx
 sYqSLNkeF9qrIFwerzrdXqde+WzC0ENRdpLIuzZf3c21vqBWmy9ycwsaFA4AxZmF/MDc7
 g+oU9y+MGUhhrqfnBCkwbnpeKgIOtgobuCsXN6+TGe8EMDUaBx+OAgqnCNPQ1eu30eB1I
 T0Y1cST98fF69sANEgMWssoGq4Gs5tSLrDIYCJUPv5zGJYKQEU0/9BjRZbQ8LDB+VE9aA
 CahD8+xdTvAYXTIB1O9bwZ7kmoXUSk04hGIgoAGhJrPblbYXs0znU01BO+pyBRdftmw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793123108;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qClkIxJz71roGtycngBWsdRRTModrXLMED0mwiynaAM=;
 b=KMEtgX0e88utpUcz5VMCNcntF2i4InrAI/Cy2iOuQDRXiwm9VTpTAXIBkxFVKsDWE37k
 HX0NdnjhOVja+wxcANDeXt2d/Ews8i6/5ltkysXfYGWY11mVYlB/dD9Kyoa2JcKTzstMo
 8IOOzrfAYygSqsi2ERAPzUjx/NbYTrpsgSRFr3juhrd2UdM7lpKfrypCptngV1BRcYwab
 bdJM0umfEe0d7t+OhyO+isL57SRplIFFR4VXAgHhg6Kze7SIlsUZOtuwRgKZ0Mp8/xjTw
 qm+zFP7Tc5mVavu83v9dFJVLrn9VjTsOvOHkCeyVj1y7zDosXXMbxKh7lfuOh6GzHVQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aNSIm8Ru; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aNSIm8Ru
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A5D94066C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 17:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793123108; x=1824659108;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=x9idplvedQK/rjE54ZJBYphUV/sdCC/n1hUk+Mtn6sg=;
 b=aNSIm8RulDFEml9eywB75I5ddQ/xjbEyHU6y3aF+ysPd326CMSTKah9k
 pw4FNtr67aOlbEbiOOpp2ix0frJP5AXsFItfPTZ+UFvYcDTQOoy8fqv/Q
 XlAiQ18VMnb5V+TljbBcUHlBNt9SST4JOjluqkQuWF4+GmMD+Lq2rsvRR
 L5X+MoxmKSQjMUMHZHPuhNZhuP1qQ8ovJoOt1KMdDNTUhJd3jH2aBx3RS
 A778wJNb4KBvLHf2HmEXSyy8lU29yj9sTZgASFwmu23LD1Fka3vi/wdSy
 4nB2zJTFE2UO3tfzu/S8lPskB3EScArnYjS++d9WNKw6Wzt18inaVxM8V Q==;
X-CSE-ConnectionGUID: 5O6nApliS2eNMx881etmXA==
X-CSE-MsgGUID: p1f/G0RhTZ2mZe15igz0qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1713384"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1713384"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 10:45:07 -0700
X-CSE-ConnectionGUID: 4q61LInRQjKsfRs4DhOcBg==
X-CSE-MsgGUID: BAJ3LXrJQgmadBmrZfmz7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4685717"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa006.jf.intel.com with ESMTP; 27 Oct 2026 10:45:06 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 2/2] ice: reject partial NVM update on eRoT
 adapters
Date: Tue, 27 Oct 2026 18:45:02 +0100
Message-ID: <9fe20320948a496217f4888b8196f64f1cdd3874.1793119681.git.aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793119681.git.aleksandr.loktionov@intel.com>
References: <cover.1793119681.git.aleksandr.loktionov@intel.com>
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An eRoT authenticates the complete NVM image, so a PLDM capsule that
carries only part of the components is not a valid update on such an
adapter. Report that from the driver: it knows the components an eRoT
adapter needs, so it can reject the image with a reason in the extended
ACK before anything is written to the device.

Reject a repeated component and a component without data while the
component tables are sent, and require all four components before the
first bank is erased. Check the component set again before activation,
because an image whose device record selects no component at all skips
the flash path and still reaches that step. Reject a single component
request up front, and accept the Manifest component only when firmware
reports eRoT presence. Adapters whose firmware does not report eRoT
keep their current handling.

Read the device capabilities once per flash attempt and act on that
snapshot, then reuse it for the pending update check the attempt
already makes, so an update still costs one List Device Capabilities
round trip. The cached copy in hw->dev_caps cannot decide this: a
driver loaded while firmware was already in recovery mode never reads
it, and a reset re-parses it in place. An explicit capability value
other than 0 or 1 rejects every update, because an answer the driver
cannot interpret is not evidence that the image is complete.

No activation is requested for the Manifest: the AQ activation select
mask and the pending update capabilities have no Manifest entry, so the
driver writes the bank and leaves the activation flag zero. It can
neither activate nor roll back that bank, which is documented along
with the other eRoT update limits.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 Documentation/networking/devlink/ice.rst      |  24 +++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 193 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 4 files changed, 192 insertions(+), 27 deletions(-)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 792e9f8..a8d8cb5 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -205,6 +205,30 @@ The ``ice`` driver implements support for flash update using the
 combined flash image that contains the ``fw.mgmt``, ``fw.undi``, and
 ``fw.netlist`` components.
 
+When firmware reports an external Root of Trust (eRoT), the image must
+also contain the ``fw.pqc_manifest`` component and all four components
+must be updated together. A single component request is rejected before
+anything is written to the device. An image that misses one of the four
+components, repeats one, or carries a component without data is
+rejected before any flash bank is erased, but by then any previously
+pending update has already been canceled. The driver queries the device
+capabilities for every flash attempt, so these restrictions follow what
+the firmware reports at that moment, including on a driver loaded while
+the firmware was already in recovery mode. Adapters whose firmware does
+not report the eRoT capability keep their previous handling, and a
+``fw.pqc_manifest`` component always requires a reported eRoT
+capability. A reported eRoT capability value other than 0 or 1 makes
+every flash update fail with ``-EIO``; update such firmware out of band.
+
+These checks reject images the adapter cannot use. They do not
+authenticate image contents and they do not make the update atomic. The
+driver cannot activate or roll back the ``fw.pqc_manifest`` component:
+the AQ activation select mask names only ``fw.mgmt``, ``fw.undi`` and
+``fw.netlist``, and no pending update capability describes a Manifest.
+If an update fails after the Manifest bank has been written, the state
+of that bank is defined by the firmware, not by the driver, and
+recovering the adapter then needs out-of-band tooling.
+
 .. list-table:: List of supported overwrite modes
    :widths: 5 95
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 848ac58..072cd0b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1748,6 +1748,7 @@ struct ice_aqc_nvm_comp_tbl {
 #define NVM_COMP_ID_OROM	0x5
 #define NVM_COMP_ID_NVM		0x6
 #define NVM_COMP_ID_NETLIST	0x8
+#define NVM_COMP_ID_MANIFEST	0x12
 
 	u8 comp_class_idx;
 #define FWU_COMP_CLASS_IDX_NOT_USE 0x0
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 3631461..93ddcbe 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -9,6 +9,15 @@
 #include "ice_lib.h"
 #include "ice_fw_update.h"
 
+/* Bitmask values for ice_fwu_priv::seen_components */
+#define ICE_FWU_COMP_NVM		BIT(0)
+#define ICE_FWU_COMP_OROM		BIT(1)
+#define ICE_FWU_COMP_NETLIST		BIT(2)
+#define ICE_FWU_COMP_MANIFEST		BIT(3)
+/* Components an eRoT adapter requires in a single update */
+#define ICE_FWU_COMP_ALL_EROT		(ICE_FWU_COMP_NVM | ICE_FWU_COMP_OROM | \
+					 ICE_FWU_COMP_NETLIST | ICE_FWU_COMP_MANIFEST)
+
 struct ice_fwu_priv {
 	struct pldmfw context;
 
@@ -29,6 +38,10 @@ struct ice_fwu_priv {
 
 	/* Track if EMP reset is available */
 	u8 emp_reset_available;
+
+	/* Bitmask of components seen in this image (ICE_FWU_COMP_*) */
+	u8 seen_components;
+	bool erot_present;
 };
 
 /**
@@ -108,6 +121,9 @@ ice_check_component_response(struct ice_pf *pf, u16 id, u8 response, u8 code,
 	case NVM_COMP_ID_NETLIST:
 		component = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		component = "fw.pqc_manifest";
+		break;
 	default:
 		WARN(1, "Unexpected unknown component identifier 0x%02x", id);
 		return -EINVAL;
@@ -220,12 +236,26 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
 	struct ice_pf *pf = priv->pf;
 	struct ice_hw *hw = &pf->hw;
 	size_t length;
+	u8 comp_bit;
 	int status;
 
 	switch (component->identifier) {
 	case NVM_COMP_ID_OROM:
+		comp_bit = ICE_FWU_COMP_OROM;
+		break;
 	case NVM_COMP_ID_NVM:
+		comp_bit = ICE_FWU_COMP_NVM;
+		break;
 	case NVM_COMP_ID_NETLIST:
+		comp_bit = ICE_FWU_COMP_NETLIST;
+		break;
+	case NVM_COMP_ID_MANIFEST:
+		if (!priv->erot_present) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Manifest component requires an eRoT capable adapter");
+			return -EOPNOTSUPP;
+		}
+		comp_bit = ICE_FWU_COMP_MANIFEST;
 		break;
 	default:
 		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
@@ -234,6 +264,19 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
 		return -EOPNOTSUPP;
 	}
 
+	if (priv->erot_present) {
+		if (priv->seen_components & comp_bit) {
+			NL_SET_ERR_MSG_MOD(extack, "Duplicate component in PLDM image");
+			return -EINVAL;
+		}
+		/* the PLDM parser accepts a component without any data */
+		if (!component->component_size) {
+			NL_SET_ERR_MSG_MOD(extack, "Firmware component carries no data to flash");
+			return -EINVAL;
+		}
+		priv->seen_components |= comp_bit;
+	}
+
 	length = struct_size(comp_tbl, cvs, component->version_len);
 	comp_tbl = kzalloc(length, GFP_KERNEL);
 	if (!comp_tbl)
@@ -623,6 +666,25 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 	return 0;
 }
 
+/**
+ * ice_fwu_check_erot - reject an eRoT update that misses a component
+ * @priv: PLDM firmware update private data
+ *
+ * An eRoT authenticates the complete NVM image, so all four components
+ * must be updated together.
+ *
+ * Returns: zero when the update may proceed, -EINVAL otherwise.
+ */
+static int ice_fwu_check_erot(struct ice_fwu_priv *priv)
+{
+	if (!priv->erot_present || priv->seen_components == ICE_FWU_COMP_ALL_EROT)
+		return 0;
+
+	NL_SET_ERR_MSG_MOD(priv->extack,
+			   "eRoT adapter requires fw.mgmt, fw.undi, fw.netlist and fw.pqc_manifest");
+	return -EINVAL;
+}
+
 /**
  * ice_flash_component - Flash a component of the NVM
  * @context: PLDM fw update structure
@@ -667,6 +729,13 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 		reset_level = NULL;
 		name = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		module = ICE_SR_PQC_MANIFEST_BANK_PTR;
+		/* the activation select mask has no bit for the manifest */
+		flag = 0;
+		reset_level = NULL;
+		name = "fw.pqc_manifest";
+		break;
 	default:
 		/* This should not trigger, since we check the id before
 		 * sending the component table to firmware.
@@ -676,6 +745,13 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 		return -EINVAL;
 	}
 
+	/* every component table is sent before the first component is flashed,
+	 * so all components of the image are already known here
+	 */
+	err = ice_fwu_check_erot(priv);
+	if (err)
+		return err;
+
 	/* Mark this component for activating at the end */
 	priv->activate_flags |= flag;
 
@@ -706,6 +782,11 @@ static int ice_finalize_update(struct pldmfw *context)
 	struct devlink *devlink;
 	int err;
 
+	/* an image without any applicable component still reaches this point */
+	err = ice_fwu_check_erot(priv);
+	if (err)
+		return err;
+
 	/* Finally, notify firmware to activate the written NVM banks */
 	err = ice_switch_flash_banks(pf, priv->activate_flags,
 				     &priv->emp_reset_available, extack);
@@ -843,6 +924,39 @@ static const struct pldmfw_ops ice_fwu_ops_e822 = {
 	.finalize_update = &ice_finalize_update,
 };
 
+/**
+ * ice_pending_updates_from_caps - Report the pending updates of a caps read
+ * @pf: the PF driver structure
+ * @pending: on return, bitmap of updates pending
+ * @dev_caps: device capabilities holding the pending flags
+ *
+ * Build the bitmap of flash components with an update pending, from an
+ * already read set of device capabilities.
+ */
+static void
+ice_pending_updates_from_caps(struct ice_pf *pf, u8 *pending,
+			      const struct ice_hw_dev_caps *dev_caps)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+
+	*pending = 0;
+
+	if (dev_caps->common_cap.nvm_update_pending_nvm) {
+		dev_info(dev, "The fw.mgmt flash component has a pending update\n");
+		*pending |= ICE_AQC_NVM_ACTIV_SEL_NVM;
+	}
+
+	if (dev_caps->common_cap.nvm_update_pending_orom) {
+		dev_info(dev, "The fw.undi flash component has a pending update\n");
+		*pending |= ICE_AQC_NVM_ACTIV_SEL_OROM;
+	}
+
+	if (dev_caps->common_cap.nvm_update_pending_netlist) {
+		dev_info(dev, "The fw.netlist flash component has a pending update\n");
+		*pending |= ICE_AQC_NVM_ACTIV_SEL_NETLIST;
+	}
+}
+
 /**
  * ice_get_pending_updates - Check if the component has a pending update
  * @pf: the PF driver structure
@@ -857,7 +971,6 @@ static const struct pldmfw_ops ice_fwu_ops_e822 = {
 int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
 			    struct netlink_ext_ack *extack)
 {
-	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw_dev_caps *dev_caps;
 	struct ice_hw *hw = &pf->hw;
 	int err;
@@ -878,22 +991,7 @@ int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
 		return err;
 	}
 
-	*pending = 0;
-
-	if (dev_caps->common_cap.nvm_update_pending_nvm) {
-		dev_info(dev, "The fw.mgmt flash component has a pending update\n");
-		*pending |= ICE_AQC_NVM_ACTIV_SEL_NVM;
-	}
-
-	if (dev_caps->common_cap.nvm_update_pending_orom) {
-		dev_info(dev, "The fw.undi flash component has a pending update\n");
-		*pending |= ICE_AQC_NVM_ACTIV_SEL_OROM;
-	}
-
-	if (dev_caps->common_cap.nvm_update_pending_netlist) {
-		dev_info(dev, "The fw.netlist flash component has a pending update\n");
-		*pending |= ICE_AQC_NVM_ACTIV_SEL_NETLIST;
-	}
+	ice_pending_updates_from_caps(pf, pending, dev_caps);
 
 	kfree(dev_caps);
 
@@ -904,6 +1002,7 @@ int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
  * ice_cancel_pending_update - Cancel any pending update for a component
  * @pf: the PF driver structure
  * @component: if not NULL, the name of the component being updated
+ * @dev_caps: device capabilities to read the pending updates from
  * @extack: Netlink extended ACK structure
  *
  * Cancel any pending update for the specified component. If component is
@@ -913,6 +1012,7 @@ int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
  */
 static int
 ice_cancel_pending_update(struct ice_pf *pf, const char *component,
+			  const struct ice_hw_dev_caps *dev_caps,
 			  struct netlink_ext_ack *extack)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
@@ -921,9 +1021,7 @@ ice_cancel_pending_update(struct ice_pf *pf, const char *component,
 	u8 pending;
 	int err;
 
-	err = ice_get_pending_updates(pf, &pending, extack);
-	if (err)
-		return err;
+	ice_pending_updates_from_caps(pf, &pending, dev_caps);
 
 	/* If the flash_update request is for a specific component, ignore all
 	 * of the other components.
@@ -981,9 +1079,10 @@ ice_cancel_pending_update(struct ice_pf *pf, const char *component,
  * formatted image that matches this device.
  *
  * Extract the device record Package Data and Component Tables and send them
- * to the firmware. Extract and write the flash data for each of the three
- * main flash components, "fw.mgmt", "fw.undi", and "fw.netlist". Notify
- * firmware once the data is written to the inactive banks.
+ * to the firmware. Extract and write the flash data for each of the main
+ * flash components, "fw.mgmt", "fw.undi", and "fw.netlist", plus
+ * "fw.pqc_manifest" on eRoT adapters. Notify firmware once the data is
+ * written to the inactive banks.
  *
  * Returns: zero on success or a negative error code on failure.
  */
@@ -994,6 +1093,7 @@ int ice_devlink_flash_update(struct devlink *devlink,
 	struct ice_pf *pf = devlink_priv(devlink);
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
+	struct ice_hw_dev_caps *dev_caps;
 	struct ice_fwu_priv priv;
 	u8 preservation;
 	int err;
@@ -1013,18 +1113,52 @@ int ice_devlink_flash_update(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
+	dev_caps = kzalloc_obj(*dev_caps);
+	if (!dev_caps)
+		return -ENOMEM;
+
+	/* Read the most recent device capabilities from firmware. Do not use
+	 * the cached values in hw->dev_caps: a driver loaded while firmware
+	 * was already in recovery mode never reads them, and a reset may be
+	 * rebuilding them while this request runs. The same read serves the
+	 * pending update check below, so this costs one AQ command per flash
+	 * attempt, as it did before.
+	 */
+	err = ice_discover_dev_caps(hw, dev_caps);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to read device capabilities");
+		kfree(dev_caps);
+		return err;
+	}
+
+	if (dev_caps->common_cap.external_pqc_rot_invalid) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid eRoT capability reported by firmware");
+		err = -EIO;
+		goto free_caps;
+	}
+
+	if (!dev_caps->common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
 		NL_SET_ERR_MSG_MOD(extack, "Current firmware does not support unified update");
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto free_caps;
 	}
 
 	memset(&priv, 0, sizeof(priv));
+	priv.erot_present = dev_caps->common_cap.external_pqc_rot_present;
+
+	if (params->component && priv.erot_present) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "eRoT adapter does not support single component update");
+		err = -EOPNOTSUPP;
+		goto free_caps;
+	}
 
 	if (params->component && strcmp(params->component, "fw.mgmt") == 0) {
 		priv.context.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
 		priv.context.component_identifier = NVM_COMP_ID_NVM;
 	} else if (params->component) {
-		return -EOPNOTSUPP;
+		err = -EOPNOTSUPP;
+		goto free_caps;
 	}
 
 	/* the E822 device needs a slightly different ops */
@@ -1039,7 +1173,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
 
 	devlink_flash_update_status_notify(devlink, "Preparing to flash", NULL, 0, 0);
 
-	err = ice_cancel_pending_update(pf, NULL, extack);
+	err = ice_cancel_pending_update(pf, NULL, dev_caps, extack);
+	kfree(dev_caps);
 	if (err)
 		return err;
 
@@ -1066,4 +1201,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
 	ice_release_nvm(hw);
 
 	return err;
+
+free_caps:
+	kfree(dev_caps);
+	return err;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1ff69f7..0fed29d 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1152,6 +1152,7 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_OROM_BANK_SIZE		0x45
 #define ICE_SR_NETLIST_BANK_PTR		0x46
 #define ICE_SR_NETLIST_BANK_SIZE	0x47
+#define ICE_SR_PQC_MANIFEST_BANK_PTR	0x4E
 #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
 
 /* CSS Header words */
-- 
2.56.0

