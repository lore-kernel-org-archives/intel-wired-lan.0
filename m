Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626E7EB64DD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 11 Jul 2023 07:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DA7440297;
	Tue, 11 Jul 2023 07:45:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0DA7440297
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689061523;
	bh=698sirG8EAZgzn5+6AhbVCYql7PPaQUxmvpjMOwuPt0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BwXsv8EJ7FwFC/IzcOkcuLAbiG5akJMHnGptIEb7JOtyZjPnDl2PN62t9H0pP82ae
	 VdUep856txf0dl75fl/33QnqkqyqnLmqbx4c2gpugfTtiDWdv7KwHLZ6jfLYAr8Z1K
	 j9rdPr7g3Cg60NO0TNCXEuWOBUbKB2yHAJ0E7HPkgY7vG0iPYxVkdhgyLdD0Bsnpt3
	 qLMtRv8G/MS87Mk5tRX/Rhzjm+gVipRJQATRJfG4nq3wd44fTkIhfo2LE51S8hOE+j
	 zwSez2MgJCQvv9vSAcOAE7QWJV9PmOi44kF18wtZC66gELQusW/GdpleL3/KPEEYh0
	 kNMyfuVIpltyg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVT1pgo0cUCV; Tue, 11 Jul 2023 07:45:22 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 16981402D0;
	Tue, 11 Jul 2023 07:45:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 16981402D0
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 783121BF2C4
 for <intel-wired-lan@osuosl.org>; Tue, 11 Jul 2023 07:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4FF07815AD
 for <intel-wired-lan@osuosl.org>; Tue, 11 Jul 2023 07:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4FF07815AD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLG4VIV0nc40 for <intel-wired-lan@osuosl.org>;
 Tue, 11 Jul 2023 07:45:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9680981501
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9680981501
 for <intel-wired-lan@osuosl.org>; Tue, 11 Jul 2023 07:45:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 845DB61353;
 Tue, 11 Jul 2023 07:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6919AC433C9;
 Tue, 11 Jul 2023 07:45:17 +0000 (UTC)
Date: Tue, 11 Jul 2023 10:45:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Message-ID: <20230711074513.GL41919@unreal>
References: <20230711040820.16235-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230711040820.16235-1-muhammad.husaini.zulkifli@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1689061517;
 bh=0mhXs6U7XvEJ6Ea7NslaRg5qfTm+H5m/SUPlSrWeZQ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kUAXyU4rMVt6J+BfVaec0NotgLs9phx6Dx4h3D9w1ElMHrTYRqusfaPXdfRbk+Pda
 JAfMR8whc+CvJSTTwU5T6dfoLP4cFXUaoRo66oEsLDJ2pIQtLmCgQUZSvmBxWDCIqK
 M6VrkXm+tfM1GzF7ajVBOZWDOT9etZ1z909XpRmXM6JqlJt3gxOa0u6NfvfAwBOdE5
 oho/L0hUnDFkmo3+2TVQMIvxdA9olQQ92BTbXVbhghBQ8J6Jf8Kwu6+K3xhuDps+sy
 suA1Fbm/iLFkOsF/RM7AcXV104y1mmV6j+ZczE62fE09UZmI9kvCI6anKIBUXkO/t+
 mK8dpKhcQ+oVQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=kUAXyU4r
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] igc: Add lock to safeguard
 global Qbv variables
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
Cc: intel-wired-lan@osuosl.org, anthony.l.nguyen@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jul 11, 2023 at 12:08:20PM +0800, Muhammad Husaini Zulkifli wrote:
> Access to shared variables through hrtimer requires locking in order
> to protect the variables because actions to write into these variables
> (oper_gate_closed, admin_gate_closed, and qbv_transition) might potentially
> occur simultaneously. This patch provides a locking mechanisms to avoid
> such scenarios.

I have a general comment as this patch is targeted to iwl-next and not to net-next,
the locking should protect access to shared variables and it means that
lock should be used in all places where these variables are used and not
only in one function.

Thanks

> 
> Fixes: 175c241288c0 ("igc: Fix TX Hang issue when QBV Gate is closed")
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 4 ++++
>  drivers/net/ethernet/intel/igc/igc_main.c | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 9db384f66a8e..38901d2a4680 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -195,6 +195,10 @@ struct igc_adapter {
>  	u32 qbv_config_change_errors;
>  	bool qbv_transition;
>  	unsigned int qbv_count;
> +	/* Access to oper_gate_closed, admin_gate_closed and qbv_transition
> +	 * are protected by the qbv_tx_lock.
> +	 */
> +	spinlock_t qbv_tx_lock;
>  
>  	/* OS defined structs */
>  	struct pci_dev *pdev;
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index bdeb36790d77..cae717cb506e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -4801,6 +4801,7 @@ static int igc_sw_init(struct igc_adapter *adapter)
>  	adapter->nfc_rule_count = 0;
>  
>  	spin_lock_init(&adapter->stats64_lock);
> +	spin_lock_init(&adapter->qbv_tx_lock);
>  	/* Assume MSI-X interrupts, will be checked during IRQ allocation */
>  	adapter->flags |= IGC_FLAG_HAS_MSIX;
>  
> @@ -6619,8 +6620,11 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
>  {
>  	struct igc_adapter *adapter = container_of(timer, struct igc_adapter,
>  						   hrtimer);
> +	unsigned long flags;
>  	unsigned int i;
>  
> +	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
> +
>  	adapter->qbv_transition = true;
>  	for (i = 0; i < adapter->num_tx_queues; i++) {
>  		struct igc_ring *tx_ring = adapter->tx_ring[i];
> @@ -6633,6 +6637,9 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
>  		}
>  	}
>  	adapter->qbv_transition = false;
> +
> +	spin_unlock_irqrestore(&adapter->qbv_tx_lock, flags);
> +
>  	return HRTIMER_NORESTART;
>  }
>  
> -- 
> 2.17.1
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
