Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FE3C021B2
	for <intel-wired-lan@archiver.kernel.org>; Sat, 22 Feb 2025 06:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A384440346;
	Sat, 22 Feb 2025 06:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LhvQHvxzqMPE; Sat, 22 Feb 2025 06:16:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A77B40347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740205016;
	bh=/HnHPxaO3wJZGXMvsdko4fw441+pxOAceN2K3e5IV34=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VRZSdo4TWzZBsgu/jRkI0tkDUqSSFh9kjzMP/ULVQ1WYMHawKagI3nCsZhCM0nbd3
	 Gggxj0khuLyYfRoF7nHN0DHJU8KZyFclAimepyXXI4Kno0/KUBDi5Hc4eZoeJaQA85
	 Im1DsG5RQs4vvzajNJdo+vbeu07kKyGNsB2FJyVFpuVGp0AMFSTYo73jTIDk2YHbDX
	 hURiPzumNxwQQMtTAJQJxtKUwh4dMx+BJ6+sSY+XzBAfmvikMvxqG/hFRE8PF3IMtW
	 qTvOdjABBXrsHVPWwN4tFDaSLhnXjF+UJ8z/jy+9YcRwUG9CRfTzwu8ZZXbKHtPWJa
	 EaGBvCsTTjGrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A77B40347;
	Sat, 22 Feb 2025 06:16:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C7136B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Feb 2025 06:16:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E569B82090
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Feb 2025 06:16:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EUDIc50EBuGJ for <intel-wired-lan@lists.osuosl.org>;
 Sat, 22 Feb 2025 06:16:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 039208208B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 039208208B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 039208208B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 22 Feb 2025 06:16:53 +0000 (UTC)
X-CSE-ConnectionGUID: Rkcaw/AGRNi1lFArQDqjcw==
X-CSE-MsgGUID: jZ5mp6m2S6+N0g0ZALluqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44681640"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; d="scan'208";a="44681640"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 22:16:53 -0800
X-CSE-ConnectionGUID: TUR3361IQRmk2o/yleH7ow==
X-CSE-MsgGUID: ujlA1LrzRf2vfaH/1XGt7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; d="scan'208";a="115277019"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
 by orviesa009.jf.intel.com with ESMTP; 21 Feb 2025 22:16:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1tliof-0006LN-0w;
 Sat, 22 Feb 2025 06:16:46 +0000
Date: Sat, 22 Feb 2025 14:16:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <202502221412.TDbqnUpd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740205014; x=1771741014;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=bERci+EnP68fSaz8z6pV4FtfvjP9YJlknHF4NJgGmH8=;
 b=Ap+fIVDw8Auey5vAt7ZGrczFL7S4NI2xBFiz82t22P8NHMAe1eO4B7MV
 bFGR2T3LitAQ9f43YvkkFx8Szg/mDZg2rtUE0lmHDrEno6Zoq3TrckvnN
 TdRx28l0XOgmugAaMe9Jf53RfdQDfTI8wrAplQuoa1Gty9i1iK6Cqh1FX
 BFsydBZFQFYrxOb62VZpcfDduzy9PUJ+ieW7Fn8qoz/cNTzBZMhTU7zzI
 l6ZC5nEGs4puZjz3bPLkNbUHVWcHYJUb+k88TLY/h5ajGEniAE5rtCZwk
 XlZjQFQMLRefnUde2WVBS7bND+hzDdRJARKBPk0UiUVO0hozwumzAClMo
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ap+fIVDw
Subject: [Intel-wired-lan] [tnguy-next-queue:40GbE 8/39]
 wx_ethtool.c:undefined reference to `ptp_clock_index'
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 40GbE
head:   bb3bb6c92e5719c0f5d7adb9d34db7e76705ac33
commit: ce114069a654be6b1597da983a201c72ceca7a85 [8/39] net: wangxun: Support to get ts info
config: i386-buildonly-randconfig-005-20250222 (https://download.01.org/0day-ci/archive/20250222/202502221412.TDbqnUpd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502221412.TDbqnUpd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502221412.TDbqnUpd-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/net/ethernet/wangxun/libwx/wx_lib.o: in function `wx_clean_tx_irq':
   wx_lib.c:(.text+0x3334): undefined reference to `ptp_schedule_worker'
   ld: drivers/net/ethernet/wangxun/libwx/wx_ethtool.o: in function `wx_get_ts_info':
>> wx_ethtool.c:(.text+0x739): undefined reference to `ptp_clock_index'
   ld: drivers/net/ethernet/wangxun/libwx/wx_ptp.o: in function `wx_ptp_stop':
   wx_ptp.c:(.text+0xaa0): undefined reference to `ptp_clock_unregister'
   ld: drivers/net/ethernet/wangxun/libwx/wx_ptp.o: in function `wx_ptp_init':
   wx_ptp.c:(.text+0x104e): undefined reference to `ptp_clock_register'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LIBWX
   Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PTP_1588_CLOCK_OPTIONAL [=m]
   Selected by [y]:
   - NGBE [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_WANGXUN [=y] && PCI [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
