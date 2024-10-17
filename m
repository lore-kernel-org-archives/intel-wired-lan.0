Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07BCD37487
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Oct 2024 13:15:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57EB280E75;
	Thu, 17 Oct 2024 13:15:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j54pumQ1BWFs; Thu, 17 Oct 2024 13:15:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8ED1581252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729170953;
	bh=7EL0QJWqUVJ14PPgp28uU9Yl6iEryDIF9BFdB8/1hME=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fzJTTUNfYoG6Vvih423Bl1aXaL/Yr6YTjunxZouNXfm9TXXhiQFugzU+LCnjn6aK3
	 AQc73q1jxKmvN3aUrseH0iT+/Tssqj5poGvRb9K6daPVRyMUOPPIrFFslXNSdPeDtc
	 s2j/HE1/+WuJCI9Pt/g5DvAnc3NCggC6x/0vqNV+SgHtag95UVKETos8dbGW0Je2lj
	 V0uMBlPMfF8MgkG5849gbfvFZ09goKjSHp53XXbyHh1p525oNPHbaOmI/dR6eXdGFL
	 z5xnxiKpW9JwXOKa7UgbBko1SOsii+SzujKwDr4OEjNyrK2oOO1UHHcxR8S2nkyusW
	 cOnn6KkcQEXTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8ED1581252;
	Thu, 17 Oct 2024 13:15:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 153862316
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 13:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB087402CC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 13:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CA15tVt-dT01 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Oct 2024 13:15:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=piotr.kwapulinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 40B9240672
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40B9240672
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40B9240672
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 13:15:46 +0000 (UTC)
X-CSE-ConnectionGUID: Il14VkFhSXm73rxXOuzdag==
X-CSE-MsgGUID: S12Y0CCaRbOCpNs+cLgo3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="54068258"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; d="scan'208";a="54068258"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 06:15:47 -0700
X-CSE-ConnectionGUID: E+ShnjFfRFa3pz7umIcTTg==
X-CSE-MsgGUID: eR21KDJ6RBqsuvaZNmoHaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; d="scan'208";a="82505226"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO
 vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
 by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 06:15:45 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Date: Thu, 17 Oct 2024 15:15:01 +0200
Message-ID: <20241017131501.4229-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729170947; x=1760706947;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YB7+HFcGK8k46+CVdTngS7vscQZUut1NpWXvPpsWZ78=;
 b=XzIu5e0tG4fKhaOqCbg4+dfCY2Dk2Uex1IHMa5AqW0qsnNEetMBzpYY4
 /d3IYXVaTGpqEqySolBu2Z5iSBxIDpVL/8a1PZuZjS39pRHk+74Cqkf3D
 jii6Xm3n5zPiaFxmBqYYZaiwMznRry6KgLSv7qTGJgXHqGrw58eQ+rczl
 idzuX6WWTmiHFrYWizuLaZhpKoCQUzPaJLI0LVvrnqfHQ7uAX+V8UiKz5
 Ns9UOOUBd3qTt63wLViiUsHcz1spQt0ROYV8J4XfNXEGz1yOQECSJgY5X
 AF6DZ0U7UECnzsUsOilVP1yjjjOqhjW9CrQmkQ8QKtNYHxr0Gom9R6rpq
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XzIu5e0t
Subject: [Intel-wired-lan] [PATCH iwl-next 0/2] ixgbevf: Add support for
 Intel(R) E610 device
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

Add support for Intel(R) E610 Series of network devices. The E610 is
based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

Piotr Kwapulinski (2):
  PCI: Add PCI_VDEVICE_SUB helper macro
  ixgbevf: Add support for Intel(R) E610 device

 drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
 include/linux/pci.h                               | 14 ++++++++++++++
 6 files changed, 47 insertions(+), 6 deletions(-)

-- 
  E610 ixgbe support:
  https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=426452

2.43.0

