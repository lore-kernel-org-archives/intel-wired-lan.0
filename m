Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4642AC79F89
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 11:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA93A80C86;
	Mon,  7 Sep 2026 11:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MjdT5rV2Bd8E; Mon,  7 Sep 2026 11:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2423380C7B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788779060;
	b=IDa7J2RQq0RHQXb+KW+sp5+JrOJT4vHIpBMOf6/wqG3oaL2hFzWvy8HDJkhpFQg7TAV5
	 ypwfsjULRjGweawXzAE8OsmlVSg1o9wVV/OpuVuzF2td3SELruFNZEKVPa4zBBMbnReAw
	 qNytnPdLBbaCMf0IdTIumovUda3FZaAf3t0EdAiyMimQ8TuHztOikRUv8DQh/CdK19i+8
	 Dmx1qlnHuQFotCsDOkZ+xYGg6zgKFHjQiqlqtAsTpsrmmqAEN1UeugPjkH8aOHb/s6HIh
	 jPibNIzFv940PQb6T0RDq8giJl3WG+4R9Ylu+Cj9H50ni23KvNTzt39YhKTtxgtvXUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788779060;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F0d8uFs89GyUM+UwFoxzvC+3nyuizCgATA2eOePccYg=;
	b=ItPqb4L2LiUOu4EvI4blYzhf3F9EB7b076rEDzShCN36fMGbcB0KAIXj0YjvuShgmV4k
	 51XpXDuh0CtuVmrapTsbHxHJObXmUjSmEUGe1tIQoNB/30P293HQVdi+Xom6Lkf/ElpAJ
	 HNweoT8ZcyNaRZVlmhYfy/sgn/xhqXzhJ502osRt45h9k1gHmxZ2s22B2FJqvXkR6cz7f
	 W8/g7KHDgHeyRGAJqfXPMsVSIq4mrVnqysxdGDTF/tCQUELPjJ+N+SpD3cS7gmTj7XRJH
	 b7/18Q2uNf3epG/2uy5pRtqG5O9q6yrfMCxQWwgj8aDqVGaRmUAhk+b10XVc0jNohUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788779060;
	bh=F0d8uFs89GyUM+UwFoxzvC+3nyuizCgATA2eOePccYg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BPRYaVc2w3M6icOy8YPtf1niFVyUfh0h56His+JTeWtTJ73dSWi8SqezHI/4pTbaq
	 w7m7b/9ZWM22gAaJ4slzGpTVIUeqY4hz6blaVpap8lRalDa8gMjx9tEgGNUnlDRuZ5
	 BhB4YHG6ZgrueDjOs0AosMJJJ9HWf3mLOp/jMXvF9HSjNnGhHWDZnZVBK1qodEGO8w
	 RbiYO9eHNDClNyeqa/qR1Ut02wC77IA1eWLkv9PhCBdfK2iGXmhR+6RmvYAwNE62dh
	 fQw81Mc/a/bWegsKTgSDMXcI0nAnrtwHR6h/hNRGlX8+4eUgXz9oiU+YeOcOab04Rm
	 l3ied0WE25odw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2423380C7B;
	Mon,  7 Sep 2026 11:04:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CCFC8A48
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5CA760631
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5Nied1DUUru for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 11:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B9A32605DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788779057;
 b=cZPNnrb7L1mEhVRF4qch+ITxhSc1rteakkjbKOKh+B0dCldN09WWnPHMW4lTs4iA1R2y
 0FDTJvd6hZXWf+j/QoZrD8M6fOWFzXzRF7Sg2g+INhlq1fBsU7mL5Acw6Os30gpHnMYia
 rRcH3NJh9gBYFSIlKriOZbUJ/hnRSCkKTbROn+vqoLLblopZFCDD9uR0Zvd5iwZps/zKv
 Fmrap4zzNgchGvOVoLWZ7cW0bycVvYEuWtrtAhGHSJjXlw2flDLMkKSCFXrJqnT5ea6jW
 uXZZGpdhhD/cvn0dIGDKBwlPojlycrZ9Hnuh6jRiGKe7OahtTOQ2jW7GZCWQGeaWwmQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788779057;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=F0d8uFs89GyUM+UwFoxzvC+3nyuizCgATA2eOePccYg=;
 b=T2TxDdL/Tnr1XqFZ62LDfuwN2mtgg+4W+0mtBsI9GBK6U6eoHUUSvmef+8OJ9b53oGUb
 MZ2f4oANTWkZK2jgL2Prk4jh1iWrKDshp7Cb6uR3EMn+E5KqyBznRQDX7BUobJ/VxHeM6
 8moLLpVmm/vD14LqNlVB2f88vBnidulOgZsA8LCP/jdrGgdZZQbe1tcCWIhqJYy2AraPk
 YfVyGzcHNDCk3bobHPG9daW0y9X1tWWOU+/N3olywGBqNrldtrF14dKcgjbY9fFYJp+QS
 O/hbXBJfKPBk/Hc4O6jLXDfnrubszNd6tUrE6a2vpDRWtwr5BDtQOaTCH8KGjs81ETQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linux.intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BSAAb555; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=BSAAb555
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B9A32605DA
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788779057; x=1820315057;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dkW+c/aEGHdcs31Czl1Xa8/WURGdNAowLoEHdpJjXfI=;
 b=BSAAb555/TFaf62TR3WljoEutfxtsJ0drgifJFJ6ypXr52TeIaLLRtKn
 449OgiptwOMy8HhAkGAAW9ShALPV0993Q8+ol2oedCwHh0TlHiY+DuzmP
 ZquP/KmxoRKiU3qT8MadnzEOh5NeZL9qHin8GG4Gn1rpNcYxz8mar1FJ7
 JtzWA7RLVuvQJszOH62o8XnwW8cYMAn7bMvsCWsGeIj60LV98kaiHicfC
 i6mzNUR8exGD7QDoFI+AFhNP7U/FmgQdcEMZelZmAL6Phd7Ik9IKjSaZA
 9D1D46bYi3C/DjiIP0+2wCqIQU5cibiTw8QdCWUDp4/Xoce8lpGrOj0SG A==;
X-CSE-ConnectionGUID: LlRIh1zDSey5eoumrLAopQ==
X-CSE-MsgGUID: NCR8v9i+RYq4JZ9G6iBODw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89214057"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="89214057"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 04:04:16 -0700
X-CSE-ConnectionGUID: nCHJH4QvSISRu6YUYVk0xw==
X-CSE-MsgGUID: y94bKgtUTiK7LCnB9PwkKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="274195229"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by orviesa003.jf.intel.com with ESMTP; 07 Sep 2026 04:04:14 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 00/10] Interrupts helper in libie
Date: Mon,  7 Sep 2026 12:24:07 +0200
Message-ID: <20260907102418.2697317-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
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

Hi,

To not copy the same code to handle interrupts in ixd driver move it to
libie_irq module and use in both idpf and ixd.

First part is changing current idpf code to make it more friendly to be
moved to the lib. Basically there is no need to store MSI-X entries in
separate table. Instead of that store it in xarray which also replace
custom lifo implementation.

Patch with libie is about moving the code to the new module. No
functional changes here, just moving the code or adding some more
descriptions.

The irq code is similar in ice. One patch also coverd the changes in ice
driver.

Last patches is the implementation in ixd driver. To manage MSI-X it
needs to first map correct regions. Do this using virtchnl command,
similiary as in idpf.

Michal Swiatkowski (10):
  idpf: store HW vectors information
  idpf: fill q_vector interrupt registers one by one
  idpf: get rid of msix_entries array
  idpf: drop v_idx from q_vector structure
  libie, idpf: move irq code to libie
  libie, idpf: move hardware irq info struct to libie
  libie, idpf: move parsing alloc vectors command to libie
  ice: use libie_irq for interrupts managing
  ixd: support for getting lan memory regions
  ixd: use interrupt for mailbox communication

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/ice/ice.h          |   5 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_irq.c      | 181 +-------
 drivers/net/ethernet/intel/ice/ice_irq.h      |  14 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   3 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  15 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  70 +--
 drivers/net/ethernet/intel/idpf/idpf_dev.c    | 108 ++---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 430 +++++-------------
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 136 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  23 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c | 109 ++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 162 +------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   9 +-
 drivers/net/ethernet/intel/ixd/Kconfig        |   1 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  27 ++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     |   8 +-
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  18 +
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  93 ++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 127 +++++-
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c |  70 +++
 drivers/net/ethernet/intel/libie/Kconfig      |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   4 +
 drivers/net/ethernet/intel/libie/irq.c        | 363 +++++++++++++++
 include/linux/net/intel/libie/irq.h           | 118 +++++
 29 files changed, 1174 insertions(+), 939 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/irq.c
 create mode 100644 include/linux/net/intel/libie/irq.h

-- 
2.49.0

