Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12F9C25B10
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 May 2024 11:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E6FF83503;
	Mon, 13 May 2024 11:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8cHTFfFdc_Th; Mon, 13 May 2024 11:20:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D89983103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715599224;
	bh=xnmIFBXcdpdt+cLQdDsaNKH1oSUW4QqSa8m/WqOVhho=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=CDNPuTxi4FXShQK6jOh8jQ30+VsE2EJ3texHDoj3/J5khgmDti8N/bmXQnXMWURud
	 xB3fZB8GyiaH3no+gp5NLVaAKMgXDhcFFogvmYSy3SZ78UYrKjBMks46U/moblv7r6
	 JMoBOkBNTCi4Emn9/WMLQSTg7zh0Yx3TcGvR3+aqmUNCY+OytC0CaocKPncdJSVG8j
	 qkEf4MC/m546oxOcJOEy7axfSzyjs2M6+LlfEVfJEYwb3SkoiaOfo8226hpOSxahPL
	 TZ0LSdSVp2eQSSf4YsidoMJLbHCer3H2fi7auMbu25vQsx/9HvyEClXA1F3/hU5yeb
	 Qi7fyWy2tTL2w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D89983103;
	Mon, 13 May 2024 11:20:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 6BEEA1BF479
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 May 2024 11:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57CBB608E9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 May 2024 11:20:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6vp_t6RdQPb for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 May 2024 11:20:20 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 102A660698
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 102A660698
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 102A660698
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 May 2024 11:20:19 +0000 (UTC)
X-CSE-ConnectionGUID: qSFRMgIpSiugnEmeHtN85g==
X-CSE-MsgGUID: pzOe1NleQlm7B4+onOqqxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11688040"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="11688040"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 04:20:19 -0700
X-CSE-ConnectionGUID: J/4b2f0ARZOReGHXD88oMA==
X-CSE-MsgGUID: AtogBFklRTOPGTXqvev16A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="35067355"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 04:20:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1s6Tj0-000000076o9-0ukO; Mon, 13 May 2024 14:20:10 +0300
Date: Mon, 13 May 2024 14:20:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: lakshmi.sowjanya.d@intel.com
Message-ID: <ZkH3aUDaFMR-8Mlo@smile.fi.intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
 <20240513103813.5666-11-lakshmi.sowjanya.d@intel.com>
 <ZkH3GP2b9WTz9W3W@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkH3GP2b9WTz9W3W@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715599220; x=1747135220;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=RH4wkxhYNMrJGXF3Af+Oo/w1xDf5vFVpf71RPqH/jJ4=;
 b=N64xO3GZ3owZy6uMOVYjpGhIL9x/eKQYJI/60d8DvjDXnxf3rcV055q6
 mTixYGtHjQ1BXYEKxS/Y8GXbakDqvsMzKCOmyWpFhO6OgU7w7YyyVvgkq
 +2m0O2ZfLHhA0JPnzXrGXXlALW0smIOu0sR0Vm0mDNVs0I15a5XiJb8sI
 q0tXH/vbW1CrY1Xr3Kb2Q569y6J9P1KKfSszpJPBycCN/L3J8zca745B1
 tn0p1U5TQuE02TDEoyP8ZYj4d4IBibJfZGsHZOjJdQqguv/qPIA5h65VV
 DYffnE0e6W9o65/H7KEbw0MDuJuLkpRm30ykkt9QMp4jhDIC2tQhvdaH2
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=N64xO3GZ
Subject: Re: [Intel-wired-lan] [PATCH v8 10/12] pps: generators: Add PPS
 Generator TIO Driver
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

On Mon, May 13, 2024 at 02:18:49PM +0300, Andy Shevchenko wrote:
> On Mon, May 13, 2024 at 04:08:11PM +0530, lakshmi.sowjanya.d@intel.com wrote:

> > +	pps_tio_disable(tio);
> 
> This...

> > +	tio->enabled = false;
> 
> ...and this should go together, which makes me look at the enabled flag over
> the code and it seems there are a few places where you missed to sync it with
> the reality.
> 
> I would think of something like this:
> 
> 	pps_tio_direction_output() ==> true
> 	pps_tio_disable(tio) ==> false
> 
> where "==> X" means assignment of enabled flag.
> 
> And perhaps this:
> 
> 	tio->enabled = pps_generate_next_pulse(tio, expires + SAFE_TIME_NS);
> 	if (!tio->enabled)
> 		...
> 
> But the above is just thinking out loudly, you may find the better approach(es).

You might need to introduce pps_tio_enable() counterpart, in such case it would
be more natural to have enabled be assigned accordingly.

-- 
With Best Regards,
Andy Shevchenko


