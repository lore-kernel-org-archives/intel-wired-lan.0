Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB125C04FDF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Aug 2023 10:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46565813F8;
	Thu, 10 Aug 2023 10:38:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46565813F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691663928;
	bh=/sgIuIselAKj7UUJa3j5+93eUxeSwdDjTHMDeD8xbTw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=1o/f1QU0WIW9tw9g+C4JlV1vdfd98jPoD8Ykol5sEWSz2e0vJ+Boum783T9pml1/g
	 Dum1QPcGqUvYopSEHKBNw/cgHAFNE1W+2JzuWvxMfhNYHFHEyGyEKGYHstodSdY03h
	 1ZyaD9/bKJGZ2rYuMYupVb44ff0apla2jLQSqCsQFu8sDBFgfeX1+AoFG2x9gm3SKK
	 eXRVw5AY0s96aAhZzlOqNanX7ovDWs5gOQxP6KxMSXTUESiH4AFY/DFO2y0irljLTF
	 BcaHBMSTpzGgTGYBFpUgF67dLhG9I0hKqLe2pPKD67s0iVBW5Bn5dnnL/MV9u22DI6
	 hyhZrO5HxSwxQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EHfYE3ma1W2x; Thu, 10 Aug 2023 10:38:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6277681411;
	Thu, 10 Aug 2023 10:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6277681411
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 6EB271BF34D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 40C3B417BD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40C3B417BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ly2uVhzC8wMM for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Aug 2023 10:38:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1AA61417B6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Aug 2023 10:38:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AA61417B6
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260804"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="370260804"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2023 03:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237163"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; d="scan'208";a="767237163"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:40 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A5DD2332B2;
 Thu, 10 Aug 2023 11:38:39 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Date: Thu, 10 Aug 2023 06:35:02 -0400
Message-Id: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691663924; x=1723199924;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n/ok4NrU7F+F8sAu/7N+WQcM11TVUa5cAcBCcZXT/xs=;
 b=kdMXONcBZo1L4/xBk22EQHR1Phuc2Vlyi+zqMWyQAa8Y0jdXACYzHdmq
 rRWUXp+7btdBy7IT5m4csC2q0zuzQcScN77H/Ev7hY0LkqfR7OOOI6f36
 9WJI2kHD3wh6KPKDEQeccls9AtN0TIKLw8M7V99TRXku5Yd0lc+TBN5RS
 pmU+oWlQnIBb6Q0FHMXRzOe0AztpsStpY49q3oga4kxbhV1ngqdgkHsuj
 e+dLmIBugAR6KUSOi94CLxWTpdzoQN6ApE9hGS/zHHC3wM9c1pT6K8oDM
 jIG/gbP/twJoe5w2TyDPqXYZIwOYw0SPXMxQwjDoMCAe3znzIv65VxzrY
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kdMXONcB
Subject: [Intel-wired-lan] [PATCH net-next v1 0/7] introduce DEFINE_FLEX()
 macro
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Steven Zou <steven.zou@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add DEFINE_FLEX() macro, that helps on-stack allocation of structures
with trailing flex array member.
Add const_flex_size() macro which is a wrapper to get size of data
allocated by DEFINE_FLEX().

Accompany new macros introduction with actual usage,
in the ice driver (hence targeting for netdev tree).

Obvious benefits include simpler resulting code, less heap usage,
less error checking. Less obvious is the fact that compiler has
more room to optimize, and as a whole, even with more stuff on the stack,
we end up with overall better (smaller) report from bloat-o-meter:
add/remove: 8/6 grow/shrink: 7/18 up/down: 2211/-2270 (-59)
(individual results in each patch).

Przemek Kitszel (7):
  overflow: add DEFINE_FLEX() for on-stack allocs
  ice: ice_sched_remove_elems: replace 1 elem array param by u32
  ice: drop two params of ice_aq_move_sched_elems()
  ice: make use of DEFINE_FLEX() in ice_ddp.c
  ice: make use of DEFINE_FLEX() for struct ice_aqc_add_tx_qgrp
  ice: make use of DEFINE_FLEX() for struct ice_aqc_dis_txq_item
  ice: make use of DEFINE_FLEX() in ice_switch.c

 drivers/net/ethernet/intel/ice/ice_common.c | 20 ++-----
 drivers/net/ethernet/intel/ice/ice_ddp.c    | 39 ++++---------
 drivers/net/ethernet/intel/ice/ice_lag.c    | 48 ++++------------
 drivers/net/ethernet/intel/ice/ice_lib.c    | 23 ++------
 drivers/net/ethernet/intel/ice/ice_sched.c  | 56 ++++++------------
 drivers/net/ethernet/intel/ice/ice_sched.h  |  6 +-
 drivers/net/ethernet/intel/ice/ice_switch.c | 63 +++++----------------
 drivers/net/ethernet/intel/ice/ice_xsk.c    | 22 +++----
 include/linux/overflow.h                    | 27 +++++++++
 9 files changed, 101 insertions(+), 203 deletions(-)


base-commit: 052059b663c957aea5a90f206ece4849f88f34bf
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
