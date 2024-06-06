Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C052C27C55
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Jun 2024 12:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 299E684633;
	Thu,  6 Jun 2024 12:33:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M0DeUnuyis62; Thu,  6 Jun 2024 12:33:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D7A2841E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717677211;
	bh=ppcBgRJQrnm+5ryYYxZiG6LhrxmbC8yd/WbWELisQFw=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Rdu1U659vZ+Fe6+145IVb8HtNVWlVF1PjoeG31HcVpNlLmwz1Ln80MgQe7EKhP+QA
	 XX/td5TCp/sA9B+uS7XUu5tqS7SKoXODB99NAsWuSloXqfnDxed42GwiQQK4K4w9Tw
	 NFizuZadhsDH/xH1+9xAUyXWxvbvdDQbc5PJd1hxh4PBOQozzeDjyw1CA/cT2q3G42
	 Gl25rSpTvnjxCAFoEm5H3Vx/Vyy3QGG1YctVPcpPOMyweS+ufESTrDHWlyMBdiTlUh
	 8i6h2aWllktnMhgZwhSR0UrVVu1cKV710RJ6akuv9mXZIL053RCGOyoduTWAgHGFmh
	 gsM24ZZw/QKZA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D7A2841E3;
	Thu,  6 Jun 2024 12:33:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 681851BF593
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jun 2024 12:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E517841E3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jun 2024 12:33:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-Z0q--p8Dcq for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Jun 2024 12:33:29 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=dawid.osuchowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ACBC081F98
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACBC081F98
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ACBC081F98
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Jun 2024 12:33:29 +0000 (UTC)
X-CSE-ConnectionGUID: JZVWDOtBRUKROJm4frHiDg==
X-CSE-MsgGUID: sN8tE0igTfq7SfOLaTiQqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14460316"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="14460316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 05:33:29 -0700
X-CSE-ConnectionGUID: /YOP+PncSPa1D9kFStS9TA==
X-CSE-MsgGUID: 8jaB9foOTwOqCMQQGPa2Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; d="scan'208";a="42417032"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.246.6.23])
 ([10.246.6.23])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 05:33:26 -0700
Message-ID: <fbec0c39-8749-4c47-b005-b045253eebd7@linux.intel.com>
Date: Thu, 6 Jun 2024 14:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20240506153307.114104-1-dawid.osuchowski@linux.intel.com>
 <0257b1fb-3e0a-d5d2-4e2c-eedc12e7dcd6@intel.com>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <0257b1fb-3e0a-d5d2-4e2c-eedc12e7dcd6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717677210; x=1749213210;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=v6zwqbT3eNtldS0DZCFshKxvXCvz8cwJ1YakBqbHgLE=;
 b=dbxTikZSr6WwzOb6F05uFGfBmkyz5Oo8RgKUD2y3mWUVH6U91Lvi8jUp
 QFNKNarzpITITrPdbQa6wcLdiARaX4OVPbGFQslEg+221OJwLxfhxLplz
 KLZRxYpq4sKOBagDE8BbhHVJDYu5qoOjRdLAIpEc7XKTYTox4D3Qfniq6
 eYO4rGn5HyIfpk5t2nbuSV9rMx76QA6LJxEUArzm0F7LhifwQWMEXmOrC
 EyoqwBK0+hBPcXD+31cwYqvddv03TPC8OzLnHy/6d/nt3f6LMIIXzHEfD
 Ia0fBeqVytDiHzQ0FSeuEifQDG9x3v0MT3esO1KI+7nnKNT1yMJgRFIm1
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=dbxTikZS
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4] ice: Do not get coalesce
 settings while in reset
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
Cc: Ngai-Mint Kwan <ngai-mint.kwan@intel.com>, netdev@vger.kernel.org,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Simon Horman <horms@kernel.org>,
 Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 09.05.2024 18:11, Tony Nguyen wrote:
> Seems like commit message, and probably title, need to get updated for 
> this change?

During testing of the change, it turns out at the current state our 
driver is in we have to use the approach with returning -EBUSY. Will 
update the description in v5 to account for this.

--Dawid
