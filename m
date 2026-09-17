Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132F6C982D2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 09:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2B78404EC;
	Thu, 17 Sep 2026 09:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ilEXZ9XtRtsP; Thu, 17 Sep 2026 09:43:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ED1E940746
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789638200;
	b=rbv9eI8T0zaHskUSIyurqHG0a5Y+4P0n2gjBL+AeTPJSkKFuP6zCHtdoHpICKqxcId+G
	 MocTctkxMdC+rfYGlZ0TcUavOVELLZrpPC9LxKUFh6//GKPExToeep8L+ZdHykHd06MOj
	 MG7MOScDeKukqRRrUokl7fMQ/S/6WJ6en1d2I264CMrBX9+AQWWBKmUl++B6HHm5UpVZ4
	 wP7EUyWzF8Sew7+3Zpckc53afme6u+dVZfQ07f/zgfIbotYDNrQWcWeE+SAt0vtPsBEBY
	 0dxDE+vzZIaNF8TY0Fr7Xb3cXliaRj4KjIVD9XRnhWrta6jNyaGgu5CmpbDqUHrUuww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789638200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wZUc7H28ZPEFg8PzaOD70+tVDH4ckEaq+QY3uAKagnk=;
	b=U5m7Q7fx3NQS42prnzz8CJybQHCWxsAd0Ui4d6QB0tUcSvjBoL1BuRT4H+d71xAthcWO
	 n4pgWB3XZVXfQj44AlZQFlLoDViqKwHJ2wYApbFLwWSDvW3KlLdfx3qRLPzmsn7DNTBwh
	 RxUWWzdYx5sXKDQsUKWjZYyTm1i4HVVmO6JyrYptAb3+FFgAPJEgw+omKg+WeHfmkwDJ0
	 7bXl56EAIyuASSzJEaQ7Y1KxArgv7E2F0/mHzkwQkY3a3O/Ss40wTr5vZE6NSrBSYJGmr
	 6W6mCJBjcv+fHujl8xdIYbEHPYj4RJ9Z6Ci/O+XGx7lYD2tTba7dH848LDhKKwF8JlQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789638200;
	bh=wZUc7H28ZPEFg8PzaOD70+tVDH4ckEaq+QY3uAKagnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VqYgQOQe1bM3Ek7zOBR8HHg9n3VU76DTPi0UwiZu+y/Jj+EkT6e9vR42pHt50rg1y
	 yiWHVqz0O01skdkEKAx4OyhJpqaEPz/HAmhOZ+kjI4QZFJE4ZYeqTKh4rdyqo+qSUQ
	 o5Kf+pXqIcjE5+qtluVIFYA17jP2SMXuqKHHZZWA10y3vdtqPHy+y879Z5IgeK0L2g
	 gExZxDFwzhdvnnAmMDwLAh8SyVpRAeM5USVbsKKHtXODEWAWqInBOUNbMG6WUHj1nS
	 EJi1J7aRAKLSFOPUiIzMwO5HqECwUnt+5l/uKb0yCadyH1bqYwmwnvm1z386bFWpk1
	 +40JBu6T1UC3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED1E940746;
	Thu, 17 Sep 2026 09:43:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D69F13D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FD3B80C8E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJOrkRfYflmF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 09:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8C9AE80E17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789638197;
 b=jdQwWWmJmJw9d3oelAWflKpeifLxAwwGdbrHyKF2uGUT42KOsujPiKWJn/xcSeGniLKO
 E5pyqo9MZd1yjcIjhj4jBICOBaTKyVi2lIbltHcVdnkbRyi+yqnKCa3Z+Z2beX2oKiLes
 x75GGRZ77hWnNKdFVVF0pNCtTvmGrqGI+ctiA+dxFRXBb+YQmqKRChXYpl4uboWKJqheB
 S2l6LnQ/zeiZvgYNX0khtDYgwoOYlK4IZUe+6iSEtxtEuTJt4KzmnliOQA4xVE5j3Fo8q
 ZKwkDwj1ce2YXxZTSa064wXqHyX0Z8dtMhrPVpTgCwk7F36/Hz7PxC3d07A5xBzbR1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789638197;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=wZUc7H28ZPEFg8PzaOD70+tVDH4ckEaq+QY3uAKagnk=;
 b=U3WYO+No49+NSh1RnwNYAhY76IcceCCR9+WbVhOVoIaMjA6aLgwpfYSPXNCknWWGJNY/
 LyvJg6CTz8+dixq6UbET73MzSZfU+frMu+Kei1Mac3yaA9sXKJ7Y7tKVXNVryykVu1PeW
 VNf2OsxmSV0mDGf3gaX/ZzwsauD95s4TzAmoRaYRmjMiqkxpDV6JQFq8zTebA+GFLjdXc
 aeGGUNfWO72uU7aklptGMjKmEckBfNBKUSPbnXDrDwx/fWibT6TLjj0c9fs3WNCbntTKR
 ApOrwNQQv3bnn7ysWI0EK4S07PUaXwYCoE35+vNfOAbSma8h1U6rE3m/Y1uROAAnqqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CSjPklaB; 
 arc=none smtp.remote-ip=192.198.163.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.9;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CSjPklaB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C9AE80E17
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 09:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789638198; x=1821174198;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5PiRaKoQmAY7dp5ExsOS/8a+QnYZ6ge28TIZ18TnBgs=;
 b=CSjPklaBT/J6XAgX8g+6BSuCi5yi5rYRwNl/2zABapmV3VHdeC8G+TMj
 YDAtwrN4iTxrixJsNV1Y5rRvn+cFoZgKjFaVGj4w6+kGnPzUCNEguipNi
 6VnuIzX2OwNDnJqTGnYZKz0JWjldji59CV6Lksr1is4DN7rbrvu+/zZnK
 lvKkVgXB+R+DKw6n63Cr00B9iYElGCccioOPNy9NEe2sYZjSaw4wWtvqz
 gkqhrBs9nBCzXAWMLSez6Uz9aa5Fe2lKRkC4W9/E+q5SX0Vz3FLP9XVYv
 6hXrCtnxvNPevfmyNOithX7GEKs+VU2oubiBz30+/6d92phz+z2ikEdMc w==;
X-CSE-ConnectionGUID: vswlh1LAQtuBZwbEz9zTgw==
X-CSE-MsgGUID: 0R9qqcbTQLqIK8W5FB9CVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100706504"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="100706504"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 02:43:18 -0700
X-CSE-ConnectionGUID: beFfsIBbQVWSTeHv7MbuUw==
X-CSE-MsgGUID: periOg7ZRxmooXQS1xOZgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269400577"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa006.fm.intel.com with ESMTP; 17 Sep 2026 02:43:15 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, 6b0e0deb9a688f5d6289c31b0eba49801deb832e, Mon, Sep,
 17, 00:00:00, 2001, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Thu, 17 Sep 2026 11:43:11 +0200
Message-ID: <20260917094312.1567881-2-aleksandr.loktionov@intel.com>
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

CNSA 2.0 PQC adapters carry an external Root of Trust (eRoT) controller
that enforces full-image authentication during NVM updates.  Detect its
presence at init time so later patches can gate firmware update flows.

Primary detection uses the LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT device
capability (0x004E) reported by firmware.  When running on older firmware
that does not advertise the capability at all, fall back to reading the
eRoT presence fuse (SR 0x1016 bits[1:0]).

The capability ID is reserved in the shared libie adminq.h rather than
defined locally in ice, alongside the other LIBIE_AQC_CAPS_* values that
ice_parse_common_caps() already switches on.  AQ capability IDs are a
single firmware-defined numbering space; reserving 0x004E centrally
prevents libie from later assigning it to an unrelated capability out
from under ice.

The result is stored in hw->erot_present and exposed through the
ICE_F_EROT feature bit.  ice_parse_erot_presence() is called from
ice_init_hw() after ice_get_caps() so the device capability field is
already populated at detection time.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c |  7 ++++
 drivers/net/ethernet/intel/ice/ice_lib.c    |  3 ++
 drivers/net/ethernet/intel/ice/ice_nvm.c    | 39 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_nvm.h    |  5 +++
 drivers/net/ethernet/intel/ice/ice_type.h   |  5 +++
 include/linux/net/intel/libie/adminq.h      |  1 +
 7 files changed, 61 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c701..a78fa17 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -210,6 +210,7 @@ enum ice_feature {
 	ICE_F_SRIOV_LAG,
 	ICE_F_SRIOV_AA_LAG,
 	ICE_F_MBX_LIMIT,
+	ICE_F_EROT,
 	ICE_F_MAX
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ef1ce10..1e0936d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1031,6 +1031,7 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_cqinit;
 
+	ice_parse_erot_presence(hw);
 	if (!hw->port_info)
 		hw->port_info = devm_kzalloc(ice_hw_to_dev(hw),
 					     sizeof(*hw->port_info),
@@ -2479,6 +2480,12 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 	case LIBIE_AQC_CAPS_TX_SCHED_TOPO_COMP_MODE:
 		caps->tx_sched_topo_comp_mode_en = (number == 1);
 		break;
+	case LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT:
+		caps->external_pqc_rot_present = (number == 1);
+		caps->external_pqc_rot_present_cap_advertised = true;
+		ice_debug(hw, ICE_DBG_INIT, "%s: external_pqc_rot_present = %d\n",
+			  prefix, caps->external_pqc_rot_present);
+		break;
 	default:
 		/* Not one of the recognized common capabilities */
 		found = false;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9e08db3..ad2b6fb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4003,6 +4003,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 		ice_set_feature_support(pf, ICE_F_GCS);
 		ice_set_feature_support(pf, ICE_F_TXTIME);
 	}
+
+	if (pf->hw.erot_present)
+		ice_set_feature_support(pf, ICE_F_EROT);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index 21f3b61..9ae7de2 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -1105,6 +1105,45 @@ static int ice_determine_css_hdr_len(struct ice_hw *hw)
 	return 0;
 }
 
+/**
+ * ice_parse_erot_presence - detect eRoT and populate hw->erot_present
+ * @hw: pointer to the HW struct
+ *
+ * Uses the device capability LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT when
+ * advertised by firmware, falling back to the eRoT Presence fuse only when
+ * the capability is not advertised at all (older firmware).
+ *
+ * Priority:
+ *  1. Device capability external_pqc_rot_present (advertised && == 1)
+ *     => eRoT present
+ *  2. Fuse BIT(0) set (only when capability not advertised)
+ *     => eRoT present
+ *  3. Otherwise => eRoT not present
+ */
+void ice_parse_erot_presence(struct ice_hw *hw)
+{
+	u16 fuse = 0;
+	int err;
+
+	hw->erot_present = false;
+
+	if (hw->dev_caps.common_cap.external_pqc_rot_present) {
+		hw->erot_present = true;
+	} else if (!hw->dev_caps.common_cap.external_pqc_rot_present_cap_advertised) {
+		err = ice_read_sr_word(hw, ICE_SR_EROT_PRESENCE_FUSE, &fuse);
+		if (err)
+			dev_warn(ice_hw_to_dev(hw),
+				 "Unable to read eRoT presence fuse (SR 0x%04x), err %d; assuming eRoT not present\n",
+				 ICE_SR_EROT_PRESENCE_FUSE, err);
+		else if (fuse & ICE_EROT_PRESENCE_FUSE_PRESENT)
+			hw->erot_present = true;
+	}
+
+	if (hw->erot_present)
+		dev_info(ice_hw_to_dev(hw),
+			 "eRoT (external Root of Trust) present\n");
+}
+
 /**
  * ice_init_nvm - initializes NVM setting
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index e1d1a11..4b31dfc 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -28,7 +28,12 @@ int ice_get_inactive_nvm_ver(struct ice_hw *hw, struct ice_nvm_info *nvm);
 int
 ice_get_inactive_netlist_ver(struct ice_hw *hw, struct ice_netlist_info *netlist);
 int ice_read_pba_string(struct ice_hw *hw, u8 *pba_num, u32 pba_num_size);
+/* eRoT Presence fuse SR offset; BIT(0) set means eRoT present */
+#define ICE_SR_EROT_PRESENCE_FUSE	0x1016
+#define ICE_EROT_PRESENCE_FUSE_PRESENT	BIT(0)
+
 int ice_init_nvm(struct ice_hw *hw);
+void ice_parse_erot_presence(struct ice_hw *hw);
 int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data);
 int
 ice_aq_update_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index d9a5c1a..1375106 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -311,6 +311,9 @@ struct ice_hw_common_caps {
 	/* Post update reset restriction */
 	bool reset_restrict_support;
 	bool tx_sched_topo_comp_mode_en;
+	/* eRoT (external Root of Trust) controller present */
+	bool external_pqc_rot_present;
+	bool external_pqc_rot_present_cap_advertised;
 };
 
 /* IEEE 1588 TIME_SYNC specific info */
@@ -1040,6 +1043,8 @@ struct ice_hw {
 	u8 dvm_ena;
 	u16 io_expander_handle;
 	u8 cgu_part_number;
+	/* true when eRoT (external Root of Trust) controller is present */
+	bool erot_present;
 };
 
 /* Statistics collected by each port, VSI, VEB, and S-channel */
diff --git a/include/linux/net/intel/libie/adminq.h b/include/linux/net/intel/libie/adminq.h
index 839114d..df42f5b 100644
--- a/include/linux/net/intel/libie/adminq.h
+++ b/include/linux/net/intel/libie/adminq.h
@@ -175,6 +175,7 @@ LIBIE_CHECK_STRUCT_LEN(16, libie_aqc_list_caps);
 #define LIBIE_AQC_CAPS_PENDING_OROM_VER			0x004B
 #define LIBIE_AQC_CAPS_NET_VER				0x004C
 #define LIBIE_AQC_CAPS_PENDING_NET_VER			0x004D
+#define LIBIE_AQC_CAPS_EXTERNAL_PQC_ROT_PRESENT		0x004E
 #define LIBIE_AQC_CAPS_RDMA				0x0051
 #define LIBIE_AQC_CAPS_LED				0x0061
 #define LIBIE_AQC_CAPS_SDP				0x0062
-- 
2.52.0


