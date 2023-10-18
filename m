Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A649CDB47E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Oct 2023 06:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF15841DB0;
	Wed, 18 Oct 2023 06:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF15841DB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697612250;
	bh=dSdQopDcUtXDx25e4EI2xJNIt1Q+xI6etfoVcQOCB1E=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GwfrqWujkQUf37p+XmbnWLFhu5DxLfrJMOGfRcln8VBsMP0suoYF422vWq+q6Heau
	 AXmFNHLw9DRsfW+HvNkLmaSzhy+9SDWXA87a6iCq6PlulP6nlpekd+dYlPx8izDP4+
	 a7enqUlmiCrIdguXJ5tBxrbudY2WPwDu5Ed6Z3WyzWmPYZ+N5RyQS+SQ+hiyn+P3tO
	 FZ2WCAsOT+SeI3Fkv81kSgJccNM1Sy7DROl+482naGTXUvAfiGFdFAGC5rKleS1Wp/
	 sq3LGOkbbvCUDYiHITjGt4FEwnskZjvaTvC4uGe1P0GuKMnOOYFo8gG3vFVy5Wyg56
	 0vIaANmPzAFBg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qR0tNPylA3v9; Wed, 18 Oct 2023 06:57:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1752541DD0;
	Wed, 18 Oct 2023 06:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1752541DD0
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 0EB281BF2AB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 06:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDC1840463
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 06:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDC1840463
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UK_5RKFdEyuz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Oct 2023 06:57:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE7F440165
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Oct 2023 06:57:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE7F440165
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384833929"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; d="scan'208";a="384833929"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 23:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="706314154"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; d="scan'208";a="706314154"
Received: from vboldovs-mobl.ger.corp.intel.com (HELO [10.214.215.26])
 ([10.214.215.26])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 23:57:25 -0700
Message-ID: <a525b216-04e8-4888-8709-a21399404b6f@linux.intel.com>
Date: Wed, 18 Oct 2023 09:57:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sasha Neftin <sasha.neftin@intel.com>, intel-wired-lan@lists.osuosl.org
References: <20231003054811.3679788-1-sasha.neftin@intel.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231003054811.3679788-1-sasha.neftin@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697612247; x=1729148247;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=A6XOa/vUbQa9wsZKqalYR0voWk1ANd5+YV1mtRAYy6w=;
 b=Xjp88dv7nAWGwq1Gd3DKbrQq1zJGvq5ejP5uf0iuK6UZsM8NQKiLK5aa
 5qagNO8HWMrn8sbMNBFTkHSO+vAshyBoJeso/jEKmne93TMYyNx0m/SV7
 EcHrtzPgE/Zdp8cBO6EvjI6avQxnyV4MNaDIS38hGmLvbQ9HgyuKc65Bo
 CbethsC8iHMMMBplSNB88i9ZUpynCinckwZSB/xecRBWNyf75iJkXGg81
 2CNqDol5CPVzOkJxLNhqWUlP7fzkxSA6ySuXNAqXjAdLWq56buhLG2zIf
 xjVo2xr3Qlofcvf7sqSwO35iVDjbRx9gREWZpUBh1KZ0a6Z3e2Ascp2Sx
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Xjp88dv7
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] igc: Fix ambiguity in
 the ethtool advertising
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 10/3/2023 08:48, Sasha Neftin wrote:
> The 'ethtool_convert_link_mode_to_legacy_u32' method does not allow us to
> advertise 2500M speed support and TP (twisted pair) properly. Convert to
> 'ethtool_link_ksettings_test_link_mode' to advertise supported speed and
> eliminate ambiguity.
> 
> Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Suggested-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 35 ++++++++++++++------
>   1 file changed, 25 insertions(+), 10 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
