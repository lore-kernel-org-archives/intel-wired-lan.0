Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05D60A2627
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vb/z+FiO;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouneHihr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C96D340534;
	Tue, 10 Nov 2026 17:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLgRbztSydoF; Tue, 10 Nov 2026 17:53:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E3CBA408D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333205;
	b=qfpQuMExFCFJMc1CkdJQQo55vMj0LsWzGrgYeqG6lLa7xoseDt+0D/3rJm7514381hCG
	 pPzcWSNQpi80fBBYn0umVX8lxRiSwxpWWs1QoNDwN8gFbbek+aRkuQoiRsKln5qo84Nmo
	 siiB7CPf4IV4try1s9ZGtiKtH8khnEkkNsn2ebZGuoKoLjtc7D9zNpDU5XoOIl8XaSnb7
	 oDIn0hTtiVGL6Ezr+vscaLgHJRQi/K3K/nYrGdevQeMOBEqQX4TUNDU5aq5pYlUHRCYjk
	 HGhjqGz+nBXraqE4dC/0nmCAYCHHuls6XkFmnJEhHcXT/Aw6cq8lsUNhrCGIW85XXLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6MQvK9HWwZWHwV5/ACER8rs2MpoHm1YL0h+P0A0LB84=;
	b=X3p+D9krjX36LxfI2IA7rPWGhOvhlBuO5rRRcdGG+72cZ9sNNZkqPpzpbay5UBXi/E+N
	 VAXdl4AH4SFvgmUYoWG3SWgQQaYwKlka9Mtrum7erNrErLxHr/pU3u4f9EgzuY9U3fpyb
	 7cubwoYZmehbSjntKF4aj/LQgdJOkmDp6deQ69fYOUAhA+9f6lTjvXBqB2fJWDeV5QL7S
	 vcQqMITcFnV9PQkbcVtCM/PMBbVsZJTAgGq8i6qEkmp7menv8QhvkQ72kbPsbfb4yvtq+
	 aXhroV/9MmIXLjED61tcC/kwbkvPp9q+goq99bclcCnJ9Lhkc9UfeaOWMcVHuTydH9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouneHihr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794333204;
	bh=6MQvK9HWwZWHwV5/ACER8rs2MpoHm1YL0h+P0A0LB84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vb/z+FiOk5tQrT/U/+rgMGO62uJejQrzZLQq85EzXkKdl00nZV8NaoU1MQSerIWPt
	 435zQyFsmv5CH7a/w3FTyIpoDu4cvQOxnKlXsOZEheaaBEXrnkP0wwL7IneeUXk6o9
	 mfcwCCzXoJT9YPZTj0N2jMjcoGC/6SqTXiOk2E06tzKMQS9zhKt3vTIdRooT25IIW5
	 3b04PAftjVLqhxo7WxrT6o1hFIyJfMYNrfATvdIH0bsE1QlnefQ5Z2R0tIOv+mPZ29
	 AxbbiO5DFp4QYN3i6o/HAVdTqPNNJEaWymyKLOv1/yugrCKw6dqT5oLVGmYMybrBfv
	 AzevfgoOe5u9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3CBA408D1;
	Tue, 10 Nov 2026 17:53:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 745BB1FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59299408D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OM1Oem4s-KTt for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:53:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40FA140534
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ouneHihr
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40FA140534
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07FCD4383B;
 Tue, 10 Nov 2026 17:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48D01F0089F;
 Tue, 10 Nov 2026 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794333200;
 bh=6MQvK9HWwZWHwV5/ACER8rs2MpoHm1YL0h+P0A0LB84=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ouneHihrCG3paXR7Ptpn3Lx6Wvz8tQZc3rajD77OTxzog01M9G8DIlQrR0PlosCoK
 dK7EBIK42+YA1f/e9BxrblvrbCvGoa7/BHbl32Be1QFK9DLFB+cLuOIB/T9Bwj66Yd
 1jg+ed88eWOWGndCVkkrvrooV7/ZxiIDWdJ/28F+JOwP9Xt0kPepnEIRLcOLFOhZTS
 PrduKLSb4RsLMNFFA9s8Q75OapieXdiIOuHMkBgFi98g5v+weyVxMMZ6fBTNA1GTq1
 poTl/zVfvu98L5iPdhMnbbpzsxHW9t04hSJGoiqbIIWUltS02JrcGDGByzpoEY/kN3
 RQIMYYmU0wQoQ==
Subject: Re: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from
 the periodic work only
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:19 +0000
Message-ID: <179433319925.994134.5092477928749468374@kernel.org>
In-Reply-To: <20261106121005.1327603-2-ivecera@redhat.com>
References: <20261106121005.1327603-2-ivecera@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] This patch leaves the comments in
  ice_dpll_tspll_state_on_dpll_set()…

--

ice: dpll: notify TSPLL lock status from the periodic work only

This patch stops ice_dpll_tspll_state_on_dpll_set() from sending a TSPLL
device change notification from the TIME_REF pin callback. The callback
now only updates dpll_state. ice_dpll_periodic_work_e825() refreshes
dpll_state on every run and sends the notification when the state differs
from prev_dpll_state.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index ade1fb3dd0674..bdbcf7af296eb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> @@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
>  		WRITE_ONCE(pf->ptp.tspll_locked,
>  			   new_state == DPLL_LOCK_STATUS_LOCKED);
>  
> -		if (tp->prev_dpll_state != new_state) {
> -			tp->dpll_state = new_state;
> -			tp->prev_dpll_state = new_state;
> -			changed = true;
> -		}
> +		/* ice_dpll_periodic_work_e825() compares the state with
> +		 * prev_dpll_state and sends the notification.
> +		 */
> +		tp->dpll_state = new_state;

[Severity: Low]
This isn't a bug, but do the comments in ice_dpll_tspll_state_on_dpll_set()
still match how the notification path works after this change?

The new comment reads as if the periodic work compares the tp->dpll_state
written here. In ice_dpll_periodic_work_e825() that value is never read.
The work recomputes the state from the cache and overwrites dpll_state
before it compares:

ice_dpll_periodic_work_e825() {
	...
	new_state = ice_dpll_tspll_lock_status_get(pf, true);

	tp->dpll_state = new_state;
	if (tp->prev_dpll_state != new_state) {
	...
}

The older comment just above the WRITE_ONCE() was not changed:

	/* Sync the cached lock state to what we just observed from HW
	 * so ice_dpll_periodic_work_e825() (cached path) does not emit
	 * a spurious UNLOCKED notification between now and the next
	 * PTP monitor tick.
	 */

That reason applied when the callback also set prev_dpll_state. Now that
it doesn't, the WRITE_ONCE() to pf->ptp.tspll_locked is the only way the
callback's HW reading gets to the periodic work.

Without it, take a switch from TCXO (prev_dpll_state is UNLOCKED) to
TIME_REF where the HW reports LOCKED but the cache still holds false. The
next periodic run would compute UNLOCKED, which matches prev_dpll_state.
No notification would be sent, and dpll_state would go back to UNLOCKED.
The result would be a lost notification, not a spurious one.

Could both comments say that the periodic work picks up the new state
through pf->ptp.tspll_locked? Then a later change is less likely to drop
the WRITE_ONCE() as just a way to avoid spurious notifications. As far as
I can tell, the comments are still unchanged at the end of the series,
after "ice: dpll: update locking comments".

>  	}
>  	mutex_unlock(&pf->dplls.lock);
> -	if (changed)
> -		__dpll_device_change_ntf(tp->dpll);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
