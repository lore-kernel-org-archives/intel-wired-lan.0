Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4589606A31A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=rjaNHRN5;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e8r+KHg7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0E6B40A80;
	Thu, 29 Oct 2026 22:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iXNhoxnaj0tx; Thu, 29 Oct 2026 22:26:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8B9740A8F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793312784;
	b=NxFB3G8KYpUrusZ7/BqnR38PNCWIOXoC900qSx/zlDm46x/DcwTtsrIdJDMpOcCSQSIG
	 L9rdw2gr1Qru1iDlCorfsUaQC+AfQ8jUb+PwesapYwFXBYH13jwHB4prUqq0iV6itTqvW
	 nQ/RNiB14IEx0qoVo4rYpjvM1DfeyCo25neq8g6xrQIOUS/q/WpsdKX6FLMWkvzqHHn/9
	 u3gTjkYCLhwnHEV10LGDQz0t5bTzBzvgUTrOf6cLT62eum8xNLurdYojaII1sJIibMkzO
	 daKgPDYmkZLG603JaYeLGukuQeCACXg/EwAiWNnRBm+n7NNbnbjzgD3x5trEsF4aEpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793312784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fygEecCJCUJgrLJtcWLuFisD6JsaK+3YiuYOhOVjvXo=;
	b=aufPETaC8ziK41sZtl4YWQHG17SKdsQbISh+IsLmCspFExutoSGuuV8mx6qVzXoND7HT
	 +1rhSgZbNN5nv9q1aiTCS+OQ0riesRYZ5e4/DHYPKdVYzvF+AkP5lIA2tCyBYVrXrGqlQ
	 SC+GNTpnu/2F7NxNOTus0Uibwfzn1gJIEu7b8lC9n7tIjbNeY5dkypbYuZsCfqIQFZRdi
	 9I6ZVP7RNi/k7KgjbHsXp3TaOX/5HmcN7yNGotwsa/EYROeI3qgmtFVnZfIYPTwSWq6o7
	 EOx9lzLDXxIM6+/xm4PFcuPyW4C/2kreb+t/WVEXE+h3MFHKUrCjV5BvYMLbvPzmUQg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793312784;
	bh=fygEecCJCUJgrLJtcWLuFisD6JsaK+3YiuYOhOVjvXo=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rjaNHRN56APjGkqqp6hKVwFK1ASUp3hx4BnjPLOOSbrZjSq4M8ZwP2hu0Efvaej+t
	 Zqp0qs5VlGuuVv46jaH6wihYxzFvoxNBbfnN6A6v/JGe17HdY4Zy3fOc5RdZl5vPjb
	 2mpOHL/HfqCnw+JxY/QeznMy4gqmgR7M+KpTGtI5v2s+d7IOq+85Hytbm6UsEwRyKk
	 6nOanDJzuLDqftiPDLe7D/BowJXxaE2SNK4dIcMWf7KXf1byDJlAyZIRZ8UQdRDDiK
	 7x1oqycB8pZMLZpElY2gJKiE8d4D6SkXK/hw0kgnQ4e5IYEISZD/+kuAxS30nFs4v0
	 5Cm3S3rGahxeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8B9740A8F;
	Thu, 29 Oct 2026 22:26:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 359831DE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 22:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B5F360A79
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 22:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VmiHAUrNjP4s for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 22:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 13A18605D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793312783;
 b=fGJD2mCqN0PSF0ZdTZ0CVUH/yFWNsgMgot6ysVi8nnCp16fWrdy9aHNU3Kx0VPlwAn6X
 CbsVLJU4+TCG5MhvURSAU02CyvvRjdlSmmTTfY6EhuIL8y+T8fmlzMv4OiBO7bVMq0hUk
 7yKgvnta0THNNFCP0XR3ph6u9jKnWpLqMx6hseMmbNRevJYbwSOrDVJTAtGZ2eq94FfkF
 1tIDDE9zn6B5rZY9rx3aFsdvIN4eqXD0ks6q3CeA/TUJA/P/md2Y0lsXjfbwEOcfIq3Rf
 dftwXDe9C0gv4vUtXVOK4mNrkhEkuG6z1A3OshmteAdPXl/UkV1rpGaqr6lGUAqIybQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793312783;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:User-Agent;
 bh=fygEecCJCUJgrLJtcWLuFisD6JsaK+3YiuYOhOVjvXo=;
 b=nWUGm6HGgHhid9d9r1rinaMuQouDFDavEQL3xa27rZCicC0PwZhh7jrZJYss04OAqw8w
 3yWmeuthYQn7giSdpQq4G1P3UaOvRQY+Vha1tb+kzpEO0tFb6IDsOr/5AoiOU/0W/o5Hr
 Xe2sGq6JuuMesleEi4Tgs2YDKeN26GPDAQeorPso/JqLm+0A04uD6oiJUdcto9umET4ZR
 SQ58jXEjpPYwMC6MRh1+PP6UJiN9hFofy/JTl1AgLHbERdvFd5NelPVPUIFmSfclGuptm
 IQHnoAVxqjs7vAzD/m9Uxi3Tny2x5ev2Z1rsfYk9BzYRhYNiH6jNbaIC533qcO8+DlA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=e8r+KHg7; 
 arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e8r+KHg7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13A18605D2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 22:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793312784; x=1824848784;
 h=date:from:to:cc:subject:message-id;
 bh=GGqzMNCH+nPu6Hm4Mvq5YP89VmRaQ0MA/5ZdzrPbKpY=;
 b=e8r+KHg7lxtOWRR2heTG9SsT+ichcwlmpisZh45P8WR1pNeF3TAWlaZL
 8LJvWBfy9KSUzsyMx2VHHuzzP1XkDST4eZr8IQDw0tkSJjTOXi4kwKg3L
 SVnmTk9vemYbaRYy5UhFEsF2JlO7JTpTlp78zU+M4o4Kb53wW94TuVQ08
 hN2zeOK86QQA4/1QOiUJUZk4yQLArgB6ACqyD1TuYsl0HNkLKDpYBezvk
 kbiKPNvw/37ClnbZyszqLXlx+9mEfWxFoJdGR4kkTkW+4fZmrQ2Eep9as
 OVg3Ecfim+nuUE6080ZM7OIE3bwb7HQhHuIts7IVdvuDJkMohllDZKKqx w==;
X-CSE-ConnectionGUID: KUoBLh4mSe6IrhxESxwQRQ==
X-CSE-MsgGUID: Wv3s54mlRBeP0bG/2ClZmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2095840"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2095840"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 15:26:22 -0700
X-CSE-ConnectionGUID: dvnq/JJzRLaDcMQuwa1Zfg==
X-CSE-MsgGUID: MtyI1TEYSS2hGrCY2FtkHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5231210"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
 by orviesa001.jf.intel.com with ESMTP; 29 Oct 2026 15:26:20 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMYZd-000000005MR-2v5X;
 Thu, 29 Oct 2026 22:26:17 +0000
Date: Thu, 29 Oct 2026 23:25:51 +0100
From: kernel test robot <lkp@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [tnguy-net-queue:100GbE_E825_timecounter 14/15]
 drivers/net/ethernet/intel/ice/ice_ptp.c:2366:32: error: 'cached_time'
 undeclared; did you mean 'cache_type'?
Message-ID: <202610292344.LN4xt1gu-lkp@intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE_E825_timecounter
head:   3f3ca43bb77f800814e88fc923238ad0a122d79f
commit: a1bbd79fcdadf25fd90973f46fe35f9461d04a8c [14/15] ice: store cached PHC time in ice_adapter
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261029/202610292344.LN4xt1gu-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261029/202610292344.LN4xt1gu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610292344.LN4xt1gu-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/ice/ice_ptp.c:9:
   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_get_rx_hwts':
>> drivers/net/ethernet/intel/ice/ice_ptp.c:2366:32: error: 'cached_time' undeclared (first use in this function); did you mean 'cache_type'?
    2366 |         ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
         |                                ^~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_trace.h:49:67: note: in definition of macro 'ice_trace'
      49 | #define ice_trace(trace_name, args...) ICE_TRACE_NAME(trace_name)(args)
         |                                                                   ^~~~
   drivers/net/ethernet/intel/ice/ice_ptp.c:2366:32: note: each undeclared identifier is reported only once for each function it appears in
    2366 |         ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
         |                                ^~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_trace.h:49:67: note: in definition of macro 'ice_trace'
      49 | #define ice_trace(trace_name, args...) ICE_TRACE_NAME(trace_name)(args)
         |                                                                   ^~~~


vim +2366 drivers/net/ethernet/intel/ice/ice_ptp.c

77a781155a65905 Jacob Keller     2021-06-09  2340  
77a781155a65905 Jacob Keller     2021-06-09  2341  /**
3310aad20defb96 Larysa Zaremba   2023-12-05  2342   * ice_ptp_get_rx_hwts - Get packet Rx timestamp in ns
77a781155a65905 Jacob Keller     2021-06-09  2343   * @rx_desc: Receive descriptor
9031d5f491b9571 Larysa Zaremba   2023-12-05  2344   * @pkt_ctx: Packet context to get the cached time
77a781155a65905 Jacob Keller     2021-06-09  2345   *
77a781155a65905 Jacob Keller     2021-06-09  2346   * The driver receives a notification in the receive descriptor with timestamp.
77a781155a65905 Jacob Keller     2021-06-09  2347   */
3310aad20defb96 Larysa Zaremba   2023-12-05  2348  u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
9031d5f491b9571 Larysa Zaremba   2023-12-05  2349  			const struct ice_pkt_ctx *pkt_ctx)
77a781155a65905 Jacob Keller     2021-06-09  2350  {
77a781155a65905 Jacob Keller     2021-06-09  2351  	u32 ts_high;
a1bbd79fcdadf25 Jacob Keller     2026-10-21  2352  	u64 ts_ns;
77a781155a65905 Jacob Keller     2021-06-09  2353  
b1a582e64bf2229 Jacob Keller     2022-07-27  2354  	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
3310aad20defb96 Larysa Zaremba   2023-12-05  2355  		return 0;
b1a582e64bf2229 Jacob Keller     2022-07-27  2356  
b1a582e64bf2229 Jacob Keller     2022-07-27  2357  	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
b1a582e64bf2229 Jacob Keller     2022-07-27  2358  	 * PHC value, rather than accessing the PF. This also allows us to
b1a582e64bf2229 Jacob Keller     2022-07-27  2359  	 * simply pass the upper 32bits of nanoseconds directly. Calling
b1a582e64bf2229 Jacob Keller     2022-07-27  2360  	 * ice_ptp_extend_40b_ts is unnecessary as it would just discard these
b1a582e64bf2229 Jacob Keller     2022-07-27  2361  	 * bits itself.
77a781155a65905 Jacob Keller     2021-06-09  2362  	 */
77a781155a65905 Jacob Keller     2021-06-09  2363  	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
a1bbd79fcdadf25 Jacob Keller     2026-10-21  2364  	ts_ns = ice_ptp_extend_32b_ts(pkt_ctx->phc, ts_high);
77a781155a65905 Jacob Keller     2021-06-09  2365  
5443362bae71a77 Przemyslaw Korba 2026-05-11 @2366  	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
5443362bae71a77 Przemyslaw Korba 2026-05-11  2367  
3310aad20defb96 Larysa Zaremba   2023-12-05  2368  	return ts_ns;
77a781155a65905 Jacob Keller     2021-06-09  2369  }
77a781155a65905 Jacob Keller     2021-06-09  2370  

:::::: The code at line 2366 was first introduced by commit
:::::: 5443362bae71a77a7bf37467cef3be608ce32783 ice: add rx timestamp tracepoint for debugging

:::::: TO: Przemyslaw Korba <przemyslaw.korba@intel.com>
:::::: CC: Tony Nguyen <anthony.l.nguyen@intel.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
