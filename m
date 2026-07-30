Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5837CC55165
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Jul 2026 12:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 082A16068C;
	Thu, 30 Jul 2026 12:26:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wwyO8BECs7-W; Thu, 30 Jul 2026 12:25:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BBFB606BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785414359;
	bh=lpMA6Y8SQpR03HLgMbb8mUFVl3OtsfazuoBzzZEHBNs=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ogNvOirOZbw6yiE2awUFrSY9aOv7nCuZncO9k3uVH8q72X+t9EaRXzznUvA+Ho0rO
	 00heqGuy/jpjVa+u2yMYpPgoVfpauBZ2+uJkROo9TfYRgRWlqeGuREjkhKj6I+8zS3
	 1IkPipr8eVt7jipEaKsqTHhppbderi/B8hudbYsRqmBUtVE7OJrNtfUzFbi9Hf76xI
	 shBmFetzkMxO3FxLjp4rn9KG/yuhQocB2PcqlwVKcheeETu1XeSLd2eZEg/E1LT6S8
	 dNUbauCq7kwO7x6Mbt/VsNXA4sZM0fyMgVd9cxKtIYe1QoyjuPCdKYx/okjxXJaWFn
	 Gj+G0HT9RnzeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BBFB606BD;
	Thu, 30 Jul 2026 12:25:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C77627B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0943D40224
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:25:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23SKhpcRE8wB for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Jul 2026 12:25:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E9463401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E9463401A3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E9463401A3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Jul 2026 12:25:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7747A60A5A;
 Thu, 30 Jul 2026 12:25:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905E91F00A3A;
 Thu, 30 Jul 2026 12:25:52 +0000 (UTC)
Date: Thu, 30 Jul 2026 13:25:50 +0100
From: Simon Horman <horms@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com,
 piotr.kwapulinski@intel.com, arkadiusz.kubalewski@intel.com,
 aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Message-ID: <20260730122550.GA51943@horms.kernel.org>
References: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724093448.63154-1-xuanqiang.luo@linux.dev>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785414355;
 bh=lpMA6Y8SQpR03HLgMbb8mUFVl3OtsfazuoBzzZEHBNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=g8dWPKDchVoDtm0hgvHiiCLG9EevebFIkn48QcwXerpU7KXCHpM0Pz9rIHj5cWL8I
 FtfOGVO0YC0S14Ae8nAK7AX8d6QNdPd/6ax0xW4bTmR9i1IBWV4YkosWsSw1efNXLf
 orYY9RWnhO9B78ibYlm5xUdMpOtg/rJkZdcQIVlFHEXGAdBOOMVkTVrgSK5HMPV9gi
 PsSqAw0wxdSOUf9ScDfwJSbGQe7vJHyk5GdZcZMPI0K4/DDSEnkplkcfnxzBvvY2Dp
 gug0km7vG5tip9SRWt2LLyvTcHo1Gc0ms02PGY55sKs+D16xN0iYBkWXh/H4gtB5bO
 WTJuf5bpZezwQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=g8dWPKDc
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] i40e: fix races in PTP
 external timestamp work handling
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260724093448.63154-1-xuanqiang.luo@linux.dev?part=1
---
--- Patch [1]: [PATCH iwl-net v1] i40e: fix races in PTP external timestamp work handling ---
commit 4359cf206cb2602e153fdeac3151f8d4bacf9195
Author: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

i40e: fix races in PTP external timestamp work handling

This commit disables external timestamp events and drains the work
queue before unregistering the PHC to fix a use-after-free, and
moves the work initialization to device init instead of reset. It also
excludes reset recovery during teardown to avoid concurrent rebuilds.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index a04683004a567..2909a58d57562 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
[ ... ]
> @@ -16157,14 +16158,6 @@ static void i40e_remove(struct pci_dev *pdev)
>  
>  	i40e_devlink_unregister(pf);
>  
> -	i40e_dbg_pf_exit(pf);
> -
> -	i40e_ptp_stop(pf);
> -
> -	/* Disable RSS in hw */
> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), 0);
> -	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(1), 0);
> -
>  	/* Grab __I40E_RESET_RECOVERY_PENDING and set __I40E_IN_REMOVE
>  	 * flags, once they are set, i40e_rebuild should not be called as
>  	 * i40e_prep_for_reset always returns early.
> @@ -16173,6 +16166,14 @@ static void i40e_remove(struct pci_dev *pdev)
>  		usleep_range(1000, 2000);

Simon says: I think the issue flagged below is somewhat orthogonal to
            this patch and can be considered in the context of possible
	    follow-up.

[Severity: High]
This is a pre-existing issue, but does this ad-hoc polling loop violate core
networking synchronization rules?

The subsystem guidelines state that using retry/poll loops on flags to guard
code sections is a bug, as it evades lockdep deadlock detection and lacks
proper memory ordering guarantees. 

i40e_remove() spins on __I40E_RESET_RECOVERY_PENDING with a sleep instead of
using a standard lock or workqueue synchronization, which exposes the teardown
path to races during hotplug or PCIe AER unbinds.

>  	set_bit(__I40E_IN_REMOVE, pf->state);
>  
> +	i40e_dbg_pf_exit(pf);
> +
> +	i40e_ptp_stop(pf);

[ ... ]
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index ff62b5f2c8150..fd51ab8c10c20 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
[ ... ]
> @@ -1541,6 +1550,13 @@ void i40e_ptp_stop(struct i40e_pf *pf)
>  	struct i40e_hw *hw = &pf->hw;
>  	u32 regval;
>  
> +	/* Stop external timestamp events before unregistering the clock. */
> +	regval = rd32(hw, I40E_PRTTSYN_CTL0);
> +	regval &= ~I40E_PRTTSYN_CTL0_EVENT_INT_ENA_MASK;
> +	wr32(hw, I40E_PRTTSYN_CTL0, regval);
> +
> +	disable_work_sync(&pf->ptp_extts0_work);
> +

[Severity: Medium]
Does this reordering introduce a TOCTOU race condition with the PTP ioctl?

The flag I40E_FLAG_PTP_ENA is still set here while we disable the workqueue.
Because i40e_remove() does not hold the rtnl_lock(), a concurrent
SIOCSHWTSTAMP ioctl could execute i40e_ptp_hwtstamp_set().

Since the ioctl checks I40E_FLAG_PTP_ENA, it might observe it as still set
and call i40e_ptp_set_timestamp_mode(). This would overwrite I40E_PRTTSYN_CTL0
and re-enable hardware interrupts immediately after i40e_ptp_stop() just
disabled them, leaving the device generating events for a disabled workqueue.

>  	clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
>  	pf->ptp_tx = false;
>  	pf->ptp_rx = false;
>  
>  	if (pf->ptp_tx_skb) {
>  		struct sk_buff *skb = pf->ptp_tx_skb;
>  
>  		pf->ptp_tx_skb = NULL;
>  		clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
>  		dev_kfree_skb_any(skb);
>  	}

Simon says: Although the issue flagged below is flagged as pre-existing
            I am concerned that it is exacerbated by this patch.

[Severity: High]
This is a pre-existing issue, but could this freeing pattern result in a
double-free or use-after-free?

A user configuring PTP and transmitting a packet sets pf->ptp_tx_skb.
The watchdog task in i40e_ptp_tx_hang() checks the timeout and reads
pf->ptp_tx_skb without an atomic test-and-set claim.

If a hardware interrupt arrives at this exact time, i40e_ptp_tx_hwtstamp()
can preempt the watchdog, read the exact same pointer, set it to NULL,
call skb_tstamp_tx() and then dev_kfree_skb_any().

When the interrupt returns, the watchdog task resumes and frees the exact
same SKB pointer again. This teardown path in i40e_ptp_stop() also forcibly
frees ptp_tx_skb without atomic protections against the interrupt handler,
compounding the race.

[ ... ]
