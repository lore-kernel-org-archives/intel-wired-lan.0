Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67150C98314
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 413D681BBD;
	Thu, 24 Sep 2026 12:59:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6tCCp-PUJF1; Thu, 24 Sep 2026 12:59:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6D29781CD0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254781;
	b=FRSnG2rcbWeJAlkzIQNL5jZnAFTlysGLhVRbxDbQs9wpeZqOAioOwEZ7rw2XLoVzyoQ7
	 ur+9H8qznVQTnWLG6BN3UjB8FLN/QLggLveO6uRxZNKYdpJOveKJMVw3WK4qBpneAEIbu
	 +LYyvbiE8GvjYRupsa6f2rUSpOAVyqoq6yLLs5CSTzzTXFcsUq/RtQO77RlNjlfM3b9ML
	 un09OPJt0HzlZixfBP/qle/hA1sYkLj7nIs+58DGR7/Lz9sEAJE7pQ9ByvWUYoH54Orl8
	 JJyDdPAHUm+APzo4meF6rV03P4j/O50F3lKSPm1zxFW2JFm/+LXKh6FBOjNOxgi557A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254781;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q/0F1lRA0KxFHCz6ZH4xA5oaartOM54tEKJ6UNKgiQU=;
	b=KKdbfRNzoVraGSRktz6kd4iO/DgJQTSuVUQ+QejqGlFGZliP7gHhWyJqUvOlsclrAu1z
	 oYLg2bjvPwvNVoF6q+bD6MUbjCoLb2laIXXL3lR7trz5VT6L09LSfYtyHrlYM3l6TyWPC
	 WV+CpxOGn4DP5eAXBmIL2D+jG9wj3AiVafXmcJajqAAIzkvGTJp68RFoUpnIbdVnh0dsI
	 FWK/AVDsTQu60pm1IkRcdUXCpbLt6aDN6+OgulJHrYZC/UmKzV6dYLqWvV/0lj7Vbn08o
	 gv7ekBdOpgD3W4d3diPBquKrc7lnKI8Lwxci8ImQ3Qb816jwOD18fXjutPX0mY64zZA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254781;
	bh=Q/0F1lRA0KxFHCz6ZH4xA5oaartOM54tEKJ6UNKgiQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QsFpifpgsMk+93o59JKiaxCtXFTeEkaMMdtrybfbOFnlOh5/X4k4+t1QgDD0HdyAl
	 mvW9/lzelz3zp7Q7q7pJpN1D47w2+v8KG+PCixiKBnIPJZm1FP9bNw2PEPj1DiiFjF
	 1dF4JgNcAxMoh/gm+raSjcZg39iuZXG84IETeSjzTZOieeJuUr7u+tNwFd0tA40yxJ
	 /f4JYRKell5ZO6ubluFfCE8uvA78CNXIzvSNs+1mEl0VlPf0YrxxhkhU1UH33GYghT
	 OkW+xc8MeVqyHyYsjOccqHVnJJ2npjBmam9P1r+YuTWZcvqSPtoGJAEqB83G3kSwC3
	 /C+Kwd0xIqKWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D29781CD0;
	Thu, 24 Sep 2026 12:59:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 839A11F41
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74B5260807
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZFFglqE1BKT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A638960824
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254772;
 b=eLTdM+ZJ2J4ZSMxOaF98T3dMUata/Ec6EuGyQm024ZQiCSFCT7KRl6vGsLHwN7DV9ii7
 lYuQblML+EuZHmt9SQOK9i52O4NYFy9IU32iuL+7PdYu0ob/WNHm4UZ9qKKhJE9m2JsCL
 eVP9rTd1X6TSX9jho8NLcT+uSxHB3m3A82Rdhbk8rhbzs7sB8r+euXqeFpoaQJvaTdett
 WEgYsJiSOosmm1CMVdk5Hiy5DSugm634SiCDxdnXYzQnEfIeOEqoVx2Y9GAd9A82r8Juu
 zES3WKmVs3szo/IfV44B5GziFMvNR7YwAxxj82m/Y4w/1a8hLH6vvMSuM50vpa8Kb6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254772;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=Q/0F1lRA0KxFHCz6ZH4xA5oaartOM54tEKJ6UNKgiQU=;
 b=Dlaw3/C0eKc5k01BS2fHSUlrTQFOJbZ1TG+GVoh5HJYndeIkZ0D03vCm2IFWRJgd+cTt
 Jaw+a4R6uvKkX1Md2HRXWEgOKnHgpjItN4JZEA4ZPXjVGPZtkGsqKdWRjji6TnVtXrwdB
 siYayuAZ6odm98HYg9eT/WR/cqcD5YKywJEXTQaIKJlcUIL7nYWAUtSZ5w9T3s39UL+wM
 3McaLaOql5JCH6jyUvf95wuZeQWyjCXy0xRQnGGNpJnzw57Az3ef6ylMc9e3UcBqaqJ53
 1GV/oCwZ+k+bAXZXCRtZ7rLugX7mj5/hsABgVEdkQhBM3bVLUT8rX6qPfVxBeH5VXIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YGdY0InY; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YGdY0InY
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A638960824
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254773; x=1821790773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XTikmKf6gQDrTZu/kQxT5155ydRKPagkSJygHGDmZuo=;
 b=YGdY0InYjpEveD2kG0RQbvfLec54dx8UNLIBFGCDc9Agls/xmtmXoleM
 bKPlT5h9T4YtyVF0NXpm9NhPV17R8YpZX0nlYaN/sreCZTObWmOpegldI
 HWXuui3hMGXgAU7QYqa5Fj6VyffM2kICK30m+3Pxfw0b5+oaIPbrWq/cm
 GEVRW8Y6yQNGiNwdbw3PLgEjX6eKGY3yzvUbdpeRKEUOZFi0+3tHlw5Wr
 ESDFqyuMI93AE4np+CyyIOVcBAd/6M6gmcxJXMelre0mleJAORrWGsTGQ
 qNU8JBnHgd42oigpkkWo4hTTMCzKQ+U48fZGZURPT1a7nWFD6q9nou18r w==;
X-CSE-ConnectionGUID: JyKTAx4WTJCLjiP3tlAkSw==
X-CSE-MsgGUID: HiWs7tBlT026pgCetmXsSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249251"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249251"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:26 -0700
X-CSE-ConnectionGUID: pb/ZDq2ZT26kSpfoFx9lKg==
X-CSE-MsgGUID: /zWNdHnIQeyw/fwM9d1iCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934432"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:25 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 7/8] ice: Annotate PTP control PF lock handoff
Date: Thu, 24 Sep 2026 12:59:15 +0000
Message-ID: <20260924125916.2796499-8-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
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

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        | 12 ++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 26 +++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  6 +++--
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index c454f19a2cb2..8b7891ac25b0 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1179,4 +1179,16 @@ static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
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
index a85aa8f99057..eb7fdd000cf2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5361,15 +5361,16 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
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
@@ -5377,7 +5378,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 #define MAX_TRIES 15
 
 	for (i = 0; i < MAX_TRIES; i++) {
-		hw_lock = rd32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
+		hw_lock = rd32(pri_hw,
+			       PFTSYN_SEM + (PFTSYN_SEM_BYTES * pri_hw->pf_id));
 		hw_lock = hw_lock & PFTSYN_SEM_BUSY_M;
 		if (hw_lock) {
 			/* Somebody is holding the lock */
@@ -5389,7 +5391,7 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	}
 
 	if (hw_lock)
-		up_read(&pf->adapter->ctrl_pf_lock);
+		up_read(ice_hw_ctrl_pf_lock(hw));
 
 	return !hw_lock;
 }
@@ -5404,14 +5406,18 @@ bool ice_ptp_lock(struct ice_hw *hw)
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
index 16b1988e993d..ce8eb0672e71 100644
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

