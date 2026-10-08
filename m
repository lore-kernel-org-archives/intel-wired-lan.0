Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74850CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 14:14:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1760D81283;
	Thu,  8 Oct 2026 14:14:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r5lpwDjkFbXj; Thu,  8 Oct 2026 14:14:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 18B46812C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791468868;
	b=JUVJqFdJjr6KHtJgctebg3c/NsJQL7bqlei3iEaIhDTUT6beZU39xs7wVQ+YYl5oFLCL
	 ZJ38n7HjPVLpoWIRCdZwHQDQ9L0Pq0CD4Bttmu3CoTKUipg7PV1cC02PqWFbPGq+6wKn5
	 aw0NczZDSS8MtolYKlkrqtRf/l/DAcPkwFkDRMJ9OZ9UlPYqMfQn1QEmz9z5q5CVr/TRM
	 Ee0F5n8VaACglRLzo+FlhcvBm9F9r3w0T5+nuXcqzuHCnjjTp5Ix2/rJFLhCZU3pQY6X/
	 aSBBC5Ess87rAxt/s+sNcbzJeEl1dbimqgmNaDDnnJGk8YTuEtjNpsjo8o8bEspsx6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791468868;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NRuKAXOunpHS0ihAl2NrHTUle5uBTiggtBleHM70Wdg=;
	b=p8ggMXtnh5YdAISPHapg5r5xxNk8Ll9B4yjoty9d7o8h/EeiB4+/Q30wpAmGxVEDUL7u
	 06cSsR7+DoIl303heX50w3+iRlLaAvhC5IExdjFVL4Rt3L07yvdvVNWbyvo7ofvCu/ic/
	 +ZCn4F4rDxd1YfSkdxbPoRIgSYwaWGBcxRy/hGgFgJRyr9qavi0ETdYTC7S8j225Hlf/y
	 SV+1Z+SXEXzvpDRrvJirtz6HcgQsPIxUuOYO4jYGJwWvSJ/IlahYrWc0U7bAF/M+9N53u
	 DpAK3PO0KF/GGs6M/Rg6gi3zuHwiZdg8YqftW5/BV8+Bfo8uHykBRoW3uPDS/c6yq2A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791468868;
	bh=NRuKAXOunpHS0ihAl2NrHTUle5uBTiggtBleHM70Wdg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e2+QcNrr3hC+qwdKQEhV7GkvYzhEp9DY8fccupdiH5hbcmMgNTfIrWJJkcyvscvu3
	 ZMsob2CFYBqK7Gkat/ZRLn1YbZ6HOL3o1bnq64Ov4IvckP/ic/hfHjeEOWDQl1vBtF
	 7+KAdWeVIutK59q99VVvEFcbd2Oji3yJXGHqAjpFQUvNGHUs+V2o+aafP/vqtwsa5L
	 varH1PCfoHfe05JYsxHXk5WeuDwzBkuNBVKHe/Gjl4GDnxp7tvGfQzdY5+I344WqqN
	 blilg4GdIltXyT4p8Ia6z/zLIZ8ccYDqXftchFYh5xBbBBbZGh15AcQN8PtJFEJJ78
	 JvMwtqVVX2Ayw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18B46812C0;
	Thu,  8 Oct 2026 14:14:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F14C338
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 34E8C40ABB
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7C8DPV8eto-l for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 14:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0B31840AEF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791468864;
 b=je0vq8sxn6dknXhvqY6zinBREHiI4Wmo6arA37Vq3FKl3ragb2yoTbGIIX4tUxy/6V09
 X5/h0BhCzDforBnsYdm//mpdE70EftjibP94FW9c3hC087bq4SkqQadlgjq+XTT1bTeVR
 mXx+zimlrjsVOYSEDnNKSyFAWKCNHfuKgvCtL3BzdWuFZCWPYwnrSvcB6bS+nlFz/Qooo
 CB1R9mxh/x+dXTZH/GgQkadP96UmnDdGCpOtrTpqSCR+xqO+5xCxCNvIEswwToZ9Q6sez
 eM4s3Or1z0dc5NHQGgBEbaOMljAaV6dI4U6RAOsNqbsPm5T1bfrU+faK82m8ltGcPkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791468864;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NRuKAXOunpHS0ihAl2NrHTUle5uBTiggtBleHM70Wdg=;
 b=IgFzr1RBAcYAKc1sQogLHqzEQs3+tuUTABvy22fB4RM+JSHUZMufWIGy8CYMXWZvb9BM
 D5wwTGaOQsTVhT728HIPm4WbvKczmJCvVYUx0HGZiS12IAi8+wODHRHqpUK5pKpMiiLh5
 6CDIyQY5cR+P9OTWONGU0qOlBckBlPr1r/a2yoFtmHQTRNKydM55uu4eN0TrgOUUOVHwb
 CYi0eMIaSz6Mufkq8C4ExV2IVNPD50Se5T1r8q1pPlHgCXHC5MA8ywiKf943XPMSDOWLw
 NVgKK4G1GAjS/FQsA866m9dHi8lkoCslS6xmZBAF9CBnkYlq+AvRpmsEHzq4ffl1HjA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N23PuGRu; 
 arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=N23PuGRu
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B31840AEF
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 14:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791468864; x=1823004864;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NrP7N6qpCmIYyDJNH1ogSI5Pf4lKqi14J+YEWHVoXsU=;
 b=N23PuGRuxeAdYglIlpLnsKI0TERFQdxaLweVjp4qOlUD9IAm6SW03OQG
 DKhpTM6rogEyn3uf7NSo3k/PM1xTY3I+QTu37RjjhXjiQIIVtergqzfew
 2AeGS5aeXFjo8iMD8XMMK/2+hHbAD5H2NHKYo6uqPYgYqc3NPjPQvVl8Y
 oU3ydNQqJy7iU4Yosfcv6VUZUOsAEdX/kyJE3v16dFsDweSlheiUyyqZt
 rPk3TMqcbkZG/VNKphvtstrIpz/IobK8LYuoie5DfFOHUbSDILAKmIAeB
 ZfXXrLtKyec0JhmvD8Z2nDj2pnmHIZvtv+9gDReUbZADAaACVhv9k2+zX w==;
X-CSE-ConnectionGUID: VHy1twulQRO44z9wFNAW4A==
X-CSE-MsgGUID: kddOwNftRWGN2WpQZIEIQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="250633"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="250633"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 07:14:24 -0700
X-CSE-ConnectionGUID: ulRFivNqSbizLorGSlEYjA==
X-CSE-MsgGUID: es83QinJTCKv7/gQ+/WYfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1887330"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa012.fm.intel.com with ESMTP; 08 Oct 2026 07:14:22 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 2/2] ice: reject partial NVM update on eRoT
 adapters
Date: Thu,  8 Oct 2026 16:14:18 +0200
Message-ID: <20261008141418.958066-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
References: <20261008141418.958066-1-aleksandr.loktionov@intel.com>
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

Require NVM, OROM, NetList and Manifest together when firmware reports
eRoT presence. Track the component IDs while sending the PLDM component
tables and reject an incomplete set before erasing a bank. Reject
duplicates only for eRoT updates, leaving ordinary duplicate handling
unchanged.

Read fresh device capabilities for each flash attempt before canceling
a pending update or acquiring the NVM write lock. Use the confirmed eRoT
presence as a per-update snapshot for component selection and validation.
This avoids depending on probe-time state after reset or in recovery,
where normal hardware initialization is skipped. Use the same fresh
query for the unified-update check, retaining its recovery bypass.

Treat an omitted capability as absent, retaining legacy full-image and
fw.mgmt component updates. Enable eRoT-specific restrictions only when
firmware explicitly reports presence. Older eRoT hardware whose firmware
omits the capability is not protected by the early completeness checks.

Propagate discovery errors and reject explicitly reported values other
than 0 or 1 before pending-update cancellation or the NVM write lock.
Neither case reaches package transfer, erase, write or activation.
Recovery mode does not bypass this check or require full hardware
initialization. Pending-update cancellation already discovers device
capabilities, so recovery flashing required that query before this series.

Reject single-component requests up front when eRoT presence is reported.
Keep the completeness check independent of the PLDM END flag: component
filtering can omit the component that would carry END. Also check before
finalization, since an empty applicable component list skips the flash
callback but still reaches bank activation.

Accept Manifest only with confirmed eRoT presence. Its activation flag
is zero: the AQ activation-select mask has bits for NVM, OROM and NetList,
but none for Manifest. This does not establish its activation timing.
Define its bank pointer, without adding an unused bank-size constant.

Document the component rule and the capability-only policy in normal
and recovery modes. These checks neither authenticate image contents
nor make the update atomic.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 Documentation/networking/devlink/ice.rst      | 21 +++++
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 87 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 4 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 792e9f8..e03630a 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -205,6 +205,27 @@ The ``ice`` driver implements support for flash update using the
 combined flash image that contains the ``fw.mgmt``, ``fw.undi``, and
 ``fw.netlist`` components.
 
+When firmware reports an external Root of Trust (eRoT) as present, the
+image must also contain the ``fw.pqc_manifest`` component, and all four
+components must be updated together. Images missing any of them, or
+containing a component more than once, are rejected before any flash bank
+is erased. An empty applicable component list is rejected before
+activation. Updating a single component (``component fw.mgmt``) is not
+supported when eRoT presence is reported. ``fw.pqc_manifest`` is accepted
+only when firmware reports eRoT presence. These checks do not authenticate
+the image contents or make the update atomic.
+
+Before each flash attempt, the driver reads device capabilities from
+firmware. An omitted eRoT capability is treated as absent, preserving
+legacy full-image and ``component fw.mgmt`` updates. Older eRoT hardware
+whose firmware omits the capability is not protected by the early
+completeness checks. An explicitly reported value other than 0 (absent)
+or 1 (present), or failure to read capabilities, blocks the update before
+any pending update is canceled or a flash write lock is acquired. This
+policy also applies in recovery mode, which only bypasses the separate
+unified-update capability check. Pending-update cancellation already
+requires capability discovery, including in recovery mode.
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
index 3631461..9da7df6 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -9,6 +9,13 @@
 #include "ice_lib.h"
 #include "ice_fw_update.h"
 
+#define ICE_FWU_COMP_NVM		BIT(0)
+#define ICE_FWU_COMP_OROM		BIT(1)
+#define ICE_FWU_COMP_NETLIST	BIT(2)
+#define ICE_FWU_COMP_MANIFEST	BIT(3)
+#define ICE_FWU_COMP_ALL_EROT	(ICE_FWU_COMP_NVM | ICE_FWU_COMP_OROM | \
+				 ICE_FWU_COMP_NETLIST | ICE_FWU_COMP_MANIFEST)
+
 struct ice_fwu_priv {
 	struct pldmfw context;
 
@@ -29,6 +36,8 @@ struct ice_fwu_priv {
 
 	/* Track if EMP reset is available */
 	u8 emp_reset_available;
+	u8 seen_components;
+	bool erot_present;
 };
 
 /**
@@ -108,6 +117,9 @@ ice_check_component_response(struct ice_pf *pf, u16 id, u8 response, u8 code,
 	case NVM_COMP_ID_NETLIST:
 		component = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		component = "fw.pqc_manifest";
+		break;
 	default:
 		WARN(1, "Unexpected unknown component identifier 0x%02x", id);
 		return -EINVAL;
@@ -220,12 +232,27 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
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
+			dev_err(dev, "Manifest component is not supported on adapters without eRoT\n");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Manifest component is not supported on adapters without eRoT");
+			return -EOPNOTSUPP;
+		}
+		comp_bit = ICE_FWU_COMP_MANIFEST;
 		break;
 	default:
 		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
@@ -234,6 +261,14 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
 		return -EOPNOTSUPP;
 	}
 
+	if (priv->erot_present && (priv->seen_components & comp_bit)) {
+		dev_err(dev, "Duplicate component in PLDM image: component ID 0x%02x\n",
+			component->identifier);
+		NL_SET_ERR_MSG_MOD(extack, "Duplicate component in PLDM image");
+		return -EOPNOTSUPP;
+	}
+	priv->seen_components |= comp_bit;
+
 	length = struct_size(comp_tbl, cvs, component->version_len);
 	comp_tbl = kzalloc(length, GFP_KERNEL);
 	if (!comp_tbl)
@@ -648,6 +683,12 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 	u8 flag;
 	int err;
 
+	if (priv->erot_present && priv->seen_components != ICE_FWU_COMP_ALL_EROT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
+		return -EINVAL;
+	}
+
 	switch (component->identifier) {
 	case NVM_COMP_ID_OROM:
 		module = ICE_SR_1ST_OROM_BANK_PTR;
@@ -667,6 +708,13 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 		reset_level = NULL;
 		name = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		module = ICE_SR_PQC_MANIFEST_BANK_PTR;
+		/* The AQ activation-select mask has no Manifest bit. */
+		flag = 0;
+		reset_level = NULL;
+		name = "fw.pqc_manifest";
+		break;
 	default:
 		/* This should not trigger, since we check the id before
 		 * sending the component table to firmware.
@@ -706,6 +754,12 @@ static int ice_finalize_update(struct pldmfw *context)
 	struct devlink *devlink;
 	int err;
 
+	if (priv->erot_present && priv->seen_components != ICE_FWU_COMP_ALL_EROT) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
+		return -EINVAL;
+	}
+
 	/* Finally, notify firmware to activate the written NVM banks */
 	err = ice_switch_flash_banks(pf, priv->activate_flags,
 				     &priv->emp_reset_available, extack);
@@ -981,9 +1035,9 @@ ice_cancel_pending_update(struct ice_pf *pf, const char *component,
  * formatted image that matches this device.
  *
  * Extract the device record Package Data and Component Tables and send them
- * to the firmware. Extract and write the flash data for each of the three
- * main flash components, "fw.mgmt", "fw.undi", and "fw.netlist". Notify
- * firmware once the data is written to the inactive banks.
+ * to the firmware. Extract and write the flash data for the selected firmware
+ * components: "fw.mgmt", "fw.undi", "fw.netlist", and, when firmware reports
+ * eRoT presence, "fw.pqc_manifest". Notify firmware once the data is written.
  *
  * Returns: zero on success or a negative error code on failure.
  */
@@ -1013,12 +1067,37 @@ int ice_devlink_flash_update(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
+	struct ice_hw_dev_caps *dev_caps __free(kfree) =
+		kzalloc_obj(*dev_caps);
+	if (!dev_caps)
+		return -ENOMEM;
+
+	err = ice_discover_dev_caps(hw, dev_caps);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot determine eRoT state: unable to read firmware device capabilities");
+		return err;
+	}
+
+	if (dev_caps->common_cap.external_pqc_rot_invalid) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid eRoT capability reported by firmware");
+		return -EOPNOTSUPP;
+	}
+
+	if (!dev_caps->common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
 		NL_SET_ERR_MSG_MOD(extack, "Current firmware does not support unified update");
 		return -EOPNOTSUPP;
 	}
 
 	memset(&priv, 0, sizeof(priv));
+	priv.erot_present = dev_caps->common_cap.external_pqc_rot_present;
+
+	if (params->component && priv.erot_present) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "eRoT adapter does not support single component update");
+		return -EOPNOTSUPP;
+	}
 
 	if (params->component && strcmp(params->component, "fw.mgmt") == 0) {
 		priv.context.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1fede0f..43f3208 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1151,6 +1151,7 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_OROM_BANK_SIZE		0x45
 #define ICE_SR_NETLIST_BANK_PTR		0x46
 #define ICE_SR_NETLIST_BANK_SIZE	0x47
+#define ICE_SR_PQC_MANIFEST_BANK_PTR	0x4E
 #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
 
 /* CSS Header words */
-- 
2.52.0

