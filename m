Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81A6CC6B03
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90D49809E9;
	Tue, 13 Oct 2026 09:12:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iwKkGUZkVdzr; Tue, 13 Oct 2026 09:12:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2ED680A49
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791882761;
	b=A8xG5yMo6ewaLfeklq8sXXcGmVO9gzqj2IVJelRt8ZiHZxNQiBzKwsyAu8Lx4PZ7VbGi
	 wKosu+1786e66VM7MmxeIXInseldtJHOa2gPk0T35a4Y6WddqHFFTC8ob4wanTLNrk65I
	 /P56CO/SccHGdshnF8sUplrLJAiXCzXCpVMm/GK9GfNAatJ3L1E5N/an6MO5a4OADewTW
	 SfinctE2tYqgytmJEKFpAGlHIuL0isL9aR9rMefEncZQTBKhIsNAn2FyggJI8LImlEGlc
	 spg9kjljCsohaLZZBqi/4bf64tLMnVC9irCB7Lwx3lU6gAmxWf4QfUzw000TvwVJAuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791882761;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kk4yMPjX6gBn9WFeD484vrF7C5xxFDp3Og0eJ3TWY8s=;
	b=ftQQ/W/utwb201+N34442WpNYtwcSrqJw095w/EIlVXcNSKy377EUOLEbrYtjclJpxT+
	 V5o521mWxiTVJoTP//FvyXeQyR/LIp6iFb3skBiP67foyjl+VuWMSPv7Q6YoTF0ZmYpp8
	 iXxptJ6JlIbb10TelyhqAkQ5c+8n1y2ozVFiZItO4nhur9pnNW7CwkU4U6vg+TRNRJL8f
	 fS1IUOGNLsapPywUDoXGCcy/wTlKsgU9xUUhuKsVvx/NMf5jCpEOW5x78khreS67CGVn3
	 P2+5KMa7FR8bALR9nGutrsX2bRf62vxqeCrEzaBfDVoSuX1R2e+xujvYI+vA+GCIDIg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791882761;
	bh=Kk4yMPjX6gBn9WFeD484vrF7C5xxFDp3Og0eJ3TWY8s=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uXolEe8+Ku3kvPI9fEvDbE12J9273b3KMkznWqFyc/VitYLKSliifZAgDFURSoyDF
	 y4i4pH2IbkXMTwVxXiwRA9cUivOhyd8JWGzPPAbw63h7F1N+Qcm3TKWKdv4VxbZlH8
	 zm+da2P761E5J1arRlw2JNY1hOYFO8nSlbSrCFwKCrlbAD7YVaeSACU91q6/4VBvre
	 fjlYazNwvP7+d2k8GRhgk8FgKn/eFiufyOvdZaVYNWcLfnKrLl+Y8XaHtM+h+Ty7sx
	 kV8wkZ6ejMZI3ZBr3845OyFfZQVUcGp3Yz6YugnB20ZcFTHHb0v5NT5WWGPbM+qzZ4
	 4mKP3OrxL5kfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2ED680A49;
	Tue, 13 Oct 2026 09:12:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2926F4DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F3954026F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 09:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKmC4wqi4vbd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 09:12:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 346564005F
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791882759;
 b=aERbJ7MZ+7nTBak9dwq8vUOu0szZCu5Bi9In9kDao7J8IDLJ1mr1NKTqi2H0EqVwjeAJ
 Jrn6NvepGNch6oaQBEIa8Gi937zyaESg7ysqwYghdZ1KJt9J69HXNqMnLYAfRMmqzH9bC
 4NLafeKxSYS+606Dw6+ngLxEFWvpGfrrfM4b1aDzCT5Ncr0daGqKtfb5TjC6YLIFh7oIN
 McTYVUaz8QsEUtFlcRhwVKwIg80V8EcgioH7NzP09TNJrNnE7+0sJlRyrg7oV3SGZepK7
 ESHUcqp+JqKpsQM9+dFlCAq+IIkBAWVvGbYyq4ckOwPUHbqE3Y0YPI6nUtlhhJhVUZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791882759;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=Kk4yMPjX6gBn9WFeD484vrF7C5xxFDp3Og0eJ3TWY8s=;
 b=e30T79AzpNtsbOk9dUS8x8hqW99l/L/JZHqOiXDyyMRHQvylJp4HLVIXAP2sCgDEg/Vx
 D8pnqzNBpEvvRPT0D4Gw6uAjSQhRUs+g21Qi/s4NbwXu+mZFLRPXgeTEi6o0kjuK6849z
 N4ag9rfcKj9W6J8iD7UhpY/qpWPhs/d4rPf+wwWmSzjXafaOSIGvo8u3dVZn2OCaxq8jf
 pFWEgCDWdsVXH/VMnwDOHWIeeOYD5MW8R0/7WnYzbRVjIfDUsbnNtdRFUD+lvaW2s/EIf
 7sen/wQcxueIjgQ8Ot5h30Lmv2x77utFgMNbr5BuJ5eYBtCmlPbQlcgCO8+jgSTZICw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="LNYiov/Z"; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=LNYiov/Z
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 346564005F
 for <intel-wired-lan@osuosl.org>; Tue, 13 Oct 2026 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791882760; x=1823418760;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=tlKDFl2GSx5zXS7I88rDXSbLHBo8npYU+hfD8Ofr08Q=;
 b=LNYiov/Z9mCC5ns5ZLByX9sfT/pxJhyHx9QosOpCyzMYUt4mWyuU0KDZ
 oPOjMDvFvkJrr/aIcHL3tkS0JeAF1SRbB4/3aYnpcJcVGT/aWLvokOmWz
 pGydk0OXZrZMhVPqbnbmAzhbGHhvPLgQwkMOay6rhhVrPxAsU6WhOw90W
 LBKhq4e7RMcrY4JGAYB1u3razC7iaZ/qt9VYerLX24+8e3Hjb1TcBu/7D
 3sufzJay6fwcsrPC8rO/s9gUA69nt405KkVl8PnthvnrZGB7MUzG4SJ35
 yhYW14CWT0W08c6ULPZrSItgO6qUE5f1CZ0qwBTQow1spTX76WT5ad8H0 A==;
X-CSE-ConnectionGUID: 2UaaYyzAThaGQaZdF3EQxQ==
X-CSE-MsgGUID: lJOLV1+oRSGAuy2YPSNvBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="481264"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="481264"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 02:12:38 -0700
X-CSE-ConnectionGUID: ut1QyZ+yROqITjY22RDQEA==
X-CSE-MsgGUID: RNr74+8sS8yZDi07xaqyTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1125343"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 13 Oct 2026 02:12:37 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@osuosl.org
Subject: [PATCH RESEND iwl-net v6 0/7] Rework usage of the control PF pointer
 in struct ice_adapter
Date: Tue, 13 Oct 2026 09:12:28 +0000
Message-ID: <20261013091235.1423979-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
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

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://lore.kernel.org/intel-wired-lan/20260924125916.2796499-1-sergey.temerkhanov@intel.com/

v1->v2: Rebase onto the latest dev-queue branch
v2->v3: Cosmetic fixes
v3->v4: Add the rw_semaphore to protect the ctrl_pf
v4->v5: Split patches into smaller self-contained parts, tighten potential race
        condition windows, annotate RCU-related code
v5->v6: Rebase on top of the latest dev-queue, remove absorbed changes

Sergey Temerkhanov (7):
  ice: Protect the control PF pointer with RCU and a rwsem
  ice: Cache struct ice_hw pointer for split register reads
  ice: Reject PTP access without a control PF
  ice: Clear the control PF pointer when the control PF is removed
  ice: Document control PF lock ordering
  ice: Annotate PTP control PF lock handoff
  ice: Release control PF lock before RCU wait

 drivers/net/ethernet/intel/ice/ice.h          |  42 +++-
 drivers/net/ethernet/intel/ice/ice_adapter.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h  |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 189 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  78 +++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_txclk.c    |  20 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |   5 +-
 10 files changed, 293 insertions(+), 82 deletions(-)

base-commit: d2e3fa79cfab4d5c5715d6503a77c8648ef3c76c

-- 
2.53.0

