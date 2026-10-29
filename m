Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0069606A322
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=VYwdWcMZ;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfCEoXZ3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70C64606DA;
	Thu, 29 Oct 2026 02:37:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kDlfC56T-G_t; Thu, 29 Oct 2026 02:37:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BDBC9606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793241445;
	b=VAeaz+UJbkoaWgfeBIf0OL/MgOHC7Popfc7FJeBddbkPUvWcQrIMObiyFMiDFnacwEUq
	 AA+B+RTWaUCSGsxrpdfgcs2BtTx+6m4zpQMSLMrf7udKcV/MZDsl5Ba9dpyqNUuNscM9s
	 jTAzorJzvJKbvI9QIeu3S0jJdcUn8AyGG6ZrbkmxdhWJQt8VTFLz1wy7pn3A7JsVHQVXG
	 DjOqTvJYIrQteE9XRinBMk3RZiWZEm0RKP/g5nJ708KHA0a+utjJNitOhZEDPJSyTiVLG
	 gWaSwZFOWo6KX2a3oA9an3QySYKL3keHPWp9IJuSUKub+m5H/M2VG0ujIdOsyk5nN7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793241445;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Rvaxj/9xZzaDwaag2rGM3SvZn2Eugwkdg0lI1SmK/t4=;
	b=CZaf9g86GAx3N8ylBYmspl/5JFBZYCIFAfuvJT2End1aR41WKu/i7ZxV8uQA2m78uAVD
	 RQ7wtI2Rx+m6ECrly/COaNjn9GdrP1CFnqW/6mI8t+WJPwzEHfcZwO8EbOuesPPCU25rX
	 eFYx6IdWK6Ut8Wl5nqkyM7u46bsuv8vJfI85x3t2wKtLXOeX60dAhgdR3xK9h23fz9uzn
	 8ej4NBS4Sh/1PffJCvA4gUC4ON+N+BW+XtAvO9iKP1PE2G+fAtJrs9v5clycQjEjS2hpE
	 kVLGHx1A++zsMaloAFW/lEqVcplRCYoaNSZr2WIUuiRdi5pb98afxY1uAFMcltceKGA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793241445;
	bh=Rvaxj/9xZzaDwaag2rGM3SvZn2Eugwkdg0lI1SmK/t4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYwdWcMZPsVzejnAAYaxAaKpAAkaIIR+UkK+nytMrTSi55vq+owkncG0ccbpx+jne
	 FsQNHyagT3F4v9BHooy4wQ6mSkGUS7ZYc2K7kk+L+0LWerUEEOvGofKTK9NoJ/+9J+
	 VaW+nS4vCNPJnM4iFsQTuzGog5iqc3ehyG6RIVb9XfTmjmZa8gse/qoT44tiTO+k1Z
	 qHAUQU+jJyHHfgj2qPC6YRw8SGRfx7l8gcLTPx2cXjB+JxKgKxkvjsdKiBKLNw/ndq
	 Qg/Yo0Oi7UMTJ3jhQhwcZdQTHgHIarSBRNsNhylm9qG2Ae2jdAE2z8waHMezavaGkB
	 CV/ZXWhZ3E7eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BDBC9606CA;
	Thu, 29 Oct 2026 02:37:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAC6E2E5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 02:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC8B640329
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 02:37:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id frfRPTfqyv9g for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 02:37:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8CA88402F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793241442;
 b=bo1VPQkufW12h1OuORRibxVzCv32PrTpy79n58RQW3EAHp2HwVTvf3pEiMpWCGdm9y4E
 6yT6jAP/6smLmjsL9Day5ViURjqrMuvhk3js+F/36PU/z48ISLDPxGbGp1ZglNfAcXDCw
 qRXBOnSi2lYAYC8l4e+K5y57SCpYrdt6y/oS4wDvnR1gq7p5LZ2Z8AZJigPCL6naUKXWr
 T6y69p9aYuO+KrR5iA9oY+TazrkV7gDlKU+++HkHtppxJZLglrQZc4QgsuorJ1t4W8cT7
 q1PuP4vIhTSYwbrSMNMPgO1r9i+xedHmIfhO1dcwuXE2nxOffxTWatlr9q+BVNPWPpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793241442;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=Rvaxj/9xZzaDwaag2rGM3SvZn2Eugwkdg0lI1SmK/t4=;
 b=nca7qAxPLhaAYRW3TfVB3R8tTWOOd7+VHjoOIDIdxltBvOQVp4ogUxP8RsTmWW1/8ewc
 cjCNd9QegHUQyjDHl+zNeaxad/0btKLUALi3yj+fvrO8FruWSyD5P0ByzDmtA3IIP9Vl9
 5Kfmx+nsNBwbDBLJgOez+B0EbXXgHzwM71eYZTER6q+pqwCMXyEo5S/9A/PXLqYkEK8Be
 6kgY/4ORHnKsl1xawxQqzc79WlmSmtFJu6PlIe10OQn45e4dSkWW0wrTCc6zeHalgakJR
 yAsvFZmHOoV1Lw86acBIi+N7T43zXEv/hAMOajK5JYLgRyMOgYeSCuapb4xYWJM+Hbw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MfCEoXZ3; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MfCEoXZ3
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CA88402F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 02:37:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 538DF43966;
 Thu, 29 Oct 2026 02:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B801F01825;
 Thu, 29 Oct 2026 02:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793241441;
 bh=Rvaxj/9xZzaDwaag2rGM3SvZn2Eugwkdg0lI1SmK/t4=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=MfCEoXZ3II+fxXHYtsr1n18w/J62sgfVBIxUFC8CW/0hvEssvWDFWO3mjd0JRhLbx
 dzabngBqraLqbcNd1RAFGa7JrV/7fuCl43CRpG9/DUl9UU1K7p48zKbpiIl4LcA+Wz
 nhZ9cNWZQ4ehxGGrAy+73YBzXyD/m3aKunx0603z9cOmoO62TdqAnnSkvg1qSBX/PU
 rkOJ5vOnO2TjgsOlVihhSTHKV6Wb0EOurj0bFbTLgIatAV5FRvJwsB9IDtDL0cJuqS
 vi/uBJGfDPNksctzE65t4fsDWQk14mf4dsL8bUBV//Mx3amyuIcTKBunImwTGbQpCh
 S9zMRuSafdvKw==
Subject: Re: [PATCH net v2] ice: fix Tx hang dump using stale tx_buf[0].skb
From: netdev-bot+sashiko@kernel.org
To: choiniere.vincent@hydroquebec.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, aleksandr.loktionov@intel.com,
 michal.kubiak@intel.com, wojciech.drewek@intel.com,
 mateusz.polchlopek@intel.com, pmenzel@molgen.mpg.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 29 Oct 2026 02:37:19 +0000
Message-ID: <179324143967.3134.13716472134019576369@kernel.org>
In-Reply-To: <20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@hydroquebec.com>
References: <20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc@hydroquebec.com>
X-sashiko-severity: High
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] ice_tx_hang_snapshot()'s safety argument is that PF VSI rings
  'are only replaced or freed under RTNL or from the service task, so…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch's
  new guard makes it look handled.
- [High] This problem wasn't introduced by this patch, but it is a
  deadlock between devlink DRIVER_REINIT reload and the Tx-hang…
- [Low] tx_hang_buf is published and consumed without synchronization.

--

ice: fix Tx hang dump using stale tx_buf[0].skb

This patch changes the ice Tx hang devlink dump so it no longer
dereferences tx_buf[0].skb or the saved tx_ring when the dump runs. It
records the queue and ring indices at timeout time. Under RTNL, it checks
that the saved ring is still one of the PF VSI Tx rings and that the VSI
is up, then copies the descriptors and IRQ name. It keeps only the skb
pointer value and drops RTNL before calling devlink_health_report().

Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/

> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a8178d4..b9493ab4766e 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c

[ ... ]

> @@ -424,24 +429,104 @@ void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
>  	buf->vsi_num = vsi_num;
>  	buf->head = head;
>  	buf->intr = intr;
> +	buf->queue = tx_ring->q_index;
> +	buf->next_to_clean = tx_ring->next_to_clean;
> +	buf->next_to_use = tx_ring->next_to_use;
> +}
> +
> +/**
> + * ice_tx_hang_snapshot - copy the hung Tx ring state for the dump
> + * @pf: PF on which the Tx hang was detected
> + * @tx_ring: ring saved by ice_tx_timeout(), possibly stale
> + * @ev: event to fill in
> + *
> + * The saved ring may have been freed or replaced since the timeout (e.g. by
> + * ethtool -G or -L). Use it only if it is still one of the PF VSI Tx rings
> + * and the VSI is up: those rings are only replaced or freed under RTNL or
> + * from the service task, so with RTNL held every access below is to live
> + * memory. ice_clean_tx_irq() may still run and free the skb at
> + * next_to_clean at any time, so only the pointer value is recorded and the
> + * skb itself is never dereferenced.
> + */
> +static void ice_tx_hang_snapshot(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
> +				 struct ice_tx_hang_event *ev)
> +{
> +	struct ice_vsi *vsi = ice_get_main_vsi(pf);

[ ... ]

> +	ASSERT_RTNL();
> +
> +	if (!tx_ring || !vsi || !vsi->tx_rings ||
> +	    test_bit(ICE_VSI_DOWN, vsi->state))
> +		return;

[Severity: High]
Does the lifetime claim in the kernel-doc above hold for the ice_remove()
path?

In ice_remove(), RTNL is dropped inside ice_unload(). ice_deinit() then
tears down the VSIs without RTNL. The service work is only cancelled
later, in ice_deinit_dev():

    ice_remove()
        ice_unload(pf);        <- unregister_netdev() takes/drops RTNL
        devl_unlock(...);
        ice_deinit(pf);
            set_bit(ICE_SERVICE_DIS, pf->state);
            set_bit(ICE_DOWN, pf->state);
            ice_deinit_pf_sw(pf);  <- ice_vsi_release() frees rings,
                                      tx_rings and the vsi
            ice_dealloc_vsis(pf);  <- devm_kfree(..., pf->vsi)
        ...
        ice_deinit_dev(pf);    <- ice_service_task_stop()
                                  -> cancel_work_sync(&pf->serv_task)

ICE_SERVICE_DIS stops new scheduling, but it does not stop a work item
that is already queued or running. ice_vsi_free() holds only
pf->sw_mutex:

    pf->vsi[vsi->idx] = NULL;
    ...
    mutex_unlock(&pf->sw_mutex);
    devm_kfree(dev, vsi);

Suppose a Tx timeout fires shortly before removal. ice_service_task()
then sees tx_hang_buf.tx_ring set and calls ice_report_tx_hang() without
checking ICE_SERVICE_DIS. The work can block in rtnl_lock() while
unregister_netdev() holds RTNL. It then gets RTNL while ice_deinit() is
freeing the VSIs.

Could ice_get_main_vsi(pf), vsi->tx_rings and test_bit(ICE_VSI_DOWN,
vsi->state) then read the freed pf->vsi array or the freed struct ice_vsi?

The ICE_VSI_DOWN check only helps while the vsi itself is still
allocated. Does the service task need to be stopped or flushed, or
tx_hang_buf.tx_ring cleared, before the VSI teardown in ice_remove()?

[ ... ]

>  void ice_report_tx_hang(struct ice_pf *pf)
>  {
>  	struct ice_health_tx_hang_buf *buf = &pf->health_reporters.tx_hang_buf;
> -	struct ice_tx_ring *tx_ring = buf->tx_ring;
> -
>  	struct ice_tx_hang_event ev = {
>  		.head = buf->head,
>  		.intr = buf->intr,
>  		.vsi_num = buf->vsi_num,
> -		.queue = tx_ring->q_index,
> -		.next_to_clean = tx_ring->next_to_clean,
> -		.next_to_use = tx_ring->next_to_use,
> -		.tx_ring = tx_ring,
> +		.queue = buf->queue,
> +		.next_to_clean = buf->next_to_clean,
> +		.next_to_use = buf->next_to_use,
>  	};
>  
> +	if (!pf->health_reporters.tx_hang)
> +		return;

[Severity: High]
This isn't a bug introduced by this patch, but can this check pass with
a reporter that has already been freed?

In ice_remove(), the reporter is destroyed before ice_unload() and
ice_deinit(). The service work is still live at that point:

    ice_remove()
        ice_deinit_devlink(pf);
            ice_health_deinit(pf);
                ice_deinit_devl_reporter(pf->health_reporters.tx_hang);
                    devl_health_reporter_destroy()  <- kfree(reporter)
        ice_unload(pf);
        ...
        ice_deinit_dev(pf);    <- cancel_work_sync(&pf->serv_task)

ice_health_deinit() never sets pf->health_reporters.tx_hang to NULL, so
the stale pointer passes this check.

With a Tx timeout just before or during removal, the service task can
reach ice_devlink_health_report() after the kfree(). devlink_health_report()
then writes reporter->error_count and reporter->health_state, and it
dereferences reporter->devlink and reporter->ops.

Waiting in rtnl_lock() while unregister_netdev() holds RTNL also makes
it more likely that the report runs after the reporter has been freed.

> +
> +	rtnl_lock();
> +	ice_tx_hang_snapshot(pf, buf->tx_ring, &ev);
> +	rtnl_unlock();

[Severity: Low]
This is a pre-existing issue, and the changelog's limitations section
already covers it. The window looks wider now, though. ev.head, ev.intr,
ev.queue and the ring indices are read from tx_hang_buf before
rtnl_lock(). buf->tx_ring is only read after rtnl_lock() returns.

ice_prep_tx_hang_report() stores buf->tx_ring before the other fields,
with no ordering. ice_service_task() then clears the pointer with a
plain store:

    if (pf->health_reporters.tx_hang_buf.tx_ring) {
        ice_report_tx_hang(pf);
        pf->health_reporters.tx_hang_buf.tx_ring = NULL;
    }

Suppose a second timeout arrives while rtnl_lock() is blocked. Could the
dump then combine the first event's queue/head/intr with the second
event's ring snapshot? Could the clear above also drop the second event?

>  	ice_devlink_health_report(pf->health_reporters.tx_hang, "Tx hang", &ev);

[Severity: High]
This isn't a bug introduced by this patch, but can this deadlock against
a devlink driver_reinit reload?

ice_devlink_reinit_down() runs with the devlink instance lock held. It
ends up in cancel_work_sync() on the service work:

    ice_devlink_reload_down()
        ice_devlink_reinit_down()   <- devl_lock held by devlink core
            ice_unload(pf);
            ...
            ice_deinit_dev(pf);
                ice_service_task_stop()
                    cancel_work_sync(&pf->serv_task);

The tx_hang reporter has a dump op, so auto_dump is set. In that case
devlink_health_report() takes the same lock from the service work:

    if (reporter->auto_dump) {
        devl_lock(devlink);

Suppose a Tx timeout fires just before the reload. The service task can
then be inside ice_report_tx_hang(), possibly waiting for RTNL during
unregister_netdev(). It returns early from the snapshot because the VSI
is down and then blocks in devl_lock(). Meanwhile the reload thread waits
for that same work in cancel_work_sync().

Dropping RTNL before reporting avoids the RTNL/devlink lock ordering
problem. Does it do anything for this dependency between the reload and
the service work?

> +
> +	kvfree(ev.desc);
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026-ice-tx-hang-dump-v2-1-e2136ef2c5dc%40hydroquebec.com
