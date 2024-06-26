Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B57C2BBCA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Jun 2024 01:19:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EB9B6066A;
	Wed, 26 Jun 2024 01:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id muZxOKgG750z; Wed, 26 Jun 2024 01:19:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C80B60AAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719364782;
	bh=hMmPtezqGKmC2hCm/UUiUfhIJo+RX/m05TixXE6mgyk=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=COWrh4mG6Tupixmt1RyEI3ZwU5as+mGk2Y3DPvf19CAPlA6s1X0lfr4nJcPjDFI92
	 ZrWsg6yRfWi3BtUPkL2CoZQd+x2t41HXp1DrpKuN+LUbQBQMFagPiay/w0A9uAuzlo
	 rIBHHEASBntYu1PPA9AjtpW4HKT+opl3grWBosJm3srR+djBlnS2WRAkSozwf32zQe
	 22Ws9Gl95T36FkRVwkxMAl3ZQBHYsamQ+d1w47bhhzS5HbARYRWZQLE0IQmZI4+9nh
	 HxzYwOTeTCm4J0XL7LX9wblzGQ7T90XLz8s0S52e0h6AmhyZjPKn8r0dRmWoz9Bxl5
	 I1IM6qGdZE72w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C80B60AAA;
	Wed, 26 Jun 2024 01:19:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E46291BF3C6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Jun 2024 01:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D031A40363
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Jun 2024 01:19:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwWz8mPD-ByI for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Jun 2024 01:19:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=faizal.abdul.rahim@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7343540338
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7343540338
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7343540338
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Jun 2024 01:19:40 +0000 (UTC)
X-CSE-ConnectionGUID: UcZObRbSR7KkxlmucJHz4w==
X-CSE-MsgGUID: s6MF9HzsTwGo8MIDo0ovBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20222704"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; d="scan'208";a="20222704"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 18:19:39 -0700
X-CSE-ConnectionGUID: Jvap4mEuRuiaOAexReNxjg==
X-CSE-MsgGUID: lQ9+WCG/QFKlJVqQa1/JTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; d="scan'208";a="48409095"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.120.43])
 ([10.247.120.43])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 18:19:36 -0700
Message-ID: <106e0d31-c520-4ef6-994e-df1a4c9a986e@linux.intel.com>
Date: Wed, 26 Jun 2024 09:19:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20240625082656.2702440-1-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719364780; x=1750900780;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/ZaYhtjBB6pfsj/x9la5o1sL1jgDGNz1LjDhyzmUjwQ=;
 b=ed0SwHvuctocHusyRE78QnFP9JEF61bhiSPtMoqRyTVa87802dxdYmAO
 bCY/xagzFfHGhfo86r3x+hbHwDtbC8oxVt3tARrF4jTzUo+ZlXCSR+AIM
 yk5o26WMTITSkWpjkcTsh7rSc5flhzMVf2/2MCbdYLDyRNgZ13S1PPDqA
 Fd4REdavpHitDIJWJi93v2oJvnNhZMqQ3e4hyBO9giBPGp66B1oi3mcYe
 8QR/pbDdMvPxcRvraHz0DhOqWdHMMt9s8MhiRYZ9obt6pSD70a8QRpURK
 Xs/VUPP5F4Y2Eq8sfxKqidi0zcxIRRMZt4/sdhfOdvn2Q2r9OJsWS73/S
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ed0SwHvu
Subject: Re: [Intel-wired-lan] [PATCH net 1/1] igc: Fix double reset adapter
 triggered from a single taprio cmd
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>, muhammad.husaini.zulkifli@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Added Vladimir and Husaini in CC.

On 25/6/2024 4:26 pm, Faizal Rahim wrote:
> Following the implementation of "igc: Add TransmissionOverrun counter"
> patch, when a taprio command is triggered by user, igc processes two
> commands: TAPRIO_CMD_REPLACE followed by TAPRIO_CMD_STATS. However, both
> commands unconditionally pass through igc_tsn_offload_apply() which
> evaluates and triggers reset adapter. The double reset causes issues in
> the calculation of adapter->qbv_count in igc.
> 
> TAPRIO_CMD_REPLACE command is expected to reset the adapter since it
> activates qbv. It's unexpected for TAPRIO_CMD_STATS to do the same
> because it doesn't configure any driver-specific TSN settings. So, the
> evaluation in igc_tsn_offload_apply() isn't needed for TAPRIO_CMD_STATS.
> 
> To address this, commands parsing are relocated to
> igc_tsn_enable_qbv_scheduling(). Commands that don't require an adapter
> reset will exit after processing, thus avoiding igc_tsn_offload_apply().
> 
> Fixes: d3750076d464 ("igc: Add TransmissionOverrun counter")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 33 ++++++++++++-----------
>   1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 87b655b839c1..33069880c86c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6310,21 +6310,6 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>   	size_t n;
>   	int i;
> 
> -	switch (qopt->cmd) {
> -	case TAPRIO_CMD_REPLACE:
> -		break;
> -	case TAPRIO_CMD_DESTROY:
> -		return igc_tsn_clear_schedule(adapter);
> -	case TAPRIO_CMD_STATS:
> -		igc_taprio_stats(adapter->netdev, &qopt->stats);
> -		return 0;
> -	case TAPRIO_CMD_QUEUE_STATS:
> -		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
> -		return 0;
> -	default:
> -		return -EOPNOTSUPP;
> -	}
> -
>   	if (qopt->base_time < 0)
>   		return -ERANGE;
> 
> @@ -6433,7 +6418,23 @@ static int igc_tsn_enable_qbv_scheduling(struct igc_adapter *adapter,
>   	if (hw->mac.type != igc_i225)
>   		return -EOPNOTSUPP;
> 
> -	err = igc_save_qbv_schedule(adapter, qopt);
> +	switch (qopt->cmd) {
> +	case TAPRIO_CMD_REPLACE:
> +		err = igc_save_qbv_schedule(adapter, qopt);
> +		break;
> +	case TAPRIO_CMD_DESTROY:
> +		err = igc_tsn_clear_schedule(adapter);
> +		break;
> +	case TAPRIO_CMD_STATS:
> +		igc_taprio_stats(adapter->netdev, &qopt->stats);
> +		return 0;
> +	case TAPRIO_CMD_QUEUE_STATS:
> +		igc_taprio_queue_stats(adapter->netdev, &qopt->queue_stats);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
>   	if (err)
>   		return err;
> 
> --
> 2.25.1
> 
