Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AACC3601A
	for <intel-wired-lan@archiver.kernel.org>; Wed,  2 Apr 2025 12:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D1EF6F683;
	Wed,  2 Apr 2025 12:58:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0dUmH4qN5moO; Wed,  2 Apr 2025 12:58:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA1FF6F6C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1743598682;
	bh=OSm70u8tMLroCFAhMGXJydB5zmnt/ZsQN4exXcnN/Aw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=guhRI3EtYvQm8IgLIFOoLoW0dXr6qyfLdMJUCOmIxmWPx0GsF9Ct4Q0ao552nesKK
	 LtkJoxspqLi1pf3LAnOJeIErRj9WVYAFq2yyjqoitxxXfTnZit9Rp6d2zssIQXXA6y
	 cB0mB8/PrbftD1+3gEk84p3MO8MiQPOuKSSGMGDVBkhf7bEkLOLVot6i5DaClsF8Qy
	 XM7C77wsceijIlF/rWppuAWdh9cb2EC2dVlbyLzKimw2TeiMJtp2MCUyiY0wlMLE9z
	 K4XIW5SC9ezWSlc3GG/mYxCbDwsbfH984udFu8cWf9dXwjlLLn7453e06vG7b97LeS
	 D73vY2rnZ3sZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA1FF6F6C6;
	Wed,  2 Apr 2025 12:58:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26ABF123
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Apr 2025 12:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06A1881E62
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Apr 2025 12:58:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w355wrVEtD4C for <intel-wired-lan@lists.osuosl.org>;
 Wed,  2 Apr 2025 12:58:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=andriy.shevchenko@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A144820FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A144820FE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A144820FE
 for <intel-wired-lan@lists.osuosl.org>; Wed,  2 Apr 2025 12:58:00 +0000 (UTC)
X-CSE-ConnectionGUID: QbfIm8qUSA2aziQEywt5Ew==
X-CSE-MsgGUID: UxRnRIphR46SW7rcZ74lIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="48750391"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="48750391"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2025 05:58:00 -0700
X-CSE-ConnectionGUID: /xJdOPYHT0W4RBku5oc+fw==
X-CSE-MsgGUID: md2FkTnQT4etxJfUUnTQ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; d="scan'208";a="149880473"
Received: from smile.fi.intel.com ([10.237.72.58])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2025 05:57:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1tzxfG-00000008Tqt-2q8U; Wed, 02 Apr 2025 15:57:54 +0300
Date: Wed, 2 Apr 2025 15:57:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
 torvalds@linux-foundation.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-toolchains@vger.kernel.org
Message-ID: <Z-00UkrBC1TRnoqA@smile.fi.intel.com>
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
 <Z-0SU8cYkTTbprSh@smile.fi.intel.com>
 <20250402121935.GJ25239@noisy.programming.kicks-ass.net>
 <20250402122224.GB25719@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402122224.GB25719@noisy.programming.kicks-ass.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743598681; x=1775134681;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9PaKlNBLrieA3abOkdoYAAKdlkNEcWYYrdczTHWO80Q=;
 b=RBWFI2IaEIoM1Ev2bjpwit5xv/YMMR4RE9deuAn52otu9xizI2faecSn
 RJes0cXddOfVQXrdlS2ADswaMvy/944NgzYFBGw1zokNzhsrycRhAoQFw
 lLeQFwLQf7fBqA7d9uv27jOe3m3PZ+/+TQb9nZKMTmP3LmHRzZ3UGbhLD
 L7B9EnFrQPW+6Toj1uLjeSZIChfYqjauBzWd728kQzcQ2euO/FImU09Km
 MCI60QJpfggeSBSvQCRfyqXxzMcJ249nUVW7ywR5DToVo6XF4RDP0bSB/
 OkH1/vN6sbwfm1FXIGZDyoTCpNrLjKeFsBzFbIS7q7LnOcwus5CYqHPr6
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RBWFI2Ia
Subject: Re: [Intel-wired-lan] [RFC] slab: introduce auto_kfree macro
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

On Wed, Apr 02, 2025 at 02:22:24PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 02, 2025 at 02:19:35PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 02, 2025 at 01:32:51PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 01, 2025 at 03:44:08PM +0200, Przemek Kitszel wrote:
> > > > Add auto_kfree macro that acts as a higher level wrapper for manual
> > > > __free(kfree) invocation, and sets the pointer to NULL - to have both
> > > > well defined behavior also for the case code would lack other assignement.
> > > > 
> > > > Consider the following code:
> > > > int my_foo(int arg)
> > > > {
> > > > 	struct my_dev_foo *foo __free(kfree); /* no assignement */
> > > > 
> > > > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > > > 	/* ... */
> > > > }
> > > > 
> > > > So far it is fine and even optimal in terms of not assigning when
> > > > not needed. But it is typical to don't touch (and sadly to don't
> > > > think about) code that is not related to the change, so let's consider
> > > > an extension to the above, namely an "early return" style to check
> > > > arg prior to allocation:
> > > > int my_foo(int arg)
> > > > {
> > > >         struct my_dev_foo *foo __free(kfree); /* no assignement */
> > > > +
> > > > +	if (!arg)
> > > > +		return -EINVAL;
> > > >         foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > > >         /* ... */
> > > > }
> > > > Now we have uninitialized foo passed to kfree, what likely will crash.
> > > > One could argue that `= NULL` should be added to this patch, but it is
> > > > easy to forgot, especially when the foo declaration is outside of the
> > > > default git context.
> > 
> > The compiler *should* complain. But neither GCC nor clang actually
> > appear to warn in this case.
> > 
> > I don't think we should be making dodgy macros like you propose to work
> > around this compiler deficiency. Instead I would argue we ought to get
> > both compilers fixed asap, and then none of this will be needed.
> 
> Ah, I think the problem is that the cleanup function takes a pointer to
> the object, and pointers to uninitialized values are generally
> considered okay.
> 
> The compilers would have to explicitly disallow this for the cleanup
> functions.

Hmm... What I have heard is that the cleanup is basically a port of
C++ destructor code to C, and it might be related to the virtual functions
that are may be absent for the basic classes. But not an expert here,
just speculating based on my poor knowledge of C++.

-- 
With Best Regards,
Andy Shevchenko


