Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DDDCAC597
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 Sep 2025 10:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3002C611EA;
	Thu, 18 Sep 2025 10:54:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuU2ie9ulENf; Thu, 18 Sep 2025 10:54:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CCD96611DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1758192845;
	bh=xsDP46X6fdA2u1G9s7qo7CSnBAFcuoriQweXOrgAGIw=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s8y3ggRG31He/kdh6+7TU4NBqw85F3wNaFx0x5L+X5SAHPAbSskYqE+7tENDmlhq5
	 +pNEZ9ZdkKq6fSqEkl1SbTNLixYPW7pqfhFgHaKoB+hKXPoSXN561OkXQLdda+knA1
	 zIpkfXLQTECDqqYPwmWmpchbsf21zfQrUpKe8/0eu3qE1YSedVS/PVeR3CS05Gtzqy
	 blskdI4zfWKHnM/6LF5l3vfajNk/mGduprAEUWUDQc1Kj1BY4f+UFh41XbmJ1Rwdin
	 3Aj/TuQwLeJ9bqGtc09tsxe19fjoTYOGakRDkBXTdP+qyDrOgJTVsxb3FEWbMK5Zhl
	 y9tAGL7dOBMAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCD96611DC;
	Thu, 18 Sep 2025 10:54:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12CEC1E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Sep 2025 10:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED64D405DB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Sep 2025 10:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ww5JyhBkpx_n for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 Sep 2025 10:54:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::b2; helo=out-178.mta0.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BDB9E404C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDB9E404C7
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BDB9E404C7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Sep 2025 10:54:02 +0000 (UTC)
Message-ID: <3091c796-acad-4c87-9782-3b67210147c2@linux.dev>
Date: Thu, 18 Sep 2025 11:53:53 +0100
MIME-Version: 1.0
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250916191257.13343-1-vadim.fedorenko@linux.dev>
 <20250916191257.13343-2-vadim.fedorenko@linux.dev>
 <20250917174148.0c909f92@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250917174148.0c909f92@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1758192838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xsDP46X6fdA2u1G9s7qo7CSnBAFcuoriQweXOrgAGIw=;
 b=ApqCQqNJDO++mHt1LnGEJWA8arGHVsC9zfb3M8bICGy4orbt6bKbtqRv2+JeOnCjCDUyY2
 W4RQxNrn+sjIRwN8zInaCDNEiItPcQtjHY+8H0UUZonfyo/G4/niu2Hf6dT0qQamsymVKC
 M9NmnF0Qa0mhKKijJQuKBXcuqNcodwY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=ApqCQqNJ
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 1/4] ethtool: add FEC bins
 histogram report
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

On 18/09/2025 01:41, Jakub Kicinski wrote:
> On Tue, 16 Sep 2025 19:12:54 +0000 Vadim Fedorenko wrote:
>> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
>> clarifies it a bit further. Implement reporting interface through as
>> addition to FEC stats available in ethtool.
>> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
>> index 7a7594713f1f..de5008266884 100644
>> --- a/Documentation/netlink/specs/ethtool.yaml
>> +++ b/Documentation/netlink/specs/ethtool.yaml
>> @@ -1219,6 +1219,23 @@ attribute-sets:
>>           name: udp-ports
>>           type: nest
>>           nested-attributes: tunnel-udp
>> +  -
>> +    name: fec-hist
>> +    attr-cnt-name: __ethtool-a-fec-hist-cnt
> 
> s/__/--/

That will bring strong inconsistency in schema. All other attributes
have counter attribute with __ in the beginning:

     name: fec-stat
     attr-cnt-name: __ethtool-a-fec-stat-cnt

     name: stats-grp
     attr-cnt-name: __ethtool-a-stats-grp-cnt

     name: stats
     attr-cnt-name: __ethtool-a-stats-cnt

> 
>> +    attributes:
>> +      -
>> +        name: bin-low
>> +        type: u32
>> +      -
>> +        name: bin-high
>> +        type: u32
> 
> We should add some doc: strings here so that the important info like
> which one is inclusive is rendered right in the API reference

Yep, will add some doc

> 
>> +      -
>> +        name: bin-val
>> +        type: uint
>> +      -
>> +        name: bin-val-per-lane
>> +        type: binary
> 
> probably good to doc this too

ack

> 
>> +        sub-type: u64
>>     -
>>       name: fec-stat
>>       attr-cnt-name: __ethtool-a-fec-stat-cnt
>> @@ -1242,6 +1259,11 @@ attribute-sets:
>>           name: corr-bits
>>           type: binary
>>           sub-type: u64
>> +      -
>> +        name: hist
>> +        type: nest
>> +        multi-attr: True
>> +        nested-attributes: fec-hist
>>     -
>>       name: fec
>>       attr-cnt-name: __ethtool-a-fec-cnt
>> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
>> index ab20c644af24..b270886c5f5d 100644
>> --- a/Documentation/networking/ethtool-netlink.rst
>> +++ b/Documentation/networking/ethtool-netlink.rst
>> @@ -1541,6 +1541,11 @@ Drivers fill in the statistics in the following structure:
>>   .. kernel-doc:: include/linux/ethtool.h
>>       :identifiers: ethtool_fec_stats
>>   
>> +Statistics may have FEC bins histogram attribute ``ETHTOOL_A_FEC_STAT_HIST``
>> +as defined in IEEE 802.3ck-2022 and 802.3df-2024. Nested attributes will have
>> +the range of FEC errors in the bin (inclusive) and the amount of error events
>> +in the bin.
> 
> Does this sound better?
> 
>    Optional ``ETHTOOL_A_FEC_STAT_HIST`` attributes form a FEC error
>    histogram, as defined in IEEE 802.3ck-2022 and 802.3df-2024
>    (histogram of number of errors within a single FEC block).
>    Each ``ETHTOOL_A_FEC_STAT_HIST`` entry contains error count
>    (optionally also broken down by SerDes lane) as well as metadata
>    about the bin. Bin range (low, high) is inclusive.

Ack

> 
>>   static void
>> -nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats)
>> +nsim_get_fec_stats(struct net_device *dev, struct ethtool_fec_stats *fec_stats,
>> +		   struct ethtool_fec_hist *hist)
>>   {
>> +	struct ethtool_fec_hist_value *values = hist->values;
>> +
>> +	hist->ranges = netdevsim_fec_ranges;
>> +
>>   	fec_stats->corrected_blocks.total = 123;
>>   	fec_stats->uncorrectable_blocks.total = 4;
>> +
>> +	values[0].bin_value = 445;
> 
> Bin 0 had per lane breakdown, can't core add up the lanes for the
> driver?

Like it's done for blocks counter? Should we force drivers to keep 'sum'
value equal to ETHTOOL_STAT_NOT_SET when they provide per-lane values?

> 
>> +	values[1].bin_value = 12;
>> +	values[2].bin_value = 2;
>> +	values[0].bin_value_per_lane[0] = 125;
>> +	values[0].bin_value_per_lane[1] = 120;
>> +	values[0].bin_value_per_lane[2] = 100;
>> +	values[0].bin_value_per_lane[3] = 100;
>>   }
> 
>> +/**
>> + * struct ethtool_fec_hist_range - error bits range for FEC bins histogram
> 
> Don't say "FEC bin histogram" I think the word histogram implies that
> the data is bin'ed up.

Ack

> 
>> + * statistics
>> + * @low: low bound of the bin (inclusive)
>> + * @high: high bound of the bin (inclusive)
>> + */
> 
>> @@ -113,7 +114,11 @@ static int fec_prepare_data(const struct ethnl_req_info *req_base,
>>   		struct ethtool_fec_stats stats;
>>   
>>   		ethtool_stats_init((u64 *)&stats, sizeof(stats) / 8);
>> -		dev->ethtool_ops->get_fec_stats(dev, &stats);
>> +		ethtool_stats_init((u64 *)data->fec_stat_hist.values,
>> +				   ETHTOOL_FEC_HIST_MAX *
>> +				   sizeof(struct ethtool_fec_hist_value) / 8);
> 
> sizeof(data->fec_stat_hist.values) / 8
> 
> would save you the multiplication?

yeah...

> 
>> +		dev->ethtool_ops->get_fec_stats(dev, &stats,
>> +						&data->fec_stat_hist);
>>   
>>   		fec_stats_recalc(&data->corr, &stats.corrected_blocks);
>>   		fec_stats_recalc(&data->uncorr, &stats.uncorrectable_blocks);
> 
>> +static int fec_put_hist(struct sk_buff *skb, const struct ethtool_fec_hist *hist)
> 
> over 80 chars, please wrap (checkpatch --max-line-length=80)

ouch, that's proper strict check! :)

> 
>> +{
>> +	const struct ethtool_fec_hist_range *ranges = hist->ranges;
>> +	const struct ethtool_fec_hist_value *values = hist->values;
>> +	struct nlattr *nest;
>> +	int i, j;
>> +
>> +	if (!ranges)
>> +		return 0;
>> +
>> +	for (i = 0; i < ETHTOOL_FEC_HIST_MAX; i++) {
>> +		if (i && !ranges[i].low && !ranges[i].high)
> 
> low and high should probably be unsigned now

ack

> 
>> +			break;
>> +
>> +		if (WARN_ON_ONCE(values[i].bin_value == ETHTOOL_STAT_NOT_SET))
>> +			break;
>> +
>> +		nest = nla_nest_start(skb, ETHTOOL_A_FEC_STAT_HIST);
>> +		if (!nest)
>> +			return -EMSGSIZE;
>> +
>> +		if (nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_LOW,
>> +				ranges[i].low) ||
>> +		    nla_put_u32(skb, ETHTOOL_A_FEC_HIST_BIN_HIGH,
>> +				ranges[i].high) ||
>> +		    nla_put_uint(skb, ETHTOOL_A_FEC_HIST_BIN_VAL,
>> +				 values[i].bin_value))
>> +			goto err_cancel_hist;
>> +		for (j = 0; j < ETHTOOL_MAX_LANES; j++) {
>> +			if (values[i].bin_value_per_lane[j] == ETHTOOL_STAT_NOT_SET)
> 
> You know, bin_value could be 'sum', and bin_value_per_lane could be
> simply 'per_lane'.

SG, I'll change it

> 
>> +				break;
>> +		}
> 
> {} brackets unnecessary
> 
>> +		if (j && nla_put_64bit(skb, ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE,
>> +				       sizeof(u64) * j,
>> +				       values[i].bin_value_per_lane,
>> +				       ETHTOOL_A_FEC_STAT_PAD))
>> +			goto err_cancel_hist;
>> +
>> +		nla_nest_end(skb, nest);
>> +	}
>> +
>> +	return 0;
>> +
>> +err_cancel_hist:
>> +	nla_nest_cancel(skb, nest);
>> +	return -EMSGSIZE;
>> +}
> 
> We need a selftest. Add a case to stats.py and do basic sanity checking
> on what the kernel spits out? Maybe 2 test cases - one for overall and
> one for per-lane, cause mlx5 doesn't have per lane and we'd like the
> test to pass there.
Yeah, sure, I'll add them as another patch to this series

