Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE89EA4FBB
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Feb 2026 13:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 256E940C13;
	Mon, 23 Feb 2026 13:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3gJb_aJlNKeS; Mon, 23 Feb 2026 13:47:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3B6BB40BE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771854434;
	bh=J23ZZyUd0FB7ErfJRpotw2F/RF4vICfawSHZ87HnyhQ=;
	h=From:To:Cc:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rPWqLn1RTlJawdCRLoIVJstcOMG3Sqt9NsPczOjT4xCz/3xklSv6wTVKkombgIaQm
	 Pp74BNWghqFhbHOZBFso62FllkDpmq2Xwf3zSWLio9Uyo6iPc9LCQmL7GmT4i1xJtg
	 KL8XwmRF5qXHjWVRkqcpnCzInIkA/V5WACv02ZNg9TBu3BAI2b6jAuRwAqlxQTC+dX
	 QH2VG14H1j1OuH3m5toWhpfb3iPujX5SyeDI5uam/OWkxRvx/pHzXCnOM0VFWLGdnH
	 c4TZy9OnMIuLCGLcdvyyKrrHZQvlfqjuuR0soUnWNErMnuB3xEhnTYcczw8S8kf41/
	 jtRXnhkpJyaDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B6BB40BE9;
	Mon, 23 Feb 2026 13:47:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 840D2249
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 13:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D377842A6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 13:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id txdCSrFbeC65 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Feb 2026 13:47:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 743DA842A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 743DA842A5
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 743DA842A5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Feb 2026 13:47:09 +0000 (UTC)
X-CSE-ConnectionGUID: wEcN/waRQdi5ZEz0rgcr4w==
X-CSE-MsgGUID: qA3dNR0nQ0WQfrWPl2puRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72756779"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="72756779"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 05:47:08 -0800
X-CSE-ConnectionGUID: 1v88AsnGQx+5D12EpgNwKg==
X-CSE-MsgGUID: mmVGelq+SZamc1NuWYyuZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="219682264"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.246.249])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 05:47:03 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jonathan Corbet <corbet@lwn.net>, Kees
 Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
Date: Mon, 23 Feb 2026 15:47:00 +0200
Message-ID: <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771854429; x=1803390429;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=ydmdhEGM/O41rgUA/G7JvzJvk3KxbBzvvuzH7eImK34=;
 b=VW6zsY06sAfcNAvKJWHscJ64vXxvEeKcaVZlOfLrkM+hM7lsQXrvesiq
 pr3SEdJpszneKIzb69UK/XLs9Ehl9kHECZmu81ue8uW6XqMc7bY7Mh52W
 lR3kgIIN2AppERlvRcPOhclAskuO3AU9XK5IX8B/c5vZSJy/LBKWgHZAd
 3EQf79t1MCDfIfqJMrj9FbIyVOyM8hC/mb2jwLWIYW3730sjVSAk3uD5O
 sCO9DsSFwQ+NnnxMImulw3b4uxKLaBrB5TKyQa3zGkUP2vzQlBjEMu+Eg
 tk0YA/oXRe+kW+6NbEZE0ONr9aQ1+lWRFQdnIp1F3vEKcgBL/0+nbeuEV
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VW6zsY06
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
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

On Wed, 18 Feb 2026, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> As anyone that worked before with kernel-doc are aware, using regex to
> handle C input is not great. Instead, we need something closer to how
> C statements and declarations are handled.
>
> Yet, to avoid breaking  docs, I avoided touching the regex-based algorithms
> inside it with one exception: struct_group logic was using very complex
> regexes that are incompatible with Python internal "re" module.
>
> So, I came up with a different approach: NestedMatch. The logic inside
> it is meant to properly handle brackets, square brackets and parenthesis,
> which is closer to what C lexical parser does. On that time, I added
> a TODO about the need to extend that.

There's always the question, if you're putting a lot of effort into
making kernel-doc closer to an actual C parser, why not put all that
effort into using and adapting to, you know, an actual C parser?


BR,
Jani.

-- 
Jani Nikula, Intel
