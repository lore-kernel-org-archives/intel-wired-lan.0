Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B47606A334
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nfQjLzrt;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EE7t+/yV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DFB840467;
	Thu, 29 Oct 2026 23:28:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8c_ofkK9AXkq; Thu, 29 Oct 2026 23:28:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B670403FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793316512;
	b=dB0KlFQerUF+/zgRPLGU/jVLBBeF4XrECYllN5OipHxCVzTcJ0oOJ6TEsdhG82Bj5IyB
	 I4e7IruIpjVtXf77BssWeVK/ZQSt7B6xi2hi1NAWIdQzDLHdKni3jGkTk2cvnoKGfT8XC
	 c2XbdmVcmgDem5vSewCjZivC2tnLawYwWl1QoxCLeYQ0iIu/Ic/PF9jf7M54cLovGvYr/
	 hX4t25CyRsrpTPSHvOl7PdQCD0BpRunUqEhZkov/Kz8RdCTQG5gVyAl0H4HWKLV2OjJ81
	 GOFtB3IWmzTT+bzk/vhphLoxzgAB/wGeoQyLuGT/SJ4ojc5ErPcf7jw3vDNjTNv5XLA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793316512;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Gpn7SZjgFeXUYSeU/S/f3bTQwWe945+YKT9VTSfqIvw=;
	b=mzmxr6TTMSUl0j+jIw2j+l5a73Um7gQJD3FA18DpQu9cfCC944dBo8edVAR1FGJBz2rg
	 GaXUglwh5fIc/i4vL5d0kvKFpOQag/X+U2sru04R7TgKF910ffKvTkEhCn4xpQicH8/SI
	 V2uACc8T3dMgYxs9fgEW/jfyoSzGrEX4KdVlI6BKe4AMG4SlPoQBdsYbaLl1g8dB7pj3x
	 Nx6bbTxJXRRPBiwbiRLdUFVtammoaNOAfRpVFTmlEOJ2n40JPulgpZeJ+lTJqxGEGA/Fn
	 ESTsEbC8FB+UDVVV6ENf1xqVkKOlYYbo9BoaS2auSqgJEEk3d0tpP0TgJqYQ+x5OrbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793316512;
	bh=Gpn7SZjgFeXUYSeU/S/f3bTQwWe945+YKT9VTSfqIvw=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nfQjLzrtwZI6Ki+MiL9vTvfU4PfRe0HDGyVcNA+xAgqj53wtTB7Wf3UmBOECaMWej
	 OrRnd8kIEReh2iV4ZnkGK8ouN2T1JnDp1ReW/EcejbbneRLZyzoVSMebLaVqQo47U2
	 VtSFlwrjHbjiYlPReQ2fQlwKKrqO9ATL7yYwBCC/mJQiAjN3mIFi1DneJdJIxl/lxS
	 8N7+Q2EJ0pGpn4OnPbxayWmw8r+n/AvvANIRPacXnAHzJxjeR4A2Wc3Az1VMJrdk/h
	 UjIsLIWTPY7hQ+ppCkq4U0boe9VxN8AAfgoklOFjubOF8MCO5uKgCjMDBdkyw9jzck
	 ZwBcJLuly/x/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B670403FC;
	Thu, 29 Oct 2026 23:28:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 25733D38
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 23:28:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B30280F4A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 23:28:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8pGbB4tK23MH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 23:28:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC22080F47
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793316508;
 b=D9c74QhLjZ2aofBxPqku0vaJpW0VqHbcgd/dyuRnI2yOMmTesBVqz/w7ofPHzEX7Q24B
 wZ3yCvfx3iNJ7z/VefjfouvLTofxeaFM9IHZ/7MmJ5AcpDFcCEeo4cRBj7tyfvVe4dncP
 Yc4oCnt2tibk1nto2BZtKpMrzO5ziVWZKlFhWnYZbir1BOHCLbm0A9QyB9rTSbmgDuHHQ
 6JoxotOIHJff1k2vQJTSnGzGeBOD+ZiUbqXD0xyUWq3yOCv83O8T1DLwGM4Ty0RttlGGt
 bdG2sX9/64NAm5eiyOhWATEekqXZTirBwd0U13uhuvN9ufgFgs5G/9x50kb4DNqhspA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793316508;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:User-Agent;
 bh=Gpn7SZjgFeXUYSeU/S/f3bTQwWe945+YKT9VTSfqIvw=;
 b=MIgGbrotbQ6hbZbPKxSFYzDIhrUuNZzXN6eHrgm8dmR1cYDLh4eXOF2enOJ8H2N80Wa1
 5Q8PNaysXXAoI2wwcxvtwIcpEtEhf9mjN2GjGhLeVXEZAn5Kjka684/dqzqN7FaN1X2nv
 fMQgtCuo7sOi9qJrx8urm9PBwYeePE1qNTMJ6t7dt0mt7uuOrt2zDc6hztnIa5IpW114v
 o9BeQN0kdnHLYGToQEGru2eVvuXeRLxUxEEmOgba/JGE9qZ20w4Xmch36xQN5zPrfS0il
 1SBqZRt24eb9fK56+1ixjfpgttfAbLhS6nBUvRlo53zgjliXlnKYJrKZoc4KOud9s5w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="EE7t+/yV"; 
 arc=none smtp.remote-ip=192.198.163.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EE7t+/yV
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC22080F47
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 23:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793316509; x=1824852509;
 h=date:from:to:cc:subject:message-id;
 bh=H/6GkqWngU0tBjeCwttQpQ0xwAw18cAjpMIs4G6mTNk=;
 b=EE7t+/yV9M4h6c14ndXFmA8u9zIrvrgOoo6MT01IGgDLY5F42sqi1NY9
 U3pwbrSR+AJnEHICKMXxQeke7nbx9IImc01Rqt2t8yeVWrqe6O9uQAJk1
 Z53q6E+mf1SJcgGbaw5UKSzGl0GpfNyPYtvbZetfoBsnlVq2BEIGsdY9X
 WeiR7gGRVtqN9hzU/rNeBr13kiDpDtvitYMLQG7UOh2k3XkRtle8GWBjr
 HgfOX4iXjirtMOg4w1IJP7xkhLpMSWBhiI5hq0rP01O9/5jr7zIg+V+sl
 hpa7EG2an3UqAbzgWHhWiPvTl43mM2N25+UejvoTX1U/dyHYcZi3XY4Ql Q==;
X-CSE-ConnectionGUID: zqimgEZxRPqR/69QqT5eFw==
X-CSE-MsgGUID: 5hIroyaoQBeaqA/BnoM5jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2079046"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2079046"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 16:28:26 -0700
X-CSE-ConnectionGUID: 29qHAZeqT+a9syeOZ3inDw==
X-CSE-MsgGUID: ifLbYDmRSZuyc2IH6uSUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5636487"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
 by fmviesa006.fm.intel.com with ESMTP; 29 Oct 2026 16:28:25 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMZXi-000000005OZ-3cv7;
 Thu, 29 Oct 2026 23:28:22 +0000
Date: Fri, 30 Oct 2026 00:28:00 +0100
From: kernel test robot <lkp@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [tnguy-net-queue:100GbE_E825_timecounter 14/15]
 drivers/net/ethernet/intel/ice/ice_ptp.c:2366:25: error: use of undeclared
 identifier 'cached_time'
Message-ID: <202610300044.0bHmTu2J-lkp@intel.com>
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
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20261030/202610300044.0bHmTu2J-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261030/202610300044.0bHmTu2J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610300044.0bHmTu2J-lkp@intel.com/

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
