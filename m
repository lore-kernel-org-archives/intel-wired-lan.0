Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A069CC6B38
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Oct 2026 16:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3672860B57;
	Fri, 16 Oct 2026 16:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7nvzBLZZSOp9; Fri, 16 Oct 2026 16:56:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F3F360AD7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792169806;
	b=hGmrzrjG4/DIlgi+R5aDiG0p6FLzT7xR09QVVjexwAqHdf49Zb7jMv6nDXaIEEmBsE+D
	 q/oWIoRV3lW9Lb0T3+MSyvH8+iJAfs1y5bKqzOO0iWCdxvQIcF/JV8/gwd8BsbZPiT6Vl
	 jmJi1MmI98LfvK0KnMVmlwnXxejPvHheq5VJCrifDLnq9Jekhp9ohu4f2Dtpd4k8fa7+R
	 8fy+TXQbL726l+nTYAQ3vGyAMyrs4C3IjpAqJlEVa/KF7mfyiDhuraymVLEghvgoPDulH
	 9qV9R0BZ40BlWPX0TyCp25N5oKpUpF6nYkuHNFiqxrZ8esta6FHXSIkfZYMo2wUamyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792169806;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M86NJ4IZ6fNbViWJtHydCb8YPVJzzZtCVo1NWFk9yDs=;
	b=LU9mxcrZZZYS8SAOdrAPhX5SNwnlVd/GYH+rI9Pnrcp+ZPObxl9KApZdBe6tQZ+X1kOv
	 cpC5jI7cc2vfDnJqMpzNHj7V3g+EU9blYS4e2kcKs74pDVblat7Jyr4vp/LeEQQGq0JAD
	 L7QQQzL3OINRVDPq7CQ8rRfMFbe3djuel8wY/SCt8HHDDhDQfDBnOZyd6/2EahCsWsLtK
	 FMFUlgdEkDIcqs4V6yk8RcDwsCfhVArak2tji9VBHfp0XD8MFWNeLbtZZFtLwLtIByB39
	 RGKFYitlIf4k9m7QlyNBssF6G32fV5c2EKWQY5u8x6BKqk723GO49ScKCkEF5KvGk6w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792169806;
	bh=M86NJ4IZ6fNbViWJtHydCb8YPVJzzZtCVo1NWFk9yDs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3IYJ8Dl11owMBgqOKKUtd5atCSTpznWbxsNmoMT2oFjvvfOzkO4rXDyJFoUyHYsGW
	 yZxF8dsonQm1TeaKMG1qZPwaBaNPnS0DgL9U9ZR3PMCkri6/BW8+eNMF9sJk0vjSZY
	 xDsQmXGxjT//WtWlmybeXohjk5Qmwvi8/Swf3BeNo3qaDCZhf4FSYi+zQUCq7uM5ZD
	 qBCOvEnsz56rsQECyMhxZVANM2aOcggTIccMdXtOK/VSaacf0s2VxXn/Kk8RNAW7Zw
	 Fxzrx1EURBSV9zDNjpWoQBecKzw15ITSSOzk6bljjMaz0FHupFniFcGXjNwEsPdRMT
	 grw4+uF23SZPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F3F360AD7;
	Fri, 16 Oct 2026 16:56:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EBCC7105
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E95398167B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RO-z_6D_O9sZ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Oct 2026 16:56:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8CDE881677
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792169803;
 b=FJDaLfVOhEp/1h5U2e/tdrzJcMT0en7DwN2iLtXmeses3lDW56Fdo1GLEOOG0ffUAhAO
 ksq2vLsux96ETZza8ofw2qE+U7ThOPMDAZ7Jj/k7SVsyZqRxZWB64srDD3Hj7j5i65FjZ
 GJ2gpjQ/Y9BhCKd8C7MNW9OnTvybzRyNeQ2OqtdGI938fnoyplw7r+IDqoTiPMZJYBjzk
 0qVtNgfJIuBYFShMtk/n6OPu891ljn6x3S1tp+x8KbHwAXSY2zCZP5T0kTWPEMuim4wuQ
 MmHBevO8ICMfPwwMy/QrzNlHr3y8OnKi8MhQkp5R/ggT1GVvhZcvk0BO+u/czNT3kGQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792169803;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=M86NJ4IZ6fNbViWJtHydCb8YPVJzzZtCVo1NWFk9yDs=;
 b=K3Q8xRsZlBUuyN4CjzXTBgE/2yiZw+sobmaIQ4I8HE3vvPj5KUeNAxZxhuKeFnrcjRxz
 hB/k/j1AqPRC0qrmRExUfi/r/fzeoV8RRgNQ3f8UBi1/xYWB4KEvXDMaQQ9UVWey0BQOv
 BPI5dPfhBGDU+b6JqxnQVzy1xLPofq4vES3LwncxWtUCP5URUYy+eJlqPxfVEF28kxfuy
 rRG7ByLptFSyZ68L3FyC0wLn7arHOe41tZyC1ZQpzTjvzuQmyEs/2Dzv2PzVF6xRBnAWw
 yhgYnTfc87yDDQh5tqnyohn1YL/5Fb36b3vpIgDXEl0UIq9wlr4gcsasaufKrmsqZ6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=molgen.mpg.de;
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b=YfFF7DuQ; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=YfFF7DuQ
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8CDE881677
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 16:56:41 +0000 (UTC)
Received: from [10.0.36.124] (unknown [62.214.191.67])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0ABF64C442F863;
 Fri, 16 Oct 2026 18:56:02 +0200 (CEST)
Message-ID: <5a1b4d3d-c2c4-4b3f-8969-551767309ded@molgen.mpg.de>
Date: Fri, 16 Oct 2026 18:56:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ice: fix Tx hang dump using stale tx_buf[0].skb
To: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261016-ice-tx-hang-dump-v1-1-3df0f5979a51@hydroquebec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1792169762; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=M86NJ4IZ6fNbViWJtHydCb8YPVJzzZtCVo1NWFk9yDs=; 
 b=YfFF7DuQldV9OVPmSexX3aVubwPR3i7CDpaUPPEl2FVG7McvNAIyadMcH8KU0dHwLfR7yPtJgvLN
 Vm+a/eC3ntuytUHmF2fFiGPatyVGHvr+9bzMr53XlFLNwf6/4U/DH1DhwHY6mtiwfTPkSI8xRSFMZA
 0tzGsuxV7WmroroHeNKUbT3ckgXUI8x5hOOLgkgM6Zl644V4vI/mQYqWuMk0wKaZJ5EWNl0EEBsC2n
 /XT0YqbVeHElexuLi4TsnW3t8nRH1QMz4hrRtjYtxHLp2ysH9TIJ+TMTeI9dxSARGo2zOSQwCgUIPD
 H79DG8g1YWw+xyVpVLJbA3knh+wc9P5A==
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

Dear Vincent,


Thank you for your patch.

Am 16.10.26 um 15:08 schrieb Vincent Choiniere via B4 Relay:
> From: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> 
> ice_tx_hang_reporter_dump() always reads tx_ring->tx_buf[0].skb,
> regardless of next_to_clean. The Tx cleanup path frees the skb and
> marks the buffer empty without clearing the skb pointer, so slot 0 can
> hold a stale pointer. A NULL check alone does not cover this, and
> devlink_fmsg_dump_skb() can fault on the freed skb.
> 
> Read tx_buf[next_to_clean] instead, use its skb only if the buffer type
> is ICE_TX_BUF_SKB, and skip the skb dump otherwise.
> 
> Observed on an E810 PF passed through to a KVM guest (Ubuntu 7.0.0-14,
> PREEMPT_RT, local scheduler patch): a delayed queue IRQ led to a Tx
> timeout and a page fault in devlink_fmsg_dump_skb():
> 
>   BUG: unable to handle page fault for address: 0000000004cd0c11
>   Workqueue: ice ice_service_task [ice]
>   RIP: devlink_fmsg_dump_skb+0x2d8/0x5d0
>   Call Trace:
>    ice_tx_hang_reporter_dump+0x1ce/0x210 [ice]
>    devlink_health_do_dump+0xcc/0x190
>    devlink_health_report+0x1d7/0x260
>    ice_report_tx_hang+0x7d/0xa0 [ice]
> 
> With this change and auto_dump enabled, starving a queue IRQ thread
> reproduced the Tx timeout; the dump contained the test packet, no Oops
> occurred and the PF recovered.

Also past the dump (excerpt)?

> Fixes: 2a82874a3b7b ("ice: add Tx hang devlink health reporter")
> Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Choiniere <choiniere.vincent@hydroquebec.com>
> ---
> This complements the NULL check in [1]. With only that check, a non-NULL
> but stale tx_buf[0].skb is still dereferenced by devlink_fmsg_dump_skb().
> I have only reproduced the crash on an Ubuntu 7.0.0-14 kernel with
> PREEMPT_RT and a local scheduler patch, and the skb lifetime against
> concurrent Tx cleanup still needs review. Feedback welcome.
> 
> In my case next_to_clean was 0xfc while the reporter read slot 0.
> Upstream v7.0, v7.2 and current net main (191aa4154) all read
> tx_buf[0].skb unconditionally. Before this change, recovery stayed
> stuck until reboot.
> 
> [1] https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/
> ---
>   drivers/net/ethernet/intel/ice/devlink/health.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a817..059859c36 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c
> @@ -390,12 +390,15 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>   				     struct netlink_ext_ack *extack)
>   {
>   	struct ice_tx_hang_event *event = priv_ctx;
> -	struct sk_buff *skb;
> +	struct sk_buff *skb = NULL;
> +	struct ice_tx_buf *tx_buf;
>   
>   	if (!event)
>   		return 0;
>   
> -	skb = event->tx_ring->tx_buf->skb;
> +	tx_buf = &event->tx_ring->tx_buf[event->next_to_clean];
> +	if (tx_buf->type == ICE_TX_BUF_SKB)
> +		skb = tx_buf->skb;
>   	devlink_fmsg_obj_nest_start(fmsg);
>   	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
>   	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
> @@ -409,7 +412,8 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>   	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
>   	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
>   				     event->tx_ring->count * sizeof(struct ice_tx_desc));
> -	devlink_fmsg_dump_skb(fmsg, skb);
> +	if (skb)
> +		devlink_fmsg_dump_skb(fmsg, skb);
>   	devlink_fmsg_obj_nest_end(fmsg);
>   
>   	return 0;
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
