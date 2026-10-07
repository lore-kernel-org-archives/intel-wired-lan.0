Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94636CA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 13:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 647F4606B0;
	Wed,  7 Oct 2026 13:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5YyaUjtlwmw; Wed,  7 Oct 2026 13:17:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9F1AA60821
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791379029;
	b=LCiFdWD2G3Yjz/eGt1U3N7w/409B3RaV+FXo5WKWeJFsw1F0Ht/26s8mDgDPubiHEP6D
	 koCuBhP6fY+Pmsn6MgwlN8HldI0YivrulBCe5Ls636rKWCU27EBiJje5E6lWeD9AqIzeY
	 kkHUvGTeT4gUX4kzp6WkAG9gw00JzWa+FBAoxk9JkUe3PxAVPzitMezYAXu+za2d2EVh8
	 WxeMqSYynyaNLw50/vz+emegNIs6pejiRz+OAWTu4lduTMBTgMJRpi9v9uFt973am9Yx/
	 kSIzISFt0OZBYyswlzKkq2Rh53k5+ZwIVyfhvG30vlu3T4MkyYSj7S5uGgSLm8G06KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791379029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/60bGBbXMhnQLXlmIb9VefK/5xK7Q11QCapYtDvy8Js=;
	b=Zrl1dAojcJbVampYU8jsEWM6whoNU93o7oKY9bpRWzhtZJGT9RAMxyTfDexzyp2HjRX5
	 kYXSb6cozUR7OEmEdz8VltedvX+Qpb5XVPPGih4w4dPgOVRNa2yU7+VjY5vvfeFWotxeX
	 gFggm8LGatCL5ZsKiByLzLum/8BP+CVZD55pCoAcv3SYwujEx11gDdyoJTMzCEYvqLL1e
	 dxbVQHibM5DovWQTXkgwxikv56fQ6yqEzggH5HxGzzrUD0+8JpfXYE2ulNBBCqw7H9z04
	 AlKuuxDZxXlOlYnsJMgbrv8jYRox9Ig9iwK0wWElqCq7J6I5v+AlDn8PY3rrcCpWTKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791379029;
	bh=/60bGBbXMhnQLXlmIb9VefK/5xK7Q11QCapYtDvy8Js=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q/QuhEi1hux04OXIh9cJhGCLMuq+rfioxZm/yFxFOvH+7ML162fY8+4u0ax6sbvMG
	 G2RBWhYukMPVbevhgdgiddHdCohOrE6jjrEA1Thq1IPqA2ciuk2CYc1bqWXZqxBz1S
	 r0cmcV8N5VgYLDdKRAGHvRBWwD4lLojk65wHS2/TdnEcKjDDNHOXc5mXH3i8+Tqx85
	 pVBtIsE10HT1brixWH6qUAvVm5bpRyb0sw8uvJJzoAy+GfprUY17gZZPQ0HxxAwZKz
	 YwCOLwjzGbRu/i0fRMHo5OzGGrcl/84telt+nMeh9OUEvr/7sK7I0NLKnlUtk/2Trc
	 H1NdX5Clbvvdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F1AA60821;
	Wed,  7 Oct 2026 13:17:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A4B4338
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 600E080EDA
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zoaf3Lap97xG for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 12:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 700BE80D91
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791377306;
 b=CJ6t+1NkwukKstf/2d4vvakLQJwdNxoPTYTFGJ8V8aiJPBPeC+3SysZrFN7Fn0zXt5J4
 RGTGAzDh0B4m4Y1a4YEaAEDEj96fmkoHQdCdXuLRvE38tJwQREu2t7VXpwWM5bsegC73L
 vqBlskf8L0vXxhIlm2g0pN9NZo0feTjg/vnhB1vTpQQlzQAqhJriiAQHCkRVWL8+D1/UN
 gjruDyYWriwt68wgrOpC+w8avDaXj5maAtjfD4q7B6FomNAtrvhOIOTeuVMTYtFxrAizZ
 Atfct0k9PoTJWeZHtQysYLXIgiRwyOmGgRT5JT9CA8HEOpTzm4QRh7QExiSLBejpG1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791377306;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/60bGBbXMhnQLXlmIb9VefK/5xK7Q11QCapYtDvy8Js=;
 b=if2v10lZ85wkoKwGmE9QKu3l1NjZXb10A4Tc2eLlKPsPhzJWaUEwIUQ5+7xmJSEMNMsh
 xagaeto3Mt23w4nfikm1szR9MId7t7lv+iDqne0ayuD8CVyqQcCPlu/1NbswNIR4utG3/
 rKqupQ29mHv7kY+sWqlL0WKn4ohLJbszVPivjso9NTikT/2zeoa1SiGqRxPUQm/WZVAJn
 PE/PKAyRqzwueniwvD/aHrEhaQqtNYJCaJIr7B5ROhndTZMUxAlP839PQiCm1pySzYCjG
 HSvs0r/m77QNVJnx5XiAN2lhyMds0YxipJArrlBoA6anthT8YvxoOt9RUA7U+rOhiuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RCgmIzta; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RCgmIzta
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 700BE80D91
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791377306; x=1822913306;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2Haw0CH9mI0z+9mY8ANpjk468+dCgy4XCUTg19+BBjg=;
 b=RCgmIztaUM/LpEUJKYEGoCy7eI9rcpw9c7iMLpAEfpl3CFUHC5gOJ0Fu
 wf2E1J4Wo5OHm7bWxXHT0plv+0PlCGHFQSWwg9MScskw5qyEgNjxsS/VZ
 zq7+MMPJp2+ayBGesgSpYAIkhaGcSIaadUIrwyo3GUd1Rk2Yt5ufyo4s4
 tFIpY0BrDLOdte1XYA36ouWRHSHtPZjR5sg0oto3quhaJl3oAmjXVf3Oy
 eLdS/PdRIcmYTY/OKcoX64qwyjQSFrU/5/QslP0DMNJNoOE6ghlvn+ZCl
 vBn0lq46qYW6vpj/nneyP4doTgJCphU0ALx8tJT+tRPC0fitu3/HKantC g==;
X-CSE-ConnectionGUID: 5VckiyuZRL+j+o5LAoIeYA==
X-CSE-MsgGUID: i7KkNEpLRSuGUvLcQFrZGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="31587"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="31587"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 05:48:26 -0700
X-CSE-ConnectionGUID: Hel6Ic/UQV6kfvT62UIk7w==
X-CSE-MsgGUID: npmnDOLaTh6ttrUDesxNQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="281191712"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 07 Oct 2026 05:48:25 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net v6 6/7] ice: Annotate PTP control PF lock handoff
Date: Wed,  7 Oct 2026 12:48:18 +0000
Message-ID: <20261007124819.1074675-7-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
References: <20261007124819.1074675-1-sergey.temerkhanov@intel.com>
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

ice_ptp_lock() conditionally retains ctrl_pf_lock for read when it
successfully acquires the hardware semaphore. The matching unlock occurs
in ice_ptp_unlock(). Describe this cross-function handoff with context
analysis annotations so static analysis can verify callers.

The annotations are inert for now: drivers/net/ethernet/intel/ice/ does
not set CONTEXT_ANALYSIS := y, so CONFIG_WARN_CONTEXT_ANALYSIS does not
cover these files. Opting the directory in requires annotating the rest
of the ice locking first and is left for a follow-up.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        | 12 ++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 26 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  6 +++--
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index aa81b6db7502..b63dd40b606d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1180,4 +1180,16 @@ static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
 		rcu_dereference_check(pf->adapter->ctrl_pf,
 				      lockdep_is_held(&pf->adapter->ctrl_pf_lock));
 }
+
+/* container_of() expands to a statement expression, which clang cannot parse
+ * inside a context analysis attribute argument, so open-code the cast here.
+ */
+#define ice_hw_ctrl_pf_lock(_hw)					\
+	(&((struct ice_pf *)((void *)(_hw) -				\
+			     offsetof(struct ice_pf, hw)))->adapter->ctrl_pf_lock)
+
+bool ice_ptp_lock(struct ice_hw *hw)
+	__cond_acquires_shared(true, ice_hw_ctrl_pf_lock(hw));
+void ice_ptp_unlock(struct ice_hw *hw)
+	__releases_shared(ice_hw_ctrl_pf_lock(hw));
 #endif /* _ICE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index dde6bddd4ecf..13d171d8386a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5375,15 +5375,16 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
 bool ice_ptp_lock(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+	struct ice_hw *pri_hw = hw;
 	u32 hw_lock;
 	int i;
 
-	down_read(&pf->adapter->ctrl_pf_lock);
+	down_read(ice_hw_ctrl_pf_lock(hw));
 
 	if (!ice_is_primary(hw)) {
-		hw = ice_get_primary_hw(pf);
-		if (!hw) {
-			up_read(&pf->adapter->ctrl_pf_lock);
+		pri_hw = ice_get_primary_hw(pf);
+		if (!pri_hw) {
+			up_read(ice_hw_ctrl_pf_lock(hw));
 			return false;
 		}
 	}
@@ -5391,7 +5392,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 #define MAX_TRIES 15
 
 	for (i = 0; i < MAX_TRIES; i++) {
-		hw_lock = rd32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
+		hw_lock = rd32(pri_hw,
+			       PFTSYN_SEM + (PFTSYN_SEM_BYTES * pri_hw->pf_id));
 		hw_lock = hw_lock & PFTSYN_SEM_BUSY_M;
 		if (hw_lock) {
 			/* Somebody is holding the lock */
@@ -5403,7 +5405,7 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	}
 
 	if (hw_lock)
-		up_read(&pf->adapter->ctrl_pf_lock);
+		up_read(ice_hw_ctrl_pf_lock(hw));
 
 	return !hw_lock;
 }
@@ -5418,14 +5420,18 @@ bool ice_ptp_lock(struct ice_hw *hw)
 void ice_ptp_unlock(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+	struct ice_hw *pri_hw = hw;
 
-	lockdep_assert_held(&pf->adapter->ctrl_pf_lock);
+	lockdep_assert_held(ice_hw_ctrl_pf_lock(hw));
 
+	/* ctrl_pf cannot be cleared while ctrl_pf_lock is held for read, so a
+	 * successful ice_ptp_lock() guarantees a primary hw is still there.
+	 */
 	if (!ice_is_primary(hw))
-		hw = ice_get_primary_hw(pf);
+		pri_hw = ice_get_primary_hw(pf);
 
-	wr32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), 0);
-	up_read(&pf->adapter->ctrl_pf_lock);
+	wr32(pri_hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * pri_hw->pf_id), 0);
+	up_read(ice_hw_ctrl_pf_lock(hw));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index c607627350df..f8ed04f6943b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -293,8 +293,10 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
-bool ice_ptp_lock(struct ice_hw *hw);
-void ice_ptp_unlock(struct ice_hw *hw);
+/* ice_ptp_lock()/ice_ptp_unlock() are declared in ice.h, where struct ice_pf
+ * and struct ice_adapter are complete and ice_hw_ctrl_pf_lock() can be used
+ * in their context analysis annotations.
+ */
 void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd);
 int ice_ptp_init_time(struct ice_hw *hw, u64 time);
 int ice_ptp_write_incval(struct ice_hw *hw, u64 incval);
-- 
2.53.0

