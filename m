Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB67ECD11C2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 10 Apr 2024 13:59:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F44E40A06;
	Wed, 10 Apr 2024 13:59:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XdooBOnM8YD3; Wed, 10 Apr 2024 13:59:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DE15414CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1712757576;
	bh=tk/F0IBqyYbRLFPOoDWEbPg5Ov57WuF4XGixOoC5Ch0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1qus6EZWupnR8E/7EiolI0kDehVpPGcx+1mrj0h83T00uU7JcQfyKJhUR3SlXiU3a
	 6q257hBukMtZunsShq3Wfyp93VfRguoJJDNJqw7gI+HDrUeQuwEGHz6bO+8Ajyf0De
	 cnw9dKOOE6IQHt9AuaQBzMtp336sPTgkOM66SR8Iy9D/Up43TnjJGqt8rRWXhT/XvU
	 gcoVXOfTb4PxbgCmmXa3kag6WOWFPPKyahkx+R6Sc3ltdlXVlFTK7bVwiZyOaXHOth
	 Rk5zRtK94n/+75/FNdesiLq4il8ODPW9py7ybaL+E/8xxtkaYbYk+MZFcDDUHmxIbj
	 /053vKgpQd/dA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DE15414CE;
	Wed, 10 Apr 2024 13:59:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 2E5DF1BF275
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Apr 2024 13:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19BA760646
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Apr 2024 13:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ylnNmn_MJgHB for <intel-wired-lan@lists.osuosl.org>;
 Wed, 10 Apr 2024 13:59:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 30A43605C3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30A43605C3
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 30A43605C3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Apr 2024 13:59:34 +0000 (UTC)
X-CSE-ConnectionGUID: TwL7cUQaSWC7fBpvfqTrIQ==
X-CSE-MsgGUID: 8xr0kY1kSn23AKxcmEWc8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7993192"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7993192"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2024 06:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433717"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; d="scan'208";a="915433717"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
 by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2024 06:59:28 -0700
Received: from andy by smile with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1ruYU0-000000035Gi-3T2g; Wed, 10 Apr 2024 16:59:24 +0300
Date: Wed, 10 Apr 2024 16:59:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Message-ID: <ZhabPIK_zDJgVf4c@smile.fi.intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-12-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410114828.25581-12-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712757574; x=1744293574;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KzIwAs0WuSRVdxrxETt53ZODVPWPZANummHTPBLM92g=;
 b=L42VrYWgU6IzUNSnkINbQMgH4duX2iZ591pjCnZ80afEty4yJJtjZMie
 s6P0fWcePfbnMleZSFDGdaDnCGB7plOPWl9oB/kN2XOWV6lAHt50KxP2D
 Kt5epZYmAyLYrgtw0DbWfgUp6XYnARBBJqccJjj7LKNmOu1tXPGlsN2YK
 k2Sb2LnnnaY/5g7MACGZu+kcbvPz7ZblOOwzHFWSE49q0ULLpLVhbBbyf
 cdAmSNQbz4vgCSzXTXTVphakAbjEAmp5MzQ9cEOND3c59YgdK5PBNXnU8
 UyWbUs9W/Tz5zDY5jQm43wMn+odkdKPwFcIRwIyFUh7G0An/vG4XKYuFn
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L42VrYWg
Subject: Re: [Intel-wired-lan] [PATCH v6 11/11] ABI: pps: Add ABI
 documentation for Intel TIO
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
Cc: linux-doc@vger.kernel.org, alexandre.torgue@foss.st.com, perex@perex.cz,
 anthony.l.nguyen@intel.com, thejesh.reddy.t.r@intel.com,
 christopher.s.hall@intel.com, corbet@lwn.net, x86@kernel.org,
 joabreu@synopsys.com, peter.hilber@opensynergy.com,
 intel-wired-lan@lists.osuosl.org, subramanian.mohan@intel.com,
 linux-sound@vger.kernel.org, tglx@linutronix.de, giometti@enneenne.com,
 netdev@vger.kernel.org, pandith.n@intel.com, eddie.dong@intel.com,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com, jstultz@google.com,
 davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Apr 10, 2024 at 05:18:28PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver.

...

> +Date:		March 2024
> +KernelVersion	6.9

This boat is already sailed...

-- 
With Best Regards,
Andy Shevchenko


