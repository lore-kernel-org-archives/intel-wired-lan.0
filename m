Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4967CD37B5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 09:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6496140DEC;
	Mon, 11 May 2026 09:28:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HtxEHGbxWFxa; Mon, 11 May 2026 09:28:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A099641599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778491708;
	bh=4+QbGEhEsquEoKxIhD2AqcM08oL+NVhQbtrM0BhEX14=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O0uvWCPKzzTdntimX/nXDhfvybMR9OiSDByn93ZC6rvD42qE5zOdhxrKKL7FfFU8Z
	 Hvp/3F+pTQJGD1gEIidX3GjGKaR2t9HlPxe1rUIaomeiJl1mlyxpyYBIQR5hXpB916
	 E8O+eUVYPA/LWG09sS/WA6bygTPcthegRzsAPaWaDeencE5LxWLaUmnQZlIgWBE93V
	 ZwHbug2vVNFgd/f+xvDwb3+99UadDUhMmjO9RV1Jt35cLPtfry3E2MBKIOBy6tQqAd
	 MPYb8iJlELRSAN3finFEadU87Wnqrem0Tzzn2baiDxxaJiE2HvWZwu6IExqo7EV3kC
	 A4hg95ClD/BbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A099641599;
	Mon, 11 May 2026 09:28:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B581B223
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 09:28:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FA9841592
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 09:28:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2i6XCTguIcZd for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 09:28:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9493B40DDB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9493B40DDB
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9493B40DDB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 09:28:26 +0000 (UTC)
X-CSE-ConnectionGUID: 9yBd239qQc+X8RgcxcUalA==
X-CSE-MsgGUID: a6b2Ovv7ReOBFR/Gzz31WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96938066"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="96938066"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 02:28:25 -0700
X-CSE-ConnectionGUID: HK+RH4NgR0aUAcStq54VYQ==
X-CSE-MsgGUID: xU11dsJQS32E3Xyj7ulxYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; d="scan'208";a="234741131"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa008.fm.intel.com with ESMTP; 11 May 2026 02:28:25 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 11 May 2026 09:28:21 +0000
Message-ID: <20260511092824.2522188-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778491707; x=1810027707;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WMTE157dD8g+v5naxxaBeOIvwYVp6WNe8lrymqYZFTI=;
 b=ACg4DDHbg7l8LFmcLtVnNSuprqjaKhRD4/SUUMmzLEN2HFj485fBGCr2
 StsGkfBdP91/7BPEDyhAV2HB0pjJaTnXK4tkTqP2fx17JRddAudP6cxqZ
 XdNxP+nVBrfcuvE0caeLTDGMRNafLhaT/QZ6gMTNsL/Erpe+9zSPVh2La
 xNB9Yu6umpJXbqrqTA1y5OaVf8kVwhNx+CXuuPUqAOshFWxr+6bIPJ/3L
 euyJDSdoQvl0VUC7b9RqQOz8SC7gU/LUiVb1aXbOQaKSweiDuMqjFi305
 Z4FDOoaExOoaam5buZEULtsiuc7JGxeDXKLL2afhoR2IH8NqtJbPUsvZ2
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ACg4DDHb
Subject: [Intel-wired-lan] [PATCH iwl-net v2 0/3] Rework ctrl_pf pointer
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

Previous version:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260504/054842.html

v1->v2: Rebase onto the latest dev-queue branch:
        297c032796ab ("igc: add support for forcing link speed without autonegotiation")

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

