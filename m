Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8008606A333
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Nov 2026 21:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=q8fJDSV+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDCxueI8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1B8C808D9;
	Tue, 24 Nov 2026 21:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5RYv3K1m0es7; Tue, 24 Nov 2026 21:38:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B44388096E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795556329;
	b=Gzanrdmr5kdfJMYrr0qRnK7pMzHcodNFbdFQcz34ur+GOsq3gzdO5trj+vCNNLTAyeXu
	 vyUJ7tc8qSl3keklu2JTLGWHKjK8ARAaDqRcoaBQtRuASyPbTos4d3zRgaJGrGGWW6Bl2
	 BVu2ZqK0qZhHvZR1eYbkXOMskGSXCdRKls9X4jVJJTSRnwqa8AeeK5M8AFhSLNUV53S9m
	 dcZ1PjS+lSywHPIt98d/UJTNS7j0sc/b8rG8Qlu4tLSrhFvV3coS0vDpp2XQy/3xsHSuk
	 T9KrwjrH0bb3c00X5RtJ5HqqQssiZenOoHhV7QM2Oit2PBxR4+/oIncTG09x01/6uNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795556329;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AFWQM/ayVfLWcrTdIVoMV9feWq7JxicreTRydRV9/s8=;
	b=Yg6ut3yaFJwJQ70YkqAETA/NXJUO6HRHcdB6Ta/gbBQTUiJ40pwDvgtXpTt86qy48XMM
	 Iokif5jOeDbOkSPQ2wsl0mn2dZbuhIRwR5w89GVDINuVwnM2ZP657uSUZIpbEHPMMQ8A+
	 6E4q1pAICeZzaIs/1APjGhj+RIKsLAamwCwIsxw+Q8Upy7vzCSygHr2UMq+FaYcTf1KwC
	 HAnHN68+pi4A+A2jYeOqZ0rmE5/92GE5rjcGq2eBm+nSqMRXvSVRdHBCpbBtClfqVkfEh
	 lioZo1JnDAP4iZRsksMfjXSfw3HhaVmbEK0qkqtWUtKvukpcjpdiDzo9RlBAneRnXXw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795556329;
	bh=AFWQM/ayVfLWcrTdIVoMV9feWq7JxicreTRydRV9/s8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q8fJDSV+RUFKYlCfV7Cag7n+6mx6luXwjlvyyVlOodIBRdnxBG3Sj7uUHf8cIIq3L
	 B2QEKrE6zdeG4ufO05W46OGOk3T5u4/9w2muIeGE+zQUMmECkVDyAfBftimNmgYVwL
	 4Ro24Vpw1X0X3eZ9SPN+NDO8Hy0wM2f+HCbTpjZKbppWs7ZPLulqsJZ9eCbFWUvYgG
	 VgItbx8sFFMB6JDI1ojvc7eoHBnh8G8TXH2+TQeCPkmgp6S9jkKxsd7gYUlUpRnQZV
	 7E2dZPzrbJ/+8+XN5xCB9p/sUN9vTQhsLWewqe1u2vCO3f0LSv75rpRuKWkKUmaatL
	 kSiwpgk4qX4qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B44388096E;
	Tue, 24 Nov 2026 21:38:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AB3772F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A92AE4009D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X64uv9ogUxlr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Nov 2026 21:38:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A13D340071
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oDCxueI8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A13D340071
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Nov 2026 21:38:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACF4042204;
 Tue, 24 Nov 2026 21:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F941F000E1;
 Tue, 24 Nov 2026 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795556326;
 bh=AFWQM/ayVfLWcrTdIVoMV9feWq7JxicreTRydRV9/s8=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=oDCxueI8fo43C72o5hrQwU9UzrMnJhUaymgEwGotgJ75Ef54xTnOoWzObgfgAIqeI
 5Q1sb67Szyo27VAP1wP5ASceIHDRpxOfr4UjupEMiD2jqbeO+/2UFYcG372la0QH6Z
 FrddEyIlxFbXIaBVOiH7TxLmJOjcG4Ze4vS+tuHS0r84b6szcbmsE4Wa22cuwKgDb0
 yfPoWMdktYaUjnDB6DT6Lu+mGZodPqurWM/20WoBvurdyLOMvmXmtD6+UGMHGyGYw6
 lyjH4M7wk+TIGgn3A5o4F8tE/Ax/9cLteX336RAUzSOrO2IrTDDV9fG0WBzEtQ2sCh
 3KyJj1HOGa7tw==
Subject: Re: [PATCH net v4 3/4] igb: link queues to NAPIs under RTNL after
 runtime resume
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 21:38:45 +0000
Message-ID: <179555632542.3135.3194340362837900458@kernel.org>
In-Reply-To: <20261120210134.133238-4-antonio@mandelbit.com>
References: <20261120210134.133238-4-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] igb_rtnl_resume_task() now calls igb_link_queue_napis(), which
  reads adapter->num_q_vectors and dereferences adapter->q_vector[i]…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but igc has the
  same bug.

--

igb: link queues to NAPIs under RTNL after runtime resume

This patch stops __igb_open() from calling netif_queue_set_napi() when
RTNL isn't held, which is the case on runtime resume. The queues are
linked to their NAPIs from igb_rtnl_resume_task() instead, and that work
item uses an __IGB_DOWN check under RTNL to decide the q_vectors are valid.

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

Is checking __IGB_DOWN under RTNL enough to make the q_vector accesses in
igb_link_queue_napis() safe? The free paths all hold RTNL, but on runtime
resume the publish side does not:

igb_runtime_resume()
  __igb_resume(dev, rpm=true)
    igb_init_interrupt_scheme()   /* stores num_q_vectors, q_vector[i] */
    __igb_open(netdev, true, false)
      clear_bit(__IGB_DOWN, &adapter->state);
    schedule_work(&adapter->rtnl_resume_task);

None of this runs under RTNL, and clear_bit() has no release ordering.

Also, nothing cancels or flushes rtnl_resume_task on runtime suspend.
__igb_shutdown() frees the q_vectors under RTNL, but the only
cancel_work_sync(&adapter->rtnl_resume_task) is in igb_remove().

That means a work instance queued by one runtime resume could still be
pending, or waiting on rtnl_lock(), when the next runtime suspend runs
after the autosuspend delay. It could then still be waiting when the next
RTNL-less runtime resume runs.

Once the work gets RTNL, its loads of num_q_vectors and q_vector[i] are
ordered after the relaxed test_bit() only by a control dependency. A
control dependency doesn't order load->load on arm64 or POWER.

Could the work then see __IGB_DOWN clear and the new num_q_vectors, but a
stale NULL or freed q_vector[i]? If so, it would oops in
igb_set_queue_napi() when it reads q_vector->rx.ring.

This seems unlikely in practice, since the q_vector stores happen well
before clear_bit(). Still, would either of these make the claim in the
comment hold?

- A cancel_work_sync(&adapter->rtnl_resume_task) in the runtime suspend
  path before rtnl_lock().
- An smp_mb__before_atomic() before clear_bit(), paired with
  test_bit_acquire() in igb_rtnl_resume_task().

[ ... ]

> @@ -4219,7 +4230,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
>  	for (i = 0; i < adapter->num_q_vectors; i++) {
>  		napi = &adapter->q_vector[i]->napi;
>  		napi_enable(napi);
> -		igb_set_queue_napi(adapter, i, napi);
> +		if (rtnl_held)
> +			igb_set_queue_napi(adapter, i, napi);
>  	}

[Severity: Medium]

This isn't a bug introduced by this patch, but igc appears to have the
same problem. igc_runtime_resume() calls __igc_resume(dev, true), which
only takes RTNL when !rpm:

drivers/net/ethernet/intel/igc/igc_main.c:__igc_resume() {
    ...
	if (netif_running(netdev)) {
		if (!rpm)
			rtnl_lock();
		err = __igc_open(netdev, true);
    ...
}

__igc_open() still links the queues unconditionally:

	for (i = 0; i < adapter->num_q_vectors; i++) {
		napi = &adapter->q_vector[i]->napi;
		napi_enable(napi);
		igc_set_queue_napi(adapter, i, napi);
	}

Wouldn't igc_set_queue_napi()->netif_queue_set_napi() trigger the same
"RTNL: assertion failed" splat on every runtime resume while the interface
is up?

The note about igc is below the --- line, so it won't be in the commit
log. Is a separate igc fix still planned?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120210134.133238-1-antonio%40mandelbit.com
