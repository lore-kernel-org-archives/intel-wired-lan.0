Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9178C3DA6E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 Dec 2023 09:47:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 715BC408EF;
	Mon, 25 Dec 2023 09:47:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 715BC408EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703497643;
	bh=SZLzaOgTHfXZbJAR1IdfOqTpG2B/fiPsQ9aWX4Mpb74=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BLjJSHlBe5T1NGzkYGODLZiolQ9Yq/KQs1E1HwgwAaIMZbvr1GjUrnta0TuDXCz9S
	 oUI0kJ4UbUkmURFE0qq22jq/wQpjz2/rHEY15SrpNzIgWgINg++yr+eDZlldLubG7x
	 l/lU4wGcX4bwImSGnZ8bc7iMhCB/sW1x4tHGYuS/Zy3hmxiO9fs0ozLXjAcZhbNyMy
	 A5oygtNvEVY2GsxRTG4Q7UXqOERHlarQR0ZiVAuKl+7wsi5CnnlDJB/EQys4U7ULQP
	 ziQarGkvoUjdpAi3U/HFyW/KZpObADi0SIO/C+uJLyiqaoSuRYCnkhmJ2jzTHlq24u
	 /zrnUpra8JABQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AoJ5Ydzy0CRC; Mon, 25 Dec 2023 09:47:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60A584150C;
	Mon, 25 Dec 2023 09:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60A584150C
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 76BBD1BF35B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Dec 2023 09:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CC90403E5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Dec 2023 09:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4CC90403E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U96MbU0XXNjo for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 Dec 2023 09:47:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 439DA40193
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Dec 2023 09:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 439DA40193
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="400101375"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; d="scan'208";a="400101375"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2023 01:47:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="777693071"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; d="scan'208";a="777693071"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.245.129.131])
 ([10.245.129.131])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Dec 2023 01:47:16 -0800
Message-ID: <c3f3e361-e875-41fb-929c-ea3f0773c8d3@linux.intel.com>
Date: Mon, 25 Dec 2023 11:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kurt Kanzenbach <kurt@linutronix.de>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20231201075043.7822-1-kurt@linutronix.de>
 <20231201075043.7822-2-kurt@linutronix.de>
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20231201075043.7822-2-kurt@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703497640; x=1735033640;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Rlpd3UlQEWJrxpTZBvVC4ryivn0KgIhOOqKJ7HEBPMM=;
 b=TxBqeFk9PcqZJEv7jPRYzJCZDRLQEDm/QKmFPu/FxotvfuZHvV49T0KK
 a40GD716QYw7aTyPSw0Qp73EmrolDudT5adVKUeKmRtwrGwzyo7tNNQD7
 zAP34yKu/QGQBCVgaLCpbAPmoRmKJnA6QJVLsfe4RinMA1byoV4HQJFxR
 x1rYeN2tSrsWJC5qycF8yppUIjZb1s98oi6p3t7FpEyrrKW0PiD20QKzo
 OJKzDY4OUlqEauQwWfysjqgx9FIN6gHFn4RqeEwJ4w+gKEbp6hHZ7hijr
 5TYfl714pUXuFAI4i/+6z2KSwwcpecJGtsz6HHTAm33+z09idxiuIvjIi
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TxBqeFk9
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/2] igc: Report VLAN
 EtherType matching back to user
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
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 12/1/2023 09:50, Kurt Kanzenbach wrote:
> Currently the driver allows to configure matching by VLAN EtherType.
> However, the retrieval function does not report it back to the user. Add
> it.
> 
> Before:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        Action: Direct to queue 0
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x8100 mask: 0x0
> |        VLAN: 0x0 mask: 0xffff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 0
> 
> Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
