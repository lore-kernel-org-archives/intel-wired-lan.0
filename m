Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80415C531C9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 284AE40B04;
	Fri, 24 Jul 2026 12:13:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id auKdDyxrn66o; Fri, 24 Jul 2026 12:13:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FB0940A92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784895235;
	bh=l1hED1t/hFQzDzIYc7wU8c2WWobiJKXmn7n7l+XDS0c=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5qA+gwoblmixsuZcvnsYZYMqVuTelIncwnEIKdC8lfqBhGibdUxjt4g1ad4X2Pz7x
	 LHreAVB5Jf80HMkC6mHuWOD9kKkq8uqt18wGJga3D08ikr1J2vxnOx37rOdEx9gPLH
	 +eCuls7dSoGjdIb7SEishfs0ogTiXi/TkdKgwQ2BWdqUlMHkJHtBRjXmzvVGRATP/s
	 +HUtpfwk6mdmrb33/0D7Jljzs5fj1U+swmRlH0f3HhwMdYrZWsHAtVIVqd9fNOKJTm
	 Baxks4oyIzZJJl8kNpLC/Bpmct2htbhhhfefCJ9VLrgyBWzsI1XLYk9giLCrN2+prt
	 tl1xJ9hY95mfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9FB0940A92;
	Fri, 24 Jul 2026 12:13:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 443353B0
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35E4B40A90
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6J9VYUe28pX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 24 Jul 2026 12:13:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8246040A72
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8246040A72
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8246040A72
 for <intel-wired-lan@lists.osuosl.org>; Fri, 24 Jul 2026 12:13:52 +0000 (UTC)
X-CSE-ConnectionGUID: ODKJOiqqRGe5UuV6zWdj6Q==
X-CSE-MsgGUID: nTS0sWn8T/qr0kaNSIlMRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84686070"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="84686070"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 05:13:52 -0700
X-CSE-ConnectionGUID: DgfMutTjTR2vWz7p1WTTgQ==
X-CSE-MsgGUID: D14Hl43PTZGGzfkLTaSLug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="252367699"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa009.fm.intel.com with ESMTP; 24 Jul 2026 05:13:51 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Fri, 24 Jul 2026 12:13:46 +0000
Message-ID: <20260724121350.1565330-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784895234; x=1816431234;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1EhgpuYzmdDfWT+P5HVUN3eIwVgkLFfWxhb2wx0O2YA=;
 b=n3dfs5MwXJ0Id5xzZ/XE5xIBt20YZifvYQa+hzRuNze4zf4joVTiv87u
 FqX04tWJvwcO+U5g45Z1NF8Lw9JaBMu1G0KlYohcBm2W1DZfu5Zmch3ER
 FTtck9CBX4G8li1vbvloUf0IVF4PiWzmVkLy7fMO2yJ4xgt91eNgmBtRn
 t/zHaN68PGNxd9uOBFY4NdNI3hr7ViXZJIKFsbCrjdrqjBienk2xEoYYN
 28ZrsGrI4PcmI3uyJ2O1IJ14DU6YMqMYBblEouTb0WBB+UlOUO84qRW5M
 fnwiRSCBOC+jB5Wxs6JHMiUFD9JhKnopLVQcxNzvkjtJrt6zi2qNkXwZo
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=n3dfs5Mw
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/4] Rework and fix ice dpll
 pin control
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

This series reworks and clarifies ice DPLL control logic.
Contains refactoring changes for better readability and
maintainability as well as the changes making the pin
controls compliant to design requirements.

v1->v2: Harden the error handling paths, additional bounds and
        pointer checks

Sergey Temerkhanov (4):
  ice: dpll: Rework multiplexed pin notifications
  ice: dpll: Use switch statements to handle pin states
  ice: dpll: Rework U.FL muxed pin (SMA) control
  ice: dpll: Rework the SMA control logic to match the requirements

 drivers/net/ethernet/intel/ice/ice_dpll.c | 347 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_dpll.h |   1 +
 2 files changed, 290 insertions(+), 58 deletions(-)

-- 
2.53.0

