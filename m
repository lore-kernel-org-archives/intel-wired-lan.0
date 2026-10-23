Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA92B606A337
	for <intel-wired-lan@archiver.kernel.org>; Fri, 23 Oct 2026 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KD94f7FB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K9L3IjIv
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8EE460A3D;
	Fri, 23 Oct 2026 19:28:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxUM2m42TmrA; Fri, 23 Oct 2026 19:28:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AC9E60A45
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792783695;
	b=DIdzgeoZC5dP4XwTJmTsvfCoqcRyetH/qulrZ+l5x4POcHc0TNzVWDWyS8WWxjiAhpA3
	 yrnyyhKkNpAmBEAvXP+mqm1AREUBxoY6oH0KUrBQJZb1e/Ko+kDIfqlR3iyn5KLGiTskW
	 Lw3J19iMpPRHh+5xdqw2QwP3b/CLbuPLYCsBNq8BQTnRTZBaSYFecVls/RRtyGcqcBxmC
	 UnUDov8BI0BGmIohPT2Sl8OV2G7yP3OrxY2Mrc7EwukeTZcl+/TWfZX+ppnqRyiqQOzSA
	 q5GbotkR/kxEYfLd2WCWiyi7loNtF4E543sP4KwkkHpA31D0aQrB/YdK8bXT81q27cA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792783695;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=L65+TZ8C/s20AWM+38laNw3uQWtlYumAuKoh7lqRum8=;
	b=nfivxe5QKngF18fOcluDzK+OOkAwIcN245vqRs4yN2JXRMQ8NFsLU+2Swau7Y8peu98x
	 DiWodgv+ycVJeZDxtLENqgH5d34/uKy2tSfIbskLGTEFPYkuoOlF2cZ8SPJnxML4TJo1y
	 35NmXW88qG3uJZsrtOppdwAIfwpCMp4S8wie25a0d+pTbwcQv501RYU8600RNEbIle/kO
	 U+kt3euCEXkaFE0mYu7KEa/zJx+yPojVKgwNvBj2VG3eUrZ3FUd55FAOJvu8yLpkr25mz
	 UMiM6OlrTfSON1HBhmTlg5QjifNWqHvwEWs/UyH8k57IV32TA5a8CtoVt6oSELJYaCg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792783695;
	bh=L65+TZ8C/s20AWM+38laNw3uQWtlYumAuKoh7lqRum8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KD94f7FBcAE8IM4/d/DUU/Ik3iqiWlsgXUjn3OxzabRga2Hh6nO19zgOnCc1Q+N3M
	 rJwwPoyh052ghAIGMjlKe6d8zli8Yb3kN7L4D60wdT7MkdF2/IV9zt7y/YAoMSi5ts
	 1uwip0uEnQ7o+syUxiM3NjErKLu1JG7UTm8hpKuOJAROI997Oe/s5FG77bhMB212dY
	 nPhTvvPdYcdgrGbVp9KWkemK3cx6gvp8twK5iltsK3wkNx7pYC5OERkyirYCilxAHD
	 3AWzYZjmU9bKjh9NG0uoOcDBTOSNX8Ck0QYCDjhJQsZ2lXUKZiv84Gu83FT6yuBVhx
	 MheGXIx2ykIMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AC9E60A45;
	Fri, 23 Oct 2026 19:28:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 32E06235
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 19:28:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2467340A5A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 19:28:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFkQXbPHaqR5 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 19:28:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B741A40A59
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792783693;
 b=is4peG9e6m96XMXLf+weyq+FnkNvshjtkjqfHRI1GtRvjD57Png72PnZZdIFtMZlfx8z
 FYNAPiGIGHgraADLyc5p4t67m/muRc0BWKB+u20kT1CP5Udc5q5eH8UmInkORI+XSOIXI
 SYeiWG97wlHT2YondYBzYRqLx04ILZqR5sIbm2yhnPRnSdEFIomCPPi4plFB1WhE44sxS
 Q/4/jnecr1rGsNcPjHX6AEn6g01wCx3EhFHHkY68Yjwm6+PRC8x1gw8TGOfwvofVk/1cg
 SDhNzoPUoU8u98w/03QgS58KUYJS+C3wKhDV6Qy8m5iavo4ByvRz28RAy2OY5+hetkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792783693;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=L65+TZ8C/s20AWM+38laNw3uQWtlYumAuKoh7lqRum8=;
 b=IBB2RA5BsKObdPaBE0qHWWhk4v2/r0razuFXpRNxyA91xxRD2l9gK4iNwt52vR16dxwX
 ohXFWekCrwNkuKF7qfM4bRCvHKUyHvYwQ6TN4EfZF8EIIe6Yp1eA4NYcVEgT2A2xpSrip
 JJ16Dw4mXhxDyQQZ9KCMLjSUGvSf2oeMsXUNl1bH4K14ybgwtEdQiV2h1XSuv8CpHzVki
 q2UYiqb5ISTKUed5/QUZgADCzfrEGAz9Wak6vOFl9bYrHcZOW30rkzPGbiDb9pjJRmjyF
 ejAaeeNXMxa7oot/3UUI/xEsLlMBYDlEedvYD23pRXWdmoZZ9dL0IIJrvYwUWMmM05g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K9L3IjIv; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=K9L3IjIv
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B741A40A59
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 19:28:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C6CD601DE;
 Fri, 23 Oct 2026 19:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347251F01825;
 Fri, 23 Oct 2026 19:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792783690;
 bh=L65+TZ8C/s20AWM+38laNw3uQWtlYumAuKoh7lqRum8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K9L3IjIvDDJubxkgnT5a+UHaRcFY/i3Qqj1+DCZ3/jDJNPYPbzqSj6QZc9k1Cg4iU
 X1dpyRbwNtB+lQt3SpA0XWZXmJq0JDgeEmatecwZs4WuF1Y0thY8qsL578sUsQW+4S
 oTuWA+rn4jofdw4KbhpTFEZpj+f7BECByRRwbRw0GsNV8EmuL21IFwH7KOt3H/4Qx9
 Rm2/29sN0QGDaolAjCh8hpA7cozQL5V+S1lr16XVfUhFcqQIEumdFk933bhPhEp1H2
 mAWgNFNhAuXdA5bKgpDhEX+9DKG9qeVLB86T0QsQSMwwjfAzQgBEt3YKsfuUplCreT
 2Q0G613RoBiTw==
Message-ID: <sashiko-outbox-183115@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v1] iavf: reset the VF instead of freeing rings
 when queue disable fails
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261022192753.69765-2-oss.patchbox@gmail.com>
References: <20261022192753.69765-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 19:28:09 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] iavf: infinite loop in iavf_remove() when queue disable fails
- [High] iavf: ring resource leak and dangling NAPI in iavf_disable_vf()
- [High] iavf: deadlock in iavf_reset_step() when disable queues fails on s=
uspend
- [Medium] iavf: pending filter deletions lost when reset is scheduled on q=
ueue disable failure
--

commit 362caa9d16f7d9e3e52d1978b838d37d34c2a1f6
Author: Yuho Choi <oss.patchbox@gmail.com>

iavf: reset the VF instead of freeing rings when queue disable fails

When the PF returns an error for VIRTCHNL_OP_DISABLE_QUEUES, this patch kee=
ps
the Tx and Rx ring resources allocated and schedules a VF reset instead of
freeing the rings immediately in iavf_virtchnl_completion().

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/ne=
t/ethernet/intel/iavf/iavf_virtchnl.c
> index e6b7e8f82c7c1..178bba609677f 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -2718,6 +2718,15 @@ void iavf_virtchnl_completion(struct iavf_adapter =
*adapter,
>  		adapter->flags &=3D ~IAVF_FLAG_QUEUES_DISABLED;
>  		break;
>  	case VIRTCHNL_OP_DISABLE_QUEUES:
> +		/* If the PF could not stop the queues, the hardware may still
> +		 * access the rings and Rx buffers. Keep them and request a VF
> +		 * reset; the reset path releases them after the PF has reset
> +		 * the VF.
> +		 */
> +		if (v_retval) {
> +			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
> +			break;
> +		}

[Severity: High]
Can this cause an infinite loop in iavf_remove() when disabling queues fail=
s?

In drivers/net/ethernet/intel/iavf/iavf_main.c, iavf_close() calls
iavf_down(), sets adapter->state to __IAVF_DOWN_PENDING, releases
netdev_lock(netdev), and waits up to 500ms on adapter->down_waitqueue for
adapter->state to become __IAVF_DOWN.

If iavf_remove() is invoked while adapter->state is __IAVF_DOWN_PENDING
(either while iavf_close() is sleeping in wait_event_timeout() with the
netdev lock released, or after the 500ms wait times out), iavf_remove() sets
__IAVF_IN_REMOVE_TASK and loops until adapter->state leaves
__IAVF_DOWN_PENDING:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_remove() {
...
	if (test_and_set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
		return;

	/* Wait until port initialization is complete.
	 * There are flows where register/unregister netdev may race.
	 */
	while (1) {
		netdev_lock(netdev);
		if (adapter->state =3D=3D __IAVF_RUNNING ||
		    adapter->state =3D=3D __IAVF_DOWN ||
		    adapter->state =3D=3D __IAVF_INIT_FAILED) {
			netdev_unlock(netdev);
			break;
		}
		/* Simply return if we already went through iavf_shutdown */
		if (adapter->state =3D=3D __IAVF_REMOVE) {
			netdev_unlock(netdev);
			return;
		}

		netdev_unlock(netdev);
		usleep_range(500, 1000);
	}
...
}

When VIRTCHNL_OP_DISABLE_QUEUES fails with a non-zero v_retval,
iavf_virtchnl_completion() now breaks out without changing adapter->state
from __IAVF_DOWN_PENDING to __IAVF_DOWN, and calls iavf_schedule_reset().
However, iavf_schedule_reset() does nothing when __IAVF_IN_REMOVE_TASK is
already set:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_schedule_reset() {
	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section) &&
	    !(adapter->flags &
	    (IAVF_FLAG_RESET_PENDING | IAVF_FLAG_RESET_NEEDED))) {
		adapter->flags |=3D flags;
		queue_work(adapter->wq, &adapter->reset_task);
	}
}

Since reset_task is not queued and adapter->state remains
__IAVF_DOWN_PENDING, won't iavf_remove() spin forever in the while (1) loop
before ever reaching unregister_netdev() or iavf_request_reset()?

[Severity: High]
What happens if the reset scheduled here times out in iavf_reset_step() whi=
le
adapter->state is __IAVF_DOWN_PENDING?

When VIRTCHNL_OP_DISABLE_QUEUES fails during iavf_close(), adapter->state is
__IAVF_DOWN_PENDING and the per-ring Tx and Rx resources remain allocated. =
If
the subsequent VF reset never completes in iavf_reset_step(), it calls
iavf_disable_vf() and returns before reaching continue_reset:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() {
...
	if (i =3D=3D IAVF_RESET_WAIT_COMPLETE_COUNT) {
		dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
			reg_val);
		iavf_disable_vf(adapter);
		return; /* Do not attempt to reinit. It's dead, Jim. */
	}
...
}

In iavf_disable_vf(), iavf_free_all_tx_resources() and
iavf_free_all_rx_resources() are only called when adapter->state is
__IAVF_RUNNING:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_disable_vf() {
...
	if (adapter->state =3D=3D __IAVF_RUNNING) {
		set_bit(__IAVF_VSI_DOWN, adapter->vsi.state);
		netif_carrier_off(adapter->netdev);
		netif_tx_disable(adapter->netdev);
		adapter->link_up =3D false;
		iavf_napi_disable_all(adapter);
		iavf_irq_disable(adapter);
		iavf_free_traffic_irqs(adapter);
		iavf_free_all_tx_resources(adapter);
		iavf_free_all_rx_resources(adapter);
	}
...
	iavf_free_misc_irq(adapter);
	iavf_free_interrupt_scheme(adapter);
...
}

iavf_free_interrupt_scheme() then calls iavf_free_q_vectors() and
iavf_free_queues():

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_free_queues() {
	if (!adapter->vsi_res)
		return;
	adapter->num_active_queues =3D 0;
	kfree(adapter->tx_rings);
	adapter->tx_rings =3D NULL;
	kfree(adapter->rx_rings);
	adapter->rx_rings =3D NULL;
}

Because adapter->state is __IAVF_DOWN_PENDING rather than __IAVF_RUNNING,
doesn't this free adapter->q_vectors (and each embedded q_vector->napi) whi=
le
the per-ring rx_ring->pp page pools still hold pointers to &q_vector->napi,
and leak all per-ring descriptor rings (tx_ring->desc, rx_ring->desc), buff=
er
metadata arrays (tx_ring->tx_bi, rx_ring->rx_fqes), mapped skbs and Rx page=
s,
and rx_ring->pp page pools once adapter->tx_rings and adapter->rx_rings are
freed and adapter->num_active_queues is set to 0?

[Severity: Medium]
Does scheduling a reset here lose pending filter deletions that were queued
by iavf_down()?

When iavf_close() calls iavf_down(), the driver marks active filters for
deletion (f->remove =3D true, cf->del =3D true, and
rss->state =3D IAVF_ADV_RSS_DEL_REQUEST) and sets the corresponding
IAVF_FLAG_AQ_DEL_* flags in adapter->aq_required alongside
IAVF_FLAG_AQ_DISABLE_QUEUES:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_down() {
...
	iavf_clear_mac_filters(adapter);
	iavf_clear_cloud_filters(adapter);
	iavf_clear_fdir_filters(adapter);
	iavf_clear_adv_rss_conf(adapter);
...
		if (!list_empty(&adapter->mac_filter_list))
			adapter->aq_required |=3D IAVF_FLAG_AQ_DEL_MAC_FILTER;
		if (!list_empty(&adapter->cloud_filter_list))
			adapter->aq_required |=3D IAVF_FLAG_AQ_DEL_CLOUD_FILTER;
		if (!list_empty(&adapter->fdir_list_head))
			adapter->aq_required |=3D IAVF_FLAG_AQ_DEL_FDIR_FILTER;
		if (!list_empty(&adapter->adv_rss_list_head))
			adapter->aq_required |=3D IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
	}

	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DISABLE_QUEUES);
}

In iavf_process_aq_command(), IAVF_FLAG_AQ_DISABLE_QUEUES is sent before any
of the IAVF_FLAG_AQ_DEL_* flags. If VIRTCHNL_OP_DISABLE_QUEUES fails and
iavf_virtchnl_completion() triggers a reset, iavf_reset_step() clears
adapter->aq_required and marks the remaining entries in
adapter->mac_filter_list (and adapter->cloud_filter_list when ADQ is active)
to be re-added:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() {
...
	adapter->aq_required =3D 0;
...
	/* re-add all MAC filters */
	list_for_each_entry(f, &adapter->mac_filter_list, list) {
		f->add =3D true;
	}
...
}

Won't this leave advanced RSS configurations stuck in
IAVF_ADV_RSS_DEL_REQUEST on adapter->adv_rss_list_head (causing future
iavf_set_rxfh_fields() calls for the same packet headers to fail with
-EBUSY), leave cloud filters with cf->del =3D true on
adapter->cloud_filter_list without freeing them (causing future
iavf_configure_clsflower() calls with the same cookie to fail with -EEXIST,
or re-adding them with cf->add =3D true when ADQ is active), and re-add
secondary or multicast MAC addresses on adapter->mac_filter_list that
iavf_clear_mac_filters() had marked with f->remove =3D true?

[Severity: High]
Can scheduling a reset here deadlock in iavf_reset_step() if
VIRTCHNL_OP_DISABLE_QUEUES was triggered by iavf_suspend()?

When suspending while the interface is running, iavf_suspend() calls
iavf_down() without changing adapter->state from __IAVF_RUNNING:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_suspend() {
...
	if (running)
		iavf_down(adapter);

	iavf_free_misc_irq(adapter);
	iavf_reset_interrupt_capability(adapter);
...
}

iavf_down() calls iavf_napi_disable_all(adapter), which disables each
q_vector->napi (setting NAPIF_STATE_SCHED), and schedules
IAVF_FLAG_AQ_DISABLE_QUEUES.

If VIRTCHNL_OP_DISABLE_QUEUES fails before the admin queue is shut down and
iavf_virtchnl_completion() schedules adapter->reset_task, iavf_reset_step()
runs under netdev_lock(netdev), sees adapter->state =3D=3D __IAVF_RUNNING, =
and
calls iavf_napi_disable_all(adapter) a second time (since
adapter->num_msix_vectors is still non-zero):

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() {
...
	running =3D adapter->state =3D=3D __IAVF_RUNNING;

	if (running) {
		netif_carrier_off(netdev);
		netif_tx_stop_all_queues(netdev);
		adapter->link_up =3D false;
		iavf_napi_disable_all(adapter);
	}
...
}

Since the NAPI instances were already disabled by iavf_down(), won't calling
iavf_napi_disable_all() again cause napi_disable_locked() to loop forever
waiting for NAPIF_STATE_SCHED to clear while holding netdev_lock(netdev)?

>  		iavf_free_all_tx_resources(adapter);
>  		iavf_free_all_rx_resources(adapter);
>  		if (adapter->state =3D=3D __IAVF_DOWN_PENDING) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022192753.6976=
5-2-oss.patchbox@gmail.com?part=3D1
