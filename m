Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E74EA71B7
	for <intel-wired-lan@archiver.kernel.org>; Mon, 20 Apr 2026 03:20:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8522F40483;
	Mon, 20 Apr 2026 03:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yrIpUAAgJNDg; Mon, 20 Apr 2026 03:20:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D1D8740437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776655217;
	bh=CDbOcpEpwlCoe+cmcL5MxKFYd9FeAbNUbUef9MdqyjY=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=egjiinG4mUEFrlO1OxJ5yoUzos0w1BrPl7erY3Es4yF4wa5qLBbGM6XLyTHGQvOPS
	 AdPSjzAsXZBb26hmXQa+AAkIscG5lA25j7336lBO4pJY5FD50k/w1sLJE4ZG8L70xr
	 t6YEtn3/re1vyr/ZthHjUSEbWtGcfZX50ZiPCvVJd5sjvZYmE7SD3q5kXcSUtjlqRk
	 KSLFxflB1Xi2NKXjza7LpiPZ5t657fs9RqKMLG9mohEb1wSBjA3dDbAtVHp0AzGAfX
	 VCmx5ndGcIPFz1dfCRBLIzTscv1ciS0E2BJt/0/lFeHUgdQBmiLi6tlreKO7RvsynY
	 q2oyigt4DrC4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1D8740437;
	Mon, 20 Apr 2026 03:20:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB108355
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 03:20:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCA81404EF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 03:20:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMReus_E_Cf3 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 20 Apr 2026 03:20:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=faizal.abdul.rahim@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 61FD44018B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61FD44018B
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61FD44018B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 20 Apr 2026 03:20:15 +0000 (UTC)
X-CSE-ConnectionGUID: eI4SSgJnS5myW+Y5Vnb4pA==
X-CSE-MsgGUID: UXeC/2seRbGjrA+0kJrMxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="89032151"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="89032151"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2026 20:20:14 -0700
X-CSE-ConnectionGUID: qPAi+K2FSGeq+PDZXEyAuw==
X-CSE-MsgGUID: eNtEGU/+Shq84y5c6COEFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; d="scan'208";a="231880747"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.8.237])
 ([10.247.8.237])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2026 20:20:11 -0700
Message-ID: <3481ae84-5c36-4591-94c1-78b70fff4d7b@linux.intel.com>
Date: Mon, 20 Apr 2026 11:20:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Horman <horms@kernel.org>, khai.wen.tan@linux.intel.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com, khai.wen.tan@intel.com
References: <20260416015520.6090-4-khai.wen.tan@linux.intel.com>
 <20260418164837.380985-2-horms@kernel.org>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <20260418164837.380985-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776655216; x=1808191216;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=I96x05WWbxNDXdYnL1sEhcmWSmBoa7yu/uYaLcjrTYE=;
 b=Dgj2nrWv/oNhUfvezmbOV1vr9UfQ6lED1Lef+03Lux5P6bbjcb5vXl+e
 KwZZdYQ5uRJCPwoXwcXnVUCYsFaq7gMy7Yy5o03Z7iOn0UglcNClDcU5B
 GXSPTz/RrcnYx+gRImicGxSxiJdK4QPE5uvWdhCy6eeFoGuiv/pSG1+g1
 KXDe8TOU+0rUwks6kK6fGCivr43J/7EfezIqwOTMWuOzmNvsJjtGpgI/Y
 LUeaVB8WsyBIZazgqhPfHSv5zELdun0KQjYtpGhU9607uIxo5yCPOe8ec
 EZaD/AQ6NRmt/YK/2Fh6jvU1JB9apRpxHTTrvFo/cxJ77o/2OgfJtMCkH
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Dgj2nrWv
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 3/3] igc: add support for
 forcing link speed without autonegotiation
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



On 19/4/2026 12:48 am, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> igc: add support for forcing link speed without autonegotiation
> 
> This commit adds support to allow users to force 10/100 Mb/s link speed
> and duplex via ethtool when autonegotiation is disabled.
> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index cfcbf2fdad6ea..5bd37d1be1688 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> 
> [ ... ]
> 
>> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
>> + * @adapter: private driver structure
>> + * @speed: requested speed (must be SPEED_10 or SPEED_100)
>> + * @duplex: requested duplex
>> + *
>> + * Records forced speed/duplex when autoneg is disabled.
>> + * Caller must validate speed before calling this function.
>> + */
>> +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
>> +					u8 duplex)
>> +{
>> +	struct igc_mac_info *mac = &adapter->hw.mac;
>> +
>> +	switch (speed) {
>> +	case SPEED_10:
>> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
>> +			IGC_FORCED_10F : IGC_FORCED_10H;
>> +		break;
>> +	case SPEED_100:
>> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
>> +			IGC_FORCED_100F : IGC_FORCED_100H;
>> +		break;
>> +	default:
>> +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
>> +		return;
>> +	}
>> +
>> +	mac->autoneg_enabled = false;
>> +
>> +	/* Half-duplex cannot support flow control per IEEE 802.3 */
>> +	if (duplex == DUPLEX_HALF)
>> +		adapter->hw.fc.requested_mode = igc_fc_none;
>> +}
> 
> If userspace issues an ethtool command without specifying duplex, the duplex
> value can be DUPLEX_UNKNOWN. In this case, forced_speed_duplex correctly
> defaults to half-duplex since duplex == DUPLEX_FULL evaluates to false.
> 
> However, since DUPLEX_UNKNOWN is not equal to DUPLEX_HALF, the check above
> fails, and the requested flow control mode remains unchanged. Could this leave
> flow control enabled on a forced half-duplex link, violating IEEE 802.3?
> Should this check be based on the resolved mac->forced_speed_duplex state
> instead?
>

You're right, thanks for pointing that out.

That said, it feels simpler to address it with [1]:
if (duplex != DUPLEX_FULL)
     adapter->hw.fc.requested_mode = igc_fc_none;

Rather than [2]:
  if (mac->forced_speed_duplex == IGC_FORCED_10H ||
         mac->forced_speed_duplex == IGC_FORCED_100H)
         adapter->hw.fc.requested_mode = igc_fc_none;

Are you okay with [1] ?

> [ ... ]
> 
>> @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>>   		}
>>   	}
>>   
>> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
>> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
>> +		netdev_info(dev, "Unsupported speed for forced link\n");
>> +		return -EINVAL;
>> +	}
>> +
>>   	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>>   		usleep_range(1000, 2000);
> 
> This isn't a bug introduced by this patch, but does this ad-hoc
> synchronization using bit flags circumvent proper locking guarantees? The
> networking subsystem guidelines forbid using bit flags as ad-hoc locks.
> 
> Using a bit flag in a polling loop bypasses lockdep analysis, fairness, and
> strict memory ordering. Could this be replaced with a real synchronization
> mechanism like a mutex?

It looks like a worthwhile cleanup. However, it likely doesn’t belong in 
this series, since the synchronization pattern predates these patches and 
is used throughout the igc driver (set_ringparam, set_pauseparam, 
set_channels, etc.). We could address it in different patch series and 
align the other code paths at the same time ?

