Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B13C53216
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Feb 2026 06:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 863B360E13;
	Fri, 20 Feb 2026 06:18:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2bO7vBtDDtX; Fri, 20 Feb 2026 06:18:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B5A260DD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771568287;
	bh=joGnDsF92DEZgLhTMD5X9K53IOXhhiXH6I19qKpM6fE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=5XQVcV/LWBYtigHtg0+ecr98DeHH/cKDthtPN11TnRndgzZ7NweHzkngKyMzbPqlD
	 eEGswFrWrzQXOzFAznFwY/3t/ZkxrVn9fB+b+3KSpzH0re4lNQnLoA1HR2bJdFIx6K
	 mFNHjvR0py8AxKlwrixKqLtpjAcheSotigFaOAl9zC2YR5W90vQym6vhpT2feARmC0
	 +wvmLTHIGro6N0JWvyhiJNxgy5H/GEUdFRFJ7DFhGQFZBb6dKXC59Zg/b/VUcldxjN
	 nsKdKbDFtpegQ5aNSUYPPXY/Kd/zP4uo80VYiA9hHFzg3zIyZbZ6zxoN2MhJYtDvcz
	 +VgDkPklizfHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B5A260DD7;
	Fri, 20 Feb 2026 06:18:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C2534206
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 06:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF976400CB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 06:18:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFAG6644kB2M for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Feb 2026 06:18:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 044924010A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 044924010A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 044924010A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Feb 2026 06:18:05 +0000 (UTC)
X-CSE-ConnectionGUID: LboRaDnsR7eBj7vWRcwe6g==
X-CSE-MsgGUID: YRxG5zybQd+ApK6oeCX69Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="60236587"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="60236587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 22:18:05 -0800
X-CSE-ConnectionGUID: zpQLEjETQB+EvLNDYDduEQ==
X-CSE-MsgGUID: eg4a2n0bQS641+Y7zSycFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="212918155"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
 by fmviesa006.fm.intel.com with ESMTP; 19 Feb 2026 22:18:01 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1vtJpv-000000013s4-1vP8;
 Fri, 20 Feb 2026 06:17:59 +0000
Date: Fri, 20 Feb 2026 14:17:54 +0800
From: kernel test robot <lkp@intel.com>
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Message-ID: <202602201417.eTuOe57F-lkp@intel.com>
References: <20260219131500.2271897-1-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219131500.2271897-1-poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771568286; x=1803104286;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mZnZx8EnhGB8nR1tC/rsTKQ187O7k8yDgpkPcZK8kHM=;
 b=V4o2cTvxAu8wCZZidkmPRWeOu9C9qvZ3J3zqeUhMWhsT45RxsOPftQJI
 wsRWfaYLRnU4xir2sDv2f4/BFnZ2ZjfBOEXRoF5lY6F4GyL+X9UAEhKmy
 lJArmceobGGwJcjoFYWaa8pwLSfMYV8nlspuNsljRzLSWtDWV1bMbYqzG
 bzOyXglbhC6kB0M8yOdBoMVLyvPkyGKbK0j0DIx60UFMbHQg/iYi4oGGZ
 DGaoEAmhDFdde829Hv9tLGz8Ymn5vF4IJ9KusKqQ/UWKqZ+GuaHhbB99n
 JxQKfFF7d7MMfIfrbByIbr0BzjMtCItXHhSe+ZlW+0VU8y/IhCErfwet4
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V4o2cTvx
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: fix missing dpll
 notification for SW pins
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
Cc: ivecera@redhat.com, piotr.kwapulinski@intel.com,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Eric Dumazet <edumazet@google.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Simon Horman <horms@kernel.org>, oe-kbuild-all@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Petr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-net-queue/dev-queue]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Oros/ice-fix-missing-dpll-notification-for-SW-pins/20260219-211758
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260219131500.2271897-1-poros%40redhat.com
patch subject: [PATCH iwl-net v2] ice: fix missing dpll notification for SW pins
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20260220/202602201417.eTuOe57F-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260220/202602201417.eTuOe57F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602201417.eTuOe57F-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:2625 function parameter 'p' not described in 'ice_dpll_sw_pin_needs_notify'
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:2625 function parameter 'active' not described in 'ice_dpll_sw_pin_needs_notify'
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:2625 function parameter 'old' not described in 'ice_dpll_sw_pin_needs_notify'
>> Warning: drivers/net/ethernet/intel/ice/ice_dpll.c:2625 expecting prototype for ice_dpll_notify_changes(). Prototype was for ice_dpll_sw_pin_needs_notify() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
