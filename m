Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4BFC43458
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Jul 2026 11:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C8E4417D4;
	Wed,  1 Jul 2026 11:54:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VQ9mx894F62M; Wed,  1 Jul 2026 11:54:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAE0A417CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782906875;
	bh=/zyJ4gIRkJGdxZlKPKoYWtRmi8C/lGr9aBZ6yaQz6rA=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xZKi2gODMRjDuSL1c2AiKRwyHFOuqR0SLTTanBumKjSoD6NFFB4V20rWeH4EqlWZC
	 AzBcL6lOBf2BEi2FdCJKhvI+LrXJ2q2D+VSR/1m7OP7OytzzX3lN03wSilyujYPGYC
	 rGOtxkTdTo24ssGbQ2HQJD1vc2zLUCA8brVu07wpzmze9A88LrnRmgf4YaUAceS6s8
	 BSaD2TbLwOKsqll1SMqotpZo8a5AEt4l6oyiFHWRdqIm4SYJxwBWhFoTxIKtfpP+P6
	 OKzUbXesoyLLdmEQLrRUC/rmmY2zE9RrGQMhS1kpnyRkj+mu8GuFc0ZAupyuLQwCNF
	 ovYmp5IwIgdfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAE0A417CE;
	Wed,  1 Jul 2026 11:54:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 20712127
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 11:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F270E417CF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 11:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGyrI3gN9PCa for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Jul 2026 11:54:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 05C62417CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05C62417CE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 05C62417CE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Jul 2026 11:54:33 +0000 (UTC)
X-CSE-ConnectionGUID: h7Nb3otTTlW+eGF3aGJNog==
X-CSE-MsgGUID: RoGbVwcASrivrdCU2EDTpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="82754031"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; d="scan'208";a="82754031"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2026 04:54:33 -0700
X-CSE-ConnectionGUID: 2o4c0HpAQb6U0Btrbwa+8A==
X-CSE-MsgGUID: g/sNsBCkQHu7952gBy/1CA==
X-ExtLoop1: 1
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by fmviesa003.fm.intel.com with ESMTP; 01 Jul 2026 04:54:32 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Date: Wed,  1 Jul 2026 13:35:19 +0200
Message-Id: <20260701113519.49859-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782906874; x=1814442874;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hdtWniKBVjFZVT372OPazJSB8XYsV8BEec8tXq+U4QE=;
 b=P3Wh079mR40Ru0+VLNNBpPerth3LQ2X4hxPe745zshhmMCkzv9jfmMHB
 hhAwQrfHANu5R2e6zuwrU2eFvRhnE7+4T7skvR+hrG/HcV75yv1U+bsNF
 hWTFpuv41aDyHJzV5b0pLZjBYOF0IJLfOsd2ZVpOZuryUgHq3Ic1sTk/D
 NjZ4UmU8M4BLa3yCaeC6hf1t1f8s7NlVFxFxHufYKAP52nvHejQXbtx9Y
 Ynv97d3m0S8ycoQZ9YMQAXSt32lRMtNHtkEMVrTR+aHkS2j+EEM2RvquQ
 tNlOnff4BDr1pYHgynzLkY03XVcYR23seljj8qaxUT2L8dGj9Q0XWwTg/
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P3Wh079m
Subject: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: E610: force phy link
 to get down when interface is down
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

For the E610 family, similarly to the E8xx adapters, the default behavior
is for the PHY link to remain up even when the corresponding OS interface
is down.

Add function setting down the PHY config IXGBE_ACI_PHY_ENA_LINK bit
what leads to disabling PHY link.

Align functionality with the implementation of the ice driver.

Let user to configure link-down-on-close enablement through ethtool.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 35 ++++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 15 ++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 27 +++++++++++---
 5 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 30f62174acf2..7bbb82dd962c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -685,6 +685,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
 #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 #define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
+#define IXGBE_FLAG2_LINK_DOWN_ON_CLOSE		BIT(25)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index da445fb673fc..46d8a3ea86b8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1923,6 +1923,33 @@ void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw)
 	hw->fc.current_mode = hw->fc.requested_mode;
 }
 
+/**
+ * ixgbe_disable_phy_link - force phy link to get down
+ * @hw: pointer to hardware structure
+ *
+ * Send 0x0601 with the IXGBE_ACI_PHY_ENA_LINK bit set down.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_disable_phy_link(struct ixgbe_hw *hw)
+{
+	struct ixgbe_aci_cmd_get_phy_caps_data pcaps = {};
+	struct ixgbe_aci_cmd_set_phy_cfg_data pcfg = {};
+	int err;
+
+	err = ixgbe_aci_get_phy_caps(hw, false, IXGBE_ACI_REPORT_ACTIVE_CFG,
+				     &pcaps);
+	if (err)
+		return err;
+
+	ixgbe_copy_phy_caps_to_cfg(&pcaps, &pcfg);
+
+	pcfg.caps &= ~IXGBE_ACI_PHY_ENA_LINK;
+	pcfg.caps |= IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT;
+
+	return ixgbe_aci_set_phy_cfg(hw, &pcfg);
+}
+
 /**
  * ixgbe_disable_rx_e610 - Disable RX unit
  * @hw: pointer to hardware structure
@@ -2207,6 +2234,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 	u8 rmode = IXGBE_ACI_REPORT_TOPO_CAP_MEDIA;
 	u64 sup_phy_type_low, sup_phy_type_high;
 	u64 phy_type_low = 0, phy_type_high = 0;
+	bool force_on_required;
 	int err;
 
 	err = ixgbe_aci_get_link_info(hw, false, NULL);
@@ -2272,6 +2300,11 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 		phy_type_high |= IXGBE_PHY_TYPE_HIGH_10G_USXGMII;
 	}
 
+	/* If IXGBE_ACI_PHY_ENA_LINK has been explicitly disabled that means
+	 * we need to force interface enablement after reaching that point
+	 */
+	force_on_required = !(pcfg.caps & IXGBE_ACI_PHY_ENA_LINK);
+
 	/* Mask the set values to avoid requesting unsupported link types. */
 	phy_type_low &= sup_phy_type_low;
 	pcfg.phy_type_low = cpu_to_le64(phy_type_low);
@@ -2280,7 +2313,7 @@ int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw)
 
 	if (pcfg.phy_type_high != pcaps.phy_type_high ||
 	    pcfg.phy_type_low != pcaps.phy_type_low ||
-	    pcfg.caps != pcaps.caps) {
+	    pcfg.caps != pcaps.caps || force_on_required) {
 		pcfg.caps |= IXGBE_ACI_PHY_ENA_LINK;
 		pcfg.caps |= IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 2cb76a3d30ae..59044d67ebeb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -50,6 +50,7 @@ int ixgbe_cfg_phy_fc(struct ixgbe_hw *hw,
 		     enum ixgbe_fc_mode req_mode);
 int ixgbe_setup_fc_e610(struct ixgbe_hw *hw);
 void ixgbe_fc_autoneg_e610(struct ixgbe_hw *hw);
+int ixgbe_disable_phy_link(struct ixgbe_hw *hw);
 void ixgbe_disable_rx_e610(struct ixgbe_hw *hw);
 int ixgbe_init_phy_ops_e610(struct ixgbe_hw *hw);
 int ixgbe_identify_phy_e610(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 4dfae53b4ea1..0fcb9d738984 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -139,6 +139,8 @@ static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
 	"vf-ipsec",
 #define IXGBE_PRIV_FLAGS_AUTO_DISABLE_VF	BIT(2)
 	"mdd-disable-vf",
+#define IXGBE_PRIV_LINK_DOWN_ON_CLOSE	BIT(3)
+	"link-down-on-close",
 };
 
 #define IXGBE_PRIV_FLAGS_STR_LEN ARRAY_SIZE(ixgbe_priv_flags_strings)
@@ -3842,6 +3844,9 @@ static u32 ixgbe_get_priv_flags(struct net_device *netdev)
 	if (adapter->flags2 & IXGBE_FLAG2_AUTO_DISABLE_VF)
 		priv_flags |= IXGBE_PRIV_FLAGS_AUTO_DISABLE_VF;
 
+	if (adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE)
+		priv_flags |= IXGBE_PRIV_LINK_DOWN_ON_CLOSE;
+
 	return priv_flags;
 }
 
@@ -3879,6 +3884,16 @@ static int ixgbe_set_priv_flags(struct net_device *netdev, u32 priv_flags)
 		}
 	}
 
+	flags2 &= ~IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
+	if (priv_flags & IXGBE_PRIV_LINK_DOWN_ON_CLOSE) {
+		if (adapter->hw.mac.type == ixgbe_mac_e610) {
+			flags2 |= IXGBE_FLAG2_LINK_DOWN_ON_CLOSE;
+		} else {
+			e_info(probe, "Cannot set private flags: Unsupported hardware\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	if (flags2 != adapter->flags2) {
 		adapter->flags2 = flags2;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 62c2d83e1577..58ee4a186039 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7544,6 +7544,17 @@ static void ixgbe_close_suspend(struct ixgbe_adapter *adapter)
 	ixgbe_free_all_rx_resources(adapter);
 }
 
+static void ixgbe_handle_link_down(struct ixgbe_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
+		ixgbe_ptp_start_cyclecounter(adapter);
+
+	e_info(drv, "NIC Link is Down\n");
+	netif_carrier_off(netdev);
+}
+
 /**
  * ixgbe_close - Disables a network interface
  * @netdev: network interface device structure
@@ -7566,6 +7577,16 @@ int ixgbe_close(struct net_device *netdev)
 
 	ixgbe_fdir_filter_exit(adapter);
 
+	if (adapter->flags2 & IXGBE_FLAG2_LINK_DOWN_ON_CLOSE) {
+		int err;
+
+		err = ixgbe_disable_phy_link(&adapter->hw);
+		if (err)
+			e_warn(drv, "Cannot set PHY link down\n");
+
+		ixgbe_handle_link_down(adapter);
+	}
+
 	ixgbe_release_hw_control(adapter);
 
 	return 0;
@@ -8244,11 +8265,7 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 	if (ixgbe_is_sfp(hw) && hw->mac.type == ixgbe_mac_82598EB)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
 
-	if (test_bit(__IXGBE_PTP_RUNNING, &adapter->state))
-		ixgbe_ptp_start_cyclecounter(adapter);
-
-	e_info(drv, "NIC Link is Down\n");
-	netif_carrier_off(netdev);
+	ixgbe_handle_link_down(adapter);
 }
 
 static bool ixgbe_ring_tx_pending(struct ixgbe_adapter *adapter)
-- 
2.31.1

