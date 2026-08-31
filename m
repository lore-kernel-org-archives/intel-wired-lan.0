Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C4FC624A4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 14:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C9B460653;
	Mon, 31 Aug 2026 14:50:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BNQtESGulLd; Mon, 31 Aug 2026 14:50:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788187813;
	bh=Rfk0/t6d+NWJEQvatUF2qD+muKlZl6dKo0BxuV+sgjY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aizwc1MeKEr2pdzW75rXAcAJFDvD7p5yRxms6rpymHlaFEJkwMFVf5XViyjRpBMeU
	 ELbA7eNCoZSvLnEz8BgAMNZWbiogWQE0DbF8SRkwlXc4HDmGCDF+61wR/MJDusvvyQ
	 NTH963K1LYdq5xpN04smxUTHD6pxiJM9R/3AIVjXGSHfADY3DF2Cbn+axE0sz05l7P
	 GGpef9m2OLIvqg9565F8JfJEyvW3UdL8U5iCWglgoPm1I8yhMBpU2xhz/b+YZ7jODV
	 OvUt66B7DeeibBisdoBF4hnFJzPTUXiqFUDFrLM9LbmqefWt9vCcwE3VzSLVd0Mepg
	 qXhGgmb3Q+weQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43C2360608;
	Mon, 31 Aug 2026 14:50:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 998852FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86A974057E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaUgQwV4LV79 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 14:50:09 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=O6NEKKBp
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A9134054C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788187809; x=1819723809;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=H5foepN8aexM1UQq0RaDqG3HWzUyygLeU7cCbXw9+Tw=;
 b=O6NEKKBpBCzDIN2zQz3L/GR3w914vAekiNx1h8lhYdwsb5ulJGN+hbPw
 hj/o4SfrJrLY2fwJ1k78aKEErGxKmhiTTuKYuMqFvk0oJtGF54lOaR7zP
 03kui6G1lK55CQDsNTGajs6bpTbUFtlNFZj0ZL+z/2p4qqcIDtY/UopAm
 TK3J1IZimx5ZFhgfJPFnSDCxoSDvbEnURWbpjPq2bDBbwYPxZtXVp1pWz
 VmKrF+BYDXT9G3jqGVx1NfZ7CUsQC9pX+PiTlcii4YE24+uKTgIt6QlVH
 R8B3VJNYkSGJx+d7dZcqjUh1NMW1UK5FRRQUJ+N3MACY6OwIx4VI6RuhK w==;
X-CSE-ConnectionGUID: 9/m8Sru1RiKKW6XwnDTdKg==
X-CSE-MsgGUID: 69Lg0MXETxujzE3/4QNMDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144520"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="76144520"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 07:50:08 -0700
X-CSE-ConnectionGUID: 5xc3wQyvTuS/qXMQvShaUA==
X-CSE-MsgGUID: DUVEpbOoSrOSapURv7i1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="273003691"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:07 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 0/6] Rework dpll pin control
Date: Mon, 31 Aug 2026 14:49:59 +0000
Message-ID: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
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

https://mail-archive.com/intel-wired-lan@osuosl.org/msg19535.html

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks
v2->v3: Fully rework the rollback codepaths, rearrange changes
v3->v4: Fix transient state visibility during the state switch process
v4->v5: Minor formatting changes, additional NULL pointer check

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

