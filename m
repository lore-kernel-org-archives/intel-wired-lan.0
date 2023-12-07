Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D5DC4167B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Dec 2023 00:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 173FB436C7;
	Thu,  7 Dec 2023 00:26:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 173FB436C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701908785;
	bh=/2GAlnKosFlRO8ldCgpD5SNgu/qbDF2LCrf8P46i8FU=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=utyfEnpT3YGm82vAeDMmdZu6LDKcjfytImOgBqa5WJzbKTD51yg1QAJj2IpqNlcLV
	 iQOzsibZxjrfpkoDdLbAvcj51jZsUDS7rKthVTBpBs0qUJ/OqPc8xPTdrwB18qcFl8
	 VAq7vbeBpyDohGAJOsZf2ZPO9RrkYkdkNZRQxRgtM/SejLTd6PfvjhHdJTk/A+YcGP
	 U8J5jxQ2yaPWeVDve6a9eKuDjK7MqbLRrH/hXPbdAqsqD5iA9pRuV7fG/OGtCtY7gs
	 aaur5REFtZwzNtN5Zg+Av5/HKW2cAcTbi7i1w9S8o0d+02aGn5erxXDKqXo3mSRf43
	 kgBczTvf2VZRA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1donvyaRVUlV; Thu,  7 Dec 2023 00:26:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF181436B3;
	Thu,  7 Dec 2023 00:26:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF181436B3
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 75CB11BF980
 for <intel-wired-lan@osuosl.org>; Thu,  7 Dec 2023 00:26:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D22B61598
 for <intel-wired-lan@osuosl.org>; Thu,  7 Dec 2023 00:26:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D22B61598
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yymfl1y8CvBx for <intel-wired-lan@osuosl.org>;
 Thu,  7 Dec 2023 00:26:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB2F160C06
 for <intel-wired-lan@osuosl.org>; Thu,  7 Dec 2023 00:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EB2F160C06
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="425302679"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="425302679"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 16:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="764912669"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; d="scan'208";a="764912669"
Received: from pkaminsk-mobl1.amr.corp.intel.com (HELO [10.124.112.216])
 ([10.124.112.216])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2023 16:26:17 -0800
Message-ID: <340900d4-b30a-4387-9ce2-1971e8d8024c@intel.com>
Date: Wed, 6 Dec 2023 18:26:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
References: <20231201235949.62728-1-pawel.kaminski@intel.com>
 <20231201183704.382f5964@kernel.org>
From: "Kaminski, Pawel" <pawel.kaminski@intel.com>
In-Reply-To: <20231201183704.382f5964@kernel.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701908779; x=1733444779;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=xZ1OH9wKIvhPVgH5ur8bjSVDHHxW6WDPg5JRMWIHXSY=;
 b=ApGxM8Yj/98xUWdOP8S1//dD1aBwiSK/ZDPKPRjeLindlJWiwgPwGb/G
 ZXmjHWIEH4MfuPv2k6VqhUGZH1P9ZjG2Sgl2lXOFiFMZ8B6UhpHyD1FPo
 dfPKo3bXT6qYQgXCzBUUGLjjr/I7D93+nlpOcX31aISwZ0D3wPrrcM8hz
 xencA8kELS4AhdQzbbqubAeUoP1dmnW+6nYg9wy/VVrBjwKvJyz7Yfa74
 gLa9S2p3t+gS2ivrRj53rAVJCemnVlEClcfyRDoRCu2BGzhZBQoEeJKbY
 5HJkbTRxrnQBdd9wR8eVgqVnQZizfbbnDiFKYGMKiavaBU0IPEUh5oUJJ
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ApGxM8Yj
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ice: Add support for
 devlink loopback param.
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@osuosl.org,
 Michal Wilczynski <michal.wilczynski@intel.com>, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 2023-12-01 20:37, Jakub Kicinski wrote:
> On Fri,  1 Dec 2023 15:59:49 -0800 Pawel Kaminski wrote:
>> Add support for devlink loopback param. Supported values are "enabled",
>> "disabled" and "prioritized". Default configuration is set to "enabled.
>>
>> By default loopback traffic BW is locked to PF configured BW.
> 
> First off - hairpin-bandwidth or some such would be a much better name.
> Second - you must explain every devlink param in Documentation/
> 
> Also admission ctrl vs prioritizing sounds like different knobs.

While at certain abstraction level I agree, in my opinion it is not 
worth here to divide this to separate knobs, since underlying logic (FW) 
doesn't follow that anyways. It is driver specific and extremely 
unlikely to change in the future. Hopefully next gen card will not need 
this knob at all.

>> HW is
>> capable of higher speeds on loopback traffic. Loopback param set to
>> "prioritized" enables HW BW prioritization for VF to VF traffic,
>> effectively increasing BW between VFs. Applicable to 8x10G and 4x25G
>> cards.
> 
> Not very clear what this means...
> So the VFs are Tx bandwidth limited to link speed.
> How does the device know it can admit extra traffic?
> Presumably this doesn't affect rates set by devlink rate?

I will rewrite the description and explanation in v2 and include 
documentation change.

Thank you,
PK
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
