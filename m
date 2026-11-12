Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD49606A883
	for <intel-wired-lan@archiver.kernel.org>; Thu, 12 Nov 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VWxpWdq5;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bBeW5WC7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC78E607A2;
	Thu, 12 Nov 2026 12:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdWY5lx8wand; Thu, 12 Nov 2026 12:46:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3358660779
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794487569;
	b=Ul1Io9xJBBzESKCGAgTAHQnmqmPY6KyNR6tNnHdg5P2gy2ABF86JQqIpCqKiZIj2DfjC
	 8uT+GP2bmMKr1YIDjtTWigcVxznZbLX7RSrXTYA3yP+5S0axYLvAX0B2Ey8V03fXENtey
	 xSeqjBmB/HVN+v63h9vS5iHSFXOSBXFzTJQKuQbH36DMXTON/reei08jtFqWg4xKukybq
	 mOQ82NQHbnbQBsU/DaVDzvOTSpU/mK2ll7K2ZSeWI7Xfn2haumYyMJwvYPxOPygbawyfw
	 +vZg08WP2jn6KEMpfGzr0S+R50ZlOIRd8Q+wHN6EgZyU9Ntb3cdR100+X69FldjpfXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794487569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=fEJEIM+FO2VGrcEXjdsdYGV3pvMmLMs7um/ChWLkaKs=;
	b=KD+4QIHHZmEJx50OmNLZ2SS+9eDoZiCHN6IzVMeQiMNxG70FBfaKgWgDCtHBzKc53GYf
	 wro7JsUdUITj+bHVImBM71iU9mYlYMj2EQukoknBJy6d5HfZEwhF0wE7EB1q3CJ7piIW/
	 L5LJEzxyNugGF3ZF/hR11Md2scOFTyQB3t+E2XGHylTbqacWLsO8Yme5BeP0UgJeDylSE
	 2EbfvJRbwKe113ZZlbOQWbAspob608sDIyefhIvU3uQ588L91xrvkfeldKfiDyg/DGI6d
	 4jrZhx4I+4LT15ggFbHoODX+SW9AYG3OQZfmTXv/H95xEsVHII5PCaNyG1v68hqwqlw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794487569;
	bh=fEJEIM+FO2VGrcEXjdsdYGV3pvMmLMs7um/ChWLkaKs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VWxpWdq5WRNuKjeOy96CiQpSZz57SSm7Ztkd0zayrVgyPZqT1J4L8s7ijSiJeyxac
	 GAcok3rIEbMJqZqRryOzYa3kvVpdoJZaja/POOafZAtL9XrvMfmK6ShFoSul36BDV3
	 5khM9ZvZXhuiF/ep5TBoT2C1VTnrj4Z0VPFZ/hvLrCEn5uR+Abm5Xm9Hsh++sSQJNN
	 6ELThB2AeQJL+ldOl1yLS36ekS2ypDURMZFmFZDjMf7r5SW2UaGmlHpJQKNILrUGo5
	 QABU9FviBBAQ4UQ71ZWebNlhhBv+AAZ2uL2ftDW5R/ug2wqV9GRM4sc36oz7iWLwym
	 kjIaBcqTChC6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3358660779;
	Thu, 12 Nov 2026 12:46:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 650FE335
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 56DCE40185
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXKcWmTeKRBl for <intel-wired-lan@lists.osuosl.org>;
 Thu, 12 Nov 2026 12:46:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 85AC94016D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bBeW5WC7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85AC94016D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 12 Nov 2026 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794487567; x=1826023567;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4Ot3K3Fbs83n5uYbRA3EePHNO+FpQmc2gPeYzIf5OaY=;
 b=bBeW5WC7uMVLhboSpgj5xEvgDMrcpaqGzNoTosoBcH29Ny3Ugf9uSMpp
 PCQRkyr4max4f7NmJCV0HICnF9unlXxc1D6whfmZ5tick143+/VfoEbg6
 C4UABWw7X1zOMsjVgAO/GXZ99MHdMdnr8TdbtEZ28TsfqS6TRk8UUr3xd
 2cox3504h+ddhCMC8DK/pzzBxCkzC8fV+LfKhw9wKq3hx9WFcov7GoaVw
 2hmxb3lGaA5+LzwZfCzMryEL81SHmffDhJ4sx2xpHsM993p4pF94luppX
 0KaSF6XIjBhO7dBU62P/cRDzdbGmzz6gox2XvmjvfczvxZskO1/k9bgGj Q==;
X-CSE-ConnectionGUID: ZaoRvG81QfqQEX4vIWQ9kQ==
X-CSE-MsgGUID: vsgrbnF6Q2uErJ2vvPswuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3172812"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3172812"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 04:46:06 -0800
X-CSE-ConnectionGUID: 5SLw/NjuScOjVZN4n86yKw==
X-CSE-MsgGUID: Z0As+ZYqSfuTAexKeyonWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8833255"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
 by orviesa009.jf.intel.com with ESMTP; 12 Nov 2026 04:46:03 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com, sreedevi.joshi@intel.com,
 namangulati@google.com
Subject: [PATCH iwl-next v3 0/2] idpf: add direct access for PHC control
Date: Thu, 12 Nov 2026 13:34:50 +0100
Message-ID: <20261112123503.234508-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.47.3
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

IDPF allows to access the clock through virtchnl messages, or directly,
through PCI BAR registers. Registers offsets are negotiated with the
Control Plane during driver initialization process.

This series adds support for the direct mode, in which the main timer is
disciplined and the Tx timestamps are read straight from the BAR
registers, instead of sending a virtchnl message to the Control Plane.

Patch 1 adds the direct access to discipline the main timer.

Patch 2 adds the direct readout of the Tx timestamps. The latches are
collected by a timer that runs for as long as the Tx timestamping is
enabled, so no register access is added to the Tx and the Tx completion
paths. Latches whose timestamp does not show up within 500 ms are
reclaimed and counted as lost in the HW timestamping statistics.

v3:
* Cancel the Tx timestamp timer before starting it again, so that it is
  never re-armed while its callback is running (patch 2).
* Keep the readiness bit set when the latch holds no valid timestamp yet,
  so that the latch is read again on the next tick (patch 2).

v2:
* Use explicit spin_lock()/spin_unlock() instead of guard() (patches 1, 2).
* Do not drop the mapped cmd_sync address when the cross timestamp one
  fails to map, so direct mode never writes to a NULL register (patch 1).
* Check the Tx timestamping state under the latches lock when handing out
  a latch, to close the race with disabling it (patch 2).
* Stop the timer and flush the pending latches when the Tx timestamping is
  disabled or the vport is stopped, restart it on open (patch 2).

Przemyslaw Korba (2):
  idpf: add direct access to discipline the main timer
  idpf: add direct Tx timestamp readout

 drivers/net/ethernet/intel/idpf/idpf.h        |   6 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   9 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   8 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   2 +
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 673 ++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 130 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  23 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  12 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 201 +++++-
 include/linux/net/intel/virtchnl2.h           |   6 +-
 11 files changed, 935 insertions(+), 138 deletions(-)


base-commit: ff2563fbe0e6d28f561d58012efb9b47595fd933
-- 
2.47.3

