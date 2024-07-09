Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F9CC2BD09
	for <intel-wired-lan@archiver.kernel.org>; Tue,  9 Jul 2024 12:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F5C2411D0;
	Tue,  9 Jul 2024 12:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vRPhkwauvkhW; Tue,  9 Jul 2024 12:36:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38E62410DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1720528605;
	bh=i/10i6kYCnWKwjhXItYeUiH30BY1oNejWUOCez9M8kw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=HMzsmJeLghmKPjxpAE6Rw8XuNtPA1u4DPzgSgZvAmFZC1t+beeeX/AvR4YJ4SAkwT
	 HMMRvGRpK+X/zs2oULNfUopQJuVyKlM4YbVrVutNW+O5XAIB1eojX2OS2DgLtZpfv5
	 HzoX1peczDY/EzkIMOtYv5xx9IoTPUhITbqpDnJAo6wkn6qeKcEwALxrTvNhW3J8kf
	 GD2ObtCqjB+Gmyhknfob7T+9/W8KkCY/xdWa7TdLbMeHTdcmRbJ6i8xvebWGpXSeU8
	 p6c0jLjLCJdfsI3l/fMIrVXMYBF4eGjSXRKFfK1T2DGliOSn/FTqd0qHR/w1TzFIMR
	 UtQsJEFSI2ZYA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38E62410DE;
	Tue,  9 Jul 2024 12:36:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 774F01BF275
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jul 2024 12:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6212D4012A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jul 2024 12:36:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z8CH2kU7NA-u for <intel-wired-lan@lists.osuosl.org>;
 Tue,  9 Jul 2024 12:36:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.20;
 helo=mgamail.intel.com; envelope-from=karol.kolacinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 726DC400B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 726DC400B5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 726DC400B5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  9 Jul 2024 12:36:42 +0000 (UTC)
X-CSE-ConnectionGUID: 9ombbdOeSDO0MRrlKQKG7Q==
X-CSE-MsgGUID: DDjaktMWSvmksdUlCNaRFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17598156"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; d="scan'208";a="17598156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 05:36:41 -0700
X-CSE-ConnectionGUID: svmgPpBORcOAyNmkgJiTWg==
X-CSE-MsgGUID: QPsGzXLARcGPEJ+yAhGLHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; d="scan'208";a="47776092"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
 by orviesa010.jf.intel.com with ESMTP; 09 Jul 2024 05:36:40 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  9 Jul 2024 14:34:54 +0200
Message-ID: <20240709123629.666151-6-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720528602; x=1752064602;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XhSywQ0BcjcGguonn7oHKVbbArBG1xSAZzm3ujv8N4Y=;
 b=gSh/HvF03dsK8DoCVb0v+/s/ikBXWSWnWZYuj2REh5SDtfPwRvEvPdOj
 eJjO89x6eyAk0iZK5EQ7nWJspph1fqcFgTiSExfNAjUGTbsuY5GPF2734
 bb4J2RKE1XcqBSVmp7tikbfDDBvguoi/MxqbGLlo3pe1bsiuMDh7eY/XN
 WH2Op9nnDxP6Q5scbGqeWAwSHQSXS3TD016fJlwI29ns/Yd7ji5FhhNhJ
 GIKaTzKVxfmFlWS1IutedASc7iI6AAMYY2fRaStZRWB3U3Y6xS8k1UhS0
 VNeBbQUvBA8cOLH5ftZa6MskLY/5CcoT7PAygYKrMP1oOWkmhXpzfoshq
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=gSh/HvF0
Subject: [Intel-wired-lan] [PATCH iwl-next 0/4] ice: Implement PTP support
 for E830 devices
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

Add specific functions and definitions for E830 devices to enable
PTP support.
Refactor processing of timestamping interrupt and cross timestamp
to avoid code redundancy.

Jacob Keller (1):
  ice: combine cross timestamp functions for E82x and E830

Karol Kolacinski (2):
  ice: Process TSYN IRQ in a separate function
  ice: Add timestamp ready bitmap for E830 products

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  11 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 354 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 197 +++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 11 files changed, 493 insertions(+), 155 deletions(-)


base-commit: 529314adcbceca0e0ec72b3ea94fe4a54ae61ca6
-- 
2.45.2

