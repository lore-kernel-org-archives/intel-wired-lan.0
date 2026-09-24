Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63623C9831F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ED7981B8A;
	Thu, 24 Sep 2026 12:59:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jOpkOwRVUu99; Thu, 24 Sep 2026 12:59:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 88BEB81BBD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254780;
	b=hXGCwaBiKGFQQnudCDbKBMmjswUNqhZCnlV3aC7QcNApbMZjF6cCZW4jwLQFBlViBK/a
	 +doCoPD/QuxkuhfWCjf3vcxT0aCzGTVk5eZLGG7BF+3sWOAjFxWSUq+ujlxh+Zsat287y
	 j1KfMqbPkea6xYzXa+neHcTBBM5GSYnDqkjOuaz35Gra9nrAerkmPAPU2jYbuzimPw4FE
	 kbER/4rh+HtgTYDLp/5HsXp2wd2yfSdltHgXuM9HosFOg2pnpEyHgWt3FdZANXCToP2Z4
	 Ctt37I7dWCByPB9ICXNOSkmn/whVifnsA0sbP4p/HGY6UlTVzTlzA5ao8fAhgBPbVJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=S0HmbmvUnyNABrS5gZybRJ8qTHLPFlxZP//naxo6VYA=;
	b=LRW272ZQj94TxOoLE3X+SRnbKhp2AbN0xvMtlF2TfZzIX7x2ceiJovLSxuRJT4lUAo2L
	 nC35QpPNgtDtoEAaHcRZk1jXzVkxAKe06jwDBgb28tSVxD0aIQViRfLrLTbDWFZOzUuxG
	 vfl7eqZYcQextJYD6hwnSCzVUIJAc6p/pPl/pCIdxAiNa91Vn+J/Eu51vz0FLkfCY3sRW
	 R0gGYiMwCAFIuCBq+3TvehXpTzrbcyv/PTQ6BOvwXSNgE/yZfzIjR25A/rcLsEJ7Zdfoz
	 IkxAPlIT4tJ0zRPewKXU3iZeFavi4NNGtnXMPnXVhx04btcotrDQPMuCuJUIKdRei6A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254780;
	bh=S0HmbmvUnyNABrS5gZybRJ8qTHLPFlxZP//naxo6VYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8BGMtl8DMG8LrbTFrSKVrDb2S0S4SG5P1xwGQyga1uJ9UlzoV2t5UtUR+sCa5UUOr
	 4MEcF3v3D0HkYb6MGPVn9SzzkOji/zeogFfBMmxzqzVwzsaxx0XVCiDYQSukYvEasE
	 iBWQh3eTWrfDyypH4QY/xpoxeLsJsUTT80hvDTlmdCo2i6L+o7H4IoPi/1fnOhrJ4m
	 FIxPwgSHV4d3z9FPopMS0sY3EmkX0EDHQbFNtl4YYyZz+XqtN3QQENtoeOP0xjoCEc
	 x7Kwb0N7sAaSKDPBFoi8VsIFsVK+1XchctESJYcgg5llSNti9kgYBGu6ziaKWBCTDs
	 941J4EPRyhFXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88BEB81BBD;
	Thu, 24 Sep 2026 12:59:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A85C194
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60E89400FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYrsYbqnWcYV for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org AC23D40470
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254772;
 b=PwFrjD8k4W6cVKm1WZegOpuuigFV8Vg9A7TRdIXpnwObxZunL8HGkPeQegh5ndlc0zMv
 dn/+6ctSM5HEbD/3aSM8UCIQKtgc0SXXa1o+TGhReVuKJT5im3WwZ5TVWMF8qquXrCxw6
 fk3Ty7wwl0k5PiCwLnOZytdHGIXXb61TtLkuWtQTDUx3Xiw+679kH/rbvm34VOmA37C3W
 oeZrcCgyidnhMXlIjwY4OVHWZWhX2nQcRZrkveb+keVDUpbc6xkPuJhubGzQcLVUoFHEQ
 uEGoJcOueEnuhIR4PdvarQ8sqf+O/cywQGsU2yU3Y3Y0hnUh1911B8QO0xPKk/c92dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254772;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=S0HmbmvUnyNABrS5gZybRJ8qTHLPFlxZP//naxo6VYA=;
 b=dSfO2HcWeRkKclCChB/X2bgn+kvL0TGJlZvBE1qwWQt+bQuNWPsa1zOiO67tQT48IQcY
 2tg/ZLKD8Yu6oFqju0vQPFCLz4M/9yu2RLTtu2zplq1zBD3E5Gwee6L7OMwEqeoauEZRr
 AatnwJX0O8oM4S8pN46qo3Pp5w4jcT8KeeYbC5MIidHSYdZk8CMmGbiQgmTZLQ4mJPSwb
 OP3wxJoaey+P0zd6arJ7bXxdDXEJu5F2idPWWn9UmkK2+ZkBWT6amKWqGSmRwJ7CgL3Nx
 rVMgXV366usboT1hU4QyugNleHoXsXsJF1xFRdrpyFXPF/0QOTs0JCE8ZNCDHeZj6nA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=m5F+KpdF; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m5F+KpdF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC23D40470
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254773; x=1821790773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mKsIOdT7NnHNwx01DI9VzOebkFr0BP1VEviARtH2q/E=;
 b=m5F+KpdFTzvO1hN2Lggoo8OxUcUKyTpwyOW5WAyTu+fELkuG/JzIypcs
 Rl0n3jlXX8pnsxbWRX1Rmhm2ZzQtoygknSsAvI8FQMJ+YI1AQHmdDu+qv
 tuG1pIqGUt+iUij1UNdtwnZlfCfStwEhvUszIgjUVfdANWVztKVpRITQd
 GrSCq1AY0fp82KeiNrkD+70o96GSgN5HtAuFgGb0bqAmS3fpapFwFuCb6
 pVoUylBOoj15H4D6BbBerYfo9msZpYG6aHVTZYsMqsfr0iXXG7V6X23rA
 q8o28LSTm+Ku0CKv6Y+gMNqBoG//bUPqKXusfH8xTs8Gnuadetm+B6GdE w==;
X-CSE-ConnectionGUID: vIJJe4feSn+qjnm6r26FDw==
X-CSE-MsgGUID: aoMBKAT8RDmeNErclXpSag==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249257"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:26 -0700
X-CSE-ConnectionGUID: TpJN7cXJRo2WmkSjOOVbaw==
X-CSE-MsgGUID: bSiv6btbScuyDZd45+odbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934433"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:26 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 8/8] ice: Release control PF lock before RCU wait
Date: Thu, 24 Sep 2026 12:59:16 +0000
Message-ID: <20260924125916.2796499-9-sergey.temerkhanov@intel.com>
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

Clear ctrl_pf while holding ctrl_pf_lock for write, but release the
rwsem before waiting for pre-existing RCU readers. The published NULL
already prevents new readers from acquiring the retiring PF, so holding
the writer lock through synchronize_rcu() only stalls sleepable users.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 3ed37bbae161..24d4ab2197c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -3302,16 +3302,21 @@ static void ice_ptp_setup_adapter(struct ice_pf *pf)
 
 static void ice_ptp_cleanup_adapter(struct ice_pf *pf)
 {
-	guard(rwsem_write)(&pf->adapter->ctrl_pf_lock);
+	bool synchronize = false;
 
-	/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
-	 * is being removed to prevent any secondary PFs from accessing
-	 * it after it is deleted.
-	 */
-	if (ice_get_ctrl_pf(pf) == pf) {
-		rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
-		synchronize_rcu();
+	scoped_guard(rwsem_write, &pf->adapter->ctrl_pf_lock) {
+		/* Zero out adapter->ctrl_pf pointer when the ctrl_pf itself
+		 * is being removed to prevent any secondary PFs from accessing
+		 * it after it is deleted.
+		 */
+		if (ice_get_ctrl_pf(pf) == pf) {
+			rcu_assign_pointer(pf->adapter->ctrl_pf, NULL);
+			synchronize = true;
+		}
 	}
+
+	if (synchronize)
+		synchronize_rcu();
 }
 
 static int ice_ptp_setup_pf(struct ice_pf *pf)
-- 
2.53.0

