Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D6EC001DE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Jul 2023 17:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 893B240BC4;
	Mon, 31 Jul 2023 17:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 893B240BC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690823774;
	bh=ehozObqoMl5dTzV5czpTgL+dj35iZHSIhvedxTjYhTI=;
	h=From:To:In-Reply-To:References:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=6op/r+6XqHm5HpQeQ01LgdlXx02hk0u8gRnMBSUhC4A9SGBxywH9F7OBxIx7uBWQu
	 VCTMqnsRl+dudVGSQl08y/ojFHtqyx2H+X9NfP4/HySLArlLeqOqOWBG3zbQhRxiCx
	 pMhBe3T3dqga6lRvrjLu/QblBe02Z6UhQlz5kIondnOXo8dZr7JwXBm75G1poS4jHe
	 mzRDewss406SHmDfeNgxqGGe8igNQL09PWTpB2kRQsHqKwcquQhKZ024mJQ1zDdW17
	 ddakNkbWpx4n66Xazz9CS+45vRadENOL1aCrjd6ATCja5ChMXNPKEOod3ZBzlIOURS
	 fPOdKbvTGWqCA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDxv-F7PE-Pl; Mon, 31 Jul 2023 17:16:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D59340BC6;
	Mon, 31 Jul 2023 17:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D59340BC6
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 57ADC1BF3A1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 17:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B16C60D64
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 17:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B16C60D64
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yV7k6Tf6q63y for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Jul 2023 17:16:10 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BBCA60776
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 17:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BBCA60776
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="367981942"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; d="scan'208";a="367981942"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 10:16:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="728380555"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; d="scan'208";a="728380555"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1)
 ([10.54.70.17])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 10:16:09 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
In-Reply-To: <20230729002920.37h6y7mar5qlpgrl@skbuf>
References: <20230729001800.227269-1-vinicius.gomes@intel.com>
 <20230729002920.37h6y7mar5qlpgrl@skbuf>
Date: Mon, 31 Jul 2023 10:16:09 -0700
Message-ID: <87fs543sti.fsf@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690823770; x=1722359770;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=axlBmWSwxxOBcUPWqMCckAnhaf5nWg3vue5fqQEKaAs=;
 b=eTqK5rQHWJR4Sr2c9qEO+0E1Zwt1ZKWdMtiFAagcp+TC6SIIyuhOkdj1
 TFIrf2D42s303MCW36mba7VoSCM3EX979YD/Ca147qvpwtXVVNWvTZDqt
 CkPgHMMq2u1mTvTbi0dOJ7v2bcNNSJUgPXYiqs1CZlEoPaIkfjoQ5fRyx
 5ql/oE2ujW1hA4buMNBOBwNXjCqAnc1uB8mvpbV8g1Wp0mo1oqHMprW5U
 Mt7pLu/RPcfLTCfUhhPX3yPwGUZwUILQ1FU38DsxwJEcE7GDHdEQrdwwr
 /ns/6aTkimvtjedsnQZpN+pA237Mc5x/Lp/LJcCpD3uEoSHv8WG9jj5HL
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eTqK5rQH
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igc: Add support for
 multiple in-flight TX timestamps
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
Cc: richardcochran@gmail.com, kurt@linutronix.de, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Vladimir,

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> On Fri, Jul 28, 2023 at 05:17:59PM -0700, Vinicius Costa Gomes wrote:
>> Add support for using the four sets of timestamping registers that
>> i225/i226 have available for TX.
>> 
>> In some workloads, where multiple applications request hardware
>> transmission timestamps, it was possible that some of those requests
>> were denied because the only in use register was already occupied.
>> 
>> This is also in preparation to future support for hardware
>> timestamping wwith multiple PTP domains. With multiple domains chances
>> of multiple TX timestamps being requested at the same time increase.
>> 
>> Before:
>> $ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o 37
>>                |          responses            |     TX timestamp offset (ns)
>> rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
>> 1000       100   0.00%   0.00%   0.00% 100.00%       +1     +41     +73     13
>> 1500       150   0.00%   0.00%   0.00% 100.00%       +9     +49     +87     15
>> 2250       225   0.00%   0.00%   0.00% 100.00%       +9     +42     +79     13
>> 3375       337   0.00%   0.00%   0.00% 100.00%      +11     +46     +81     13
>> 5062       506   0.00%   0.00%   0.00% 100.00%       +7     +44     +80     13
>> 7593       759   0.00%   0.00%   0.00% 100.00%       +9     +44     +79     12
>> 11389     1138   0.00%   0.00%   0.00% 100.00%      +14     +51     +87     13
>> 17083     1708   0.00%   0.00%   0.00% 100.00%       +1     +41     +80     14
>> 25624     2562   0.00%   0.00%   0.00% 100.00%      +11     +50   +5107     51
>> 38436     3843   0.00%   0.00%   0.00% 100.00%       -2     +36   +7843     38
>> 57654     5765   0.00%   0.00%   0.00% 100.00%       +4     +42  +10503     69
>> 86481     8648   0.00%   0.00%   0.00% 100.00%      +11     +54   +5492     65
>> 129721   12972   0.00%   0.00%   0.00% 100.00%      +31   +2680   +6942   2606
>> 194581   16384  16.79%   0.00%   0.87%  82.34%      +73   +4444  +15879   3116
>> 291871   16384  35.05%   0.00%   1.53%  63.42%     +188   +5381  +17019   3035
>> 437806   16384  54.95%   0.00%   2.55%  42.50%     +233   +6302  +13885   2846
>> 
>> After:
>> $ sudo ./ntpperf -i enp3s0 -m 10:22:22:22:22:21 -d 192.168.1.3 -s 172.18.0.0/16 -I -H -o 37
>>                |          responses            |     TX timestamp offset (ns)
>> rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
>> 1000       100   0.00%   0.00%   0.00% 100.00%      -20     +12     +43     13
>> 1500       150   0.00%   0.00%   0.00% 100.00%      -23     +18     +57     14
>> 2250       225   0.00%   0.00%   0.00% 100.00%       -2     +33     +67     13
>> 3375       337   0.00%   0.00%   0.00% 100.00%       +1     +38     +76     13
>> 5062       506   0.00%   0.00%   0.00% 100.00%       +9     +52     +93     14
>> 7593       759   0.00%   0.00%   0.00% 100.00%      +11     +47     +82     13
>> 11389     1138   0.00%   0.00%   0.00% 100.00%       -9     +27     +74     13
>> 17083     1708   0.00%   0.00%   0.00% 100.00%      -13     +25     +66     14
>> 25624     2562   0.00%   0.00%   0.00% 100.00%       -8     +28     +65     13
>> 38436     3843   0.00%   0.00%   0.00% 100.00%      -13     +28     +69     13
>> 57654     5765   0.00%   0.00%   0.00% 100.00%      -11     +32     +71     14
>> 86481     8648   0.00%   0.00%   0.00% 100.00%       +2     +44     +83     14
>> 129721   12972  15.36%   0.00%   0.35%  84.29%       -2   +2248  +22907   4252
>> 194581   16384  42.98%   0.00%   1.98%  55.04%       -4   +5278  +65039   5856
>> 291871   16384  54.33%   0.00%   2.21%  43.46%       -3   +6306  +22608   5665
>> 
>> We can see that with 4 registers, as expected, we are able to handle a
>> increasing number of requests more consistently, but as soon as all
>> registers are in use, the decrease in quality of service happens in a
>> sharp step.
>> 
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>
> I couldn't apply this to net-next to view it in a git tree, but from the
> email client it looks fine.
>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> Can the same kind of work be replicated on igb, or are there not enough
> TX timestamping registers there?


No, igb has only one set of registers.

But what is on my todo list is to port the TX timestamping improvements,
that were added to igc, to igb. That should already help some.


Cheers,
-- 
Vinicius
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
