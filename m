Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE6CC54F51
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Jul 2026 21:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C98881374;
	Tue, 28 Jul 2026 21:11:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vx2L4_YgiKqc; Tue, 28 Jul 2026 21:11:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2F0B28134E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785273090;
	bh=o9fW1MepDvP5D2/yUeGOTf1zbn146vdKkO/IytDiPyA=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G1x84U6PnoL074Nz1rqaB6Qe9IgRBX9kWBQqnmMEwPlMtp1YEl6V97rO04CNk/IG9
	 jw+ch0tn9hCTmLnCXH1EzvGhFLJXrkq5FQN5gmdgIbkRdDAxWk/hoQ+yFw4U/OjmS0
	 9jqNfA5IfFznpxY33hdnf9jx9cf6hi5G0FZqH7tHbD17YB38/deIilSFFOu38GnJdV
	 QcOEwF5OmtgP5aqpiTd0gQKtZbXvgCRdDOe8+U4djHqzgJmkKs8RONKLUANc8k3NiA
	 BtkATRx0x0HxtY2vmzOnQGvenkZoPEQxPrR+5snog2B0hvsCileOJ7VUpZwla0Sb+6
	 ebOecLSglyBBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F0B28134E;
	Tue, 28 Jul 2026 21:11:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A7862E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 21:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C97960A41
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 21:11:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 29IADu-ndl_o for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Jul 2026 21:11:27 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 61ADB60A40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61ADB60A40
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 61ADB60A40
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Jul 2026 21:11:27 +0000 (UTC)
X-CSE-ConnectionGUID: ni5YbE9LTt+qzrWLFsBZRQ==
X-CSE-MsgGUID: 4cVjoTegTdCwUlvXkKILSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85725508"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="85725508"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 14:11:27 -0700
X-CSE-ConnectionGUID: h92ASrLRTPKPGJ3r8PtkXw==
X-CSE-MsgGUID: mGTuLnLaTnedQS912JmTfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; d="scan'208";a="261772434"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
 by fmviesa004.fm.intel.com with ESMTP; 28 Jul 2026 14:11:25 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1wop59-00000000en9-2IeB;
 Tue, 28 Jul 2026 21:11:23 +0000
Date: Wed, 29 Jul 2026 05:10:17 +0800
From: kernel test robot <lkp@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Message-ID: <202607290504.uO9dfz4x-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785273088; x=1816809088;
 h=date:from:to:subject:message-id;
 bh=t5psFJuPksI6AXa68LjwN5xMEKxBnfA01btcCAAp6Jg=;
 b=RqWrJY8FObudcpwOrEsCO9XnD1iAgqpTX8aKHS01ehG711agNZN3m9Ej
 V+74p3E/l8E9ug+SYUyIkGTIpW1d2RoofLf8G5TsaFtRfY+PE8SLR7mDB
 /LDM2FhUcBdqW1qGld+CbXa2Yn3q2qMxBcMqQjLfNT7aglLtUp9i0u3B+
 9AkLeSQcsMS95anbW/2QROWQGACD3/6F2CqN6Vd9CssmR1HFySsrTmGIS
 OCVrYZGo15l8SBUFOvDq6MrW7Gmnhxe5BK4pjD7Zy4f5nhD03KkzDC61e
 CkvZI/YcP7tAoHnfx9FBYcWpPM8AzxGqnbwGBkZJWgf3PzWSBELObkFYF
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RqWrJY8F
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 e095f249e2209674f6366f6db0383a2b96e19239
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: e095f249e2209674f6366f6db0383a2b96e19239  net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller

elapsed time: 422m

configs tested: 10
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha    allnoconfig    gcc-16.1.0
alpha   allyesconfig    gcc-16.1.0
arc     allmodconfig    gcc-16.1.0
arc     allyesconfig    gcc-16.1.0
csky    allmodconfig    gcc-16.1.0
i386    allmodconfig    gcc-14
nios2   allmodconfig    gcc-11.5.0
nios2    allnoconfig    gcc-11.5.0
parisc  allmodconfig    gcc-16.1.0
parisc  allyesconfig    gcc-16.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
