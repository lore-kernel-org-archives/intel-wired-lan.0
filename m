Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E9606A891
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Nov 2026 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vhgu3AaR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EYFB0ZrL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A51340781;
	Tue, 17 Nov 2026 11:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzFm7UrdXRYi; Tue, 17 Nov 2026 11:18:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 516EE40737
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794914319;
	b=mht4e2QDpUuI0FYj1EpXaKFZKOMir24BR6/zmvqHyBT9ypJCDNzK+pVIQcr2ovL2Airp
	 wRO0BNc9HDrBQt01WMhMh3u5H+QeCMliWaY2P7+k8b3qWm090/QzZrMvs6vszlORMNFv7
	 kd45aSrNMmAhiVXzNM3yYSCJhWSxiXvZuuupNlLe3EWGi8M8nLTrAgjQS9Jqu/kzYVr8q
	 KUkAhdDVMoDIatBFJzoNBMyqBiCt0iDNr4WH+r6YCcDyKvaB9tWq175inQAgmebBT7E3n
	 HieGJHazCJRb0jbslwWlbvRfMwkPzJ023MTj3g8G0qQ8RM2cGbXy3yxxnPTja0bKN4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794914319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=R7dVIQ4XDHgLNO3WaDmdHDUJK2S7GdX6/1fBTD2EHk0=;
	b=TeYh2RSO68TFFtapRnoSe9mwAd8bnnoa/fkPR0QL9XxH5KZvjTsYJBaAvXtmWWlWmLCQ
	 3fjlYiYhR3BaqKBbBEhdsktnx2017piKV4HwjDMvJTGdXKgjjX85Ypa2oQ9gmxKNDhNpl
	 JH1SuxAlKkCrrwpCkXhyjqLXyg+dJfuWE0Hj5XPiniqkOk0XzBFP99oAJAAWdmdkVOays
	 3BDPAb2ObjL50RcWbzUeWh+7Z99GMXfYKxJm6pTV74NPx3xvzx/1hebr6B6fdU2JxFgh8
	 zDRRteGOj3fWVCXeba6Vp1YRa/i0P55Ut61ACVKKqBxj+/v4t5l3mGZie6ff5vnVVDw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794914319;
	bh=R7dVIQ4XDHgLNO3WaDmdHDUJK2S7GdX6/1fBTD2EHk0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vhgu3AaRHHpHPFJLqWmLREUf+g3IHZVXmQ/Std8OsaiHU07u8sSTscn6fYxkyyvC2
	 VeIwhf4JHA87tPe6mtiyI7Id/7S6fHWgaHEWafRh61N1IRHsPWdC+ePo4CA7RYYP31
	 s0pgpuFFBO1ARJxvRFhvBZ/e8pi1sz3ZUAXN+pGlPzz9tSrTNIpVba6TzjY4tsgN7M
	 KVgeD9Dn5/CSUKVsJ/DcH4bfWF4MNZWuRoJqNuZfH/ZhBPJBgquZqJ3sFQCVhdTB1O
	 xTBwMsT/e/lJKP+DVP+FenrugkKPf3VI3a3Ar5GnhkTUkUWjdO7jsPaLg/c0bzz5Nr
	 sDKzAc4uzNr6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 516EE40737;
	Tue, 17 Nov 2026 11:18:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E72CCA32
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CC8B640308
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mS8VckPqcpT3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Nov 2026 11:18:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2F32E402CA
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=EYFB0ZrL
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F32E402CA
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 11:18:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39DE84090B;
 Tue, 17 Nov 2026 11:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783CA1F000C6;
 Tue, 17 Nov 2026 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914314;
 bh=R7dVIQ4XDHgLNO3WaDmdHDUJK2S7GdX6/1fBTD2EHk0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=EYFB0ZrLqXIET4JkS/BVKgd6yRyKcwaD/R+wLWk80JIO7h+Efxbkdl3Yp5cqC8GG1
 7PL12tm0vPfLGwk3d5cQLYJnR8mwvIzW8gV3P54eH9tcSr//VkM0sp/vBQcfde9ozp
 KIVKtSjAl35HrzPLbYWvObkN9BqvTqqPKnDv63sweM9InhRe6Ghr0d4/Fgz1a60xyo
 f77DC9+MHuSmsi4hBUxfogtMZUDJ8kTsYLeCyQhxB2xXWywf9JsjWnsQz+O7EjY+GA
 oapVy78v/gPJLfES95xA+6CiJ5QaYtqbH/ik/Bnf/tdApTkNBAlwMr48u0XW5jXKij
 LP++VaSceUBsg==
Subject: Re: [PATCH net 2/3] igb: link queues to NAPIs under RTNL after
 runtime resume
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zheng.z.yan@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 11:18:33 +0000
Message-ID: <179491431306.3136.1748912400459389536@kernel.org>
In-Reply-To: <20261113105835.3821433-2-antonio@mandelbit.com>
References: <20261113105835.3821433-2-antonio@mandelbit.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new comment above igb_queue_napi_task() says: "The
  q_vectors are only freed under RTNL with __IGB_DOWN set, so checking…

--

igb: link queues to NAPIs under RTNL after runtime resume

When __igb_open() is called on the resume path, it no longer links queues
to NAPIs. On system resume the links are set directly with RTNL held. On
runtime resume a new work item takes RTNL and sets them, checking
__IGB_DOWN first so that it does not touch freed q_vectors.

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 028cdd90522cb..f1ce9aa696ab7 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2115,6 +2115,30 @@ void igb_set_queue_napi(struct igb_adapter *adapter, int vector,
>  				     NETDEV_QUEUE_TYPE_TX, napi);
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
> +/* Linking queues to NAPIs requires RTNL, which isn't held when resuming
> + * from runtime suspend: do it from here instead. The q_vectors are only
> + * freed under RTNL with __IGB_DOWN set, so checking it under RTNL is safe.
> + */
> +static void igb_queue_napi_task(struct work_struct *work)
> +{
> +	struct igb_adapter *adapter = container_of(work, struct igb_adapter,
> +						   queue_napi_task);
> +
> +	rtnl_lock();
> +	if (!test_bit(__IGB_DOWN, &adapter->state) &&
> +	    netif_running(adapter->netdev))
> +		igb_link_queue_napis(adapter);
> +	rtnl_unlock();
> +}

[Severity: Medium]
Is this statement accurate: "The q_vectors are only freed under RTNL with
__IGB_DOWN set"? The commit message makes the same claim.

On the runtime resume path, __igb_resume(dev, rpm=true) runs without RTNL.
It calls igb_init_interrupt_scheme(adapter, true), which sets num_q_vectors
and allocates q_vector[]. It then calls __igb_open(netdev, true). If MSI-X
setup fails there, igb_request_irq() frees and reallocates the q_vectors:

igb_request_irq() {
    ...
	if (adapter->flags & IGB_FLAG_HAS_MSIX) {
		err = igb_request_msix(adapter);
		if (!err)
			goto request_done;
		/* fall back to MSI */
		...
		igb_clear_interrupt_scheme(adapter);
		err = igb_init_interrupt_scheme(adapter, false);
    ...
}

igb_clear_interrupt_scheme()->igb_free_q_vectors() sets num_q_vectors to 0
and frees each q_vector[i]. The fallback then reallocates them with
num_q_vectors set to 1. None of this runs under RTNL.

igb_remove() also frees the q_vectors without RTNL. It is only safe because
set_bit(__IGB_DOWN) and cancel_work_sync(&adapter->queue_napi_task) run
before igb_clear_interrupt_scheme().

So RTNL does not seem to serialize igb_queue_napi_task() against the
runtime resume writer. The only handoff between them is the __IGB_DOWN bit.
The writer uses a plain clear_bit() in __igb_open() and the reader uses a
plain test_bit() here. Neither provides release or acquire ordering.

Can the following sequence happen?

  runtime resume #1 queues queue_napi_task

  the work is delayed (on rtnl_lock() or in the workqueue) past the
  5 second pm_schedule_suspend() in igb_runtime_idle()

  runtime suspend #2 takes RTNL, igb_down() sets __IGB_DOWN and
  igb_clear_interrupt_scheme() NULLs q_vector[]

  the work takes RTNL while runtime resume #2, without RTNL, reallocates
  the q_vectors (possibly through the MSI fallback) and clears __IGB_DOWN

On weakly ordered CPUs such as arm64 or POWER, the work could see
__IGB_DOWN as cleared but still load stale num_q_vectors or q_vector[i]
values. For example, it could read num_q_vectors as N from before the
fallback and q_vector[1] as NULL from after it.

igb_set_queue_napi() would then dereference q_vector->rx.ring through a
NULL pointer, or through a pointer that was already passed to kfree_rcu().
The work does not hold rcu_read_lock().

This looks like a flag being used as a lock. One option is to pair
clear_bit_unlock() (or smp_mb__before_atomic() plus clear_bit()) in
__igb_open() with test_bit_acquire() here. Another is to rebuild the
q_vectors on the rpm resume path under the same lock the work takes.

At minimum, could the comment and the commit message state the real
invariant? That is, the q_vectors only change while __IGB_DOWN is set, and
igb_remove() cancels the work before it frees them.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113105835.3821433-1-antonio%40mandelbit.com
