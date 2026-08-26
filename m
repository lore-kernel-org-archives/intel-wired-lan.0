Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16C8C61DC7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 09:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CFBB40568;
	Wed, 26 Aug 2026 09:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzC_Q9mF2YLy; Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787737735;
	bh=NlaPUy5ql8RZ8zeqJtfOYBSkDFuu5nLnF/ITYn15Cqo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fhb4DUCMbBedvI3QYZR+LfiYeHY+l231ZTTQTBuNer+9phJIo97X2LNhzMqjFP3l3
	 q7wSYRuTmFAgHSiepxGvaM3qlwKj3dyoNdgM8Uc0ebHFANkUTEiu2JwlEG1yHM8PXx
	 lo5MF3G2LCp9lq6VK2ZjdTQVOxX8lFF2IzTFzk//oWM213ZXatQLcpnyfDPhY3bdwB
	 z+Tqm7eYRYliRQ0XITQnM6sEQsIPyelvMlBmT/YtQuaPXTasnfoW6UtU89IkM4ObGS
	 uLU1tMEVCneD7YQ5ay1d0947VsDmPvUV6zzgXkAuRqyoxD4kfSCpfux9uyrzOxSYuZ
	 /IVX6ppoVnbQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FA2C40563;
	Wed, 26 Aug 2026 09:48:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEEB9230
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0EB840568
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6p27eIQuGNMa for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 09:48:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LNtKTj2m
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A944940532
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 09:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787737733; x=1819273733;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qY7WCG2lM8/FG+VYanFZuap8dJ1+0ITIBbtnyEuH5ds=;
 b=LNtKTj2mHZGpQgDzOdWPosVy6cuqX5YFth6V3BsOSK3zyZJFfDTQp9cd
 Zsp8Sgul1+PJxNbsez6EAaIPlEc1lJQ1wF7Trm37mAW+m0iZxtmOxY6oM
 wG0Ox7SDEb2NXH0eaqW1MSgtko5n5HS1s8uOBcSNKZqg8gducUHtRkiZe
 CHcwKU1tIZmHBQUw1XyCuDJBpzDk/DaimHv+hqVR8gjM0zyP3BtjhmhR0
 LWL9TOxhDPcNL9LrlJ1RYKRUC+Qpin6zbl4HaaGHKWq97p/xdK9+K2mNX
 U56y+RSRZqkDZR+LlWumOFh3KxLIJP/tTEXInATV8/Y6kn8ZiR0gGSmGT Q==;
X-CSE-ConnectionGUID: IttEZQppR0mwf61z7Mid7A==
X-CSE-MsgGUID: Kmo+njT3TPiYlqY1XTN2Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88232946"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="88232946"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2026 02:48:51 -0700
X-CSE-ConnectionGUID: AorEXLkCRNO8uJ6fipy6Dw==
X-CSE-MsgGUID: sEGI6fqDStGZvKc+fLx2Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; d="scan'208";a="261404792"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 26 Aug 2026 02:48:50 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 0/6] Rework dpll pin control
Date: Wed, 26 Aug 2026 09:48:43 +0000
Message-ID: <20260826094849.4112016-1-sergey.temerkhanov@intel.com>
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

This series reworks and clarifies DPLL control logic. Contains
refactoring changes for better readability as well as the changes making
the pin controls compliant to design requirements.
Bounds checking is added to avoid any potential out-of-bounds access

https://www.mail-archive.com/intel-wired-lan@osuosl.org/msg19449.html

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks
v2->v3: Fully rework the rollback codepaths, rearrange changes
v3->v4: Fix transient state visibility during the state switch process

Sergey Temerkhanov (6):
  ice: dpll: Add the MUX tables to the documentation
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Check for bounds when updating the pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 544 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 456 insertions(+), 89 deletions(-)

-- 
2.53.0

