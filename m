Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217F5606A31F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8X3vfmlx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMqTM5aq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 018DC80B08;
	Mon, 23 Nov 2026 14:27:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ekJHZPmEoRAi; Mon, 23 Nov 2026 14:27:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1591D80DA4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795444042;
	b=hc83n48wzhcWKUnmLavQASL2qj0rAzGo2zYCRM9+EPeYms7xFK6WGEyCpP838MVfv1wC
	 Fq7h5n4GyNMedvP44RWsuuRWrtxMN/Bde+qRbKsSwQ0q4jS0vPcR4gsgxGO1CjR4yFc8h
	 iTq5l6d4GWVrTzHTqlL30Do8Rs9Fz4j4OBBmd64wQU2CrO0zZT70JPOpBy3tMaqtD+l7y
	 eo1lgH3uY91nEMsKEL1ldjfwrmzg/KqY4QoutrI80MzlChCQ8KYG7HgYSf194kBo6QDNE
	 Cx0Sau+mDU34vtNgL7gOe3149EX3qa/ZCzhIKspnVVHXPbofbnyQgdurDI4juLzS/Xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795444042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FIEfwqPEdLR1peP9GpNXpgb1AMo7kYGqg+6f5ry6xZQ=;
	b=G1rOpDABoz0Chnh9QHyh4YLl2As1ZzhPyvQNYg2jduYYBdH5z3qQ3XbiAyCQpGnDAayc
	 2oJNFrUHPED7wFpIjpNDxPjYeXmGZzOIuklUBSBbHJdCf4JjZE7skEGrRjm4m199CqHDs
	 /G0ca+JZSGWcFHxcKkq0tA6eX9YH6Lnkgq1h8r95yBGLnM6REMEahV4g+9iWDzap9t7Ik
	 GYrsqq0OBXUWNFZ8kcOFts5KuoCtraxyIjSaU8cqMeBJLwSwzftnckbM/d59EbIes1V5B
	 AfDJWydOxFF44lA+vMfYq0AQcanpa+0MfLxBgh9GpXMsycN6nbrenEtUozjyN2P22Og==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795444042;
	bh=FIEfwqPEdLR1peP9GpNXpgb1AMo7kYGqg+6f5ry6xZQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8X3vfmlxfkGYl8yCtZalmXdRrrlbnz2PrrFxyW7c42jbewNa3KNzjghu5KzfIE85c
	 9aw2KmCi4k+axrkUXj96gYZl+aqlbtMwbb3mX7I2H3hpoNnkvWOW8zIRPMfIL9V9Te
	 NGIY1x439eDjyWw+pE0Tosvmy0p3dOOG4unmAY28bT64JzEs91jMlIHIagahVQrdEq
	 ndeBzk+/WMkMB4NX7MMXn9VAd9TR5YbuFWzZSnRzxwSfEcM21d4krg3uq6rLNPw+e3
	 EFDzlj6qi7MTO8IZko42OpENUrQD4oTRzJ3Wp9wYXBdXl1Yw2U0WlYGSt+CH4ncySm
	 f1+isrrrXxOsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1591D80DA4;
	Mon, 23 Nov 2026 14:27:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 434C1260
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35822605FF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:27:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ztf8rPVsoNbN for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 14:27:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1D0A605CF
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RMqTM5aq
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1D0A605CF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 14:27:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B4089611BA;
 Mon, 23 Nov 2026 14:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37B11F000CF;
 Mon, 23 Nov 2026 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795444037;
 bh=FIEfwqPEdLR1peP9GpNXpgb1AMo7kYGqg+6f5ry6xZQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=RMqTM5aqKIsgIJ5jQlguQl6i3vOAlFN8rFfTlC21AaPzdFzY2zBRo1ZYgM1Z7fEsn
 rJvk4YLG1GDDBAHIdp2pbxJounVtyQiUlXyCjkpLMR0htc29yUjXWIHuC2xMh2joAl
 xjYzG20wiO845OuL6Jo17ByCrAvqB6xeqJAwynZaJm9YOHGMo1upidX7pf82n5lmaR
 zjBfE9WtxCZWUe/B/nswnwm8dUhNzVmzE7uf0XxvGXdifDBmeU5dMsnaP7V3Nq0AhQ
 lluG0+xEyh/Xau8e6XGFXUQLsOEx6kjEMJGna/ZTt2lttTB3sA9w3ZISVyfMfZPVQS
 x6n0lS8jMUdjw==
Subject: Re: [PATCH net v3 3/4] igb: link queues to NAPIs under RTNL after
 runtime resume
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
 john.fastabend@gmail.com, sdf@fomichev.me, sriram.yagnaraman@ericsson.com,
 kurt@linutronix.de, maciej.fijalkowski@intel.com, hkallweit1@gmail.com,
 joe@dama.to, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Mon, 23 Nov 2026 14:27:15 +0000
Message-ID: <179544403549.3135.9240068740889565692@kernel.org>
In-Reply-To: <20261119140412.163202-4-antonio@mandelbit.com>
References: <20261119140412.163202-4-antonio@mandelbit.com>
X-sashiko-severity: Medium
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch's safety argument has a memory-ordering gap.
- [Low] In __igb_open(), the comment '/* From here on the code is the
  same as igb_up() */' sits right above the NAPI enable/link loop.

--

igb: link queues to NAPIs under RTNL after runtime resume

This patch makes __igb_open() skip igb_set_queue_napi() when RTNL is not
held, which is the case on runtime resume. On that path,
igb_rtnl_resume_task() now links the queues to their NAPIs. It checks
__IGB_DOWN under RTNL before walking adapter->q_vector[].

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 6b299a1429a8e..4617aba5759d2 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4125,8 +4125,18 @@ static int igb_sw_init(struct igb_adapter *adapter)
>  	return 0;
>  }
>  
> +static void igb_link_queue_napis(struct igb_adapter *adapter)
> +{
> +	int i;
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
> +}
> +
>  /* Some settings need RTNL, which isn't held when resuming from runtime
> - * suspend: apply them from here instead, if the device is still up.
> + * suspend: apply them from here instead, if the device is still up. The
> + * q_vectors are only freed while __IGB_DOWN is set, which is cleared once
> + * they are allocated again, so checking it under RTNL is safe.
>   */
>  static void igb_rtnl_resume_task(struct work_struct *work)
>  {
> @@ -4141,6 +4151,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
>  					      adapter->num_rx_queues))
>  			netdev_err(adapter->netdev,
>  				   "error setting real queue count\n");
> +		igb_link_queue_napis(adapter);
>  	}
>  	rtnl_unlock();
>  }

[Severity: Medium]
Is checking __IGB_DOWN under RTNL enough to make the q_vector[] walk in
igb_link_queue_napis() safe?

RTNL covers the free side, because __igb_shutdown() calls
igb_clear_interrupt_scheme() under rtnl_lock(). On runtime resume,
though, the allocation side runs without RTNL:

__igb_resume(rpm = true)
    igb_init_interrupt_scheme(adapter, true);
        /* sets num_q_vectors and q_vector[i] */
    __igb_open(netdev, true, false)
        clear_bit(__IGB_DOWN, &adapter->state);
    schedule_work(&adapter->rtnl_resume_task);

clear_bit() has no release semantics. igb_rtnl_resume_task() reads the
flag with a plain test_bit(). It then loads num_q_vectors and
q_vector[i] with no acquire or smp_rmb() in between.

schedule_work() orders a work instance queued by this resume. Does
anything order an older instance that has already started running
(PENDING cleared) but is still blocked in rtnl_lock()? For example:

1. Runtime resume #1 queues rtnl_resume_task. The worker starts and
   blocks in rtnl_lock() behind another RTNL holder.

2. Runtime suspend runs __igb_shutdown(). Under RTNL,
   __igb_close()->igb_down() sets __IGB_DOWN, and
   igb_clear_interrupt_scheme() frees the q_vectors. Nothing cancels or
   flushes rtnl_resume_task.

3. Runtime resume #2 (for example a link-up PME) reallocates the
   q_vectors and clears __IGB_DOWN without RTNL.

4. The stale worker gets RTNL. Its rtnl_lock() pairs with an unrelated
   holder's rtnl_unlock(), not with the stores from resume #2.

Could the worker then see __IGB_DOWN clear while still reading a stale
num_q_vectors? It could also read a q_vector[i] that is NULL, or one
freed in the earlier cycle. igb_set_queue_napi() would then dereference
q_vector->rx.ring.

This needs an RTNL stall that lasts through a whole suspend/resume
cycle, plus a weakly ordered CPU. One fix is to pair clear_bit_unlock()
(or smp_mb__before_atomic() before clear_bit()) in __igb_open() with
test_bit_acquire() here. Another is to cancel or flush the work outside
RTNL before the q_vectors are freed. Either would make the new comment's
claim hold.

> @@ -4219,7 +4230,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
>  	for (i = 0; i < adapter->num_q_vectors; i++) {
>  		napi = &adapter->q_vector[i]->napi;
>  		napi_enable(napi);
> -		igb_set_queue_napi(adapter, i, napi);
> +		if (rtnl_held)
> +			igb_set_queue_napi(adapter, i, napi);
>  	}

[Severity: Low]
This isn't a bug, but __igb_open() still has this comment just above the
loop:

	/* From here on the code is the same as igb_up() */
	clear_bit(__IGB_DOWN, &adapter->state);

igb_up() still calls igb_set_queue_napi() every time. This loop now
skips it when RTNL isn't held.

Should the comment mention this difference and the RTNL dependency? A
later change that resyncs the two paths based on this comment could
bring back the RTNL-less netif_queue_set_napi() call.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119140412.163202-1-antonio%40mandelbit.com
