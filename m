Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6ADCA5FFC
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0D2080D96;
	Tue,  6 Oct 2026 14:39:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MreDovfAQ3Wm; Tue,  6 Oct 2026 14:39:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 33C2A80AA1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297550;
	b=PNwHMoD4yWNfFlUgkjmIvG3ndbEiXdFgtqnR9a7P3eC0U82SUAZRodyU4hwybzXQvC+c
	 V4lVjn8ibCC+Hlic+jhDOP+Vc5pFb/edjhDIigwyfCUli6NJU8ckyPGYwzybQY5UlC4U5
	 Zp5l/hLykW3PFa2kSrHM4XhITGF+QZiW+radBWxB7PSEk5FvJTvg4iiQJyTUD/AuhzmVx
	 r4vJQjS0pC9/ufn0fx/KYOyoRVqNeQqvZStWn9q4zK2LjTzeag+lfyGcL5dkwMZvlh3qp
	 fiMpWdJSyrPPPuktwTLYHGjUXoQe9K2CWM71PTEM3xUYqCl8WhMHWsNgHN44nIaolLg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297550;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vahnKXlBmegyO4gZ8ypKRVUQQgWOBvbNXZw3BhqOTAY=;
	b=gUcCX6WY05HZCvOCH5LSTKPIl6E+zI1UDE3YREik9T1XcQntEHBokrzNlLTKkWDyExPd
	 1irMDvI93IMlmzKb3oT9lj+vyrdt9U6Hc0O6wJAMOuW83YmtduhK7jK888WOdq9j2j1E4
	 tqLvy6b/HQKqeztiqeY4YWtgR/FApz1fYrwGiNDETXdsGlTgsrwmEXOIuE/RUSaTSZCNg
	 /NI+126Xjjc9n2tFZrgCBq+l0x1nWHVgQDXFfe0W62NjfLueM7jQeRbEGwzgT85+uO3Vx
	 datHa/OUZD56TdylGWu5U6jy2hW5EPNGVQmSf3wcc+cZz8CxVP7XVrR8TwNwoM2Guew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BNPVZn+q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297550;
	bh=vahnKXlBmegyO4gZ8ypKRVUQQgWOBvbNXZw3BhqOTAY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q4Une35KT9fyBhSrA4KpzPTj/B3DLokwCmyFWwp3Jfr5GYKtVxwQ4344jjsvvjIp8
	 pt2VjxjOWqtn4ISYkK2wlnuB1yIpFUA8pIYaxCc55sdArTmluhaFSdf0y03ZcycSQT
	 ZNAKFarYUv1Wp+FO1F0xRZ0MQKAFn9HgVTiCo60HNhtKDHXEyfs+Aqy7mTdArAiFRH
	 eNXxznDTsII8O8D/oz/4ahJfCLtVHDg5rLF70bkYMK7c4OVrFwZQ5ITZJVbRCX0Bqh
	 IwuzQ5Lv9ipviy9+PZlmdHPbS57w5pfantvKyLSgjDyYQ5pMfB/W7DC0ZcJMvZlX3F
	 tX6TzGgAQbkaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33C2A80AA1;
	Tue,  6 Oct 2026 14:39:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B77C11D2
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A86D680AA1
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rTVN9trq4vib for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 247A9808D3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297446;
 b=X6KDUURzP6fijAQPJNkQr49UERLXL9uoqUtBCmCMXQsZj8dnlbYXGK42jBa0ykGVZyNH
 eV2Um6XpcwZl1+A5xnbp2dWBosvvTITX3fH4LVwLGUw5/jOdCLIQhLEPNrFFqqCsNBOO1
 Sc3U8zq9P8Pp6qweCU7iZYS5f9BnieCHiR0BYskNYKC2bsB/pBbM59+3eCZ5gEcdunZn4
 KjfTWFdR4YYwy6KE5NrJmGQHebnwLiU7nfyUKZ2HzUWJG8VtCzMNvyQ/Q9TITjkRMmclj
 /pHWlVVPnv+vJDjM/xoxVy/vHWF3LmYYtctF1Pmq/IUp9MT+hZhu4OvCHrNLxW8tFzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297446;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=vahnKXlBmegyO4gZ8ypKRVUQQgWOBvbNXZw3BhqOTAY=;
 b=JVM/8z66LpGBebPEkUJOczG9+FTUS/oa+lX/kUbcqAyxO5va34nh3x8sB+U9T91i5933
 uIAHOglL3iTttg9E4zanEfnUgE0mg58v28NUk0u+bRzZlqKvVYLHZF2a180DguIJHsjRH
 U1qOqgr7AY7PWZ6bdRWGUXm6ba0fTsqc03Fplii/AKlYhJxLiCUC1yBBimqMLZSliiTtA
 vu12P9WKjocv8EROAmMtIyt/3Xky8U+KTeFuWculLh+UJaSQhKrYR/NXqS8q9PAZwHjy6
 jRC0ruMtRdG5w6QHp+xNGpAcPrQTFLVVyuSoh5OiZivbNkJgWeTG76UtY3/fX0Cii5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BNPVZn+q; 
 arc=none smtp.remote-ip=192.198.163.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=BNPVZn+q
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 247A9808D3
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297446; x=1822833446;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4ZYvQ5Dz+xpCSPt9s12RAV7Z03KVEc+QiYkffAIBT9Q=;
 b=BNPVZn+qYP3SpPVaso6lpG70L0LITKG5Jicc32ipFLqnRtXJwbY4ezfi
 mu6l72wu0NcBSctQzVlJNijUVHT6yn6TspzSM5ksCx5Sj2bVZG48rps3H
 YznhyS5MsF1LTT80alwMe3/dXx9HRximuMGs97P+gcc1/tNN6ovs6UWii
 JZAVDKCwfB1H5JurHvCFcySWsF7LZ1GinMY5H8eEH8VKhGx6wog/5CrLA
 oJ3c/+F8aRjNkgWpbr8Aqik4ZDzMIvUr8rk3XyViHp5sm1USSlWfQBH3O
 NXrHpxwg1JpwlGVnTKqwU3rCIBknrfrMudWNl3P/V2oWjsfmmixYUb1lP g==;
X-CSE-ConnectionGUID: voTl+zfWRWKydzzW16C1jg==
X-CSE-MsgGUID: GhXYSNNFSp2jAONc7Oqxqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="43271"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="43271"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:37:25 -0700
X-CSE-ConnectionGUID: PN+//domQY6vv0fGqLvzWQ==
X-CSE-MsgGUID: OXYTdrX/ShawihdtCIZbwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="1185310"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 06 Oct 2026 07:37:25 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Subject: [PATCH iwl-net v3 0/2] iavf: fix TC flower filter handling
Date: Tue,  6 Oct 2026 16:37:21 +0200
Message-ID: <20261006143723.2883728-1-aleksandr.loktionov@intel.com>
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

Reject out-of-range traffic classes and require a destination port for
valid nonzero classes. Treat deletion of an already-removed flower filter
as successful after qdisc teardown.

Avinash Dayanand (1):
  iavf: fix TC boundary check in iavf_handle_tclass

Kiran Patil (1):
  iavf: return 0 when TC flower filter not found after qdisc teardown

 drivers/net/ethernet/intel/iavf/iavf_main.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.52.0

