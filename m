Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50040C3DA59
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Jul 2024 12:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0489140640;
	Mon, 22 Jul 2024 12:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FM9I4BYJIUw7; Mon, 22 Jul 2024 12:55:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E1C74021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1721652938;
	bh=uJN5G13B68tC+bYDgus8X7UQEXAULdRN5bNVe73RV4U=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iyVD2nXjVg2vM/pWM9UHbPdzusQ3ilkLXmAKM8/mAtqystZfgMlsjvfO/J9mrCuTJ
	 xOXCuAcd11qKWz03+5bpxSvEDMZFV4tXYOc2DKbhg3tNfvhsDxbyIFybQjNfCQaibR
	 xeDs7dB8Rr12FUi2MbzhkyhmIROsB4EOdxWPYREKmpRrdDU5yCjgaL9DINalpLQApY
	 an4N77q65fTLS+6pGkjL4keVhGZnAeBYqJobjtadvtdv/5lKh0QOQ6d0MP+OjxCbBV
	 IqwnCZ8ILmhzLC0NrtNTgv9xI+/ezraLCLaJiRxhBMHsI2xpBXFDVM9MW8G8v5zWEu
	 8Cr9kpH9o53Pw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9E1C74021C;
	Mon, 22 Jul 2024 12:55:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8910E1BF2AF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 12:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76249605C7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 12:55:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9fLLaBurx3L for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Jul 2024 12:55:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=dawid.osuchowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 96C39605A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 96C39605A9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 96C39605A9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jul 2024 12:55:36 +0000 (UTC)
X-CSE-ConnectionGUID: 5cGTJo1lRN6xhaSHcOurPQ==
X-CSE-MsgGUID: 6VxDBXevTk6zHUDjRGglYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="12648712"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="12648712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 05:55:36 -0700
X-CSE-ConnectionGUID: uKCb8+AKTnO8/8dGIsYARA==
X-CSE-MsgGUID: iJg+4JGzTZOu7Gyy5sq6+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; d="scan'208";a="82515818"
Received: from dosuchow-mobl2.ger.corp.intel.com (HELO [10.94.250.30])
 ([10.94.250.30])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 05:55:34 -0700
Message-ID: <0e5e0952-7792-4b9b-8264-8edd3c788fa8@linux.intel.com>
Date: Mon, 22 Jul 2024 14:55:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>
References: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
 <cb7758d3-3ba5-404d-b9e4-b22934d21e68@molgen.mpg.de>
Content-Language: pl
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <cb7758d3-3ba5-404d-b9e4-b22934d21e68@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721652937; x=1753188937;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DyBFFW7PXxxZTzvOnBYu/Hzk9zUKJSSwJt4z4BIad1E=;
 b=Pw8TJXdYRT8/zUpU/oeeShwh4FdnDPSrg08kx02DpLnBwoufHX5U6J+v
 jx/Zl3Ede86K+kIa4ePTesHOIyFl0YBKjdrJo6vdvNZFn028k5RceKix7
 3+fOdvTvoRlpl6t65MddKMa2gunQMA2Nra501e3WG5fY+7JT2+ebMx6MK
 sbhYBLQhcHOmw99TTjaPdZtW0M0AB1mHUs49Pc/fC7SyWRx9OrfQPP86V
 Kxgb2v/ex91lrOOLf0/n0LXc29eyIF4lI7/9uqaorVE5m8LMz/Olo1cN4
 emNPoncrxzSieXpAa77stJuI8dhlYMxo2aDogX+bVGGt9gkpslLRHE8fo
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Pw8TJXdY
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Introduce
 netif_device_attach/detach into reset flow
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 22.07.2024 14:37, Paul Menzel wrote:
> Dear Dawid,
> 
> 
> Thank you for your patch.
> 
> Introduce … into
> 
> sounds a little strange to me. Maybe:
> 
>  > Attach to device in reset flow
> 
> or just
> 
>  > Add netif_device_attach/detach
> 
>  > Serialize …

Maybe "Add netif_device_attach/detach" would be the best for this, as 
the attaching and detaching doesn't happen only during reset.

> Am 22.07.24 um 14:28 schrieb Dawid Osuchowski:
>> Ethtool callbacks can be executed while reset is in progress and try to
>> access deleted resources, e.g. getting coalesce settings can result in a
>> NULL pointer dereference seen below.
> 
> What command did you execute?
> 

Once the driver is fully initialized:
# echo 1 > /sys/class/net/ens1f0np0/device/reset
and then once that is in progress, from another terminal:
# ethtool -c ens1f0np0

Would you like me to include those in the commit message as well?

--Dawid

