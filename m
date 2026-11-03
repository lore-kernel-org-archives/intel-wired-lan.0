Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79C606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 03:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=DTeAL6Pb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sw8K19vk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C7A6B40589;
	Tue,  3 Nov 2026 03:28:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rjdbtNOmGJ4w; Tue,  3 Nov 2026 03:28:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AAB44405C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793676481;
	b=EB8+hE8ZSpxOnNDiYDR3GuBhouhExY1EoGVjREglNB6GUuj/+eMIcmD+16766k3/AF2u
	 wU8SKSyQ8z++e1r/pzo1c5Fbu+UeFbTwVGtbJMLlc9SRW7o+qPn/hgx1bXD/Kj3EnBKNr
	 l3tWm1LwSjCKYtlkD6PPxfERvutY+1bMf909t5yHWNstQxBImWJ6ejipNLKaUcbrXX7Zc
	 HXX0220BR/k/+NcU0EH1gwVoZoTL0BHgV6/ikfmRcNRKJzs0JWsXDgfELCcFowbR0Qm6p
	 H7+DZjHaoFVMCqXY0PpqZodO+g/2eFJ0/1eQCZO37sjda9H23IMbeM/NsZoVU2Y4YyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793676481;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=bEBjDCPFSFFw6cNFTVNSS35s30+h6QmSAsUrUuQPjjM=;
	b=LzC9vZT3W3+4d9D0xCzOxnm8uAdJHGjxVU6NdZT5ZWz4NO7c2u63myva2/DREvc8K2tq
	 DcSkppZqY2vsHqRMs+C4oIB8RDsGcnKmzOMrqYj6j0H1eJDPT6oDANL5oKFw1x7+05Qkj
	 w4xJ3yKH6PtgeeSgb2EUzxDTPlO/43A8kaMZ10W6p0psppfrVpogVefWy8DXdUuVazFUH
	 B9h2NJokSKaFgoqbqbZyJlLYow/Iz7OuOPLTd+B+cZ/i7ji8l+O2F6+ImILhXcaP2DfH/
	 xjIFpyLWKHlAR/f6JGPpjtO3S5z0/3/Zxy2xE+Y/brjRXBdAB+zPb77z+s3Xrr7d+vQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793676481;
	bh=bEBjDCPFSFFw6cNFTVNSS35s30+h6QmSAsUrUuQPjjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DTeAL6PbBS0IInABj7Y+mCSBYilCdh9faEPIuhgUQKwh+h9wJf+cOcipuH8h6JIu2
	 nB7pjcs7o4wVU3tSf0mFmnzyABFIPd9r0KDqtxbcGwSHkl92i9ZZeEObVPNHGopOeH
	 NXG7P8lRHSKQB3IZ1ug5LkKNZiFntVY+5vzHCmJ2qjg+8Tm3wMV8m0ujm1VBYLDer8
	 +qGED1f5TBQwQNt9aYKv7SaU5vHccgoUS6r/Q490EPT9Bec7sZSyjcBc3AbFQxfUvM
	 mvBuSo0RAWW3qnnQDxSKlLaLNFjRBQRCRvfWma43/yt5/AotGNvuysiv84NjKsJUbm
	 NnFg4TPgs6Png==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AAB44405C4;
	Tue,  3 Nov 2026 03:28:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3396356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 03:28:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E04C5606E9
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 03:28:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KqGWUTz5aazD for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 03:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4C30606D0
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793676479;
 b=qRjpvYLDNkDDXuhR2wkgS+c29B3Mj8X/xi4cr3XpJvwuXco3n30uccLcV1QNt3jh9r1g
 7qMTgsdlc3+C650U4N+cBRXOPRg47AFgNkBrFa/ySXmbASDpqUckzOPho77CLiojt/bcy
 b8lh72SQo3asfs+GveljfrSPgini5VpPcfYtEN3iNV7NQ7R9M8GL1h/btMW6iHS6N0jzw
 IcXfTRX6MyaosLf6II6c8LzS++RKHMo0nCghTRlWky9VO5kO9rRi0G683ycvzo7dIEGcm
 oaRWYimmISxnPezGwPretsyKxke2TukiBRHSy8DEtLcyDH1GHWCTJgKh/LqktwzxKVg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793676479;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=bEBjDCPFSFFw6cNFTVNSS35s30+h6QmSAsUrUuQPjjM=;
 b=N36YKCXrf9uFqhfo3lTebxC5TyPMMzHG5aEDuFOF6VwPjABfhx+xqqMqMWwOsycGG1rq
 w0RqmdKuo3E4LxB1f/2SSakDyKFc3MbEDxmq/5GWDtsJKoanmregta4JIOX3HHmN61qRf
 nSGe8rqsHo6pemRkP1XDR5BYHwRT/EE7MPMEC4YbI0lL76F/ojf83C89IiA6ul2mP3O7n
 0esbYJgfQAmVOm8ktOSzLo59zVYaOVGh7xCcS2LaRYP7oAyHc+lb4kMXmumCALl2aVSkT
 qDg7USjPoYIeQkdNtUE/o06xwTQD5b+KC7sckXZjmBMU5oHmgNf6ShqgOuxMO20KfDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Sw8K19vk; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Sw8K19vk
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4C30606D0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 03:27:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DA5D41AC9;
 Tue,  3 Nov 2026 03:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551461F000C1;
 Tue,  3 Nov 2026 03:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793676478;
 bh=bEBjDCPFSFFw6cNFTVNSS35s30+h6QmSAsUrUuQPjjM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sw8K19vkg6D9iM+mAoDSw9Wu+2EpSjCAC67pWAn/bC6E6UAht6BSeiUFl1bozcrAx
 +fTvNlX7A2vrF5/onvYx55eaR5xdlNv+g89n8bQP3fBvpbDcdY2iDfzRx2IexdPtSl
 OcuklW7Mwd7nd5els5egkb/oC3DoyE/p6SkDqYs6rpj9mwhWmsW4HwCXYjNibOiRdA
 zqdwzaq0VrCFCIjkLWSI6DPbEc4t0RppWUsllyz3swABiEd62ls9e+9Je8lkBddsM4
 MLqh7sh6Z6mPkMCmlVnDXexcMoEy3fFcaBCPO3/+gzcMr80sExOVD0gQZw7YINPuwD
 S2bvbKRPfAfRA==
Message-ID: <sashiko-outbox-194516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2] iavf: reset the VF instead of freeing rings
 when queue disable fails
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261102032744.304907-2-oss.patchbox@gmail.com>
References: <20261102032744.304907-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:27:57 +0000
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] iavf: ring overwrite and leak if iavf_open() races with removal af=
ter disable failure
- [High] iavf: deadlock in iavf_reset_step() when disable queues fails on s=
uspend
- [Medium] iavf: pending filter deletions lost when reset is scheduled on q=
ueue disable failure
--

commit aa95b33cf39978724a2d6af912102047e7464b0f
Author: Yuho Choi <oss.patchbox@gmail.com>

iavf: reset the VF instead of freeing rings when queue disable fails

When the PF returns an error for VIRTCHNL_OP_DISABLE_QUEUES, this commit
keeps the Tx and Rx rings allocated and schedules a VF reset instead of
freeing the rings while queues may still be active. It also updates removal
and VF disable paths to handle the kept rings and state transitions.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/ne=
t/ethernet/intel/iavf/iavf_virtchnl.c
> index 66c8b0261fd62..ac74b235aa871 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -2726,8 +2726,22 @@ void iavf_virtchnl_completion(struct iavf_adapter =
*adapter,
>  		adapter->flags &=3D ~IAVF_FLAG_QUEUES_DISABLED;
>  		break;
>  	case VIRTCHNL_OP_DISABLE_QUEUES:
> -		iavf_free_all_tx_resources(adapter);
> -		iavf_free_all_rx_resources(adapter);
> +		/* If the PF could not stop the queues, the hardware may still
> +		 * access the rings and Rx buffers. Keep them and request a VF
> +		 * reset; the reset path releases them after the PF has reset
> +		 * the VF. During removal no reset is scheduled, but
> +		 * iavf_remove() resets the VF itself before it releases the
> +		 * rings, so let it stop waiting for the queues to go down.
> +		 */
> +		if (v_retval) {
> +			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);

[Severity: Medium]
As reported by Sashiko on v1 [1], when iavf_close() calls iavf_down() in
drivers/net/ethernet/intel/iavf/iavf_main.c, active filters are marked for
deletion and their adminq flags are set alongside
IAVF_FLAG_AQ_DISABLE_QUEUES:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_down() {
	iavf_clear_mac_filters(adapter);
	iavf_clear_cloud_filters(adapter);
	iavf_clear_fdir_filters(adapter);
	iavf_clear_adv_rss_conf(adapter);
	...
	if (!test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section)) {
		adapter->current_op =3D VIRTCHNL_OP_UNKNOWN;
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

In iavf_process_aq_command(), IAVF_FLAG_AQ_DISABLE_QUEUES is processed
before the IAVF_FLAG_AQ_DEL_* flags. When VIRTCHNL_OP_DISABLE_QUEUES fails
and schedules a reset here, iavf_reset_step() zeroes adapter->aq_required:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() {
	adapter->aq_required =3D 0;
	...
	/* re-add all MAC filters */
	list_for_each_entry(f, &adapter->mac_filter_list, list) {
		f->add =3D true;
	}
}

Won't this lose the pending filter deletions and leak or corrupt the filter
lists? Specifically:
- Advanced RSS filters in adapter->adv_rss_list_head remain stuck in
  IAVF_ADV_RSS_DEL_REQUEST and are never freed, causing subsequent
  iavf_set_rxfh_fields() calls for the same headers to return -EBUSY.
- Cloud filters in adapter->cloud_filter_list remain with cf->del =3D true
  and are never freed, causing subsequent iavf_configure_clsflower() calls
  with the same cookie to fail with -EEXIST (or, when ADQ is active, get
  cf->add =3D true set in iavf_reset_step() and get re-added while cf->del =
is
  still true).
- Secondary and multicast MAC filters that were unsynced and marked with
  f->remove =3D true in iavf_clear_mac_filters() get f->add =3D true set in
  iavf_reset_step() and f->remove =3D false in iavf_virtchnl_completion(),
  re-adding them on the PF.

[Severity: High]
As reported by Sashiko on v1 [2], what happens if VIRTCHNL_OP_DISABLE_QUEUES
fails during system suspend?

In drivers/net/ethernet/intel/iavf/iavf_main.c, iavf_suspend() calls
iavf_down() while leaving adapter->state set to __IAVF_RUNNING:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_suspend() {
	running =3D (adapter->state =3D=3D __IAVF_RUNNING);
	if (running)
		iavf_down(adapter);

	iavf_free_misc_irq(adapter);
	iavf_reset_interrupt_capability(adapter);
}

iavf_down() calls iavf_napi_disable_all(adapter) and schedules
IAVF_FLAG_AQ_DISABLE_QUEUES. If VIRTCHNL_OP_DISABLE_QUEUES fails and
iavf_virtchnl_completion() schedules reset_task, iavf_reset_step() (or
iavf_disable_vf() if the reset times out) sees adapter->state =3D=3D
__IAVF_RUNNING while adapter->num_msix_vectors is still non-zero:

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_reset_step() {
	running =3D adapter->state =3D=3D __IAVF_RUNNING;

	if (running) {
		netif_carrier_off(netdev);
		netif_tx_stop_all_queues(netdev);
		adapter->link_up =3D false;
		iavf_napi_disable_all(adapter);
	}
}

Wouldn't calling iavf_napi_disable_all() a second time hang forever in
napi_disable_locked() while holding netdev_lock(netdev)?

> +			if (!test_bit(__IAVF_IN_REMOVE_TASK,
> +				      &adapter->crit_section))
> +				break;
> +		} else {
> +			iavf_free_all_tx_resources(adapter);
> +			iavf_free_all_rx_resources(adapter);
> +		}
> +		if (adapter->state =3D=3D __IAVF_DOWN_PENDING) {
> +			iavf_change_state(adapter, __IAVF_DOWN);
> +			wake_up(&adapter->down_waitqueue);
> +		}

[Severity: High]
Can this transition to __IAVF_DOWN while rings are still allocated race
with a concurrent iavf_open() when a non-removal dev_close() overlaps with
iavf_remove()?

Consider a thread in dev_close() -> iavf_close() waiting on
adapter->down_waitqueue while holding rtnl_lock. Concurrently, iavf_remove()
starts, sets __IAVF_IN_REMOVE_TASK, and waits for adapter->state to leave
__IAVF_DOWN_PENDING before calling unregister_netdev():

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_remove() {
	if (test_and_set_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))
		return;

	while (1) {
		netdev_lock(netdev);
		if (adapter->state =3D=3D __IAVF_RUNNING ||
		    adapter->state =3D=3D __IAVF_DOWN ||
		    adapter->state =3D=3D __IAVF_INIT_FAILED) {
			netdev_unlock(netdev);
			break;
		}
		netdev_unlock(netdev);
		usleep_range(500, 1000);
	}
	cancel_delayed_work_sync(&adapter->watchdog_task);
	cancel_work_sync(&adapter->finish_config);

	if (adapter->netdev_registered) {
		unregister_netdev(netdev);
		...
	}
}

If VIRTCHNL_OP_DISABLE_QUEUES fails while __IAVF_IN_REMOVE_TASK is set,
iavf_virtchnl_completion() skips freeing the Tx/Rx rings, sets
adapter->state to __IAVF_DOWN, and wakes adapter->down_waitqueue. Once
iavf_close() finishes and drops rtnl_lock, before iavf_remove() reaches
unregister_netdev(netdev) and acquires rtnl_lock, another thread can call
dev_open() -> iavf_open():

drivers/net/ethernet/intel/iavf/iavf_main.c:iavf_open() {
	if (adapter->state !=3D __IAVF_DOWN)
		return -EBUSY;
	...
	err =3D iavf_setup_all_tx_resources(adapter);
	if (err)
		goto err_setup_tx;
	err =3D iavf_setup_all_rx_resources(adapter);
}

Because iavf_open() does not check __IAVF_IN_REMOVE_TASK and sees
adapter->state =3D=3D __IAVF_DOWN, won't it call iavf_setup_tx_descriptors()
and iavf_setup_rx_descriptors() on the kept rings, triggering
WARN_ON(tx_ring->tx_bi) in drivers/net/ethernet/intel/iavf/iavf_txrx.c and
overwriting and leaking tx_ring->tx_bi, tx_ring->desc, rx_ring->rx_fqes,
rx_ring->desc, and rx_ring->pp (leaving the leaked page_pool with a
dangling pool->p.napi pointer to adapter->q_vectors after removal frees
them)?

Also, because iavf_remove() sets __IAVF_IN_REMOVE_TASK without holding
netdev_lock, testing __IAVF_IN_REMOVE_TASK once inside
iavf_schedule_reset() and a second time here in iavf_virtchnl_completion()
can see different values if __IAVF_IN_REMOVE_TASK is set in between,
both queuing adapter->reset_task and transitioning adapter->state to
__IAVF_DOWN.

[1] https://lore.kernel.org/r/20261022192753.69765-2-oss.patchbox@gmail.com
[2] https://lore.kernel.org/r/20261022192753.69765-2-oss.patchbox@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102032744.3049=
07-2-oss.patchbox@gmail.com?part=3D1
