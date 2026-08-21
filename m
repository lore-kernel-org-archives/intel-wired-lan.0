Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB03C5DF7D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 15:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C67C681345;
	Fri, 21 Aug 2026 15:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NCZRACv8NRbV; Fri, 21 Aug 2026 15:25:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787325900;
	bh=+Z9/izsrwhy4sTP8WrUQwHvm2J16UbAIekPLbHyOcl8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xlM3d2wtUcQ0Z4JVbgZI+6FxrqgU37JJ8rxLKfWwNwt2f6ctgWyR+LAMXY+o4Gdbf
	 WTB3ThD7t6b75v7Q7KGSheeP0FCUUS3gz3Qzcg0Ikc1yQWQGzwdxh6cgkevvQO6zjP
	 ON9xj9TJAiCQ4uidRf2dB3m+7KeDG4Jpj7sx6FClU2qvXXHXas1Ybec9wOa1prYK+H
	 abu9kl7BNtXAIAPfqoYJwMU53aBudPbSeAncX3vTei6+yiJy2liK+jxlnqnpm/dTP0
	 q7n4q0tMVchkmsVPyvaHozBDpwPfKmZASiqJZ2ETbsem0ZRMLRzQMu67S5JzpEfeQP
	 x6mZWADNxYiJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0D81C8132E;
	Fri, 21 Aug 2026 15:25:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01E32EA3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DC38E8132E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:24:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5GPCJsPp_hoT for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 15:24:58 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IzlLAouw
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0043781325
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787325898; x=1818861898;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3nqvV05BEYnRsWzI27qZWjAJmHetEw8qaEIxCxBHfHg=;
 b=IzlLAouw6oj7ggEcA6dGmDDtA/frdem/C/z94sAC7QfCRLU5MjyckhPS
 zfvVGLyAomKVM/oZLxxHb3M2I7mym1Ze6GS/rdwziWoHwPLql5FXBlueA
 N+iy2lhFa4Xl8iM9cGFD+dWoC0XGv16KXu2vg+Db3Qkr4mGkSqQBixYdi
 PsTxRU6ji/bn519dxHifT1bLjxX+7Yp61jPh0M1SLgHPnOPfmaQaYxKUo
 uYnyDMYGJQixk0/TpTldX55GBdJytrLtKTOLZsRDKx1KiY7M/Tk71JF0n
 xzEkiUTnWM527Kt8kMOb3NDT0Em8KoOFxTZVuZa1bGgau+4c2VsRio3u6 g==;
X-CSE-ConnectionGUID: 8Ab/RIDuQAO74lw3TnKyfg==
X-CSE-MsgGUID: 2wJ6qtqqSqu4cKf69f3guA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91553197"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="91553197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 08:24:55 -0700
X-CSE-ConnectionGUID: WLPZN9GQRTymEGeVyaK6bA==
X-CSE-MsgGUID: IQ/fr3ycRSi/EAz28aHApA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="270602186"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 21 Aug 2026 08:24:54 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v3 0/6] Rework dpll pin control
Date: Fri, 21 Aug 2026 15:24:48 +0000
Message-ID: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
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

Previous version: https://www.mail-archive.com/intel-wired-lan@osuosl.org/msg19128.html

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks
v2->v3: Fully rework the rollback codepaths, rearrange changes

Sergey Temerkhanov (6):
  ice: dpll: Add the MUX tables to the documentation
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Check for bounds when updating the pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 574 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 478 insertions(+), 97 deletions(-)

-- 
2.53.0

