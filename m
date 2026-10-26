Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A2606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vjQ0kgXD;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X6EsWurm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66CE6605EC;
	Mon, 26 Oct 2026 22:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L0b-nwEnFtFX; Mon, 26 Oct 2026 22:37:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F607605F9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793054238;
	b=Q/8ZjTlkk9he4aPMGHelz9aVgNiMgIyGizoTVYeubwH9SirMStGvBf8Au1xdkMViACJn
	 c+Rb7YcYd4rLl38XlgO1T6GjgJNNsf6o9zdUPer1/wVHpZwrpZoKtjntYO3j8Cr2gwVcJ
	 ziqbfs/A2OPWCELSeM8r6yrK/I996G3Rw+bmRNExo9j6HmHNeGGtDymmPss1AD5BjGvX1
	 V43NYnRqkAZU8jFgNBoQPjtJX1I+W2e8aeJHXodyXObTsqTyTovgDYFnezLmLHFojXoxG
	 XeQRmzXbWOR57JkO9TdZ37WvzIlNgC/22+wVo4DUGhT/nKaeFjZwZ4JfB3JFeBdC0RQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793054238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0vSsgXusteS8Ih3crsVkp2LIVfNT8xAa2841f7iOlFk=;
	b=h9Kjxtw+Gk67M+xhDJLKGLgWAJUkd4JZF0gccACIEwbJu4CTM8JGWXGHT3sEh2WDdWof
	 +77xcYZVIlmnZf96UUIxWpoVJfD0T5LiVOgbK+cdux4T96m9PBWWZNEL1CT2Rb2qyfUe5
	 AfgTSumZ20fpPqhI3AH4dx2mkZh707lxVHeS5WtvWZEUOG1G9OUzsld1YoHygSHLrNUPt
	 604Av9JpZw7btYYJRcOOCHR60iFWg9MzwmMQlXQwzGcqiMypyZKzda4GLi+sS/mGsWAlp
	 VZGBLE9oJm3tq1F/Pgf3tiCkICf0Zb297iUqkzWx6Eh6SrBiU78eic/Jr+9OH9luRrA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793054238;
	bh=0vSsgXusteS8Ih3crsVkp2LIVfNT8xAa2841f7iOlFk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vjQ0kgXDy8KZ+6lh8X2TrH3TCFULrUMZDtc9hUJdo+m6VcMiijNl+acjjmu9UUkCn
	 oUrI4JM+wkUrFjaQ2LZHgZZdhGFhPI5RuyLtI5msbq3wpZkbW1xMNut/t+iZX4V/gR
	 9F86c8xvQhyC4kz5CpdlT9gSUxtFx+jaFGU0kDjMoOFyxc7jk1w2DJUqFwRS2bZLjP
	 tTDaW3TIEPFdAyOgsP4rI+kXB6YD7ZSLjjC8D7oQe9dUbXlHnVgkE3z/HQI86D1/9B
	 ThBy1ZZHnqGfzjEBrxYukHd9iVO2MTYGkgENDTbFIQr8sfZZjZXRFDFXg2pmQPXf/v
	 FLTFHc8cuJHUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F607605F9;
	Mon, 26 Oct 2026 22:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 440D03422
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A58140541
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B9ncKsFCKX7m for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 22:37:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE70F40523
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793054235;
 b=jLXP1jmoEyWZlCz79dQJX7z3d9jsVkC5sjto4tLsPo0XLJmabYAqiA/ebRDjKUoeBN0c
 NvhwL4Si9+ikCcWfXmYqrCxDK+Oq/jzaicH9r6Wgafbfe74l6Mj6in3a44dOq7T5R22QM
 /1YOacZsQTEitOBSD9di0gmCONTe3hB0ui6KiRHUMS5cAiSgTqSJgmP/bNlzVNHD5aysh
 jkQeKqaOTPDP/WDArHlAdBoZzMozgqv5ipwqxC+CpZmZ6VT+rLXNZe+n0L1zGt0GMh8DF
 S9yRyBDde/0AQRHrpRF/nQ0sIiZis/RwRxh0cYCOnWoKYBLRxN5fjFyrWIQwZDkYybg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793054235;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=0vSsgXusteS8Ih3crsVkp2LIVfNT8xAa2841f7iOlFk=;
 b=Yh4QLakw8jrcenaaxXqThvXEvHPaeI7juSWAF1sna/If7UO5WmalzAtXj+mDyzOcf+KS
 aj5mVZtluS+j+XRsGyqwxcb9+/wH7NXQS/rcuyAwGw52+ZZHnRInqe9yHaR3XmC66jrXI
 KoOs7ZJ3MzCW1KduhrD1S4QxM1XIZHn3vQ2N1Zti/wj8zyqCygI19nS/JuOEtv+eSoHU+
 SJmKZXzSap6Z255GlqtzVz01aAAWbGvSkR88B0IGJnBfH/l/ZB9Xk8Wabf8nr6CXOfN3p
 YOPTehMlp/ov1DN/Kfo5WKXILoUyRH16DXs5UEDNtSFECI7MRfboUk+L+ALsIgS7S8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=X6EsWurm; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=X6EsWurm
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE70F40523
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793054235; x=1824590235;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rntoT5/u1BU18awjwnpkyCaOfB+wqHir44TV6/SEGdQ=;
 b=X6EsWurmz2qCjQnv+92gUi3ccrcbWoC9mDPH+g5nmlC7H0VHX4Nkb3yj
 Ioc2eerMR55LYoLJBMcfARAKupV9yMQGcyuxSclUbrWRCt367wb9ckNfL
 3ZlUQDN5MtxFm2rwn/ZLYNPk+wNrSBbotHejssGuStmHSbnhiKWyhlNJ+
 6U2ktNZ32sZhGOqLCCY+OINCUyErmK1N6xRxip02lxWB7MHIqw3xBSOVq
 i8XzbClpbiz4AzLdnq2qC1n7N4vGGFUtJcNDq+bK/5oOfiYWjlAExmFbw
 lqNMXssnEeobReO9vdsT3oSe1ruN3iyX9K8FOUm8aSXJIdY5aHFESw7GJ Q==;
X-CSE-ConnectionGUID: Ps+xMYVQTymJBmjkfyVJug==
X-CSE-MsgGUID: r5T8/w7pSTmIGcGNVVoZHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1616394"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1616394"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 15:37:13 -0700
X-CSE-ConnectionGUID: A23ahk+UQDebVFxs4DzRVQ==
X-CSE-MsgGUID: JrWFj8D3RsmgPXZ/I6gX1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6217167"
Received: from coyote-pass-p6-34563.jf.intel.com ([10.166.80.105])
 by fmviesa013.fm.intel.com with ESMTP; 26 Oct 2026 15:37:14 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: phani.r.burra@intel.com, larysa.zaremba@intel.com, joshua.a.hay@intel.com,
 horms@kernel.org
Subject: [PATCH iwl-net v2 0/4] idpf: fix teardown races around reset and
 remove
Date: Mon, 26 Oct 2026 15:19:04 -0700
Message-Id: <20261026221908.24690-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.37.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes for races between reset, remove and close in idpf, and a libie
transaction manager issue they depend on.

Patch 1 lets a reset racing with remove tear NAPI down in
idpf_detach_and_close() by dropping the IDPF_REMOVE_IN_PROG early return
from idpf_stop(), and tests IDPF_VPORT_UP under RTNL. Seen in testing,
trace in the commit message.

Patch 2 skips empty netdev slots in idpf_detach_and_close(). Reproduced
on a reset with FW reporting more max vports than default vports.

Patch 3 makes libie_ctlq_xn_shutdown() release all concurrent waiters.
Not reachable in idpf today, patch 4 adds a concurrent caller.

Patch 4 keeps the mailbox up for driver initiated resets, so the vports
are disabled before their memory is freed, with the transactions bounded
as on shutdown [1].

Testing: Patches 1 and 2 reproduced as described, patch 3 has no
reproducer, patch 4 was tested with a script stressing resets in the
middle of ethtool and ifup/down callbacks.

Changes in v2:
- Patch 1: test IDPF_VPORT_UP under RTNL and assert it is held. Dropped
  the Reviewed-by tags due to the change.
- Patches 2-4: new, found while addressing the review of v1.

v1: https://lore.kernel.org/all/20260811171751.22165-1-emil.s.tantilov@intel.com/
[1] https://lore.kernel.org/netdev/20261013121224.84482-1-luckilystar08@gmail.com/

Emil Tantilov (4):
  idpf: fix possible race on remove during a reset
  idpf: skip empty netdev slots when detaching for a reset
  libie: release all waiters once the transaction manager drains
  idpf: keep the mailbox alive for driver initiated resets

 drivers/net/ethernet/intel/idpf/idpf.h        |  5 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 58 +++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  4 ++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 15 +++--
 drivers/net/ethernet/intel/libie/controlq.c   | 19 +++---
 5 files changed, 62 insertions(+), 39 deletions(-)

-- 
2.37.3

