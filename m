Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F03CA6004
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 21:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36C0440B2A;
	Wed,  7 Oct 2026 21:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFQvGnZAQpqh; Wed,  7 Oct 2026 21:18:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 52CCC40B26
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791407910;
	b=lybtFQBZWfgxpqCeLItFHjAGcPQXLvxhuB7gE21T5gEL8u3L5A2WKhycuL5tNICB1P0Y
	 O0jUVyzWYCncdsUQKL7gJt+jdlmpp3xR3cy2SLqPH2SzW1HaPnEh9RssJh+SHpw22WGEA
	 E1U3FcaBEzgK0DHbNC0GvwBH8jckw3tRNB4uxXsHCgJIe+IaSSpeNQVl0kvhCtYf5BnCq
	 4xzuEUPUTEx0OGKa5QqeE0H30c48LgFwVYgsf0us8D1VnX1bT4Yhs27pN8WreBChc8Hd0
	 FpFyWl7ud45h83ryHXaV0lVVwoVki3imSZfxJRsM+x8iQYk+qbX9/ZpGqzfi7Dw2BYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791407910;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=upjrrWsIOjqNJWDDqY95LTc9YsmP0mZ1mkK/ZMFTqRE=;
	b=ch5wVT4z/aCHVX0vay3IqbWfcLXwvlx+1HFmtvUUmLz/gpO/oURk0kWsagYy51tDaUwM
	 2WzUFb1inHI5JSRibRLMrpreSXXXu5byg2jIMR8YppLmAgDV1+SW99+PWTqpoTurHwWP2
	 l6jEGncK+DPpWAVzJ6QUZ5Q/Y+8+TIdQJ2FDR+GhCn5dd8sH3ABEPRGCORIGPsDvSoE2M
	 VCWSbOXr/RALW1BpyzjM4Q2/OtqNLqbGqWSk3O2At//vy74LcMIaZnGTmisupAdSFJI+e
	 +1CJ25iMrUyz5rSGv71dK7W2Lpg0Tr+ISsYELTAB1rM/Nm2XvJUAdy0j/TvqGKNf2BQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791407910;
	bh=upjrrWsIOjqNJWDDqY95LTc9YsmP0mZ1mkK/ZMFTqRE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gX7HYZGf4dks+zpHkWbFrudaJ2LzFPtQ6KBFHF28xxmgAgawyCxlISzpm8/tBlZP3
	 UV+ukJjuTcZP3welyRyoe47QnPQ2O0kmxKvXQyHoCdE0Nl9TTADM7Je5W2gDg43McI
	 hAzLU1XGlNhVEh6vX+yoqbnfyYLKh2kbynfz91VTIpbyFui6aBW9gWj/cMs8nGhaUp
	 DPA473NPy/Eu8kJF0VIQEUJNR9lpUnnzmU8nYCswphm3u35Nw52NeBoZ15t7rnLJI2
	 TSJvVnuUWNEdwnl4jnxtMkUgqjzwW/JIRMYzCNHWICebGkMNXlFVV5Qnlc9eGDFoTZ
	 BYlzXWpiWhxtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52CCC40B26;
	Wed,  7 Oct 2026 21:18:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1371E22B
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 20:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04A7681442
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 20:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2IyklCPh6LK3 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 20:03:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4F32D8143E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791403407;
 b=Jf/rde7mLAKLk9TZ2E9SoiKGjD6Bg1tZVo3/EILZQSXCPm2jWuNT9KOlMo22HigOKSBf
 YJt2IbC+V53a46Qq1JL/L/H4jdkq/SHyc1xGmF0jakJhRy/ypwJwno85B3Ir4imJYP5S6
 LHXL/J3uhqKOrTRKb/MHGyrvENmTTfcF++X/9gNGnchFZf/Eq5jDP/nURZdNPUSXe2o2h
 xxx53k2vN7QXEVwPyLfhaB+AfLaGC1jjJUWYHftAIPeGDLUElmNKXjkMCJP+duKjvyTOY
 x8Dutd38CSqHj6k2O7mryx8CCaW2tLIIZQaixCAzDDyqMk5ZT6SuQugWNJtPFPbTOuw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791403407;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=upjrrWsIOjqNJWDDqY95LTc9YsmP0mZ1mkK/ZMFTqRE=;
 b=JU9JXG8MD7ulqDKQU+4fjjWzovZZVfw3aEZaN+wVDfUC2VaDSQibzTlC9kwZgVfBGRRW
 p+wbTyUEF6TBc3GTurlASsHNkNBhwLamKv5ehGN9EFCwB+MbEAuqy7M6pIkZQeMyMPTZb
 J8q82c8Dpa45h/pZ8aV7yrF7SnoduUOD+J+obDwX8jrT48TvR48+BEoFPWgGoCWM8+JxI
 Vth3t8doXiydDv4m19/aiwITD3wel1Ya5rPx0KY4b6JqtOUn+ub3ug5lPXhqo1tGXJTBz
 uehct6Z4ZBS9yRGi+mNkuQH5GMssDhPnplECvy0iG8P/eLAf/eRdYJJ/f0uL6bCHOMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=UvIcrUq9; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=maciej.fijalkowski@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UvIcrUq9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F32D8143E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 20:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791403408; x=1822939408;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=a4mcv9oUmg3FAGRPQ/LhS/it/LUVnSs147ZtH9kUuIw=;
 b=UvIcrUq9uDBPDpXbcNs8SCEjETqrKwi1wNzVfPuLP9LiifC3M+iUJ/kE
 o1WEcaY3Dk5EpMIWxjAmHAyRJ/CKgS3fWn99PBn/U+Xo93UONH8FoH3tw
 oNY/FWfDwdbXlwjbIrO8CO2z3SCF17WQnv3sdwNmXqMXXQ9pQikpfKz3g
 4Z95dly8VYn1gzr2K4qdawrfpnH3EIiXmOPJ15Gt/L9wwogM16R2WnMFp
 iEPIhNMvDnMp2K4km0n/cxcrE58QKgR5hGgTan+SYqey6Xqyqe7maOlar
 WdGLMvt2t4PxFRQ2LW2cxAlxPsJD3q0IgldGAZrQ4IekbbJeBtYEUx61K g==;
X-CSE-ConnectionGUID: fueGlrIrTyONl3yI49yWgg==
X-CSE-MsgGUID: 3iNTewY9QcaMh8YgZxeXkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="173244"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="173244"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:03:27 -0700
X-CSE-ConnectionGUID: IyOWPPkKT5qgnvbK+ZHYxw==
X-CSE-MsgGUID: l49xqbp4SAOYpeRMiH5CjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="238066"
Received: from boxer.igk.intel.com ([10.102.20.173])
 by orviesa010.jf.intel.com with ESMTP; 07 Oct 2026 13:03:25 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, magnus.karlsson@intel.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net] ice: keep the RSS hash function on indirection-only
 updates
Date: Wed,  7 Oct 2026 22:03:11 +0200
Message-Id: <20261007200311.730443-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
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

The ethtool core passes RXH_XFRM_NO_CHANGE (0xff) in input_xfrm when a
request does not touch the input transformation, e.g. when it only
rewrites the RSS indirection table. ice_set_rxfh() tests input_xfrm only
for RXH_XFRM_SYM_XOR, which 0xff has set, so such an update switches the
VSI to symmetric Toeplitz hashing behind the user's back.

Once symmetric-xor is reported, the core requires all hashed flow types
to be symmetric for any following RSS set. The GTP flow types hash on
the TEID, so every later netlink RSS update fails with "hash field config
is not symmetric", including the one that would put the indirection
table back.

Keep the current hash function when input_xfrm is RXH_XFRM_NO_CHANGE.
ice_set_rss_hfunc() then returns early and leaves the VSI as it is.

This has been encountered while trying to run xskxceiver within drv-net
tests where one of the setup steps was queue pull out of RSS indirection
table.

Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index dffa213734f1..fd2f3cb9faba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3704,7 +3704,9 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	}
 
 	/* Update the VSI's hash function */
-	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
+	if (rxfh->input_xfrm == RXH_XFRM_NO_CHANGE)
+		hfunc = vsi->rss_hfunc;
+	else if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
 		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
 
 	err = ice_set_rss_hfunc(vsi, hfunc);
-- 
2.43.0

