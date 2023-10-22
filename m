Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA37C0032E
	for <intel-wired-lan@archiver.kernel.org>; Sun, 22 Oct 2023 13:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3EA44F51F;
	Sun, 22 Oct 2023 13:46:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3EA44F51F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697982388;
	bh=JnTPlIOvKZb7fCYkw1zy/yrPy4K2OM0A4LFwbMCRv+Q=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=kBVaSg3t4/0PokAlles9dlRvg2D9fV12EPiHYfHXMEjHWWILGCbDdXLwIq4/9vwcG
	 RynmkrLcqmYmeihzRDDqfKrd/C332xeuJTvLRIPbz41gTHzrNL3dGGDWFJ2d1hsgeK
	 kByOHY0YpMnaVlGL//tggfqRGcXi7YE+sOJQbwdse9cpFj5De7PnebgppajMRpynv1
	 lWTdWgYW1ty7S7FV7pQMAf+vM9qvaXxIAfpFFZb7l0QEhzMPfAvol/GsdRYq6B7ssx
	 y1Sv8aeJUstisR9j7qb8+WexOkEi30us2HBQFe4X9hWJ65ZYjNitRcQtWAueLLSoX8
	 wq14xIYn2o6sQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJINZYhiUjca; Sun, 22 Oct 2023 13:46:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF3F34F521;
	Sun, 22 Oct 2023 13:46:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF3F34F521
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 6A01E1BF4DD
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Oct 2023 13:46:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48DEB40AB5
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Oct 2023 13:46:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48DEB40AB5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DdchvfKG1iFy for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Oct 2023 13:46:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03A2C4023F
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Oct 2023 13:46:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03A2C4023F
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="453174711"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; d="scan'208";a="453174711"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2023 06:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="757912833"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; d="scan'208";a="757912833"
Received: from naamamex-mobl.ger.corp.intel.com (HELO [10.251.190.2])
 ([10.251.190.2])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2023 06:46:19 -0700
Message-ID: <04d2afbc-af34-4866-b04b-250143a8a837@linux.intel.com>
Date: Sun, 22 Oct 2023 16:46:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>
References: <20230921-igc-multiple-tstamp-vclock-v2-v1-0-aa0971cb0fe9@intel.com>
 <20230921-igc-multiple-tstamp-vclock-v2-v1-2-aa0971cb0fe9@intel.com>
Content-Language: en-US
From: "naamax.meir" <naamax.meir@linux.intel.com>
In-Reply-To: <20230921-igc-multiple-tstamp-vclock-v2-v1-2-aa0971cb0fe9@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697982385; x=1729518385;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5N6NumvAVlwFjW00Y1Hd1m5PT6eLfkXoJAmfLwbhvIA=;
 b=bPIczuWT05705NN5fl1NKUq15HbvoCPGgNvzTLauAmW+XU3XPZI6c/5A
 0sdB0ni4rSmU1FdP2eWp06kkJ+q03SmVWThZU069ho+HIyHygT72AJXgi
 535jaJuzI5um+qcCeQCA5cJzjTb5x6reqvNaB+OD9ARfhQJm84KHL6IIl
 hN/MRwGOSd+OoghI8Qx6+ko/R5RECz7J61yM0hGv4OFsUYHsQADCqDpIi
 iiVfX5sjWXn1Mu0/yI7+35WHyRg/iVBZ6Mi7k59wCEO4zH+yrClxcX8Mg
 8QEaIOXtv+O+PBGbFUQK7/RkSgy0s+nLmRGLZbaTPJgOnKlddrKBf50fW
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bPIczuWT
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/2] igc: Add support for PTP
 .getcyclesx64()
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
Cc: intel-wired-lan@lists.osuosl.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 9/22/2023 04:40, Vinicius Costa Gomes wrote:
> Add support for using Timer 1 (i225/i226 have 4 timer registers) as a
> free-running clock (the "cycles" clock) in addition to Timer 0 (the
> default, "adjustable clock"). The objective is to allow taprio/etf
> offloading to coexist with PTP vclocks.
> 
> Besides the implementation of .getcyclesx64() for i225/i226, to keep
> timestamping working when vclocks are in use, we also need to add
> support for TX and RX timestamping using the free running timer, when
> the requesting socket is bound to a vclock.
> 
> On the RX side, i225/i226 can be configured to store the values of two
> timers in the received packet metadata area, so it's a matter of
> configuring the right registers and retrieving the right timestamp.
> 
> The TX is a bit more involved because the hardware stores a single
> timestamp (with the selected timer in the TX descriptor) into one of
> the timestamp registers.
> 
> Note some changes at how the timestamps are done for RX, the
> conversion and adjustment of timestamps are now done closer to the
> consumption of the timestamp instead of near the reception.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         | 21 ++++++++++-
>   drivers/net/ethernet/intel/igc/igc_base.h    |  4 ++
>   drivers/net/ethernet/intel/igc/igc_defines.h |  2 +
>   drivers/net/ethernet/intel/igc/igc_main.c    | 55 ++++++++++++++++++++--------
>   drivers/net/ethernet/intel/igc/igc_ptp.c     | 50 +++++++++++++++----------
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  5 +++
>   6 files changed, 101 insertions(+), 36 deletions(-)

Tested-by: Naama Meir <naamax.meir@linux.intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
