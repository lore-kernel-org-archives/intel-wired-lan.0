Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3181FC4345F
	for <intel-wired-lan@archiver.kernel.org>; Sat, 13 Apr 2024 16:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B3A1240272;
	Sat, 13 Apr 2024 16:59:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JAGJg8a64qg; Sat, 13 Apr 2024 16:59:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E052740126
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1713027585;
	bh=oUiH+vf0hrK/Qru/neSqNEsJpr3LCTr96aLlQw5o3oQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=bir3NqTFf+guTMz7QnncQJOrv10vKOtavdREV3LkljbUrsb+QLW7bbEW3JOR7o6oL
	 JbJPu0+wWS+5FGqplxRbGJ/lNoFJKJTy+nSDp53NHbt3rMw2luCE7MN2IMx5jbH7mv
	 xozbGwEkIHaLqeygQT9zjp5mM5CPe9XYA3JdBSNRIFYmu7FgRe8DA4j2zuOSptwLnJ
	 c18w7n+UIssVsqOzokzOie4Li8AmZfSMTakAfShDMzZBESWjiqiaNGdIWNhXr6fgYR
	 IA0g1EdDl+S2N/xlreklGBZKcGitoMgB4jlcb7LOiHabDOGebQulHEemhTgfH5qnpm
	 VQmT3EDzfr4UQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E052740126;
	Sat, 13 Apr 2024 16:59:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 198C51BF3EB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Apr 2024 09:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F19B9416CA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Apr 2024 09:35:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fR6xmhPseR-E for <intel-wired-lan@lists.osuosl.org>;
 Sat, 13 Apr 2024 09:35:04 +0000 (UTC)
X-Greylist: delayed 403 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 13 Apr 2024 09:35:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 94D2741506
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94D2741506
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.121;
 helo=smtp-relay-canonical-1.canonical.com;
 envelope-from=hui.wang@canonical.com; receiver=<UNKNOWN> 
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94D2741506
 for <intel-wired-lan@lists.osuosl.org>; Sat, 13 Apr 2024 09:35:02 +0000 (UTC)
Received: from hwang4-ThinkPad-T14s-Gen-2a.conference (unknown
 [114.249.187.16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 521D03F108; 
 Sat, 13 Apr 2024 09:28:15 +0000 (UTC)
From: Hui Wang <hui.wang@canonical.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com
Date: Sat, 13 Apr 2024 17:27:43 +0800
Message-Id: <20240413092743.1548310-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 13 Apr 2024 16:59:44 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20210705; t=1713000498;
 bh=oUiH+vf0hrK/Qru/neSqNEsJpr3LCTr96aLlQw5o3oQ=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=PUc7I9kH3kdYLEjB4wj2ewioPUwWudW/StyQJSR0yIyCekVT1KKqTBrkJyui3ZtgH
 uf7kTYWg+Uu/xyJzrtxnGUI9ueYNwtUJA3qMoZktQBscOBfBrsZK0hX1pbV/amcK9u
 hR0nsw6wrKx1UYIU1QvwjR2cI3UPsHWN2vtdfeS8QaOskcSgBVIdoGWU1cw9rCe02a
 lSelF3W/JQkewFnT4kROc5i0XW2zs4IYYPbLWD3ifbnB2ACaL2mtYVRFu6jLCMEC1T
 WC0xBnt3V3vhXb2dOPHsLcUt7nXqULndRyLTXeBocV9eRqKCNANvfzMb8PuESj1RB7
 qE5TwUat5S3pQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20210705 header.b=PUc7I9kH
Subject: [Intel-wired-lan] [PATCH] e1000e: move force SMBUS near the end of
 enable_ulp function
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
Cc: hui.wang@canonical.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The commit 861e8086029e ("e1000e: move force SMBUS from enable ulp
function to avoid PHY loss issue") introduces a regression on
CH_MTP_I219_LM18 (PCIID: 0x8086550A). Without this commit, the
ethernet works well after suspend and resume, but after applying the
commit, the ethernet couldn't work anymore after the resume and the
dmesg shows that the NIC Link changes to 10Mbps (1000Mbps originally):
[   43.305084] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 10 Mbps Full Duplex, Flow Control: Rx/Tx

Without the commit, the force SMBUS code will not be executed if
"return 0" or "goto out" is executed in the enable_ulp(), and in my
case, the "goto out" is executed since FWSM_FW_VALID is set. But after
applying the commit, the force SMBUS code will be ran unconditionally.

Here move the force SMBUS code back to enable_ulp() and put it
immediate ahead of hw->phy.ops.release(hw), this could allow the
longest settling time as possible for interface in this function and
doesn't change the original code logic.

Fixes: 861e8086029e ("e1000e: move force SMBUS from enable ulp function to avoid PHY loss issue")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 19 +++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index f9e94be36e97..dd670cd87df2 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1225,6 +1225,25 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	}
 
 release:
+	/* Switching PHY interface always returns MDI error
+	 * so disable retry mechanism to avoid wasting time
+	 */
+	e1000e_disable_phy_retry(hw);
+
+	/* Force SMBus mode in PHY */
+	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
+	if (ret_val)
+		goto release;
+	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
+	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
+
+	e1000e_enable_phy_retry(hw);
+
+	/* Force SMBus mode in MAC */
+	mac_reg = er32(CTRL_EXT);
+	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
+	ew32(CTRL_EXT, mac_reg);
+
 	hw->phy.ops.release(hw);
 out:
 	if (ret_val)
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 3692fce20195..cc8c531ec3df 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6623,7 +6623,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 ctrl, ctrl_ext, rctl, status, wufc;
 	int retval = 0;
-	u16 smb_ctrl;
 
 	/* Runtime suspend should only enable wakeup for link changes */
 	if (runtime)
@@ -6697,23 +6696,6 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
 			if (retval)
 				return retval;
 		}
-
-		/* Force SMBUS to allow WOL */
-		/* Switching PHY interface always returns MDI error
-		 * so disable retry mechanism to avoid wasting time
-		 */
-		e1000e_disable_phy_retry(hw);
-
-		e1e_rphy(hw, CV_SMB_CTRL, &smb_ctrl);
-		smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
-		e1e_wphy(hw, CV_SMB_CTRL, smb_ctrl);
-
-		e1000e_enable_phy_retry(hw);
-
-		/* Force SMBus mode in MAC */
-		ctrl_ext = er32(CTRL_EXT);
-		ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
-		ew32(CTRL_EXT, ctrl_ext);
 	}
 
 	/* Ensure that the appropriate bits are set in LPI_CTRL
-- 
2.34.1

