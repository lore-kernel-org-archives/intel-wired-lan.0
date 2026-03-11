Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28881FD064F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Mar 2026 08:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBA98402B2;
	Wed, 11 Mar 2026 08:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 318F44YOsNn3; Wed, 11 Mar 2026 08:01:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66E6040205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773216104;
	bh=4N0hRvpWf30KUSWlLMa0c8FuiB4mSGfDfRHOkal5kNU=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=67oxufBaajgKhtD5qF2jqIAb2JZL4kUqtsdst+fdjtcRIaVyb0EyWFAGlfpZoRjnI
	 +lgE8SDW1yKZh7UKhe+X/RQ1y8kLTHW8CDtgTKOUmvLAFBJdpp5otES2HfI34T2smQ
	 XEX3jSizW4UyXCl4HohYpVbFFcTyIXvsJtg85QablWdVGFaSDofAgi6yOgE0A1YS2V
	 vtSAp5bgadUj+XrTTApxewLc2In7O/qTwk8AU5WfObG7iDNAz/dY28muy+RjEf6rr7
	 MxhnmAnatuuCt2JEZCrMveB+XOf1DeqwAtLHiHFxyeZphVFBjhETK8xrwRruqaWMoO
	 Sx2Q8q6Ht6Xww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66E6040205;
	Wed, 11 Mar 2026 08:01:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EF60C33A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 08:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED1F8402E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 08:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fWIm_8WS6k8Q for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Mar 2026 08:01:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=dawid.osuchowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A8C2C40198
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A8C2C40198
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8C2C40198
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Mar 2026 08:01:40 +0000 (UTC)
X-CSE-ConnectionGUID: vg7S2vC2RoWsKTakEwZ4gg==
X-CSE-MsgGUID: j8GuoT0fQSCcFyd169gXOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78131348"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="78131348"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 01:01:40 -0700
X-CSE-ConnectionGUID: ErpfsMPtQWuRebz+UAoZVA==
X-CSE-MsgGUID: 5jpk3QSSSZuNDtXTWgTU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="216666472"
Received: from mikolajn-mobl1.ger.corp.intel.com (HELO [10.94.252.226])
 ([10.94.252.226])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 01:01:38 -0700
Message-ID: <b42c280d-f6b9-4fce-99f9-00ff65916585@linux.intel.com>
Date: Wed, 11 Mar 2026 09:01:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemyslaw Korba <przemyslaw.korba@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20260309141220.343224-1-przemyslaw.korba@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773216102; x=1804752102;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zbpJ7hkdbm4ZGh4qt8gdPUqMBxrJaflCnD5tCL28uxM=;
 b=cYOHYHiUwcjqQ+3hDfT4CIlnhMjEZgvqPY9vIWWNvhHx5zarGxIB4/Rr
 ECzv/PKjAjj/MJDmktjLqbyV0wkhar8TgNvcpVlOAkrV9GYt+NES+yITi
 XAXX6BgJfbYhzAEbHj4Y7Ys+3kdsX1nSxH97slI4Ddb+KpC1ugy/1visL
 uiwurkpPR7O/EK8NwtkAK/lTbrsnu0QSKgKKV3J+LMfqkzONRJCN4oK4Z
 Jpef66tdmPNPbf441RN6A5aED4QlT59pBrL+TeshDzYQFroqQVubj5/8a
 vz3eH4OuASEw7ZTJ8fNiWpaJoNP4wvSy9PWRECXCVyUCP0fhRdgdzgIQI
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cYOHYHiU
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: PTP: set supported
 flags in ptp_clock_info
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

On 2026-03-09 3:11 PM, Przemyslaw Korba wrote:
> Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
> ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core now
> requires that the driver set the .supported_perout_flags and
> .supported_extts_flags fields in PTP clock info. Otherwise, the additional
> flags will be rejected by the kernel automatically.
> 
> i40e does not support perout flags, so reject any request with perout
> flags.
> 
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>

Hey Przemek,

**Please don't circumvent our established process of going through 
internal review before posting to iwl**. You should send to our internal 
mailing list and get at least one Reviewed-by tag first, before posting 
to iwl. I think we make exceptions only when there is a strict time 
constraint and need to get the change out FAST (e.g. bug present in 
Tony's tree or netdev but not in Linus' tree yet). Reach out internally 
if you don't know the process and I can share the proper resources.

> ---
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 7bcea7d9720f..8d7958692235 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
>   	/* TODO: Implement flags handling for EXTTS and PEROUT */

Ignoring Simon's comment (not because it doesn't have merit, but because 
I don't know this part of the driver and the referenced patches), given 
you just seem to have implemented setting (or maybe handling) these 
flags in this commit, might be the time to remove this TODO comment? :)

-Dawid
