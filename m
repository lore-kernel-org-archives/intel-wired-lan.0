Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0EACD342C
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 May 2026 11:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2031613A0;
	Mon,  4 May 2026 11:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DHf9BSf3Wnw1; Mon,  4 May 2026 11:01:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 536276139E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777892463;
	bh=GFlSzFuCsYRsKnBoTwugtJIWDem31V1ps+/wdSqR5sk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G3MsBO1tVx6E3SIbvF09lhPojbAc9+Iew9xyrC4uqeE5wVzo76e9fBnRhj4+pJMf3
	 NvGVCBhBOzBN5AAigsFJxRKHXLp7gNz8XRLLtKmCkCL5VirZ4cJOR2uM9aCxyrxpbQ
	 ALLwEgDIYJNdSbOX8DVr0jVWzDGtI7VawARirgiB2mLsn4n5IAQeJ5SN2/1UGeIaaq
	 GzeYvl/p7a6N4U1jSjBEPJR5eTfmilvMYqKhg3kg6olQhWIimE19OibU9pF7uf1zRf
	 ttuEs11w2g2F5DaxZksOjDnMBH9rVRIkuV+WoUA1Id69EEhu5nHfyyDTSzPegQwRGJ
	 unpEMoem4zaHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 536276139E;
	Mon,  4 May 2026 11:01:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5202D190
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 11:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4396F6139E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 11:01:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLi7HZUP6jcJ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 May 2026 11:01:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 74CB16139A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74CB16139A
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74CB16139A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 May 2026 11:01:00 +0000 (UTC)
X-CSE-ConnectionGUID: 7pamZCgpQJqpfKHqzznOcA==
X-CSE-MsgGUID: eOsnkSE/QAuk8zQRaEts6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78939686"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="78939686"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 04:01:00 -0700
X-CSE-ConnectionGUID: 3pS4IbugQ+e4O71EbqH7Ag==
X-CSE-MsgGUID: r54MIRs3TBu19S/8Gw5f+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="239792118"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa004.jf.intel.com with ESMTP; 04 May 2026 04:00:59 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon,  4 May 2026 11:00:55 +0000
Message-ID: <20260504110058.2373236-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777892462; x=1809428462;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/rK8g29xd9hKv2k9bB829r08DZ0dHtRyNZ8rSSYcMvQ=;
 b=cwrJ2Bdgynmlf7EVlsnjV8x///3/qOFFiHKX1o76Q7S7vKOVNnFfly0A
 tKXAmsAsPbopc1Xzukuvcdx+YnuPV/NKHWz6w7KyjZ5/G/2aLpxQJP1MU
 9iWBjl08yL5f3NJ0ZwPStWpT5qV8jE0FOhOFc+42ejRmVA5JLRcgP69oF
 bu6QUSbGRaepK8wDBFAVnDt8UQEUWrkqLf19J5nM742Lat7uGtY4UUDFi
 HqHdMDF9Na8GFrwyLZ0dRkqgVf01ejCYPM7FYBF+j0C6y778bR5H9rtMd
 BihysWUTRmjyS3pHu0ffy3eFlHr0/ujSrmhSuY+DlTZnJwWjN518wdj2q
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cwrJ2Bdg
Subject: [Intel-wired-lan] [PATCH iwl-net v1 0/3] Rework ctrl_pf pointer
 usage in struct ice_adapter
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

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads

 drivers/net/ethernet/intel/ice/ice.h         | 10 ++-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 66 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 26 ++++++--
 4 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.53.0

