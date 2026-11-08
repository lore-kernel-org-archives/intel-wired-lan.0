Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7B606A326
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Mfn3RsJR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YAwnhVWQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3023B80E1B;
	Sun,  8 Nov 2026 14:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QlzjXFGhuiWa; Sun,  8 Nov 2026 14:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2972A80E15
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794148524;
	b=nDjy0heReROmb211SfD0ZOVqwWyRAeuNp3EC1LW98gY/MNn5OR+bYjr3UheJBarpQ3kH
	 4G7lFU67ZJuh08OdHCl3bLe2q2hGeZl6JsIhrIl78iMbWxX5fY/v5oIwvsAQoKS5SP56j
	 N/Rf50ODXZg1FoPhRtaT07SIUOMZxT/ByciVLLbYkxzrrOm3Rm88gZ0f3rOZQ+UjEq2wo
	 PgbUj34gqgibEV6Co2v2eNkaws6KNONKhbx1RzB7UPukPIXuAF0WZxj1tRUx8SUzDqzYX
	 tQL/gqfmaW2ZqiGS4TNQM4INwrb78csq6TDKvfm4WDyXZMPdHSN5R9loSu7DyiJCP6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794148524;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5as8Sg88475Zct3Uh6eMJe75+c4+QtKGpO1flGohHo0=;
	b=Uiyl6Xoi740wZ5qM1tGsNJBW0pnOrLUy+i9wh+hO7rA6UAaLRwOZAFPQ6oYHTU6ps6sz
	 cGAEi51xxCnuqFX0w4UzhV3ATNHx0RcgOI9qtPbv6wLubGTUsHLp4hMqKEi/9lOWJSte/
	 5C2Ao5R3MV7Mqj40HhE+6YXu0htMVfe8ZuW4fO2+eA0+ekMyxFdIA3Zg6SqbKsC01JxaN
	 XR2dWHldzWOnLwDVuXinckXBc90+fdXraVWqkQesjUK9gbxkajdWblny4FNSQiJZrtDdr
	 HxUxcSiE7KJBc8yo3FQAVgrNzunHBFzSGcxozxrMdvqfGM7r02UHgbgAXiYwpiUGNcg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794148524;
	bh=5as8Sg88475Zct3Uh6eMJe75+c4+QtKGpO1flGohHo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mfn3RsJROYO1/bug6wZLb+M5kmnwj7JlBxDxjGNj6CZz20dyON8j2MIvjrG9CwTGQ
	 2CRc47lVJt+m2GGGcgPCMYChYSlOKFIvt/98+wEi0OsXfckE/85GTdtiRj32h0PDPu
	 Y+SrYI77OHUJdJOWye6xEGB1jdR4imnI1BkBXopZXYIoRg+55LKsNoY7JLkkSIQQCG
	 FB8gpiT2zhTiSipDUcLcbwpav4QPK+/eaIu0Ir/qb2ziZU+nF8Q4BAxsqZRfNOl/Bj
	 1xzSwCloWDHKVeVN+aPIZOnWx6FjF/LXuYN37hJ3fbLMWR5vDyP6OUkSUkkaV479qV
	 F7zwt9tOstT6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2972A80E15;
	Sun,  8 Nov 2026 14:35:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 60DAE9E2
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46E624005E
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jEofea7B5uNA for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 14:35:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 02762400A8
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=YAwnhVWQ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02762400A8
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 14:35:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEF2743BFF;
 Sun,  8 Nov 2026 14:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95F71F0089F;
 Sun,  8 Nov 2026 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794148520;
 bh=5as8Sg88475Zct3Uh6eMJe75+c4+QtKGpO1flGohHo0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=YAwnhVWQhoM0vrpxez5xlyxRZb5hOLXJG3DMYW5qPZmctAiZc1q56aWGH0Oe6bpSt
 wO9xi03lVip8CuhGj+pYnXfPEdY4cUYbuapm2zHeOs0QfEDq4IzLs41pf1cQXTYOBY
 ex0Br11f9F4RxwGJIoF2hMG/WoR2PxQQNZI4ZoymFtCBXjzyYel4G8UOx6fZ+uvVOH
 lkchbO0Z2nb3O7N0bQpH5q5ynfQvjSrF9cfCcO04x5SDL3lWNM+QpEG7L5Q8HC03m5
 kws8DgwrajGjFiWP1vKiOgZUZQKhvAwrxPolYGYMdG/1QUrUGLuNh9yyX1LQKDtQkK
 K1VOgjtDZsC3w==
Subject: Re: [PATCH net v3] ice: fix Tx hang dump using stale tx_buf[0].skb
From: netdev-bot+sashiko@kernel.org
To: choiniere.vincent@hydroquebec.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, aleksandr.loktionov@intel.com,
 michal.kubiak@intel.com, wojciech.drewek@intel.com,
 mateusz.polchlopek@intel.com, pmenzel@molgen.mpg.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Sun, 08 Nov 2026 14:35:19 +0000
Message-ID: <179414851949.994134.15149868204650152541@kernel.org>
In-Reply-To: <20261107-ice-tx-hang-dump-v3-1-8f22109d1aad@hydroquebec.com>
References: <20261107-ice-tx-hang-dump-v3-1-8f22109d1aad@hydroquebec.com>
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ice_tx_hang_snapshot()
  (drivers/net/ethernet/intel/ice/devlink/health.c) decides whether the…
- [Low] This patch removes the only caller of devlink_fmsg_dump_skb(),
  which was ice_tx_hang_reporter_dump().
- [Low] The new fields tx_hang_buf.queue, next_to_clean and next_to_use
  use the existing unsynchronized handoff from ice_tx_timeout() to the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the service
  task can still run ice_report_tx_hang() during driver removal after…
- [High] This problem wasn't introduced by this patch, but devlink reload
  with DRIVER_REINIT can deadlock against the service task's Tx-hang…

--

ice: fix Tx hang dump using stale tx_buf[0].skb

This patch stops ice_tx_hang_reporter_dump() from dereferencing the saved
Tx ring and a skb that may already be freed. It records the queue index
and ring indices at timeout time. It checks the saved ring under RTNL
before copying the descriptors and IRQ name, and it removes the skb
contents from the dump.

Link: https://lore.kernel.org/all/20260327072332.130320-1-aleksandr.loktionov@intel.com/

> diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
> index 8e9a8a8178d48..faad9271df0f6 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/health.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/health.c

[ ... ]

> @@ -403,13 +407,14 @@ static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
>  	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, queue);
>  	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_clean);
>  	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_use);
> -	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
> -	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
> -	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
> -	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
> -	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
> -				     event->tx_ring->count * sizeof(struct ice_tx_desc));
> -	devlink_fmsg_dump_skb(fmsg, skb);

[Severity: Low]
This isn't a bug, but this removes the only caller of
devlink_fmsg_dump_skb(). What remains is its definition and
EXPORT_SYMBOL_GPL in net/devlink/health.c and its prototype in
include/net/devlink.h, with no users.

Could the commit message say whether removing the unused export is
planned as a net-next follow-up?

[ ... ]

> @@ -424,24 +429,105 @@ void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
>  	buf->vsi_num = vsi_num;
>  	buf->head = head;
>  	buf->intr = intr;
> +	buf->queue = tx_ring->q_index;
> +	buf->next_to_clean = tx_ring->next_to_clean;
> +	buf->next_to_use = tx_ring->next_to_use;
> +}

[Severity: Low]
These new fields are stored after buf->tx_ring, which ice_service_task()
uses as the pending-event flag. The stores are plain, with no release
ordering:

ice_prep_tx_hang_report() {
	buf->tx_ring = tx_ring;
	...
	buf->queue = tx_ring->q_index;
	...
}

ice_service_task() {
	if (pf->health_reporters.tx_hang_buf.tx_ring) {
		ice_report_tx_hang(pf);
		pf->health_reporters.tx_hang_buf.tx_ring = NULL;
	}
}

ice_report_tx_hang() copies buf->queue, head, intr and the indices into
ev before rtnl_lock(). It then reads buf->tx_ring again under RTNL and
passes that to ice_tx_hang_snapshot().

A newer ice_tx_timeout() could overwrite buf while the service task waits
on RTNL. Could the dump then show one ring's descriptors, IRQ name and
indices next to another event's queue, head and intr? The newer event
would also be dropped when ice_service_task() clears tx_ring.

Before this patch, queue and the indices came from the same tx_ring
pointer that was dumped, so they always matched. The patch notes
acknowledge that the handoff is unsynchronized. Could the success path of
ice_tx_hang_snapshot() at least set ev->queue = tx_ring->q_index, the
same way it updates next_to_clean and next_to_use?

[ ... ]

> +static void ice_tx_hang_snapshot(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
> +				 struct ice_tx_hang_event *ev)
> +{

[ ... ]

> +	ice_for_each_txq(vsi, i)
> +		if (vsi->tx_rings[i] == tx_ring)
> +			break;
> +	if (i == vsi->num_txq)
> +		return;

[Severity: Medium]
Is pointer equality enough to show that this is still the hung ring? Two
cases seem to pass this check.

With ethtool -G, the ring contents are replaced in place. The struct keeps
its address, but desc, tx_buf, count and the indices are new:

ice_set_ringparam() {
	...
	ice_free_tx_ring(vsi->tx_rings[i]);
	*vsi->tx_rings[i] = tx_rings[i];
	...
}

With ethtool -L, ice_vsi_clear_rings() frees the old rings with
kfree_rcu(), and ice_vsi_alloc_rings() allocates new ones with
ring->q_index = i. A new ring for a different queue could end up at the
freed address.

In both cases the snapshot succeeds. It overwrites the timeout-time
next_to_clean and next_to_use with the live values of a different ring.
It also copies that ring's descriptors, IRQ name, desc pointer and DMA
address. Meanwhile queue, head and intr still describe the original hung
queue.

The commit message says:

    If the ring cannot be used or the copy cannot be made,
    report only the values recorded at timeout time.

Neither case is detected here, though. Would checking i == ev->queue (or
tx_ring->q_index == ev->queue) at least reject the cross-queue case?

[ ... ]

>  void ice_report_tx_hang(struct ice_pf *pf)
>  {

[ ... ]

> +	if (!pf->health_reporters.tx_hang)
> +		return;
> +
> +	rtnl_lock();
> +	ice_tx_hang_snapshot(pf, buf->tx_ring, &ev);
> +	rtnl_unlock();

[Severity: High]
This isn't a bug introduced by this patch, but can the service task reach
this code during driver removal, after the tx_hang reporter has been
freed?

ice_remove() destroys the reporter and releases the VSIs before it stops
the service task:

ice_remove()
    ice_deinit_devlink(pf)
        ice_health_deinit()
            ice_deinit_devl_reporter()
                devl_health_reporter_destroy()   <- reporter freed
    ice_unload(pf)
    ice_deinit(pf)
    ice_vsi_release_all(pf)                      <- no RTNL held
    ...
    ice_deinit_dev(pf)
        ice_service_task_stop()
            cancel_work_sync(&pf->serv_task)

pf->health_reporters.tx_hang is not cleared after the destroy, so the new
NULL check sees a dangling pointer. ice_service_task() calls
ice_report_tx_hang() before checking ICE_SERVICE_DIS, whenever
tx_hang_buf.tx_ring is set. A Tx timeout before ice_unload() is enough to
set it.

devlink_health_report() would then update error_count and health_state
and call devlink_health_do_dump() on the freed reporter. The same applies
to a service task that is already blocked in devl_lock() inside
devlink_health_report() while ice_remove() destroys the reporter. It
reaches the freed reporter once it gets the lock.

ice_tx_hang_snapshot() also dereferences pf->vsi[0], vsi->tx_rings,
vsi->state and tx_ring->desc under RTNL. ice_vsi_release_all() runs
without RTNL in ice_remove(), so holding RTNL does not keep those objects
alive.

The patch notes list this ordering as a known limitation to be fixed
separately.

> +
> +	/* devlink_health_report() takes the devlink instance lock, which nests
> +	 * outside RTNL, so only report once RTNL has been released.
> +	 */
>  	ice_devlink_health_report(pf->health_reporters.tx_hang, "Tx hang", &ev);

[Severity: High]
This is a pre-existing issue, but can a devlink reload with DRIVER_REINIT
deadlock against this report?

The devlink core holds devl_lock while it runs the reload down path, and
that path waits for the service task:

devlink reload (devl_lock held)
    ice_devlink_reload_down()
        ice_devlink_reinit_down()
            ice_deinit_dev()
                ice_service_task_stop()
                    cancel_work_sync(&pf->serv_task)

If a Tx timeout set tx_hang_buf.tx_ring just before the reload, the
service task runs:

ice_service_task()
    ice_report_tx_hang()
        devlink_health_report()
            devl_lock(devlink)    <- auto_dump path, blocks

auto_dump defaults to true for this reporter because it has a .dump op.
The service task waits for devl_lock, which the reload thread holds. The
reload thread waits in cancel_work_sync() for the service task.

Releasing RTNL first keeps RTNL out of the cycle, but the devl_lock
dependency against reload is still there.

The FW_ACTIVATE reload path seems to have a milder version of this.
ice_devlink_reload_empr_finish() waits for the reset under devl_lock.
The blocked service task cannot run ice_reset_subtask(), so the wait
times out.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107-ice-tx-hang-dump-v3-1-8f22109d1aad%40hydroquebec.com
