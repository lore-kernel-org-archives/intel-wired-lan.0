Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E87C5AD4E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 07:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D915840462;
	Mon, 10 Aug 2026 07:57:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xM203m4ZHQyQ; Mon, 10 Aug 2026 07:57:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C09540467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786348626;
	bh=x6+cp6O5wtVjC91J7LfxWlixgOmlbpFsCI4098OBfpw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ppuXUarC9QueMITHizAUbC3IKBoifK1tPc5tQx+UVy1C9RWIwLQr99QHwaCAReX9X
	 9WGqnF0eC1DI1d8mglVCtYlBgnsZec/y2/tffEF3VEFuc7mblvcgea+nUgELg5OxFP
	 onQqjVT3rjGEzs0Fg9p1hCZyOj+FGuYU+Qcf9u1DYjMN567we+fW1QnGbBR8oy5C32
	 84W94kboJvVkJQ0RFBO9P1wQcURpN0vKc2DEPDl+vBQGfI6zl7DthrMzYY2w4nxmZe
	 IEUzwJqyiRvr1D5plN3tnipzO2anQuLfaKIyelX+tGMV/xp/XkicZXGGvzvaj3Qn1Z
	 1zBrCXGV5fKKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C09540467;
	Mon, 10 Aug 2026 07:57:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 80401259
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 07:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65E2880C7A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 07:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O5iOsJcloZ31 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 07:57:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 53FA880C74
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53FA880C74
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 53FA880C74
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 07:57:01 +0000 (UTC)
X-CSE-ConnectionGUID: iYI/JtFYSXySw3pu7JroNA==
X-CSE-MsgGUID: abH0BHPlRgWERM/D147+RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86615160"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="86615160"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 00:57:00 -0700
X-CSE-ConnectionGUID: ZK3DD+3aS3aczdK1fDddXw==
X-CSE-MsgGUID: h0HSaT1WTHqmvps8KTSS2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="256756179"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
 by fmviesa009.fm.intel.com with ESMTP; 10 Aug 2026 00:56:53 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
Date: Mon, 10 Aug 2026 09:56:52 +0200
Message-ID: <20260810075652.27915-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786348622; x=1817884622;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=K3dGZxx+dFdUL7gnm6sbE+ZMC4jTvvyK6dHc60lLDNg=;
 b=k0FgvbLNfmTK1zgRqUQ4iquaI5zRmu5080Ypl/HcLdtPjyuT1nV3iFSC
 /miTFebuHMSVqG/qo9JNYPTjEsQmo1fLWzAju2V3LFb0195Ztq2KJ/gqX
 Iai+4b8PLf8JyelGW52VFMVMUEQ9d2gNlenNreo6PmBd/K6GCrnLc6BCO
 7a0n6ALui0z+8DTYpU2QyAtvGZKezayLE6xdAjT3Fj8XOIN7CV6c25NGk
 hV2a+PxM5CSp4HaOZA9lZL/iL/dkzG2slmpKSnVnYmK/HmaMX2lhLIhMR
 L08GEgjV2HiTXseWtinz14uuUCuE82zB94WZlfxbCdikNJ75nBu7SsBy9
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=k0FgvbLN
Subject: [Intel-wired-lan] [iwl-next] ixgbe: implement Total Port Shutdown
 for E610
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Implement Total Port Shutdown (TPS) for E610. When TPS is provisioned
in the NVM (by the platform firmware), the port's PHY is powered down
whenever the interface is administratively down.

When the PORT_DIS bit is set in the Link Default Override TLV in
the NVM PFA area, enable Total Port Shutdown (TPS). This forces the
link-down-on-close private flag and prevents the user from changing
it via ethtool, ensuring the PHY is powered down when the interface
is brought down as provisioned in the NVM.

The Link Default Override TLV (0x134) is read from the NVM PFA during
driver init. Each port has its own 10-word configuration block within
the TLV. If the PORT_DIS bit is set in the port's link_options field,
the driver sets both TOTAL_PORT_SHUTDOWN_ENA and LINK_DOWN_ON_CLOSE
flags.

Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 38 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 13 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 14 ++++++-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 13 +++++++
 6 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 02e7d6f0d852..41f43294465b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -684,6 +684,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 #define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
 #define IXGBE_FLAG2_LINK_DOWN_ON_CLOSE		BIT(25)
+#define IXGBE_FLAG2_TOTAL_PORT_SHUTDOWN_ENA	BIT(26)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c92a586ee9b6..46a7c3ef7396 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -4051,6 +4051,44 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
 	return -ENODATA;
 }
 
+/**
+ * ixgbe_get_link_default_override - Get link default override from NVM
+ * @hw: pointer to hardware structure
+ * @ldo: pointer to link default override struct to populate
+ *
+ * Read the Link Default Override TLV from the NVM PFA and return
+ * the per-port override configuration.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ixgbe_get_link_default_override(struct ixgbe_hw *hw,
+				    struct ixgbe_link_default_override_tlv *ldo)
+{
+	struct ixgbe_adapter *adapter = hw->back;
+	u16 tlv, tlv_len;
+	u32 tlv_start;
+	u8 pf_func;
+	int err;
+
+	err = ixgbe_get_pfa_module_tlv(hw, &tlv, &tlv_len,
+				       IXGBE_E610_SR_LINK_DEFAULT_OVERRIDE_PTR);
+	if (err)
+		return err;
+
+	pf_func = PCI_FUNC(adapter->pdev->devfn);
+
+	tlv_start = tlv + IXGBE_E610_SR_PFA_TLV_HDR_SIZE +
+		    pf_func * IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS;
+
+	if (tlv_start + IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS >
+	    tlv + IXGBE_E610_SR_PFA_TLV_HDR_SIZE + tlv_len)
+		return -ERANGE;
+
+	return ixgbe_read_ee_aci_buffer_e610(hw, tlv_start,
+					     IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS,
+					     (u16 *)ldo);
+}
+
 /**
  * ixgbe_read_pba_string_e610 - Read PBA string from NVM
  * @hw: pointer to hardware structure
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 1f4c8b022698..fc96d67e018e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -82,6 +82,8 @@ int ixgbe_read_ee_aci_e610(struct ixgbe_hw *hw, u16 offset, u16 *data);
 int ixgbe_read_ee_aci_buffer_e610(struct ixgbe_hw *hw, u16 offset,
 				  u16 words, u16 *data);
 int ixgbe_validate_eeprom_checksum_e610(struct ixgbe_hw *hw, u16 *checksum_val);
+int ixgbe_get_link_default_override(struct ixgbe_hw *hw,
+				    struct ixgbe_link_default_override_tlv *ldo);
 int ixgbe_reset_hw_e610(struct ixgbe_hw *hw);
 int ixgbe_get_flash_data(struct ixgbe_hw *hw);
 int ixgbe_aci_nvm_update_empr(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6a35630f8421..1e1db8435506 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3852,6 +3852,19 @@ static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 		}
 	}
 
+	/* Do not allow any change to link-down-on-close when Total Port
+	 * Shutdown is enabled - the flag is managed by TPS exclusively.
+	 */
+	if (adapter->flags2 & IXGBE_FLAG2_TOTAL_PORT_SHUTDOWN_ENA) {
+		bool cur = !!(adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE);
+		bool req = !!(priv_flags & IXGBE_PRIV_LINK_DOWN_ON_CLOSE);
+
+		if (req != cur) {
+			e_warn(probe, "Setting link-down-on-close not supported on this port\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	flags2 &= ~IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
 	if (priv_flags & IXGBE_PRIV_LINK_DOWN_ON_CLOSE) {
 		if (adapter->hw.mac.type == ixgbe_mac_e610) {
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 79d5d652d3cf..5f8f9884cbea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7001,9 +7001,21 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 	if (hw->mac.ops.init_swfw_sync)
 		hw->mac.ops.init_swfw_sync(hw);
 
-	if (hw->mac.type == ixgbe_mac_e610)
+	if (hw->mac.type == ixgbe_mac_e610) {
+		struct ixgbe_link_default_override_tlv ldo = {};
+		int err;
+
 		mutex_init(&hw->aci.lock);
 
+		err = ixgbe_get_link_default_override(hw, &ldo);
+		if (!err && (ldo.link_options & IXGBE_LINK_OVERRIDE_PORT_DIS)) {
+			adapter->flags2 |=
+				IXGBE_FLAG2_TOTAL_PORT_SHUTDOWN_ENA |
+				IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
+			e_dev_info("Total Port Shutdown enabled\n");
+		}
+	}
+
 #ifdef IXGBE_FCOE
 	/* FCoE support exists, always init the FCoE lock */
 	spin_lock_init(&adapter->fcoe.lock);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 959cacecae49..43e2d3e1cd59 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -29,6 +29,19 @@
 #define IXGBE_E610_SR_NETLIST_BANK_PTR		0x46
 #define IXGBE_E610_SR_NETLIST_BANK_SIZE		0x47
 
+/* Link Default Override TLV in PFA */
+#define IXGBE_E610_SR_LINK_DEFAULT_OVERRIDE_PTR	0x134
+#define IXGBE_E610_SR_PFA_LINK_OVERRIDE_WORDS	10
+#define IXGBE_E610_SR_PFA_TLV_HDR_SIZE		2
+
+#define IXGBE_LINK_OVERRIDE_PORT_DIS		BIT(2)
+
+struct ixgbe_link_default_override_tlv {
+	u16 link_options;
+	u16 phy_options;
+	u16 phy_types[8];
+};
+
 /* The OROM version topology */
 #define IXGBE_OROM_VER_PATCH_MASK		GENMASK_ULL(7, 0)
 #define IXGBE_OROM_VER_BUILD_MASK		GENMASK_ULL(23, 8)
-- 
2.54.0

