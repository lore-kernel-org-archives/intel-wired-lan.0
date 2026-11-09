Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4495606A337
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=kNDdO2gn;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W02+QKeH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 949F940648;
	Mon,  9 Nov 2026 11:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AkPLFm3xY2pi; Mon,  9 Nov 2026 11:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0803040660
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794222310;
	b=krP2GKtMCmg9K3eO99Y4L2m+EHAHUbiSySOhT6E2ZyWIIEP6sAqaAMtQDpQ7QMG0/XwV
	 eTOgo4OxSaJUgMpsKKSHNVxUX1bi0duS+uGLD4Uf13ZE/Y+EcUVW3YKAkTo9gqRtzrgfZ
	 6al+u2eOgF9HSbejK+yC2gU3VDCuDrWBUDLx+Vz/4FMH82XHmiCjglx2sjlvt9jZdNmFA
	 cCgY+5ffhlxPLbUPfV/NXVyjwcuNj/TaR5T92A/ERCSziZQs7abtiRhOKr3GoIc96fcyG
	 8MSPrydWY300XroOHpL3O80IIGuFDEuxQajriu7rGvKLCGUFFKJEGt3hw8dz9jT0EkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794222310;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xbzI7HpEHhBxN8v5f8r+WGwUB47FvF5wtsVyz48JOeA=;
	b=OxDfk5I4EO3RO56l+ntIf8nymKc5a0lkgm1jKwvEJOBoWnpu85QKvWgrfTgxoW6KU7cy
	 A4Y12m3K0dx+SHspB2TFjnIYlddJ0rdL/cNaDIj/tXQ69vzVxnpY+KMT8Q1iB7JHmpQyz
	 vLsk8VSCU3agXJnx1XQqpusl5t4IQURlCvdLpusp1/n84EViUM4B0ZLvGPuLo20VoUy0E
	 lc9o/CdkDh2zvZGSvEBz4CC3IBw0Euz52/TGFL/s+PyHK+Z9sk1rnUS9e0dZBNQWFm63J
	 g8iXrLipO2Jn8JiTs+Menn8EeafQ1O0uyoLwu+qZAZTNIyDwsiruoz1nhyYXj6aYsbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794222310;
	bh=xbzI7HpEHhBxN8v5f8r+WGwUB47FvF5wtsVyz48JOeA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kNDdO2gn3H50I3pF33anOv9Onj4+fHnLe8VvoVc/FqO4eL70ZMW7dJKUZF3RrsZxZ
	 RtjuHQB8luSXFHYxx/hezEu8KcCWXr+gSWYxnkudDKYPUZhDrHl1Kg2GhXtSmk0FNw
	 G3GAUAGlYPwSteGWwaP7VcRRTok0sIkD/CeEAwfXiZqWZJM+GB2kA6iM2BgBm82VUD
	 1ty/x6GdzwvQJwSAeF6JSqScCe0CIcAGsNCrWIhWD+89NLvYktAzpXJFVHayP0Nu9N
	 GUCyuV4PrHS2LOUj3QR80R0k4PkiSQPfGQetFDlDLMFW0vE5DPHO8ZibjLQiNKys5v
	 vzaK4aAn1qgiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0803040660;
	Mon,  9 Nov 2026 11:05:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C05DA361
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5872401FD
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ircW5DVFOIi for <intel-wired-lan@lists.osuosl.org>;
 Mon,  9 Nov 2026 11:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E9B6940095
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=przemyslaw.korba@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=W02+QKeH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9B6940095
 for <intel-wired-lan@lists.osuosl.org>; Mon,  9 Nov 2026 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794222307; x=1825758307;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iOu+Ka5rjFPSkbA1X0MI1uwaPRK86xGNFhtYP/p0QKU=;
 b=W02+QKeH0vLD2k5RobHkNoUIOIEZ8hQ0U/0JEcvNTl7ieNWllkwc7eBa
 CsDo8Lik9Txbp1eyuCHNjdhol60nRGu0EKyNP4TqbkDYOomgV9xn7LPFg
 ua1r23elpSX4u83+csnbzVOPFRdHhCSQu3n+WdevHZ6lTcdKR/Cm/2C1z
 rLMq6Ko42cqWN3AaCCYjEa7CIQwRZIgSZL72L0YNPf1P4Yn5+ezili1Oh
 b1DHtnj+pmLJtPr+Gdio7rlBYFG9sSLdopFzsQKr83C1MyyjyCWhZbtNB
 VtzUmie/s4VEh6Rpyu6aw016ZmY0KtWBuRdoK2ZZIoNwki/PDqsdrU+of w==;
X-CSE-ConnectionGUID: Gae05ByfTD2pv2c44jVBag==
X-CSE-MsgGUID: V9XisgdJRLWPVDqaB7Al+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3042443"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="3042443"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:05:06 -0800
X-CSE-ConnectionGUID: uMYUZRNcSA+zpcDIK0n+gg==
X-CSE-MsgGUID: NTW0J/oIT8aX0xAOczALNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7887833"
Received: from gklab-003-014.igk.intel.com ([10.91.173.44])
 by orviesa001.jf.intel.com with ESMTP; 09 Nov 2026 03:05:04 -0800
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksandr.loktionov@intel.com, arkadiusz.kubalewski@intel.com,
 konstantin.ilichev@intel.com, sreedevi.joshi@intel.com
Subject: [PATCH iwl-next v2 0/2] idpf: add direct access for PHC control
Date: Mon,  9 Nov 2026 11:54:05 +0100
Message-ID: <20261109105433.133056-1-przemyslaw.korba@intel.com>
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
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 664 ++++++++++++++++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 130 +++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  23 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  12 +-
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 201 +++++-
 include/linux/net/intel/virtchnl2.h           |   6 +-
 11 files changed, 926 insertions(+), 138 deletions(-)


base-commit: 4150d6f3a7b7b533257fbb2d1edbcea031aa9e72
-- 
2.47.3

