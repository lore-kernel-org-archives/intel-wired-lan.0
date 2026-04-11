Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD575F45A17
	for <intel-wired-lan@archiver.kernel.org>; Sat, 11 Apr 2026 00:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9930E401D4;
	Sat, 11 Apr 2026 00:39:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id byc-HdcL2WuN; Sat, 11 Apr 2026 00:39:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EB9B41A2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775867994;
	bh=tnQSNDWHLKFGXe+4MxHiSd2awBm9FGP+QGj/rS67IME=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Z/f8xNrtt1CVG8iBzmZKwnRTMogSYC4AbRZzWpkuIA8FYx4QPP5UtzfjRl3MktZwl
	 nf4T9laiNOLx9NeA/k+6i5froGPUPaHhZgosvj0Ybm3Y6bGLquxDa/NPLHQDHYHJtU
	 U+a7aHLv9BOWD52IXAGWZGFf/demXAPjlcxWtyfOdWFkNMukcffIHNyRfrksEBjUvq
	 +Gcdzp0vJixWhp90LlbTGtcPArSNxq+9lL+SNp2gnhRdQyHM/EbzebZPRoUweKkiLL
	 RWFp7/6fXYC+HV2SfIifqsAvfuYJXLcwJ5eEDasj7JdrreB99gz7X5gylwJYR02lH5
	 iicD6UpyV1ZZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EB9B41A2F;
	Sat, 11 Apr 2026 00:39:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DA71237
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Apr 2026 00:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F348941A2F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Apr 2026 00:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3GAUlKeRhbb for <intel-wired-lan@lists.osuosl.org>;
 Sat, 11 Apr 2026 00:39:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=emil.s.tantilov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 40922414BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40922414BE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40922414BE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 11 Apr 2026 00:39:51 +0000 (UTC)
X-CSE-ConnectionGUID: lR0eOjW3SyypoQ8veejWKg==
X-CSE-MsgGUID: GM8rakwSQyiSOdF+9Rwgkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="64423720"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="64423720"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 17:39:51 -0700
X-CSE-ConnectionGUID: x13t4GsSRpywFZyyfr8xKg==
X-CSE-MsgGUID: hbH5JdM/S0qunHamrYpX+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="228392487"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
 by orviesa010.jf.intel.com with ESMTP; 10 Apr 2026 17:39:50 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jay.bhat@intel.com,
 ivan.d.barrera@intel.com, aleksandr.loktionov@intel.com,
 larysa.zaremba@intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 linux-pci@vger.kernel.org, madhu.chittim@intel.com, decot@google.com,
 willemb@google.com, sheenamo@google.com
Date: Fri, 10 Apr 2026 17:39:57 -0700
Message-Id: <20260411003959.30959-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775867992; x=1807403992;
 h=from:to:cc:subject:date:message-id;
 bh=bf9rDhhDLQYlfFaN1vUUcDJylrZVM5QUZxazTmomJjk=;
 b=mIslDTFZnvHLolgC20nyIV31M0iccNKI+8sIM8lLPbjRHFjf7wq8ywKM
 8PHFYxvugfvdZm8kFEUFQu6yrdDi3edygDzueIG1FKpt5TMdvf/5/vb8B
 oCWbtGGHCBye2RLOD7tHxbASyauvVxdk5Moj1Qte8MuSxuAzRY+AzqoIF
 ohyMpM+6lTIeaAFJQq4uiEv1Upq17YJ47UMrXtCVAN80aqk4GNKMEGBci
 Cqg/qhFc0BsfMyJZP8298yFM/9h4wIUKXJOecVQAxz+41+MniCt8JLghc
 yXimgMEKEAsSyOWGp4swdrwhOkNMeaGjNVOxNCVgT78nVGLrJ16Lvdaws
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mIslDTFZ
Subject: [Intel-wired-lan] [PATCH iwl-next 0/2] Introduce IDPF PCI callbacks
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

This series implements PCI callbacks for the purpose of handling FLR and
PCI errors in the IDPF driver.

The first patch removes the conditional deinitialization of the mailbox in
the idpf_vc_core_deinit() function. Aside from being redundant, due to the
shutdown of the mailbox after a reset is detected, the check was also
preventing the driver from sending messages to stop and disable the vports
and queues on FW side, which is needed for the prepare phase of the FLR
handling.

The second patch implements the PCI callbacks. The logic here follows
the reset handling done in idpf_init_hard_reset(), but is split in
prepare and resume phases, where idpf_reset_prepare() stops all driver
operations and the resume callback attempt to recover following the
reset or the PCI error event.

Testing hints:
1. FLR via sysfs:
echo 1 > /sys/class/net/<ifname>/device/reset

Previously this would have been handled by idpf_init_hard_reset() as the
driver detects the reset. Now it will be done by the PCI err callbacks,
so this is the easiest way to test the reset_prepare/resume path.

2. PCI errors can be tested with aer-inject:
./aer-inject -s 83:00.0 examples/<error_type>

3. Stress testing can be done by combining various callbacks with the
reset from step 1:
echo 1 > /sys/class/net/<if>/device/reset& ethtool -L <if> combined 8
ethtool -L <if> combined 16& echo 1 > /sys/class/net/<if>/device/reset

Emil Tantilov (2):
  idpf: remove conditonal MBX deinit from idpf_vc_core_deinit()
  idpf: implement pci error handlers

 drivers/net/ethernet/intel/idpf/idpf.h        |   3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  11 +-
 4 files changed, 129 insertions(+), 12 deletions(-)

-- 
2.37.3

