Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23312606A324
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=W4NikJdL;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KFEW47jl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFCD9605A9;
	Mon,  2 Nov 2026 20:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpLqKG089cQ1; Mon,  2 Nov 2026 20:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D62636064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793650661;
	b=fnIJNhPNdWw4nSxi0Y5PvF6TqJtyPbI6gbm8c/SrRbZTMeGlXFiarhC5uQg91bmi4txd
	 VU5rP64j8kj9EGKh+7PhD70PQPordgTamsB7vVW4L246teHTx8FxlalbD2kuW9IaHKtRE
	 qmusjinFgbmNUOtfXppJ4NVJ+i9bb1SCNa0FMQxE6dWXaer/hlQAUQSjj9o3QrUGlAUMR
	 e2QO9eLaQhVULDNutvCqN3w0LY2zNc+APwquZggoI1/hIBxdgzXXx1R94tfVYsHW3kXZC
	 YigaeZZ0g7PqemxCRMOti8Kt+GMR4UU4yWxDkW5KC9I9k0AL6S6zyl6tLH/AZgCxCCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793650661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=LMykdtl+jzPkxeZK/vmMQGLshAinqEpw2vELglAbqd0=;
	b=rQ8EyE/XpQgPngMvZ+m7fSVK/jnvUMSRjKJSTee93zB07cfZuhjrR0zvFr6jflTQcfBB
	 ZWSO0AWhNK4VEOSdnVVJExIi8F4ZAU8TY3CryVXh02lmihX82ChOy2G1VZVsyMANV3s71
	 WO0yCqRTxW6rQaQao3Y6eV8rXBM2SPDDQq6LKEZmsNipZLOoMUqqC2Jfq019/SCQiMk5D
	 0qjbzo4FPY7FtLqR2nBBltUPmkt7dcaEtoqHfFPjVgMwO9Z1L5QnDlc7sLnzutcSEjbkd
	 Ap0kt0/Ve0G+fTyjDO9BdJ+q7zfVYA6dpiJ0UofB82e4MTrUF0qSVWj60wJzLhwx6QQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793650661;
	bh=LMykdtl+jzPkxeZK/vmMQGLshAinqEpw2vELglAbqd0=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W4NikJdLTYAHZKa1YPr4PIb17uPVQl5uLVpvj/NVm5i6hvexK0rBXIBZTsUaWFJKm
	 McvRqFkoRqq2rhsC12qxCxNNJM0q8irBEbD/EpGEe808AItOa3t2wIk2i/8DNQe+co
	 FSYiLbVn1U/1ePX4hrjvYEbkq53V+cil3FZx4hVcyMKRFH2NekGbEspFGDnohwwpV1
	 o0xOplUDyO1ebMlcPhUh6m1HL/o4+FeBGUEZ9qWsiwojCpyS3WRNEn609kTyIcfOPD
	 TWUI+PhNkS4IeTW6M/HPzPFz3i0INwD75Qps/fKEVSkJBgV9Mz4r0dDmE6QeEbM3Pb
	 MuKmtkzsVCqsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D62636064F;
	Mon,  2 Nov 2026 20:17:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C9BC323
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 20:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EDC080CA6
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 20:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VLWsp73LJaP3 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Nov 2026 20:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1309380C9F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793650659;
 b=o6cxha6Ar1XR3u9HbLIAlkEH/+hAGm2p0FOEBA3WRf4admDhH/oaDRyGS7WJg60wC3bY
 b5cSuDNCbOWkJSmj3x8KImrTzUX5Qo4uSLTPy+xiv98nGGFWqyFjvLy8nYAyvG2CsGqp4
 QRplKHwuPVJ9753/ZYViuwNhHXFeAF91ZtLaJ84aL9ZjvytYrr250Q1ifmxplyt6d8mBz
 2F1qih1PQtYwSmXpU3c5bJu6D4GQH+VS9+FbFs0tbixnefyWagl+xtEu9WvzZECKicZ7d
 vcixdNlTPwyMzlUjwT/qBKBF+MubRdAFboXO9hqf8lbNniJUVj2/vqshlHPxfqz+8Gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793650659;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:User-Agent;
 bh=LMykdtl+jzPkxeZK/vmMQGLshAinqEpw2vELglAbqd0=;
 b=VilMVOBcGi4kM2bYoXI9QbFWqqxKOLv5CaBxQpVvD6eVuh4GCSaewvAJD28EzsDScaN8
 F5t9nDQ+6Qo9Nj6AERaqTwFnNgu4SpFFtxQUvHfJVFtjiZnY7G69x2OpB2iFdcLmxl8jQ
 ujjoWM57lAccd87HKB6zhy2RFule7W/k6aWbII6LfyTKCN6GDj0PJHhRAhpVCiJqQH33G
 FnpXGZt7YGY/0tiI030Vfh1DhZrjb9+aTAmSpiKxtwO9XvxVbYLqQZ32URLN0hMquHE9X
 yVZCOy8UPZ0aAE5VnXkFysIVJZsOmYFkQlIC0d8Nl3cqZ4OTN+g4hKZGmHl2JJVQOLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KFEW47jl; 
 arc=none smtp.remote-ip=192.198.163.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KFEW47jl
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1309380C9F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Nov 2026 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793650660; x=1825186660;
 h=date:from:to:cc:subject:message-id;
 bh=VO5kXN1UpIKDPgwcHNFlcsTNNVynZ5BBNVPhZFESZ34=;
 b=KFEW47jlJc43La4ge3ZUAYM+31hE8mnY63KCJfqEW8E7g/Bu5+wMgH/7
 WkMCFo2FOR8AQAT7XcHzyTekPOscC8BTw4EmDZJFDsPJzSur+P/yJUV6r
 wykBMSV+wa7h7XlUlly9Ah4rOj1HQ+/geblr65pcNad7zvtwhaDejQZVZ
 mI0gArxJGh2cpFf3PDwV/euJ/xBWhwM6YbjhckFgr91bc3F7rWPCLwLIf
 RDuEAFGhrgP72Yi0X9qyknYNDjtvTmFeHsQbDx98UIKzTyYXl3TsAKsS2
 KV+XNouP8RGvzYNWUg88ZmuFW1zoQ7zjG24POjoKpi9eFkMOZ8d6QlE2v A==;
X-CSE-ConnectionGUID: 0wLloFUoQM6Q1naVuM0TKQ==
X-CSE-MsgGUID: Alnibu1tSVKV/dxVdKFxRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464253"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464253"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 12:17:39 -0800
X-CSE-ConnectionGUID: CrMwXY80QLqS+1152fkJaA==
X-CSE-MsgGUID: Dm428blRR7KPvcVG6RAJdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6093907"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by orviesa003.jf.intel.com with ESMTP; 02 Nov 2026 12:17:36 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xNyTG-00000000hmY-0hgb;
 Mon, 02 Nov 2026 20:17:34 +0000
Date: Tue, 03 Nov 2026 04:17:31 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [tnguy-net-queue:100GbE_E825_timecounter 14/15]
 drivers/net/ethernet/intel/ice/ice_ptp.c:2366:32: error: 'cached_time'
 undeclared; did you mean 'cache_type'?
Message-ID: <202611030449.DS9rrSFF-lkp@intel.com>
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
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20261103/202611030449.DS9rrSFF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611030449.DS9rrSFF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611030449.DS9rrSFF-lkp@intel.com/

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
