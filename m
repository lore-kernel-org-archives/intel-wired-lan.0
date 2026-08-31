Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B5DC624A5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 16:11:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 795248082F;
	Mon, 31 Aug 2026 16:11:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3us8UGFN5xL8; Mon, 31 Aug 2026 16:11:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788192664;
	bh=Wo669Vcbj6n8Q097v69XGBWD4LT3CEk3ecBo00qj/bY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O4f+1BJraPCiuSJqmWTnw6CUr+UgHvE8fzwPHuKcv9nELxov2DIKQic9/FYXv+9t9
	 ox2OSOaAH4T3Q7syC3koUPXy4WnlTUT+z98ISP2NhySMg9rCVk3hid29vfXjMRTyg0
	 /we0r+WgmlpmSaQqSjyXBbNfPsF3hqGT4y61EViNEtLOODAesHD0owzGiVSVAbORqJ
	 LSID2cAXf8yuzOaHknvj4Q/g9pNYQHRpboKmOtzQRymE9ITtobacuiaAND5yMFxEDB
	 4HsuNqcLtQOUlhs71SpjdbccVw8xS1i/k7d99FpiuAUdYzvhdUEn+t511Kl6iG0YKl
	 VFV+tuBUDCG5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A013680632;
	Mon, 31 Aug 2026 16:11:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D7DD52FC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C969F4054E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxEzhKmHuKcI for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 16:11:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Nb3lKqg4
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A59CD40549
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788192663; x=1819728663;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rMwrlZAKKi7d6ptfAaRa3Yi2AtUD30qHz5yLcuMWlrU=;
 b=Nb3lKqg4RtXUCk1GX6yKV8vBieFq8HQiemcPbnWPLrI57UqGeKFLZyrW
 vs4pq1Ifvx6PEt8LBHw2eCX4TFqegZkidDwR+fIG8dvQ5UkOo1YcHcPZU
 BcnThgrtgLOZjYBIrOVNIgCuK1jZvbMl0AtCaLzqXC2uBn0Qht+w8bngs
 HJqV3/ryzpTXqkTa5Lx3cSPEl/QwdiLL2bPqMd9JIzUNW/2ceu5c8K+3b
 IvIagbZLW2ksN6Z80Vr6ogjdpSc7hweah8Z/yP2Lc1wCMgogcH4y5zeOh
 nm83/uwb7JSDZEmtb15KCqeEolTwl78VlUmfCL9HTi1IryGX3VTDhHwjB A==;
X-CSE-ConnectionGUID: sZba2+gbR5Cb6TlFAX7o3Q==
X-CSE-MsgGUID: xvWi4W4eSIeu7DDe/6kqLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88729028"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88729028"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 09:11:02 -0700
X-CSE-ConnectionGUID: H7JjW9HKSTylolVB5SHuzA==
X-CSE-MsgGUID: LgPdOwYqTfOhvQWQLX5ROA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="262706385"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 31 Aug 2026 09:11:01 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v4 0/3] Rework usage of the control PF pointer in
 struct ice_adapter
Date: Mon, 31 Aug 2026 16:10:57 +0000
Message-ID: <20260831161100.216773-1-sergey.temerkhanov@intel.com>
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

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://mail-archive.com/intel-wired-lan@osuosl.org/msg18407.html

v1->v2: Rebase onto the latest dev-queue branch
v2->v3: Cosmetic fixes
v3->v4: Add the rw_semaphore to protect the ctrl_pf

Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads


Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads

 drivers/net/ethernet/intel/ice/ice.h         |  25 ++++-
 drivers/net/ethernet/intel/ice/ice_adapter.c |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 101 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  37 ++++++-
 drivers/net/ethernet/intel/ice/ice_txclk.c   |  19 +++-
 6 files changed, 147 insertions(+), 41 deletions(-)

-- 
2.53.0

