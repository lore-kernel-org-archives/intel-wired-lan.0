Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ADBE9B344
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Mar 2026 09:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A58DF810E7;
	Mon,  2 Mar 2026 09:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30iOMcJkfCr6; Mon,  2 Mar 2026 09:51:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6EBCF810DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772445102;
	bh=zDohr75pdNgI3rBiH0yGgr6+WUvyazdz0lxidSjYHEQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mf7afXtI1HjcW9pxFzH3Nam15HY6S8RB05quSWyViZAY4Ahvz98J1JhNRfIxcFlD4
	 C7m+CYwjshP8bvGx7Cl5B4m5idRwHkVKZguRohy4UrgvVof0yi4xZfwJx5+TjsmK6l
	 tH6IkMRBViNNq2IG//OuNuiE9qSNETLZ9wslXhWl8+fKZHJF71UzVChUo0sonbRAgi
	 F7Sesi+Bv6P1C5hDL/0foH98Ii0LK8KISgzvE1wmDCoqViuKpKhpPvDiRgmgZ4QX5T
	 vy6jq+AGLjFcABE9UzNNPMOXcGNMGQClGfPEK3gtAQ70H0wQPpxeXyY73SpXZxk6Cp
	 yKiNBbJreE3og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EBCF810DF;
	Mon,  2 Mar 2026 09:51:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BAB77231
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACAB260F8F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K-nynV0tmwna for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Mar 2026 09:51:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A66B360F84
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A66B360F84
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A66B360F84
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Mar 2026 09:51:36 +0000 (UTC)
X-CSE-ConnectionGUID: JGTWci8qQdyznHcxlLlW4g==
X-CSE-MsgGUID: XejRLfVAQHCwJgfmjUO3Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="76051565"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="76051565"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:51:36 -0800
X-CSE-ConnectionGUID: 1M43xfSJTH+iKykTElvJXA==
X-CSE-MsgGUID: FgbJBCdfTpSZ7loro2hQrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="240620934"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.52])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:51:33 -0800
Date: Mon, 2 Mar 2026 11:51:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Message-ID: <aaVdo_FmncYXUQes@ashevche-desk.local>
References: <20260302090305.2193349-1-andriy.shevchenko@linux.intel.com>
 <IA3PR11MB8986BF4BB6AB02FDB0F84658E57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB8986BF4BB6AB02FDB0F84658E57EA@IA3PR11MB8986.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772445097; x=1803981097;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nnwGUvYXlWH+Q1fp3tDFhLknwZKLytF4NV2bc0HOwcw=;
 b=LW8HbHsink4J5MUSxXqNIrBJKtxS4jr/feO7HcxTjicSZnOP44ZyR38X
 f+EbJP9gorehotd27F5u9FnC1JSzH+qMHZMzf4jSMJRGpsUugBUf1RKi1
 Epq+47uIV7fWWIzEySUIOijtdwq8LjlhlkNVY21YAQcBfULGy5XtEaOO6
 eCJvKY0tBBh0xcZZnJnpTeQvMUKjVGBdTeuyTvcXq2tn1ifYCezGn5f//
 RH1LyrScXAUoXBfL3zs3jme13dM2KQARr/l7jckzh4xxMo80cdHpVWnsT
 y3IHibglLigKS/klqZcfyIjwZRtg/V6sUudf6EnqavPUWqcD/yZsA3OMf
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LW8HbHsi
Subject: Re: [Intel-wired-lan] [PATCH net-next v1 1/1] i40e: Add missing
 header
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

On Mon, Mar 02, 2026 at 09:45:46AM +0000, Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Andy Shevchenko
> > Sent: Monday, March 2, 2026 10:03 AM

> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks!
I sent a v2 with fixed Subject already, please review that one.

-- 
With Best Regards,
Andy Shevchenko


