Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E407C07E9D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Sep 2022 15:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3433082423;
	Tue, 27 Sep 2022 15:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3433082423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664292458;
	bh=ViOVdDi2TT0qkX7Y204N4BFiMDFKH3xTLxiPdJYBvZc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gGzHTOrU/wx6+ZQX4Wr/un5ghYclH5oUwCiMby2KEh4ug93gqfoVG05xSen7QtIDa
	 j57ZHsmvvF6utlsRB4+8wSv55JF2YH5yq094BI4WvuZmk5zF2ehSd79U0bqBfmIKT+
	 m5DvEn8uqbX1oAyTQUG+8UQUOzwecfFKTMvRljOGnnqpk4OD3mFIrdajNc5rpjUdyw
	 f1GjQq9E6JWIQQiiDydtyZJDcw6vKcTUqxKzABYule1DwrYDoEBFtZjTyoNmMEuonK
	 97KqUqL4vfWx4NhNQBHk0a+KFVMnTpv3OXyKlSGAkoAsfbqbNSb3nUYC/Tkerp3Of8
	 TJS8PqQaYu5vA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjD9pTzt9kpf; Tue, 27 Sep 2022 15:27:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 522B882496;
	Tue, 27 Sep 2022 15:27:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 522B882496
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1F4751BF951
 for <intel-wired-lan@osuosl.org>; Tue, 27 Sep 2022 15:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDC3182496
 for <intel-wired-lan@osuosl.org>; Tue, 27 Sep 2022 15:27:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDC3182496
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zq1L0gJY1SSe for <intel-wired-lan@osuosl.org>;
 Tue, 27 Sep 2022 15:27:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CC9A82423
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CC9A82423
 for <intel-wired-lan@osuosl.org>; Tue, 27 Sep 2022 15:27:33 +0000 (UTC)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1odCUZ-000Pws-Ru; Tue, 27 Sep 2022 17:27:27 +0200
Date: Tue, 27 Sep 2022 17:27:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Message-ID: <YzMWX1xPC0NChKNl@lunn.ch>
References: <20220927130656.32567-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220927130656.32567-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=00L8vXvRdI4FxVAid4+JoQi64LgoEtII4VifWlCMeUA=; b=Vnv9kxzcUGuh64E3WiR0fcht5X
 Im+wT7JPdHeGzT5nH5WXETxW3487dTpKLFbPsK07aCIawTcKOUcVtICo+1XqAS9E9Pi5FWxhp7cD6
 c8Lu4B04MHcfPmb7FKNRwLhho1dvr8B/+EAQ0UmdFT7r7nAv1laB37LYDYoWhHGC1fGk=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=Vnv9kxzc
Subject: Re: [Intel-wired-lan] [PATCH v1 0/4] Add support for DMA timestamp
 for non-PTP packets
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
Cc: intel-wired-lan@osuosl.org, edumazet@google.com, netdev@vger.kernel.org,
 kuba@kernel.org, davem@davemloft.net, noor.azura.ahmad.tarmizi@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Sep 27, 2022 at 09:06:52PM +0800, Muhammad Husaini Zulkifli wrote:
> The HW TX timestamps created by the NIC via socket options can be
> requested using the current network timestamps generation capability of
> SOF_TIMESTAMPING_TX_HARDWARE. The most common users of this socket flag
> is PTP, however other packet applications that require tx timestamps might
> also ask for it.
> 
> The problem is that, when there is a lot of traffic, there is a high chance
> that the timestamps for a PTP packet will be lost if both PTP and Non-PTP
> packets use the same SOF TIMESTAMPING TX HARDWARE causing the tx timeout.
> 
> DMA timestamps through socket options are not currently available to
> the user. Because if the user wants to, they can configure the hwtstamp
> config option to use the new introduced DMA Time Stamp flag through the
> setsockopt().
> 
> With these additional socket options, users can continue to utilise
> HW timestamps for PTP while specifying non-PTP packets to use DMA
> timestamps if the NIC can support them.

Although this is not actually for PTP, you probably should Cc: the PTP
maintainer for patches like this.

	   Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
