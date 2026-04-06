Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B91EFB5173
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Apr 2026 23:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 36B98407D8;
	Mon,  6 Apr 2026 23:21:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPRsT4d79t9W; Mon,  6 Apr 2026 23:21:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3001407CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775517707;
	bh=7YmkspzO6vU1XuqeESiK3Na4YZb0e1kBsdZFFlLOS5U=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e4CTEfzsmkr0crw9asO4OR253BRSdE9zvlZD89KAzOwa76yBPmqBFu/ce8Tb1olBK
	 25YxNeoVCHC5Ylm/krvtr80w08nnZrsLyQqBE0sOK6hPgak1dkqWBBLiSrh9GnaDO3
	 37dirdUZndCn2OqAOmEFDw7ZzGvnCxa07JvvQvHIUgpWB2KI1VqKbvbEDx7ZuSIS0G
	 W57N/VZ0etNZyIC0QUpLh7WAIZFt/qb2swDzRtTM7zu4CZt9lWYt3fZRv8wiN581SL
	 d2bKgQFUxOUfWvdZnJ6hDvZiyfxXV3HUPJ0NSu8+A7SLadvcyjUqUZ9pmCrL/qQSVQ
	 6UoDllcn7ZcBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3001407CE;
	Mon,  6 Apr 2026 23:21:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FF562EF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 23:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41A5280D44
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 23:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KU_0eKbpJSz4 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Apr 2026 23:21:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=joshua.a.hay@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 854A880CAF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 854A880CAF
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 854A880CAF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Apr 2026 23:21:45 +0000 (UTC)
X-CSE-ConnectionGUID: thV8JcVRS3CwBfaBVODRgA==
X-CSE-MsgGUID: +RzyXwv3R5SXcsHMkocefg==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76368982"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="76368982"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 16:21:45 -0700
X-CSE-ConnectionGUID: HGI4C95KR1Kb0yjomD8imA==
X-CSE-MsgGUID: 70QloSe0SbiPEaPQaNavfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="232050498"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
 by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 16:21:45 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Mon,  6 Apr 2026 16:32:34 -0700
Message-Id: <20260406233236.3585504-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775517706; x=1807053706;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7xmwcJYJm6E1fVmwZFpjH2ZcK/4kqQYQeVx6z126pwk=;
 b=EU1i+onZLDYHOG+VoLXwcrfTbTzl2W6GhrRZIM4bBA1cmno9DHLcFHlF
 cdDTYwDBm873pZVw4ZcsasOwUEH0YAycxdX6nFalDdbSZ2iRIwy+DYR2h
 5aLnwJbjSdbFlMRG8JKYaQLFJxRKcrlZ/C2gZ5QVgPwjI4yJr5NUlvlrB
 +PyxVV2o7sUfZSauzqHgoqHWMjk0tq7fEkQSHatlYlNhZ4SOmDM9x7fIW
 mKhtipkhHwiiBfXGiyKmhT7U+0gfiRmIahHAGWxTKilifpgW0eOIO/Kcl
 UuCbLVO44J+QXE640ZhHnxPJ9VEtgyOpt25unKgDx2kHvdJcFmOJ8fXaS
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EU1i+onZ
Subject: [Intel-wired-lan] [PATCH iwl-net 0/2] idpf: queue based scheduling
 fixes
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This series fixes some TxQ scheduling mode issues exposed by recent FW
changes. 

Patch 1 prevents XDP from being enabled if queue based scheduling is not
supported by the firmware.

Patch 2 fixes a NULL ptr dereference in the Tx path when queue based
scheduling is enabled, and also adds support to process both 4 and 8
byte completion descriptors to avoid timeouts in queue based scheduling
mode.

Joshua Hay (2):
  idpf: do not enable XDP if queue based scheduling is not supported
  idpf: fix skb datapath queue based scheduling crashes and timeouts

 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 49 +++++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++-
 drivers/net/ethernet/intel/idpf/xdp.c       |  7 +++
 3 files changed, 43 insertions(+), 19 deletions(-)

-- 
2.39.2

