Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BCCE936FD
	for <intel-wired-lan@archiver.kernel.org>; Thu,  5 Oct 2023 05:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD48880EC5;
	Thu,  5 Oct 2023 05:44:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD48880EC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696484693;
	bh=YifkYcwwwj/FkiKUkS+U5TQS6SPfM2xCpRSxwPUa0FY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=q6AaPCA3Tyi3hTgPvgY0OSRMde7lBuTyWx4IvKL1KfAybHstXtHCBVs/eBxUA/Uan
	 QqQ1Uz9uNs5Ci1C2kvM7j1U/qu1/SnPXdSZauiNxFIRWMpz0QJhBYajleOnI7rvz/b
	 q4mYPF/6zKq9xFA5wOa8eFt2dM0JPJ9tDByrykz9S/TML/vrW6yEeP6f2U2426LyMo
	 0ceLPLcTN3wqYjLkp4mD4eAYIFE2hkfGQ+1h/W6e3lyvCBVNIstxU5p+9bHW8rOcjJ
	 olpDDjcArWL0vkcqmMfhyIdVyTnc0yusSKiAlrFm/+Eyr8S3go6MKYvxZOnZksmFLI
	 W8bIt+1S2h8Zw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KG4uqmg3-Y1F; Thu,  5 Oct 2023 05:44:52 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 78BAD80F05;
	Thu,  5 Oct 2023 05:44:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78BAD80F05
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 70E3C1BF41F
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Oct 2023 05:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C2684012A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Oct 2023 05:44:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C2684012A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XitvsbQaijVi for <intel-wired-lan@lists.osuosl.org>;
 Thu,  5 Oct 2023 05:44:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C33F740111
 for <intel-wired-lan@lists.osuosl.org>; Thu,  5 Oct 2023 05:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C33F740111
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="4971783"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="4971783"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2023 22:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786821725"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; d="scan'208";a="786821725"
Received: from ccdlinuxdev11.iil.intel.com ([143.185.162.129])
 by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2023 22:44:45 -0700
From: Vitaly Lifshits <vitaly.lifshits@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  5 Oct 2023 08:44:41 +0300
Message-Id: <20231005054441.3758364-1-vitaly.lifshits@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696484689; x=1728020689;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jRje19JGrFQJf2xNkqczLaS5pmwPRQVklsS8zH+1iKc=;
 b=I8B2KiZW16arHTMQmT8mh6Pr2+hvHJGezizSt1ia4uTe4MNr85N9GXUq
 9CQ4vAbmlK5UXmsDbcRzotSeB8r4QA6sl9C/qPoQSeWpaOW5MZPOfPny/
 oi4ajjLZ0eOAEuat/ysMDyGjcjZR2iKoYGWpLdvNg7zFL7hC+DQH6MB22
 ZgAUvGMZvSo7kal2zsoXPFN6/8XyKVzmQ0ZePck+BEPYVAfvjK/XaUgha
 1iY1Tg7zWPRYZ9cD/tXSca51tr90B1ailOM+B0nqPXLyzLsrbf4EEYI3I
 jxCnkbXBcqZcveZlAUiR4K24OVEoj0P90WOP9C9lWMSFipJfw9vSIQkLr
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I8B2KiZW
Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/1] e1000e: Workaround for
 sporadic MDI error on Meteor Lake systems
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Nikolay Mushayev <nikolay.mushayev@intel.com>,
 Nir Efrati <nir.efrati@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On some Meteor Lake systems accessing the PHY via the MDIO interface may
result in an MDI error. This issue happens sporadically and in most cases
a second access to the PHY via the MDIO interface results in success.

As a workaround, introduce a retry counter which is set to 3 on Meteor
Lake systems. The driver will only return an error if 3 consecutive PHY
access attempts fail. The retry mechanism is disabled in specific flows,
where MDI errors are expected.

Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
Suggested-by: Nikolay Mushayev <nikolay.mushayev@intel.com>
Co-developed-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
---
v2: fix checkpatch errors
v1: initial version
---
 drivers/net/ethernet/intel/e1000e/hw.h      |   2 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c |  33 ++++
 drivers/net/ethernet/intel/e1000e/phy.c     | 185 ++++++++++++--------
 drivers/net/ethernet/intel/e1000e/phy.h     |   2 +
 4 files changed, 151 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 29f9fae35f42..0eb7555e0168 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -625,6 +625,7 @@ struct e1000_phy_info {
 	u32 id;
 	u32 reset_delay_us;	/* in usec */
 	u32 revision;
+	u32 retry_count;
 
 	enum e1000_media_type media_type;
 
@@ -641,6 +642,7 @@ struct e1000_phy_info {
 	bool polarity_correction;
 	bool speed_downgraded;
 	bool autoneg_wait_to_complete;
+	bool retry_enabled;
 };
 
 struct e1000_nvm_info {
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 0c7fd10312c8..1d1a30e2a614 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -222,11 +222,18 @@ static bool e1000_phy_is_accessible_pchlan(struct e1000_hw *hw)
 	if (hw->mac.type >= e1000_pch_lpt) {
 		/* Only unforce SMBus if ME is not active */
 		if (!(er32(FWSM) & E1000_ICH_FWSM_FW_VALID)) {
+			/* Switching PHY interface always returns MDI error
+			 * so disable retry mechanism to avoid wasting time
+			 */
+			e1000e_disable_phy_retry(hw);
+
 			/* Unforce SMBus mode in PHY */
 			e1e_rphy_locked(hw, CV_SMB_CTRL, &phy_reg);
 			phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 			e1e_wphy_locked(hw, CV_SMB_CTRL, phy_reg);
 
+			e1000e_enable_phy_retry(hw);
+
 			/* Unforce SMBus mode in MAC */
 			mac_reg = er32(CTRL_EXT);
 			mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
@@ -310,6 +317,11 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		goto out;
 	}
 
+	/* There is no guarantee that the PHY is accessible at this time
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* The MAC-PHY interconnect may be in SMBus mode.  If the PHY is
 	 * inaccessible and resetting the PHY is not blocked, toggle the
 	 * LANPHYPC Value bit to force the interconnect to PCIe mode.
@@ -379,6 +391,8 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		break;
 	}
 
+	e1000e_enable_phy_retry(hw);
+
 	hw->phy.ops.release(hw);
 	if (!ret_val) {
 
@@ -448,6 +462,11 @@ static s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 
 	phy->id = e1000_phy_unknown;
 
+	if (hw->mac.type == e1000_pch_mtp) {
+		phy->retry_count = 2;
+		e1000e_enable_phy_retry(hw);
+	}
+
 	ret_val = e1000_init_phy_workarounds_pchlan(hw);
 	if (ret_val)
 		return ret_val;
@@ -1145,6 +1164,11 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto out;
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* Force SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val)
@@ -1152,6 +1176,8 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000e_enable_phy_retry(hw);
+
 	/* Force SMBus mode in MAC */
 	mac_reg = er32(CTRL_EXT);
 	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
@@ -1312,6 +1338,11 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 		/* Toggle LANPHYPC Value bit */
 		e1000_toggle_lanphypc_pch_lpt(hw);
 
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
 	/* Unforce SMBus mode in PHY */
 	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
 	if (ret_val) {
@@ -1332,6 +1363,8 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 	phy_reg &= ~CV_SMB_CTRL_FORCE_SMBUS;
 	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
 
+	e1000e_enable_phy_retry(hw);
+
 	/* Unforce SMBus mode in MAC */
 	mac_reg = er32(CTRL_EXT);
 	mac_reg &= ~E1000_CTRL_EXT_FORCE_SMBUS;
diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 08c3d477dd6f..18bec3d1e349 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -107,6 +107,16 @@ s32 e1000e_phy_reset_dsp(struct e1000_hw *hw)
 	return e1e_wphy(hw, M88E1000_PHY_GEN_CONTROL, 0);
 }
 
+void e1000e_disable_phy_retry(struct e1000_hw *hw)
+{
+	hw->phy.retry_enabled = false;
+}
+
+void e1000e_enable_phy_retry(struct e1000_hw *hw)
+{
+	hw->phy.retry_enabled = true;
+}
+
 /**
  *  e1000e_read_phy_reg_mdic - Read MDI control register
  *  @hw: pointer to the HW structure
@@ -118,57 +128,74 @@ s32 e1000e_phy_reset_dsp(struct e1000_hw *hw)
  **/
 s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
 {
+	u32 i, mdic = 0, retry_counter, retry_max;
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	bool success;
 
 	if (offset > MAX_PHY_REG_ADDRESS) {
 		e_dbg("PHY Address %d is out of range\n", offset);
 		return -E1000_ERR_PARAM;
 	}
 
+	retry_max = phy->retry_enabled ? phy->retry_count : 0;
+
 	/* Set up Op-code, Phy Address, and register offset in the MDI
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = ((offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_READ));
+	for (retry_counter = 0; retry_counter <= retry_max; retry_counter++) {
+		success = true;
 
-	ew32(MDIC, mdic);
+		mdic = ((offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_READ));
 
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		udelay(50);
-		mdic = er32(MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Read PHY Reg Address %d did not complete\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
-		e_dbg("MDI Read offset error - requested %d, returned %d\n",
-		      offset,
-		      (mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
-		return -E1000_ERR_PHY;
+		ew32(MDIC, mdic);
+
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usleep_range(50, 60);
+			mdic = er32(MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			e_dbg("MDI Read PHY Reg Address %d did not complete\n", offset);
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			e_dbg("MDI Read PHY Reg Address %d Error\n", offset);
+			success = false;
+		}
+		if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
+			e_dbg("MDI Read offset error - requested %d, returned %d\n",
+			      offset,
+			      (mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
+			success = false;
+		}
+
+		/* Allow some time after each MDIC transaction to avoid
+		 * reading duplicate data in the next MDIC transaction.
+		 */
+		if (hw->mac.type == e1000_pch2lan)
+			usleep_range(100, 150);
+
+		if (success) {
+			*data = (u16)mdic;
+			return 0;
+		}
+
+		if (retry_counter != retry_max) {
+			e_dbg("Perform retry on PHY transaction...\n");
+			mdelay(10);
+		}
 	}
-	*data = (u16)mdic;
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		udelay(100);
 
-	return 0;
+	return -E1000_ERR_PHY;
 }
 
 /**
@@ -181,57 +208,73 @@ s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data)
  **/
 s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data)
 {
+	u32 i, mdic = 0, retry_counter, retry_max;
 	struct e1000_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
+	bool success;
 
 	if (offset > MAX_PHY_REG_ADDRESS) {
 		e_dbg("PHY Address %d is out of range\n", offset);
 		return -E1000_ERR_PARAM;
 	}
 
+	retry_max = phy->retry_enabled ? phy->retry_count : 0;
+
 	/* Set up Op-code, Phy Address, and register offset in the MDI
 	 * Control register.  The MAC will take care of interfacing with the
 	 * PHY to retrieve the desired data.
 	 */
-	mdic = (((u32)data) |
-		(offset << E1000_MDIC_REG_SHIFT) |
-		(phy->addr << E1000_MDIC_PHY_SHIFT) |
-		(E1000_MDIC_OP_WRITE));
+	for (retry_counter = 0; retry_counter <= retry_max; retry_counter++) {
+		success = true;
 
-	ew32(MDIC, mdic);
+		mdic = (((u32)data) |
+			(offset << E1000_MDIC_REG_SHIFT) |
+			(phy->addr << E1000_MDIC_PHY_SHIFT) |
+			(E1000_MDIC_OP_WRITE));
 
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
-		udelay(50);
-		mdic = er32(MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-	if (!(mdic & E1000_MDIC_READY)) {
-		e_dbg("MDI Write PHY Reg Address %d did not complete\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (mdic & E1000_MDIC_ERROR) {
-		e_dbg("MDI Write PHY Red Address %d Error\n", offset);
-		return -E1000_ERR_PHY;
-	}
-	if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
-		e_dbg("MDI Write offset error - requested %d, returned %d\n",
-		      offset,
-		      (mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
-		return -E1000_ERR_PHY;
-	}
 
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == e1000_pch2lan)
-		udelay(100);
+		ew32(MDIC, mdic);
 
-	return 0;
+		/* Poll the ready bit to see if the MDI read completed
+		 * Increasing the time out as testing showed failures with
+		 * the lower time out
+		 */
+		for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
+			usleep_range(50, 60);
+			mdic = er32(MDIC);
+			if (mdic & E1000_MDIC_READY)
+				break;
+		}
+		if (!(mdic & E1000_MDIC_READY)) {
+			e_dbg("MDI Write PHY Reg Address %d did not complete\n", offset);
+			success = false;
+		}
+		if (mdic & E1000_MDIC_ERROR) {
+			e_dbg("MDI Write PHY Red Address %d Error\n", offset);
+			success = false;
+		}
+		if (((mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT) != offset) {
+			e_dbg("MDI Write offset error - requested %d, returned %d\n",
+			      offset,
+			      (mdic & E1000_MDIC_REG_MASK) >> E1000_MDIC_REG_SHIFT);
+			success = false;
+		}
+
+		/* Allow some time after each MDIC transaction to avoid
+		 * reading duplicate data in the next MDIC transaction.
+		 */
+		if (hw->mac.type == e1000_pch2lan)
+			usleep_range(100, 150);
+
+		if (success)
+			return 0;
+
+		if (retry_counter != retry_max) {
+			e_dbg("Perform retry on PHY transaction...\n");
+			mdelay(10);
+		}
+	}
+
+	return -E1000_ERR_PHY;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/e1000e/phy.h b/drivers/net/ethernet/intel/e1000e/phy.h
index c48777d09523..049bb325b4b1 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.h
+++ b/drivers/net/ethernet/intel/e1000e/phy.h
@@ -51,6 +51,8 @@ s32 e1000e_read_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 *data);
 s32 e1000e_write_phy_reg_bm2(struct e1000_hw *hw, u32 offset, u16 data);
 void e1000_power_up_phy_copper(struct e1000_hw *hw);
 void e1000_power_down_phy_copper(struct e1000_hw *hw);
+void e1000e_disable_phy_retry(struct e1000_hw *hw);
+void e1000e_enable_phy_retry(struct e1000_hw *hw);
 s32 e1000e_read_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 *data);
 s32 e1000e_write_phy_reg_mdic(struct e1000_hw *hw, u32 offset, u16 data);
 s32 e1000_read_phy_reg_hv(struct e1000_hw *hw, u32 offset, u16 *data);
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
