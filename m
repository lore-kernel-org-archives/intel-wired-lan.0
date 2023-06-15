Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3691EEB64DC
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Jun 2023 11:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4B1240465;
	Thu, 15 Jun 2023 11:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4B1240465
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686827157;
	bh=OD8cD4dPtQGb+h9Kp0u4geD02iXmufbysvg/VWGOpl4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=srT6JML133bAbCbvTOtaxmJFYLjh4g7pX9ZNDDM7k9hT9dnjOoYdEqob0/XJbvwRC
	 xPe1A96Wvm+14l+1ufPVzc5a+QkgGxl2s2Fyn29FQ8mzTy/3fLdStHFmaKw60RDu3a
	 rXtK3lrKu+ZfVpk5ljfMwFK7Y3N0Odjr/oD33wwrfOQrZfxb1UbtKamZxg84kojqhW
	 NtNZNkuT+VoME+uhwXKWBU5s+108sQjYXEvnD0Si0oilnDhBAhbLQhgMYFn/B6V2OM
	 ciBslkpg6FZJJc9BG+KoHp5YM2zTLymxkUICH8vh4TKo6SkZPjdJHS/dd+YEypu59D
	 Nbr000CGatYJg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZFtqKTlCXK6u; Thu, 15 Jun 2023 11:05:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F3014154F;
	Thu, 15 Jun 2023 11:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F3014154F
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id CB3221BF276
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Jun 2023 11:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F2C783C6E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Jun 2023 11:05:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F2C783C6E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mm-o2uExdls7 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Jun 2023 11:05:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB61D83C74
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB61D83C74
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Jun 2023 11:05:45 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="387329814"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="387329814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 04:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="1042624082"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="1042624082"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2023 04:05:32 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 6287F33BE4;
 Thu, 15 Jun 2023 12:05:31 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 15 Jun 2023 07:03:07 -0400
Message-Id: <20230615110309.14698-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686827145; x=1718363145;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TbvtmmlzfMGEx3J7Y1xjQZk0k2tOmu5YA2biTGqy+88=;
 b=akut8I4SfeZnGsT6A7MRXErFDqyGlNp+itsf48ysRveC179gt7pBX/DB
 9Oa38SQJhM4cW7eaBAs4PlwaR6sKgCcRO/DFMJXzJmRJYStKNaEYN8ehq
 8KFDW2ODu2KH4KOe+LTNxQlktQ0+gljNycR9kRgRR2yTcl/UXyHNJBJBs
 4bwWOqzfIXDjI6of55F0yL6XZgExrWpxmhUdg5yDSawBSphe4Jb9l4+Xu
 2NSoeamCrXsXP4U0ZBFwm4clULoDHX97HXFk9aIyNTVK2zDmqR+KyuMj4
 j3s7sVHTJ/rZ/zkHMR5shULlLqj59lZOKfScrx2HFnJ3KHofIVzsrmpCN
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=akut8I4S
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/2] iavf: make some functions
 static
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Turn functions that are used in just one translation unit to be static.
Remove all unused functions (but keep exported ones for now).

This series depends on three patches that are in Tony's queue, see [1],
[2], [3] - dependencies are just about avoiding trivial git conflicts.

[1] https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20230502152908.701880-1-ahmed.zaki@intel.com/
("iavf: remove mask from iavf_irq_enable_queues()")

[2] https://lore.kernel.org/intel-wired-lan/20230509111148.4608-3-dinghui@sangfor.com.cn/
("iavf: Fix out-of-bounds when setting channels on remove")

[3] https://lore.kernel.org/intel-wired-lan/20230605145226.1222225-2-mateusz.palczewski@intel.com/
("iavf: Wait for reset in callbacks which trigger it")

For third of those patches, I'm suspicious of git-format-patch generating
"bad" prerequisite-patch-id, it's stable across the runs and rebases,
but it's different than the one reported by git-patch-id
(= ea8d85f15350eff7a2aa4fdb0e2653d856b42184).
I don't know if anybody cares about those anyway.

v2 - typo fixed, links to prereqs for second patch.

Przemek Kitszel (2):
  iavf: remove some unused functions and pointless wrappers
  iavf: make functions static where possible

 drivers/net/ethernet/intel/iavf/iavf.h        | 10 -----
 drivers/net/ethernet/intel/iavf/iavf_alloc.h  |  3 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c | 45 -------------------
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 34 ++++++--------
 drivers/net/ethernet/intel/iavf/iavf_osdep.h  |  9 ----
 .../net/ethernet/intel/iavf/iavf_prototype.h  |  5 ---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 43 +++++++++---------
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  4 --
 8 files changed, 35 insertions(+), 118 deletions(-)


base-commit: fa0e21fa44438a0e856d42224bfa24641d37b979
prerequisite-patch-id: 141de8c9f97d59aa7df2481120f1d666f90420cb
prerequisite-patch-id: 6eb49686279d9b2046d6fe5c78a882025c87f3ff
prerequisite-patch-id: 2b1499c46b646b5402867deee8d40b73d752599a
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
