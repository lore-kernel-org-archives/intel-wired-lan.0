Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70681C2BA18
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Jun 2024 12:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18F768467E;
	Thu, 20 Jun 2024 12:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qeMbTtycToLi; Thu, 20 Jun 2024 12:32:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CC9584666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718886720;
	bh=fYW6x9CSGMUlLPhToHTM8Uxicyu6ddMSfV8wIJ6Kwb4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=uBJ6RzyRsiGnmLC2jxcksRGUuuYL5IqzOKVkhS/61xFp1V+zmRkkZUgicTsL+KciX
	 D4zuArWBEMUlvcUd/Gr+yOQ8ck6AF83hxwN7Fxc47lRHZtCc+x+RktJYr13kG/GmGv
	 oyjq3EIJvqVEwr5Xn5xXZry6PNsnfDoDehGZr3hlbBThO94oQn5LPVmGm0eUIQWOgV
	 ahp+Dj8Can+xsN7pTUzFvO07cQi3kHuF/oNPgWiH432EJIEa+ts2EMQanB90gym26o
	 tiksZ0TG4YEBRpqPT0A7SdotEM2yhoIaeLtqcFpbVZYOBmuKmhOx1YkOtvP76WtEwR
	 zo7H9M3nTC4Uw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CC9584666;
	Thu, 20 Jun 2024 12:32:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C17A91BF573
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Jun 2024 12:31:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACDA942EC9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Jun 2024 12:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BftnNAPTkHWZ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Jun 2024 12:31:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=karol.kolacinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A928142EC1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A928142EC1
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A928142EC1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Jun 2024 12:31:58 +0000 (UTC)
X-CSE-ConnectionGUID: 0jFPMX0uQcSXfTi3tXy76w==
X-CSE-MsgGUID: z8hUbov/SEyBSfH7Vvts4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41262879"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; d="scan'208";a="41262879"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 05:31:57 -0700
X-CSE-ConnectionGUID: OjPo6sKYTqq6EcAx9D03iQ==
X-CSE-MsgGUID: u8QhCwbjS+GUWpaGLsl/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; d="scan'208";a="79712939"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by orviesa001.jf.intel.com with ESMTP; 20 Jun 2024 05:31:56 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 20 Jun 2024 14:27:07 +0200
Message-ID: <20240620123141.1582255-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718886719; x=1750422719;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CjX02a42qzAYbrtxKmG4UYbxovrRtFRFcsvg/03UgSo=;
 b=C0tmo9+NzRu1ijkj6Bmji1W2iYi2wWcBarECh7r7XoBFd0wJoygQY6hg
 55oSUrGL073jDvh5Rjh5mJdmOnqfG3TiYw+HtKmBWpyp4o9FOWI8qNxhI
 R/BEM222tjFsRJVFa5et88GqAZ4pe1Lp9xWUCh8YEY9O94xmf6lh/LSA/
 3dj/ejIGfBBuBHQ9hnRjZotpRTSP7wwSTR4e/1nbCY1adf5udv9ffhDy+
 mlexyizZ2xrNNsc/kLOHH6FAv/77KSFxyXs/dBxw0dCW2nsvZFQ8OsuUh
 uFN74jofR9BRCdLWytVLGTnAY0p6hVy+qnTxHl9RbNlN8yrOi86wSfy7Y
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=C0tmo9+N
Subject: [Intel-wired-lan] [PATCH v2 iwl-net 0/3] ice: Fix incorrect
 input/output pin behavior
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This patch series fixes incorrect external timestamps handling, which
may result in kernel crashes or not requested extts/perout behavior.

Jacob Keller (2):
  ice: Don't process extts if PTP is disabled
  ice: Reject pin requests with unsupported flags

Milena Olech (1):
  ice: Fix improper extts handling

 drivers/net/ethernet/intel/ice/ice_ptp.c | 132 +++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h |   9 ++
 2 files changed, 111 insertions(+), 30 deletions(-)

V1 -> V2: Fixed typos and other formatting issues in all patches

base-commit: 0a8975e20f25bb2f5edb28d883dc715802231e71
-- 
2.43.0

