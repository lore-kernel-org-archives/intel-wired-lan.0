Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5418606A329
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 21:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=QH9nMt8w;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FnLHSkGG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CF154052D;
	Mon,  2 Nov 2026 21:48:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zcJaYW3ynmYu; Mon,  2 Nov 2026 21:48:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F7B040525
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793656083;
	b=jWVB+05MvW4AG0IoYFzLj/utAJuZaXocHtG/nuuSQSkeeYA64W0qh/lrMdHjZjoyKxl+
	 U6dUSeqgfgL97eMTDXR4jx44TooYbbsJcYF8gN4FZo+mvdwKPdxeU/xFsaFNmK+dDLYsV
	 ot87SlkVUaBrMcQUVWX0KmEeO8SoGVuJFGJx5yJAC8bA2sz5vwtcwlDlT1+bpT1CKwJED
	 SmoW+80rGToLJo7r2ey4i+plNtnfec94qb55CEgj6D6sVbp164dehaiPhdZoR6NzmCLP3
	 M+mtG+KRqibvBbh7VlklwNqxEunWa8q5WYVV4NQk0Ur5oEi6X8a/MqfSs51Ic3kH+Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793656083;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Ecjrezbkx2gTMoUuT1bcQl4GYo4kQcGWUul21B9Xg94=;
	b=mfY0y3JJmubMCOiOs/xdAbaOWwVqbcylynqMY/MN/T7/nUjWsUMWNRIxgZDExbHOALS+
	 4l91Xg4/WW22UtxLbmMzr1MkOgmsXFt0L/f2cN7ovyyfp0YxLdJQxPIokiMvz11uQ9Irn
	 krT9Cw/1K8maaotde9Pejw0KkHq1BVKafFZ8oOBOC2DEX5lEcLQ921E019K0XIRvoq4yp
	 zHHwIQRFNqxeiLjLtC++RaZbKyQGTvI/Xtz4CMGr0+ok0nJT1Z7SrHXHm4GSFEZgT2J01
	 WEkt1qsWmaCJyCulh6Q+oLTDFebKM1dQ2e9DgRVGc8GZAktBG8TRvlfqwBBVIwQ045A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FnLHSkGG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793656083;
	bh=Ecjrezbkx2gTMoUuT1bcQl4GYo4kQcGWUul21B9Xg94=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QH9nMt8wumah/vh/B2y5CakOXeMiKYXbVgI3KtQMq9Hg/gJsvyAe+elMo/YonJmSe
	 Gsp3aN0CYJSXBfHCYIu7v+1aac1zBADfoBRYqB5QrKt7y/9G4gWmRAtAzsY5hVmOIO
	 mzjIF6u4toRy9WEER3ZXMNfcbNepGaODShJNx1vF0wYY4sygBuVcVYRkcZ2i+h4gyU
	 KfBb7wbkeo8INR3IKYs/LW3nqdZvs01Ymd/InrOxPjcfwTvGb0l6olKJCgCvZ7IWrc
	 7j1cH3lXQxVGix2fRzouELBiyXRjcCX/9Xh5Ea1Lm6DC4dzdqncy4WDz97eCeCuD9y
	 MxelGRJx7PWyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F7B040525;
	Mon,  2 Nov 2026 21:48:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F6B74BC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 24DAE40531
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CR9aeK4MiWJ2 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 21:48:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2F3640525
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793656081;
 b=Cxfx942C6qWbRMHgFgJfB4ppvmQb7ZSXIZ79EQtyOZw5GlmjNUcyn0djMXFzj3LVVQM8
 +FZHTwReJbMLZ/ep5RnA3SGUuJwVIhBGqzRMS4oLCRgv5MRHa3fF71d5rBPmrmHeJkHzL
 2MI3y4XFiK6n/S8Tfi18vvqvV0vm6eJdqT4PpeEUpRW6zt4jUo1RNaLsiAdVxH0KPuUlE
 NNgfJTi1M16ImG36MNtPGiYg66O7EDu1UT0rPQ5tEPJFHGk1JcnrmElWdtwxdjt6al+g9
 qcR20loXEkeHMoJfqiBK0pFqjA+zsshKRHO9+nKecCUmyVqgmLDLsLPNby5QWeNhk1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793656081;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:User-Agent;
 bh=Ecjrezbkx2gTMoUuT1bcQl4GYo4kQcGWUul21B9Xg94=;
 b=CwJdp2uNy/Ib777bzots9kTsDoazglRfRB+OSuEYYXH3ZpM86x2FIIq05vj/0vO7FQmt
 F5ivFmJQSKNIf/WWZq89rqTUwG8zoi/YSKs1+Dnp+iSUi6S93yEtMFXrdVMPFMJl651ij
 fEzcj4p8mHszOPhQxm7aX0NNOUROujEKagoZi8BF2SX7YslNe4VEvcALPrnkLzIppwHZr
 +1XgJXz7+ut19DGghdmGabRwrr3CwbyYiHrD48JzukeIcfJxU2Qq3pdhvljvzi43y60MH
 xiHYl4LQRd6IKmhVKFKPd7OSF5e0vNEKhESjTO6ZnHD9CO8vkwQIcIyNqwt8lDkpE/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FnLHSkGG; 
 arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FnLHSkGG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E2F3640525
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 21:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793656081; x=1825192081;
 h=date:from:to:cc:subject:message-id;
 bh=o8NtNmpEkzUgx72kGOTosC4boGIc4J4wMruvggU2jHY=;
 b=FnLHSkGGSAV+8yvF/u0Fyj4hMTa92EDDnjXWECgi6SiZAN372higvjZk
 mFu24YfOhZxGZQWuDV6PqLqqJOrjkxnKVnPe5e9ZTqeCpCfrxgDR8u+A6
 ZuswRk4+HcPt0cG70s6a158qrduKs+mQSsCOJHsB9kPbXtFnZUzbyOnW6
 uZT0+rnoWKCfmyJuB/JJPgZl9DWGdmiv+V5qvF6dgo4QNn+3NVS78X4MF
 KPDhngtgj+5ARt4e5ALtiDlLYCv5wcZjXxozfpICEOIYxyR2KV1Yiihi6
 ygPSWfe7dMUwiFj2c3jG7uDIvg+hFnbHNdeeQriklxQbgk1TrDAB4GgU+ g==;
X-CSE-ConnectionGUID: BKcT6WGwQ+amDswrQIxlWQ==
X-CSE-MsgGUID: vm0mEFyPRCKFaWSBlaYEZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2373259"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2373259"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 13:47:59 -0800
X-CSE-ConnectionGUID: 7NTgG3MxQHaDQ6dQRrpCXw==
X-CSE-MsgGUID: 8lenz+oOTfG6SnlMdGGZIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="8069523"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 13:47:57 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xNzsg-00000000htR-15Pe;
 Mon, 02 Nov 2026 21:47:54 +0000
Date: Tue, 03 Nov 2026 05:47:15 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [tnguy-net-queue:100GbE_E825_timecounter 14/15]
 drivers/net/ethernet/intel/ice/ice_ptp.c:2366:25: error: use of undeclared
 identifier 'cached_time'
Message-ID: <202611030534.V72bnxj4-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE_E825_timecounter
head:   3f3ca43bb77f800814e88fc923238ad0a122d79f
commit: a1bbd79fcdadf25fd90973f46fe35f9461d04a8c [14/15] ice: store cached PHC time in ice_adapter
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20261103/202611030534.V72bnxj4-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 65303e81f481bbfe386b8596423f94c43198ba94)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030534.V72bnxj4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030534.V72bnxj4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_ptp.c:2366:25: error: use of undeclared identifier 'cached_time'
    2366 |         ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
         |                                ^~~~~~~~~~~
   1 error generated.


vim +/cached_time +2366 drivers/net/ethernet/intel/ice/ice_ptp.c

77a781155a6590 Jacob Keller     2021-06-09  2340  
77a781155a6590 Jacob Keller     2021-06-09  2341  /**
3310aad20defb9 Larysa Zaremba   2023-12-05  2342   * ice_ptp_get_rx_hwts - Get packet Rx timestamp in ns
77a781155a6590 Jacob Keller     2021-06-09  2343   * @rx_desc: Receive descriptor
9031d5f491b957 Larysa Zaremba   2023-12-05  2344   * @pkt_ctx: Packet context to get the cached time
77a781155a6590 Jacob Keller     2021-06-09  2345   *
77a781155a6590 Jacob Keller     2021-06-09  2346   * The driver receives a notification in the receive descriptor with timestamp.
77a781155a6590 Jacob Keller     2021-06-09  2347   */
3310aad20defb9 Larysa Zaremba   2023-12-05  2348  u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
9031d5f491b957 Larysa Zaremba   2023-12-05  2349  			const struct ice_pkt_ctx *pkt_ctx)
77a781155a6590 Jacob Keller     2021-06-09  2350  {
77a781155a6590 Jacob Keller     2021-06-09  2351  	u32 ts_high;
a1bbd79fcdadf2 Jacob Keller     2026-10-21  2352  	u64 ts_ns;
77a781155a6590 Jacob Keller     2021-06-09  2353  
b1a582e64bf222 Jacob Keller     2022-07-27  2354  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
3310aad20defb9 Larysa Zaremba   2023-12-05  2355  		return 0;
b1a582e64bf222 Jacob Keller     2022-07-27  2356  
b1a582e64bf222 Jacob Keller     2022-07-27  2357  	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
b1a582e64bf222 Jacob Keller     2022-07-27  2358  	 * PHC value, rather than accessing the PF. This also allows us to
b1a582e64bf222 Jacob Keller     2022-07-27  2359  	 * simply pass the upper 32bits of nanoseconds directly. Calling
b1a582e64bf222 Jacob Keller     2022-07-27  2360  	 * ice_ptp_extend_40b_ts is unnecessary as it would just discard these
b1a582e64bf222 Jacob Keller     2022-07-27  2361  	 * bits itself.
77a781155a6590 Jacob Keller     2021-06-09  2362  	 */
77a781155a6590 Jacob Keller     2021-06-09  2363  	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
a1bbd79fcdadf2 Jacob Keller     2026-10-21  2364  	ts_ns = ice_ptp_extend_32b_ts(pkt_ctx->phc, ts_high);
77a781155a6590 Jacob Keller     2021-06-09  2365  
5443362bae71a7 Przemyslaw Korba 2026-05-11 @2366  	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
5443362bae71a7 Przemyslaw Korba 2026-05-11  2367  
3310aad20defb9 Larysa Zaremba   2023-12-05  2368  	return ts_ns;
77a781155a6590 Jacob Keller     2021-06-09  2369  }
77a781155a6590 Jacob Keller     2021-06-09  2370  

:::::: The code at line 2366 was first introduced by commit
:::::: 5443362bae71a77a7bf37467cef3be608ce32783 ice: add rx timestamp tracepoint for debugging

:::::: TO: Przemyslaw Korba <przemyslaw.korba@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
