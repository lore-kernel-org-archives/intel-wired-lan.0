Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05693CC6B0F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB666606AF;
	Tue, 13 Oct 2026 09:12:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQcNuHr9RRQ0; Tue, 13 Oct 2026 09:12:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11438606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882772;
	b=fUqzvTg4O1wGG7B5ENV/jnRipnlWJ/38mreVsdvY//VBstF87orzdMuldr4lWXPVjEyx
	 3UlfMRLaRG0cxxHJgi8RSNGc++Pyla8f7F64X+Jz/jaPajFFapj754MMeLckpc701Rztq
	 rC/XoKbv3D+k4ihxygQkEnKXPAK6ev7W7bb5+C778OVRR+uxE8bh091t13Qk1OBSXM8/d
	 iFgc1a9ujFZWmrg0wjhCeYPRuVXtm3BM+NOHuaUNCCvsN5gCkhQbCe7vmJTvMhOmVDtFg
	 24+inxWxjgT1HpzOQ/kNgq4+wBo/5p/wajT7t/rgIK0k1BHLmVphkmwkXH2038DeMkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882772;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IRHd4gGBOIi+tYDrtwWUbpJGrcdnbiTNgHtHIHClX60=;
	b=gw44HFphTfDk6Nt8sQYuhyl4u0MZuetncOpXRnM5x8aLjbk8tdsTYo0FrngV1w5nxW4D
	 Gf7O69X1IOpXMnY0VqLcYqA+4nWWAbH8wX+U6MB2kkZy9ASBhDl6zysJt+8jVpHgoUVKT
	 vzL2ICygsyNlNWqpKbEPq7tGp5dp9gIJzxZ92RBjAPyoM2bbiPGYF2TQajIgSpxxHH67t
	 W0ik00uOfYgtoLcfn8OPMD7UUKQbP2SbMwJC3Mdz0soxb1fNH8Ix1sakJlVEiD7BifT3P
	 8JQoJbByPahnQ8U5x01wAax5tarUuFahTHNy9j+WRccQHzdVBka9w5rJ4OBC3s7z4KQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dJTN1rLZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882772;
	bh=IRHd4gGBOIi+tYDrtwWUbpJGrcdnbiTNgHtHIHClX60=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iYmypHBkgeWFR68KluPb28jC+PM+YMRVaJXx8VFKdN9YNrG1GNzONTGDkUvg3P1VO
	 lrNnetNjActMAaul/Lb/VBvHmRP4UtByPO38NVYR4gzgkzaPlJGRsbtdYRMstm7gBl
	 lPkHV6QjYsl6Cq5QdvColfltGS41ZkiwMJUSBOXxAYcFVxAX7/F7r4bXSGqLSonb7t
	 nA+ZVec/6yoa/LikzcjPuExTRb3nRBoiQ7CzVCo64ZdqB8wmQsRS3vtVDv56Gna53H
	 TiKuD/nDmphuMgsBlFcZNzKBKb64MBOysqEN3LrYppqs5NlKbjKNv3bjXPIMKls0gC
	 0iPLlXZt3TZEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11438606E1;
	Tue, 13 Oct 2026 09:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED6B64DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DF7736075F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PbAocHc_YbT3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B3480606D3
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882763;
 b=fRr6N04WH6zqKQKzsom6y5fbnPdC/hXbVBuWBcyivklYqLuOHiKS7eEGJ4m7fYRHIZw6
 TFPoky4Q1KcgYj/SB5hBnpakbXvUAcKrKDiVFChClqGUMcg6RyQidwycPAmBjb7RpezpS
 ZutdD8oH7BNtt5YYeTztWlNdTyIiiLMDX+tByjWcvPixEmHGRXHNthKJRJJpkZH+f085G
 gTDdCUZMpObGa2w1126yI4E6leTHWHeh+ZS3G2nRTPfbtNMoMQsBTVjqDqJ2lKf9M3cHr
 F9l5L/Sw17ypGSblVpVugoM+An3Mb4Gc1E/UTm9kBnPkJ32J5MziIPNA7eoozBusb2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882763;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=IRHd4gGBOIi+tYDrtwWUbpJGrcdnbiTNgHtHIHClX60=;
 b=QbjPbfa7pyGvXf1UPJXzjxIRoVWorrc4qBQv6GV+F+pk61yq/7VHGktE/9q5LN6ql6FE
 AJVuu7cEblKgYghNNBeMyeu3ZgfQb1iaANbuaDp3030yYiJKdP1xnL+Ez+x3gC+0mXwLz
 MKtBDgeZR9jhLcKGE0F3hnZ3DJBw4xv00cZWWm+Px9lBGofuIl3INyY50LabJ4FmISamw
 FIaXtbAErl+k/xJc8sfgbcwajvf90qEZIgfgUursk9fNfX9FnlnyjXrNtasYGZdk9d621
 cSgK+SZExMMfc+YNWLVkzSBduZmxZkLErwDm4vpIS1mC58GVKY/awqdE/nOsC+6t5Qw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=dJTN1rLZ; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dJTN1rLZ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3480606D3
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882764; x=1823418764;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PjbRskj63Z3DYtQkM625PLtUANt2J2eDwRBWDHsXEqM=;
 b=dJTN1rLZvSzJwaYmy5Og7uLitH8JGzZJBg5V2nGpbFcSrsjoUV1kJOqs
 51HojVoflxU6PGMyRinqLsXMEnXroXHSO7xEO8WwjSzyrxXC6shsgXGNX
 8dhCVD8Ja17gu/j2Q+lqhNrUbeqtJoL3zWlHlq8XovCiSCYXt45TKNX78
 O0ae07E+pLFaZHlNsHjvwtMoLzH0YrQzf1BNzbqM0WupGEgobNcvlFaNy
 wlBmLjtnJ1uawxmwEh1SvSl1GaP9e+FAP7pcMeUBqBzW6f4OUCIuF3zt6
 ZnfhD91YSgTBdv1BC4jBIw/VMHeN6wr0felpvD3S8b9wL+6FBZVFM6CRO A==;
X-CSE-ConnectionGUID: 6PQFTvIjQBKG26Jvjka0vw==
X-CSE-MsgGUID: fezIj43tTzuMqWMJL2txvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481271"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481271"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:44 -0700
X-CSE-ConnectionGUID: xtE9EHtYTzqE34bONunuqQ==
X-CSE-MsgGUID: nRDhsa5ISkewAnu3A20KSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125350"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:43 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 6/7] ice: Annotate PTP control PF lock
 handoff
Date: Tue, 13 Oct 2026 09:12:34 +0000
Message-ID: <20261013091235.1423979-7-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
References: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
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
index f104df72bedf..749096e39321 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1187,4 +1187,16 @@ static inline struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
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
index 0786d46160ec..98ce899cd7bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5359,15 +5359,16 @@ static void ice_ptp_init_phy_e830(struct ice_ptp_hw *ptp)
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
@@ -5375,7 +5376,8 @@ bool ice_ptp_lock(struct ice_hw *hw)
 #define MAX_TRIES 15
 
 	for (i = 0; i < MAX_TRIES; i++) {
-		hw_lock = rd32(hw, PFTSYN_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
+		hw_lock = rd32(pri_hw,
+			       PFTSYN_SEM + (PFTSYN_SEM_BYTES * pri_hw->pf_id));
 		hw_lock = hw_lock & PFTSYN_SEM_BUSY_M;
 		if (hw_lock) {
 			/* Somebody is holding the lock */
@@ -5387,7 +5389,7 @@ bool ice_ptp_lock(struct ice_hw *hw)
 	}
 
 	if (hw_lock)
-		up_read(&pf->adapter->ctrl_pf_lock);
+		up_read(ice_hw_ctrl_pf_lock(hw));
 
 	return !hw_lock;
 }
@@ -5402,14 +5404,18 @@ bool ice_ptp_lock(struct ice_hw *hw)
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
index 17000df77ce9..f0d019f9bddc 100644
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

