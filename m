Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53182C88E53
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 12:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 242CF4064A;
	Tue, 15 Sep 2026 12:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qg9MT2xx_E2b; Tue, 15 Sep 2026 12:55:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8BD6840654
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789476937;
	b=jzUVOXuAVpruaKg8UqrIDJ23+068/nn02nlVHnxSB/mNTVILuSz0mfgPMBUiEqvxuOuY
	 TdFek+HbeneBvGR7OB9xbHPLkkC87wiEhdWVo4FxzlO6Ayl9L0/mvc93aQWXeaYUIdHFk
	 RQkIvV+UmrCNNz8o9SBv/dSf5lY8GaZY7Pt7reLKetjrgkL22jFIX/BIaFP+sATnWciGN
	 omvaGfYHb88QRz8RDic6oOxOCnYg1B3sdkZh6yoUw2Q5+KniPfT/70H/AnH7MPfijEeCM
	 UFwy82UhDf/FPC3vPzd0FvCrcPjeVKwCi9s1d9fARUbrnCg55ah6fgjj3CrSV6tyXRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789476937;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=89Isjeaqh/HG24xe3n7KZiGMYWPG3yDTtNkQEh0TRlA=;
	b=TYqdsQFYM0s3FfpULOhtqMHfaQCBkRW0WeM0NL6wUew48fnCHl6SYsoWy1jvyOoYicpB
	 mqqkD0hvdVh/ESrVcYH6TY9yQmyIq4qYrA83ihlVUelwCY1vPUnPRKV9kqgSm9v2jR3x0
	 cWcJDDFvXU57pgjy/OVLVkUr8KR0Jh056ItpysxCFLheiEmAxlOH3eFj2wX/0ZMIO2+3v
	 fdYj0i3KtwmQl2XLzqsE+cP8agh6/Yc/eZBNi7kRdw06rvfPo+BX09xLCr7PKjr93Lzs4
	 LRXIpiyTunyYkc6/T00t5BaMnhFAz0+BqFCSNV/Ny233HAtipSH9Ug9qsirMllBVz7A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789476937;
	bh=89Isjeaqh/HG24xe3n7KZiGMYWPG3yDTtNkQEh0TRlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BndYCUXJQazrYx1pMJLCNJAACoqiR6Fa6XmfPFzfii/mV8TQwPRnSrKurcoaO7ttV
	 Y4ImVfhmJGyg/QUN05p+qGRm6tLLQlDtfkK3119hC3pc3vMs/Q/z/eJgLQV46vADWy
	 9T1xCwIYRUZprSNKCT++GXzNhOlrkQM924VIwoEpQV/dMfqCWx+POiVwQ3F9dlTOOz
	 WnEOIFYdr3EFYFnK7MxvKfsiL+imLOKv1VMQjwbOzL0/OUF0qWCRuFyoAnyuuNh759
	 vYP3WErdRAhPB1M4ktwYUjOnFfZbCPHYXBba3YIMPkZmV1THrEFIqhkJ/8sfN6m+Ya
	 y4NhQX/CLpHQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BD6840654;
	Tue, 15 Sep 2026 12:55:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 739BD259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59F7F4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 293HrA28_kjk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 12:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 98DC04002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789476934;
 b=Obc3env6WOhJBTWDxRF+zJV033nILyAAH1+GsTdXqQGhokJEOZyk2T7AMVXblPeR9IeK
 nf2LQKP5ZF1tW5oil4NGSJh7glGo+ifvIPO9UInIxuZPkEEbRqIN7KcGA/yryq4xsWUrm
 VCN5xVvegjDspShV6ZD+96y5n+yz5kX2wfrbLdHi03GtlGcpeFxsOZy/MdCUxudCmjgwQ
 p9oFHYHyPVdjF28qET+DR8ajNHZophlFu2hpefCpu67tAfArxKTfFPU4AcyQbRPtlIUHy
 GTT5SgkLMEIRH/FdhRDMmtgY7o51FAKDC6afDOoSy7hv0wkWJfiNjF50gQwKe5aiHYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789476934;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=89Isjeaqh/HG24xe3n7KZiGMYWPG3yDTtNkQEh0TRlA=;
 b=cBXKHz697xaKEqGCwLQxWUMi+mlJBvQ29zbAbtrPX1ZPNlskMX78Ctc0V08PrvrG/EYL
 zMV1eG2oLmZdlQfAejjjreFmFU8/At/YMDYvBdicpNiXZeji/rP0hDUBrYb+cownZU//U
 ey1UD4R1KEOZnw9dg8FWiDXpmMIJg1dmTGVw6IpgiAJ/eLCL/GAifLadZWynTYnncvACy
 J6TPry2A3fc98fM4BKHxTmx3tInACIAUrfm5BV633aemT2AkUQC/hHRK1Br/LkXtb4PB1
 P5E4BX3lEVp8sGMoVneXpTGZ1+kboJutu1ZR4WK3JFYpX0p8OKhC2mZ4+N530mNPEMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JeA+Gta4; 
 arc=none smtp.remote-ip=192.198.163.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JeA+Gta4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98DC04002B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789476935; x=1821012935;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kajMgWXZORU5tyZRowiuAqvsW2zmwF2rSCVcQY2ruv4=;
 b=JeA+Gta4BvWj+KOgXJy4jsQTy74w/5eiJbfZhsiuGGT61UnA4n2Hfh/1
 QKxgta7c0rlQAV1y1DkhxO17aWz7mwgOSuamilW4TjDPVxqm98s3Pe/KA
 PWouBEuEGT6np6/CR/07VhguSJsjcgKV+EIYw/AHRoqH6vHaTn+ZXxSj8
 9/GA+8dGZzyrDwG/N5xWDlc43RGDG1J9JGczSHC5ZUUK+orbiFx52ytoV
 pf0uFMDh/H5af90kNXqkF1tbVR1OUrPVJD550tVxC5ZhU+z5hLiJ9llFe
 ckLuevUUlRLmddrd/lCLE98zSBaijl5UFhTLYtw8XDEXpnqbgjrJQceC+ A==;
X-CSE-ConnectionGUID: LzyAxzkwSSGTFoBSwBMclA==
X-CSE-MsgGUID: 4FKaBeziRXeq8maDodVIug==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89853105"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89853105"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 05:55:34 -0700
X-CSE-ConnectionGUID: DDkh/OEvQ0G/U81UVf/9UA==
X-CSE-MsgGUID: VoPsY+QvSW2Dn5HtJzS23Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1225183"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa011.fm.intel.com with ESMTP; 15 Sep 2026 05:55:33 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-net v2 2/3] ice: fix autoneg disable when link partner
 doesn't support AN
Date: Tue, 15 Sep 2026 14:55:28 +0200
Message-ID: <20260915125529.3975723-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
References: <20260915125529.3975723-1-aleksandr.loktionov@intel.com>
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

From: Konrad Knitter <konrad.knitter@intel.com>

Disabling autonegotiation was silently ignored when autoneg had not yet
completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
unchanged with no error. This could prevent link from forming if the
link partner requires non-autoneg mode.

Extend the condition to also allow disabling autoneg when the link
partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
zeroed an_info when link is down does not produce a false positive.
Introduce the helper ice_autoneg_disable_allowed() to make the check
explicit.

Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 ++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a257b7d..4ce198f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2501,6 +2501,28 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 	return adv_link_speed;
 }
 
+/**
+ * ice_autoneg_disable_allowed - check if autoneg can be disabled
+ * @p: port info
+ *
+ * Check if autonegotiation can be disabled based on link state.
+ * ICE_AQ_LP_AN_ABILITY is only valid when the link is up; gate that
+ * check accordingly to avoid false positives from stale link data.
+ *
+ * Return: true if autoneg has completed, or if the link is up and the
+ *         link partner does not advertise autonegotiation capability.
+ */
+static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
+{
+	u8 an_info = p->phy.link_info.an_info;
+
+	if (an_info & ICE_AQ_AN_COMPLETED)
+		return true;
+	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
+	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
+	       !(an_info & ICE_AQ_LP_AN_ABILITY);
+}
+
 /**
  * ice_setup_autoneg
  * @p: port info
@@ -2539,8 +2561,8 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
 			}
 		}
 	} else {
-		/* If autoneg is currently enabled */
-		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
+		/* If autoneg completed or link partner does not support AN */
+		if (ice_autoneg_disable_allowed(p)) {
 			/* If autoneg is supported 10GBASE_T is the only PHY
 			 * that can disable it, so otherwise return error
 			 */
-- 
2.52.0

