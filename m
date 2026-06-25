Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E039ECDE008
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jun 2026 10:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FCC860FF2;
	Thu, 25 Jun 2026 10:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZMmmWjuyBpaC; Thu, 25 Jun 2026 10:38:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7771B60EA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782383916;
	bh=TEQzGGFrxNtB6gMa9EEbVW6dodrdivVnbfUJXkNVajM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=K27BEd8ra9CBGu6aag5n8ReXQMrI63Ep5PN19FYMgBev6PJVuRh9pRuc7Ukpbqohk
	 V5J6wMHfVgUs3uYcISzWBS0jjVQi4YaVU+MGhbIfeAc38gyzy4NF7HjfHcg6wgbP4z
	 pvXXDBBaR9p7cWeMRFTi0nXWgxR2CudgqO4fe1wPpi7BKzFL9PKd4XNkOgZ1nKrkuD
	 42A6h+zWHVLjdxNLeOi7t15bCqfLHbgSSmSPeCjErFtzM2eBUXn7rO4w2W9PnMuVKS
	 m/BM6R7BG7ARvjGp5s1G/rJ+cUkDzZdxCyQs96gxqqN5TzmyCNqr88IQVRqL+r7lUb
	 BGxwV64+uWQDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7771B60EA3;
	Thu, 25 Jun 2026 10:38:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B9BAC18F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jun 2026 10:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB5584073B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jun 2026 10:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z2bY7K_yJfWx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jun 2026 10:38:35 +0000 (UTC)
X-Greylist: delayed 306 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 25 Jun 2026 10:38:33 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 46FB1400A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46FB1400A5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-1335312-20260625103322b06980181500020783-0zjz0u@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46FB1400A5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jun 2026 10:38:33 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260625103322b06980181500020783
 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jun 2026 12:33:23 +0200
Date: Thu, 25 Jun 2026 18:33:14 +0800
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
 jan.kiszka@siemens.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wq.wang@siemens.com
Message-ID: <guqc6o3b7hfl66qiuglb46apqdlufiuyhxeuhme66jvjkb67a7@owd45vcy7uv6>
References: <20260622041718.6106-1-meng.ding@siemens.com>
 <40abd0b5-7f3f-4cd4-9975-9db4498d15d3@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40abd0b5-7f3f-4cd4-9975-9db4498d15d3@molgen.mpg.de>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; s=fm2; 
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=TEQzGGFrxNtB6gMa9EEbVW6dodrdivVnbfUJXkNVajM=;
 b=tGJizTwjajXkLUyXQ7+sSEQj7hAdSllHPHz0LNjsFt/xqf+XDKzvaivZAIL3QBrg09Qyxk
 1XaxIWfsEjYnZEffaZ5dL3vjZfxWzyIFco75yVhOb5q7AzDOdvu4dvxzgXTIGX5YnQ5z885c
 YZ/9SYuHoz5/tadqXwXzVzYxLnP7HcfkJ+pX6ZEUvyKDGvc3hPMAonSdqo2HmQd55SvscbeR
 ddr/3qBtf22rxnrCeKn2wb16Rvg4WFe2x/BGFV4Rt/sFQr9kSGuZhTwqwh0SMCCXa/LPs9iP
 940TJzzziXEIXKdPgqQb6FAcm6WUE2oyo6MU6rLTGVm6Yi/kiiuguzMw==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=siemens.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=meng.ding@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=tGJizTwj
Subject: Re: [Intel-wired-lan] [PATCH net] igc: Fix RX HW timestamp
 reporting when NET_RX_BUSY_POLL is disabled
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
From: Ding Meng via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Ding Meng <meng.ding@siemens.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Paul,

Thanks for your comments.

On Mon, Jun 22, 2026 at 05:59:53PM +0200, Paul Menzel wrote: 
> Am 22.06.26 um 06:13 schrieb Ding Meng via Intel-wired-lan:
> > When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
> > from the NIC no longer works as expected.
> 
> Maybe paste some logs/errors, so it can be easier found by people with the
> same issue.

Will do.
 
> > This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
> > SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
> > fails to perform its driver lookup, and the igc driver's struct
> > net_device_ops::ndo_get_tstamp is never invoked.
> > 
> > Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
> > a field that the driver has not populated.
> > 
> > Fix this by populating the hwtstamp field with the correct timestamp
> > in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
> 
> Maybe detail, why the adapter needs to be passed now.
> 
> Also, please describe a test case to check the change.

Will do.

> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > index 8ac16808023..1da8d7aa76d 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > @@ -1992,7 +1992,26 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
> >   	return skb;
> >   }
> > -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> > +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
> > +					 struct sk_buff *skb,
> > +					 struct igc_xdp_buff *ctx)
> > +{
> > +	if (!ctx->rx_ts)
> > +		return;
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> 
> Is there a way to do this in C instead of the pre-processor. That way all
> the code gets build tested. (Is there a config with disabled
> NET_RX_BUSY_POLL?)
> 
 
How about defining a function to replace the pre-processor:

static inline bool is_net_rx_busy_poll()
{
#ifdef CONFIG_NET_RX_BUSY_POLL
        return true;
#else
        return false;
#endif
}

CONFIG_PREEMPT_RT=y && CONFIG_NETCONSOLE=y will cause NET_RX_BUSY_POLL
disabled.


Kind regards,
 
Ding Meng
