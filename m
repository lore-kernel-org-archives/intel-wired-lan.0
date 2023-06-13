Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1125C88CB4
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Jun 2023 12:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3881E4063D;
	Tue, 13 Jun 2023 12:24:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3881E4063D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686659073;
	bh=ma7aP8FyWg0zhRtXD5VZkSadB3htxwwRLqMrpJq3Mis=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=CP0oWZfSFftuGZt19sKDxg5b7Q3FhVVXMHr3phDDMgwnNn96WuzxS1x8fz8yjgGez
	 jI0D5oVaz3Lwe4+Tt85/1K2rRw9ux3HMIbe7k+Ut7AOTsgETlGR3Ihx3ObQREiR/nx
	 Une4Nbg/xKGC1oFDypykmthHMwhxfOlaw0ElTmYhjkRxzUQENcfBkg2S8eXdywpx+x
	 TkE/S39926IftcrtDmS7SbAsweJy+8YnASQ+cY/eVgJpGOTeDKBHV25JOjt7Xm+Zpd
	 tV6k+NokNoZxFUrDE9muFNXJkswpau+vTppFsUtJPWpGuw0kOPMM2MxeUaAn2NRzOn
	 zPPwNRW/lkafg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dX_2hbZjx8vG; Tue, 13 Jun 2023 12:24:32 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47DBC40BC8;
	Tue, 13 Jun 2023 12:24:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47DBC40BC8
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 11D721BF352
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Jun 2023 12:24:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDB8B81D21
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Jun 2023 12:24:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDB8B81D21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dFaLtr2EgFdf for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Jun 2023 12:24:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 233C081C81
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 233C081C81
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Jun 2023 12:24:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="337951204"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="337951204"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 05:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835871993"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; d="scan'208";a="835871993"
Received: from pgardocx-mobl1.igk.intel.com ([10.237.95.41])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2023 05:24:26 -0700
From: Piotr Gardocki <piotrx.gardocki@intel.com>
To: netdev@vger.kernel.org
Date: Tue, 13 Jun 2023 14:24:17 +0200
Message-Id: <20230613122420.855486-1-piotrx.gardocki@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686659070; x=1718195070;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uRT9JLXdBgnt/JTOF41e88faFHrO2GR6FggvMkMJk2A=;
 b=ejwvIyM9UDm8B9OMJU0QD+r4/cXAIFIHa8sOPoasDf80pGAg++6vk4yN
 B/8mB1WUs3kiKc6LoSAsv2zBQmiFtRWeZVrBeVj9GON4PoFg52pL1TOIJ
 t7AHcwBCAbgAF0UH3U85Nk24PpLFq6mItJFVro+b8681a10Wk4eJCJ29Y
 fGQkOfjPKAgU5wLikbaGlzpGHYzMczl9Sd7CFz8/61SwRqnoxOSMliwSj
 1iVYpeEbhUfj7L9rw5/7btq2t3Gw/MztrDmUwpsiJk46h7JpNGA1ySUIc
 ZsEYurrlh1HpK6y0UNvM/4RqNmamL7Cqt7HCZAaqqBMXhzixpzkaS0IEd
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ejwvIyM9
Subject: [Intel-wired-lan] [PATCH net-next v2 0/3] optimize procedure of
 changing MAC address on interface
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
Cc: pmenzel@molgen.mpg.de, przemyslaw.kitszel@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 simon.horman@corigine.com, kuba@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The first patch adds an if statement in core to skip early when
the MAC address is not being changes.
The remaining patches remove such checks from Intel drivers
as they're redundant at this point.

v2: modified check in core to support addresses of any length,
removed redundant checks in i40e and ice

Piotr Gardocki (3):
  net: add check for current MAC address in dev_set_mac_address
  i40e: remove unnecessary check for old MAC == new MAC
  ice: remove unnecessary check for old MAC == new MAC

 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ------
 drivers/net/ethernet/intel/ice/ice_main.c   | 5 -----
 net/core/dev.c                              | 2 ++
 3 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
