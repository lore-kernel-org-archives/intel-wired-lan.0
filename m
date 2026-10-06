Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8DDCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:41:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5145280D96;
	Tue,  6 Oct 2026 14:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2TORGM-XCte; Tue,  6 Oct 2026 14:41:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B92EA80DAC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297713;
	b=rcSnCB0htuB5qgdXmi9l+xWq/tlk24VLnRG5hioIrEU8GTcwyQzjLgWrbJBChf6Yst2l
	 e6LS/YOEFHekfG76YgZnkNjcg4lqm4VXI7zzKfwZXpGHVyFZE71B7j3l3sqSKTKZ8ChF/
	 9KQPUMvi6MsqDuGjc2oJYa9FI0eDoEjeJx1W/wtIKxtKt6dUkZMMeaKEtDfw7c7neI/y/
	 Mf7gGoYwPLUrqxGmd335vKnA0ad9yJ4Tel8Sbh6jvR+VOuYV6tDa9TSZDj5OGRtt5mkj9
	 qAPnlO6M02LNXNFRmaRJ2yHLkg+7+QAjQfpV4XWVBloqrvQvit+X7OPcHrjUcVKXTww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A1zD04wAXjMKZ5TsfZ9qOPTFrSauOwtlWC4/VMdQOM0=;
	b=R/NiQ+Gx/3wouvXSzGcrcuqaZQuZv/pL+HI0UoldN9/8QFx5mxa61aPIWXlUpl2VcfP6
	 /9HeE6QDqce1bNYGKSilHrmcRxfA29+tfhLYMT7xVQsZLvqda0vLnDHhM+r/GGT88oast
	 7kXBanv6iueLtzQHg/J5goZieqSgfyqHMBDkgRz3Iq4Kb9Eq1TPqxEluS9YeVu4Ff6fx8
	 tYFBW4jXFjdy7f7Ff9bht6Ri2uBX3+ypgbVD7xDLX+JtNJBueASBDxsFlMrHo4Vde4roL
	 6hU7zpjlZXCwQLuOLcsFZNxNJ2MzA70Ft5jWwE7WBKO49HaBNxRLuPt3X0udj1girBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297713;
	bh=A1zD04wAXjMKZ5TsfZ9qOPTFrSauOwtlWC4/VMdQOM0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sg4mCfU49WxabhakSJmQIirqi1YP5k1gJbwMTYCnNRNdNltxdCUIk0JnxbsTcZ48m
	 aPAFFjQ9iplAC5Z56V5Oh2L3/7ZEVOUH3r3HHW/fogXPhoTZBEouXQxKlBtUdzmK64
	 uuurJQQb17Qqs020KYDrAOK3F/oN/f69YvZbJzrXKpWGXRBmmPjo4Xbmvh62BSHIhU
	 gwIn+zUxhiAl7A86xlDPGXDO59+r251oZBtKpg9xkgXPbL+GO357ya4fT0/fvr1aG3
	 9RRkk82OrP4Mp9qWPEOCCYgB1DPQixZ8fhSL7wTkkASzZ1fpc+pdlvkTNXWkNbtRYR
	 yb2KAyAGmrR7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B92EA80DAC;
	Tue,  6 Oct 2026 14:41:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2140C1D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 074D660796
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jC8CGTtj4vOb for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org F3067605D0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297625;
 b=U0Xs9/XBB92p2x8tCIX5lqEzwtptzOU/PGMFwNE+DFpKh+ZeJvLJjPl263B7/xivAwDT
 VScjbdsCsN2n7OB8tnSGiEHoySaaF3NJz9UECyYyMjC8/MfXP2TrR253pBBbN/LW9gXbw
 1WPjUdM+zv/jaWgTMbHFn0wCqg1WkjCVSTJ9CoBdpPLa/b1NWHY3qdnjGR6LCCL63PjmI
 jaESc0vPLjXB+pzy7g5VrpTsewT7OkluuZcL+uzM/KG0rgTtBZZkjLNaEsdRBeRWsADcD
 RPoBAM7UFZrMUIQj6AEXf7SBe1BlGouzHDHeKLNAuwqURKJe46FQk/stzSodHGeqIeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297625;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=A1zD04wAXjMKZ5TsfZ9qOPTFrSauOwtlWC4/VMdQOM0=;
 b=kQKwa7W6GqYaGABVBOt73wdMtK2eyZH/S06dFLHNvRLEeAQ7yq+aLYtdpmqhYNe3KowR
 PHF6bfuEfuHiGujFU1/LSYtfcsbn9B3x5EZUa2YYuRRDJiJ+mDcG9POwnz+U0Rk6tFxMh
 I5uHtHYSVYVuSaIB2z+cTrg+JCrQQhNyaygwPsyLQV7mfv9988HOSQmzd8gPemsnGJUVZ
 IfAwV35eW9/8vlb6N3a11H2neOoQn2Nm2AaXcglUV8Xn2Pb57sMO0DzhoRuTUnrwbWij8
 kEy5utmNu4YyDJPiXJlJCbmWQMjY9RdgydAcQE3jLuJLV2PeS5WP3YJSW3rQStp1fyg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U6o5XLFO; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=U6o5XLFO
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3067605D0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297625; x=1822833625;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YZW4VC7D0xXPbuKScthZKOX7ucUwQmE9L3p/jFA459Q=;
 b=U6o5XLFOdsSbTEBYLPjUxkSHigu23joCfTDhBa8Hcm6RU4bB5QzfmZ3y
 2lomthnlavK9t3SjdHRVNzzXg8eRBbs1ild2XEP/upLG6BhmsLa4medQk
 lO3ONrGkfNfAqEMfgvv0CFl6MiOKtPc6xQiXu+WMm4f7O1MEqk3fmg0jb
 wXgDwWT5dD4Mi21Y+RWQ/7jfNy8laaMvRBHGg6Mdv9k6chHg2ul2AehTy
 wsbpgXH54vJR43EItKFvYdCpOIsnJn4mPtki2u8D+6h0zlcPYHPbSti2b
 sMbcnCN601ufhLXdhTeCNgG5TdSgzA9Y/nFPU7cShYsAeZFJuE1dggPHZ A==;
X-CSE-ConnectionGUID: UimVJtBlQlK+2O2ubBfRUw==
X-CSE-MsgGUID: TQU+S16GQCyxICAk01NxuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108363414"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="108363414"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:40:23 -0700
X-CSE-ConnectionGUID: lkUMIcgVQfOv3q+TId8gkQ==
X-CSE-MsgGUID: N4XHBIrRQP+Aaea5KRuNHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="315187465"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 06 Oct 2026 07:40:21 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 0/4] ixgbe: adaptive ITR tuning for RX starvation
 and latency workloads
Date: Tue,  6 Oct 2026 16:40:14 +0200
Message-ID: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

This is v2 of the ixgbe adaptive ITR tuning patchset for iwl-next.

v2 changes:
 - No code changes. Resending to pick up Reviewed-by: Simon Horman
   on patches 1 and 2 (patches 3 and 4 already carried it).

This series tunes the adaptive interrupt-throttle-rate (ITR) algorithm
in ixgbe_update_itr():

- Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us so the minimum
  bulk-mode interrupt rate is high enough to avoid descriptor ring
  starvation under sustained full-line-rate RX traffic.

- Add an ixgbe_container_is_rx() helper and refine the RX-specific
  latency-detection thresholds for finer-grained control over
  low-rate RX latency workloads without affecting TX.

- Limit how far a single ITR update can lower the interrupt rate while
  in latency mode, so a low-packet-rate ACK-only workload cannot drive
  the moderation down too aggressively in one step.

- Add an IXGBE_ITR_ADAPTIVE_MASK_USECS constant to replace an
  open-coded complement expression with an explicit named mask.

A fifth patch from the same original batch, removing a redundant
ixgbe_ping_all_vfs() call from the link watchdog handlers, addresses an
unrelated VF mailbox race rather than ITR/RX-starvation behavior and is
sent separately so this series stays focused on one topic.

Alexander Duyck (4):
  ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
  ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 80 +++++++++++--------
 2 files changed, 49 insertions(+), 34 deletions(-)

-- 
2.52.0

