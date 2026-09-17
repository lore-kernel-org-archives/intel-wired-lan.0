Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B86C982D0
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 09:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D597B60849;
	Thu, 17 Sep 2026 09:43:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBU-I6wCXBXt; Thu, 17 Sep 2026 09:43:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 444106084D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789638203;
	b=eROU8ohif+YjctEXj357I0vAF3QfvJflubTDQVXXJH1db0taPliKw33kHjjYhVuMIDZR
	 bsed7fBalMz58OXRL56lZ/qTemnXJANcvHBGJ45xhWmjMnO+OpjRhCS1tkO2eDboUbFN6
	 nHkoAw21z5jVV9LzOn6os3sbrWeiudm0S1ag/eTfirZKpp6LuJWzoc3efbnXQhFToEfZd
	 Mcwy4nqI7AK+3TtFDp5aTIl4untHC6YhbbuznK99jLRxl3RT2M4ZOI8xEjSKN4sg7xUno
	 xUZP51ap4hG8jTptg9pYmtd4W3ua9n2epsOvNULwG2QjRISRRbwwuClfu5GpzVHFlMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789638203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xTUxiiexcpuZgJc3Tn6SduP+wXOTfsQB0kIU50HENPI=;
	b=spK+hM7xeT7CpAQJRU7irBtiAgqyJh+5zNdODIou4/bBPQIuaG8I+6fQCIJrYYPt+zSN
	 s9QYGkc6Wjz4LFIy8mJkdDoW1hibJ2jFtl71gpkgJJnxyWTKiwX8n95RbP9hZInccUmaQ
	 Ya7zbqXw2bA0sH8vWHAg48MzRGAPs2klyg/EezQgtFnooFFQC10vFIrev7djTptKMjgU3
	 Im1GclKVCI0S+wJqO39BaFjRSzgkhUWOZecwHuLXDrXelpIW5yBq0tYuhyev0GFxHExqI
	 CZmGd02jMvPDblpQoxpNmWFSTCJlxJyvoaPpf6k7aiWLInnbYIcWk2JaW36slWg6h0A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789638203;
	bh=xTUxiiexcpuZgJc3Tn6SduP+wXOTfsQB0kIU50HENPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CRsuWRtm6mePeqY+JdsFtSf0bgLTvhzLUDynpdKUBRkDaimS78m8fENtMX9XJqUGc
	 QT+EhwA6aa8p0bSYLwpABleCgeCH70N5tn9jLdw5sgWOZ4yr4/A4dRDjP8cpIdHY8A
	 t1cfx8kQMB5dLMy9WexVW14T2GujVTk632EjTLFiP9sl10D05ewj7hUNPTHB1vmK6Z
	 g09GRYGBKmIqhoQgBlElTrFOfctMeuFiM5JvmKE/yM3+w9Z6uWsBry9+fGd3+5tFcL
	 CBU2uIs26G2cXGg567WHCAQZi4dC6VzRIUtiBi6UOz9qZoS8qy/SyTkWeKzWSrBnxg
	 1sj/yx+kuiKYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 444106084D;
	Thu, 17 Sep 2026 09:43:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DA4329B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23CB980E17
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id szlSbEFjIKih for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 09:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3EBD780C8E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789638200;
 b=Bg6yio7SvluHBM8oEWYNtWZAC3xld2wQ69eAxTqXbltKO0fECIKeGERbWWfXJMwdDJH9
 ttdWF8MHyCrtFWMgzS4uSA9PaXYPBVeYBW/Shqn7HLrKEEVbQvC1hjBNGsg6kEOo50uti
 FcgaOjx3p2kWkkJu9YHVbbVvh9l9gbKNukKng4i5tdnyGGJnVcmcxZsKC0sBD84togziU
 SsWegLpZIWtuO1EHLGKYjeqB6OkWLmDopPQiQj7UIJpVQAjnGos7eCZIVOS+gyaSXckhN
 7/ulphfMIjsLalcMLrc69HtEN9ReOHA4h9OYu/US4EKMst2gLoDWRBfGxu1GUMgGpBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789638200;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=xTUxiiexcpuZgJc3Tn6SduP+wXOTfsQB0kIU50HENPI=;
 b=ggML59lbrqWQ8E9sFIp00AmTngGfYsaklvaorwl+oG8hntW0vjGCUV6Ad4ldWs8LNRdn
 MeFW1spPDaK33BRuUqLACpXg0PjgnaW1sm05go2rJ1S+wuOs5qyCB3GeeZalAaO4KHEVT
 mo5HTexWtqxoKxo8vRbTAgj67Q0t9Axkn6VOtNqNu2PjEnZR0LsbtqyvEOnT2KOO/5krC
 JGdq0iyvmqsBLOc0IXurgefbHychPUGFV9xgMLx2l0GCJtOLINtf8DCDe0O6w1SSDIl2E
 pJi4X1FBOiBPIsUt2GuW7aQFAjIzJwFhKRzUoPSFr/WW3QsbpMoCVYMvTivUU8hECsw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=E00Cb4mZ; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E00Cb4mZ
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EBD780C8E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789638200; x=1821174200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/BAU9fM10RY8rU47cWaGcpIhfOTKVAOERSObnvW3YXs=;
 b=E00Cb4mZF8thqThA3XYcuOLnvMd/oNxLtfAg8/2n+hhadFVimioylSWG
 dSIOenMuEDDSC2G/rDKQmxcSV6wFY0alVOayMKTITtja6XJxEj150I4ua
 m4g44pWNDqY+Vf3gENEgxPPOSUp0ze5TDmNjxbKIgznG0b+DUywhlF2sK
 JKFYCJ8vdyUNDallUHIqbHwhRlXQw5ZtiSXep+AIYmNhe5vyz/cqo/v3P
 Ybx8ERjDl+kWhYb9HXIXjmFzYNiEItWM/FEqNURo3F810qsNMEBTUuGiH
 /g/iQHC6cLmEMlJAit+LnSo55JAJgM02iZPbCZoCW5cZhydkNF3p46eUm A==;
X-CSE-ConnectionGUID: md7QLrZMQzykYjylLg+0SA==
X-CSE-MsgGUID: pr0ZKO2YSQG79LyVJyTwuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100706510"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100706510"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:43:20 -0700
X-CSE-ConnectionGUID: NUzE5kMeQJOpH/NnhcDf5A==
X-CSE-MsgGUID: L9mp1qzbS7Ot3OPFZ+KGxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269400593"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2026 02:43:17 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, e02905820face5404ac5eb8193ba94f9823c4606, Mon, Sep,
 17, 00:00:00, 2001, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Thu, 17 Sep 2026 11:43:12 +0200
Message-ID: <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
References: <20260917094312.1567881-1-aleksandr.loktionov@intel.com>
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

On eRoT adapters, firmware rejects partial NVM updates mid-session.
Detect this proactively before any flash writes by tracking which PLDM
components have been presented in ice_send_component_table().

All four authentication components must be present for an eRoT update:
NVM Bank, OROM, NetList, and Manifest.  If any are absent when
ice_flash_component() is called, reject with -EPERM and a clear
netlink error message before erasing any flash bank.

NVM_COMP_ID_MANIFEST only exists on eRoT adapters; the Shadow RAM
pointer backing it (module 0x4E) is unallocated on other hardware.
Accept it in ice_send_component_table() only when ICE_F_EROT is
supported, so a non-eRoT adapter still rejects it as an unknown
component before any flash write, same as before this patch. Its
activate-select flag is 0, since the ACTIV_SEL bitmask only defines
bits for NVM, OROM, and NetList.

Duplicate component IDs within a single PLDM image are also rejected
in ice_send_component_table() before the component table is sent to
firmware.

Unlike its NVM/OROM/NetList siblings, the manifest bank has no
ICE_SR_PQC_MANIFEST_BANK_SIZE counterpart: nothing reads the manifest
area size back via ice_read_sr_area_size(), so only the bank pointer
is defined.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 80 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_type.h     |  1 +
 3 files changed, 82 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 42878ab..b240f2c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1747,6 +1747,7 @@ struct ice_aqc_nvm_comp_tbl {
 #define NVM_COMP_ID_OROM	0x5
 #define NVM_COMP_ID_NVM		0x6
 #define NVM_COMP_ID_NETLIST	0x8
+#define NVM_COMP_ID_MANIFEST	0x12
 
 	u8 comp_class_idx;
 #define FWU_COMP_CLASS_IDX_NOT_USE 0x0
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 3631461..fe68efa 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -9,6 +9,18 @@
 #include "ice_lib.h"
 #include "ice_fw_update.h"
 
+/* Bitmask values for ice_fwu_priv::seen_components */
+#define ICE_FWU_COMP_NVM		BIT(0)
+#define ICE_FWU_COMP_OROM		BIT(1)
+#define ICE_FWU_COMP_NETLIST		BIT(2)
+#define ICE_FWU_COMP_MANIFEST		BIT(3)
+/* Components required for a complete eRoT-authenticated update.
+ * If firmware adds further authentication components in future
+ * hardware, this mask must be extended to match.
+ */
+#define ICE_FWU_COMP_ALL_EROT		(ICE_FWU_COMP_NVM | ICE_FWU_COMP_OROM | \
+					 ICE_FWU_COMP_NETLIST | ICE_FWU_COMP_MANIFEST)
+
 struct ice_fwu_priv {
 	struct pldmfw context;
 
@@ -29,6 +41,9 @@ struct ice_fwu_priv {
 
 	/* Track if EMP reset is available */
 	u8 emp_reset_available;
+
+	/* Bitmask of auth components seen in this image (ICE_FWU_COMP_*) */
+	u8 seen_components;
 };
 
 /**
@@ -108,6 +123,9 @@ ice_check_component_response(struct ice_pf *pf, u16 id, u8 response, u8 code,
 	case NVM_COMP_ID_NETLIST:
 		component = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		component = "fw.pqc_manifest";
+		break;
 	default:
 		WARN(1, "Unexpected unknown component identifier 0x%02x", id);
 		return -EINVAL;
@@ -220,12 +238,28 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
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
+		if (!ice_is_feature_supported(pf, ICE_F_EROT)) {
+			dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
+				component->identifier);
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Unable to update due to unknown firmware component");
+			return -EOPNOTSUPP;
+		}
+		comp_bit = ICE_FWU_COMP_MANIFEST;
 		break;
 	default:
 		dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
@@ -234,6 +268,14 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
 		return -EOPNOTSUPP;
 	}
 
+	if (priv->seen_components & comp_bit) {
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
@@ -623,6 +665,24 @@ ice_switch_flash_banks(struct ice_pf *pf, u8 activate_flags,
 	return 0;
 }
 
+/**
+ * ice_has_erot_incomplete - check whether an eRoT update is missing a component
+ * @priv: PLDM firmware update private data
+ *
+ * On eRoT adapters all four authentication components must be present.
+ *
+ * Return: true when a required component is absent on an eRoT adapter (the
+ * update must be rejected), false otherwise (including non-eRoT adapters).
+ */
+static bool
+ice_has_erot_incomplete(struct ice_fwu_priv *priv)
+{
+	if (!ice_is_feature_supported(priv->pf, ICE_F_EROT))
+		return false;
+
+	return priv->seen_components != ICE_FWU_COMP_ALL_EROT;
+}
+
 /**
  * ice_flash_component - Flash a component of the NVM
  * @context: PLDM fw update structure
@@ -667,6 +727,16 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 		reset_level = NULL;
 		name = "fw.netlist";
 		break;
+	case NVM_COMP_ID_MANIFEST:
+		module = ICE_SR_PQC_MANIFEST_BANK_PTR;
+		/* Manifest has no ACTIV_SEL bit of its own; ACTIV_SEL only
+		 * defines activation bits for NVM, OROM, and NetList, so
+		 * there is nothing to add to priv->activate_flags here.
+		 */
+		flag = 0;
+		reset_level = NULL;
+		name = "fw.pqc_manifest";
+		break;
 	default:
 		/* This should not trigger, since we check the id before
 		 * sending the component table to firmware.
@@ -676,6 +746,16 @@ ice_flash_component(struct pldmfw *context, struct pldmfw_component *component)
 		return -EINVAL;
 	}
 
+	/* ice_send_component_table() is called for every component in the
+	 * PLDM image before pldmfw_flash_image() ever calls this function,
+	 * so priv->seen_components is already fully populated by the time
+	 * the first component reaches ice_flash_component().
+	 */
+	if (ice_has_erot_incomplete(priv)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "eRoT adapter requires all four components (NVM, OROM, NetList, Manifest) in a single update");
+		return -EINVAL;
+	}
 	/* Mark this component for activating at the end */
 	priv->activate_flags |= flag;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1375106..847f17e6 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -1154,6 +1154,7 @@ struct ice_aq_get_set_rss_lut_params {
 #define ICE_SR_OROM_BANK_SIZE		0x45
 #define ICE_SR_NETLIST_BANK_PTR		0x46
 #define ICE_SR_NETLIST_BANK_SIZE	0x47
+#define ICE_SR_PQC_MANIFEST_BANK_PTR	0x4E
 #define ICE_SR_SECTOR_SIZE_IN_WORDS	0x800
 
 /* CSS Header words */
-- 
2.52.0


