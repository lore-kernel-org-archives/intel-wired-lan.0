Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FECC35274
	for <intel-wired-lan@archiver.kernel.org>; Thu, 21 Dec 2023 16:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0151B437FA;
	Thu, 21 Dec 2023 16:27:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0151B437FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703176047;
	bh=HhNzKyJ7Yy067HsyD4EXhrCZNhDTE/LnEE51/ZVPeGY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JsoqVzuwhogBzzMeYS+CGQTwQB0p9QrypGiyb1jr56XTQxHlZtHwwU7QLKPoTFu5o
	 DvOcQimr/dhQeFkYSxLBVATMExCBlkNCTZDengsetNr11kBTV8znIKIiuB/iQI9XnF
	 1vrfzUVqPX+4BOOxYkQTDeVUXMCezPBp8QEFmiLfI7qe+kh58nCSCHpQzhZBTPsqoe
	 rJNaHuzNplEo7I1HT3GO63dyWEF9aj4cnO82X1nJ5CQGShRbdmBhrIhXGlGiATK5Rj
	 GhLXXvAgfoiR/utlRawVLKdphGyE99ukvRxPHb/zGbn2bafN7CkhmpW6gWVE+1Jwpy
	 tqkyQ7fW98rKg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zUmvnq-43_Ql; Thu, 21 Dec 2023 16:27:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE3FE4353C;
	Thu, 21 Dec 2023 16:27:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE3FE4353C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 966C61BF33F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 16:27:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6DE26610B9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 16:27:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DE26610B9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yc6PnUyHmTag for <intel-wired-lan@lists.osuosl.org>;
 Thu, 21 Dec 2023 16:27:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B966660B3D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 21 Dec 2023 16:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B966660B3D
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="393163078"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="393163078"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 08:27:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726475781"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="726475781"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 08:27:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1rGLtA-00000007tUq-1eGT; Thu, 21 Dec 2023 18:27:12 +0200
Date: Thu, 21 Dec 2023 18:27:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Message-ID: <ZYRnYJ0ljsvzWLXI@smile.fi.intel.com>
References: <20231221093254.9599-1-lakshmi.sowjanya.d@intel.com>
 <20231221093254.9599-11-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231221093254.9599-11-lakshmi.sowjanya.d@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703176043; x=1734712043;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Gtx3hXaYOEPt95H7RVRIGbgG0vy7IRlF6DZK8ggX4l0=;
 b=TQtiZor2LKBVJ2PgpELmkKJmatCqql9A5FgYEIeMNFXzd1PlLJIdqXSh
 VZds9EmCvgKIAkPBjPV+jFUI19lGHeeINYkdyKAFHvQ7w40eNGELnW2qV
 Yb+fKFoEzhk3PQPANToLw3kDQyZfdYxTxHutOgRw6Ho+kI2FgoPfpetTI
 17slEMWmhBh3KEcFoa+Kj55EC9LFs1jtqQR8Uxwxs5OUJ3UDe4LtHrnph
 o7Hq+biZmVVmCZwUonVgthxJ1Uq1Qpvlixgte4lCbNe++dwYQdgjeR4Yg
 dl6Lztc1eVRtoPm2mMspjKloT/S0KP1A2Gwfq/wesJvl9NxDo2E0aCRAE
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TQtiZor2
Subject: Re: [Intel-wired-lan] [RFC PATCH v2 10/10] ABI: pps: Add ABI
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
Cc: linux-doc@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
 alexandre.torgue@foss.st.com, perex@perex.cz, anthony.l.nguyen@intel.com,
 thejesh.reddy.t.r@intel.com, christopher.s.hall@intel.com, corbet@lwn.net,
 x86@kernel.org, jesse.brandeburg@intel.com, joabreu@synopsys.com,
 intel-wired-lan@lists.osuosl.org, linux-sound@vger.kernel.org,
 tglx@linutronix.de, giometti@enneenne.com, netdev@vger.kernel.org,
 pandith.n@intel.com, eddie.dong@intel.com, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, jstultz@google.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Dec 21, 2023 at 03:02:54PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver

...

> +Date:		January 2024
> +KernelVersion	6.8

No way, use next one.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
