Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6298DCE8343
	for <intel-wired-lan@archiver.kernel.org>; Mon, 30 Sep 2024 13:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0C3EC40118;
	Mon, 30 Sep 2024 13:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iV3BiPt0oeX0; Mon, 30 Sep 2024 13:39:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF28D404D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1727703546;
	bh=PdrfS5OJorGs3HStHoI5R7hp4Y+fI4O94e/ErxT7iks=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=6/mgW/Vo3Zz3phZuGtvClxYMRBD6M/5zU3ZAUuko/ptVHatB63NNIEN94BMG75nSP
	 rmq1PFAx+diVeGrpX6wlEKb9adgtuq7ozCKIkvm8gQA2sxkR2OQ26IfeGarQZ14JZ2
	 SZPa2LZYCQh6QA6YqH1GosgIq+n8jnx3HY5024cSnFpglQq4jsfa0qer1oAFbMDVaG
	 YrukLoI4QYo54hhq3eC57FcAPPjR2uGlZYNJ1alatmXULce+ktcQ2uv9yhu3depHdR
	 gxKZfdxQNWOu6HjLE1nF/x5lfbLzd+k493abvDjtDtlWR8HMGDl6hWHcgDfPih+hKr
	 UDk6Uw9GCsCzg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF28D404D1;
	Mon, 30 Sep 2024 13:39:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 1D18B1BF300
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Sep 2024 13:39:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 163D4404D3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Sep 2024 13:39:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BzVbj-OTltT4 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 30 Sep 2024 13:39:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C10C0404D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C10C0404D1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C10C0404D1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 30 Sep 2024 13:39:03 +0000 (UTC)
X-CSE-ConnectionGUID: YNosDMDvQOWrVIx6tV95Cg==
X-CSE-MsgGUID: wjuJ4qg5RfGAr94+j/5yUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44312396"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="44312396"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 06:39:03 -0700
X-CSE-ConnectionGUID: 18py0tMcTP6VRr0dm1/nUA==
X-CSE-MsgGUID: xIfpSmwzRrqWXwIQ8gEyAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="77831808"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa004.fm.intel.com with ESMTP; 30 Sep 2024 06:38:59 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 5E5D328169;
 Mon, 30 Sep 2024 14:38:58 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 30 Sep 2024 15:37:17 +0200
Message-Id: <20240930133724.610512-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727703544; x=1759239544;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=amz7lzdIctZaiT18tOT05jELSOgRlg/OpvFf3N9t3uM=;
 b=d7pXPmKWmEhvKEf31VQiL99MWpgPKas8fMa0kKjey3zbVcjKrGSSOTa6
 D1AOJxyEQ/6DD4LmN8qN974ufGm7E6xmgW+PZw3LuImOI/p7ItuapmMoX
 Ia9qWP4+Xfr/lX4dO3H7l+UOJ8Z6wXzAeHblX3daT00nzAjF64l+tCPXO
 FLTrK4TR6Qqgle5fV865MdShA51iD1STrYJ4qLGslZk9r5Qo4CVez+oB7
 hzEfYSmsv+xI++eTUNySfQAPJDSQMOMFYkXR9F6Ta+/Ae1GuC4rqdE5UD
 PnZkl6atgSGyYFiLyzp2//lLorrqT/mues02t/DtwyvobnoCrAVPMn6z3
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d7pXPmKW
Subject: [Intel-wired-lan] [PATCH 0/7] ice: add support for devlink health
 events
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
Cc: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joe Perches <joe@perches.com>, Jakub Kicinski <kuba@kernel.org>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>, Andy Whitcroft <apw@canonical.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Reports for two kinds of events are implemented, Malicious Driver
Detection (MDD) and Tx hang.

Patches 1, 2, 3: core improvements (checkpatch.pl, devlink extension)
Patch 4: rename current ice devlink/ files
Patches 5, 6, 7: ice devlink health infra + reporters

Mateusz did good job caring for this series, and hardening the code.
---
v4:
    - rebase, added patch 4 that renames curent devlink_port files

v3: - extracted devlink_fmsg_dump_skb(), and thus removed ugly copy-pasta
      present in v2 (Jakub);
    - tx hang reported is now called from service_task, to resolve calling
      it from atomic (watchog) context - patch 4
https://lore.kernel.org/netdev/20240821133714.61417-5-przemyslaw.kitszel@intel.com

v2: patch 3 (patch 4 in v3)
    - added additional cast to long in ice_tx_hang_reporter_dump()
    - removed size_mul() in devlink_fmsg_binary_pair_put() call
https://lore.kernel.org/netdev/20240712093251.18683-1-mateusz.polchlopek@intel.com

v1:
https://lore.kernel.org/netdev/20240703125922.5625-1-mateusz.polchlopek@intel.com
---

Ben Shelton (1):
  ice: Add MDD logging via devlink health

Mateusz Polchlopek (1):
  devlink: add devlink_fmsg_dump_skb() function

Przemek Kitszel (5):
  checkpatch: don't complain on _Generic() use
  devlink: add devlink_fmsg_put() macro
  ice: rename devlink_port.[ch] to port.[ch]
  ice: add Tx hang devlink health reporter
  ice: dump ethtool stats and skb by Tx hang devlink health reporter

 drivers/net/ethernet/intel/ice/Makefile       |   3 +-
 scripts/checkpatch.pl                         |   2 +
 .../net/ethernet/intel/ice/devlink/health.h   |  59 ++++
 .../ice/devlink/{devlink_port.h => port.h}    |   0
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   2 +
 .../ethernet/intel/ice/ice_ethtool_common.h   |  19 ++
 include/net/devlink.h                         |  13 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |   2 +-
 .../net/ethernet/intel/ice/devlink/health.c   | 302 ++++++++++++++++++
 .../ice/devlink/{devlink_port.c => port.c}    |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  26 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   2 +-
 net/devlink/health.c                          |  67 ++++
 17 files changed, 498 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.h
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.h => port.h} (100%)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.c
 rename drivers/net/ethernet/intel/ice/devlink/{devlink_port.c => port.c} (99%)

-- 
2.39.3

