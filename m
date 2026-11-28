Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2575606A685
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hibYTCUZ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etxzu4GT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C20F40613;
	Sat, 28 Nov 2026 09:30:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OV1-pM4KM3Js; Sat, 28 Nov 2026 09:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6212F4056A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795858213;
	b=chjPGklApK/WxHWIkMUDYLQ3pQFpV2vwYTXIUXlxDcjuc5gl80OgCdCrfr89I6969QyT
	 55Fwa40ZALx5mFFJFoLIQ8qLuH3uZISMglCJSBcfCabZOO6yoYndehRIUJLSv+ifGcnKZ
	 ucaG+aAyWGZ9VhOztjHwEHZiygXwbncRaSFPNCvDSgQNO8ttCokuJIcM8lUTmP/ASbE+i
	 BJJ9cfrbG51Zu4/xft/iqvhJOEOPPkRxlIfo6r6XIdKzXdlDR/ghRdUsbi91vNc6hmF+A
	 LJTPffjuIMdCkgrKOMfOBntuxdmaq/NvQE/9Mngx6SQEVw6xyJXEHamQcdyCZrRJ2ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795858213;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zgOM8vAhf19+9a0t5JbrihfRnYtAHBHB03GFJ5Sqe8M=;
	b=sT8983IzkfWqDVhsvZDa3fTuiE/UjhnxsQkbtilgA2hXZGcZcqvKolCuJja/8C99cFwr
	 vzyUvLlBf/JyCn26YCJ+ZlPnXFrElJdygkGzLTwvOpKmlrh6xmWKs1x/MMQqFDwW4h4vD
	 lp8LGYc+vpvw9noxwjEjwb219gJOl2N7AaS9d14IbCnZvNM9b9nSI7/GmexPqGkq/wZ5C
	 T+B0nsx5cYJZtKr+3YtmmiZzcgbz5HNEuJd4ErCo+7D5GDSg/h7fzMfLmVb2RJYzKm04Y
	 fNB/5N4MURRZlQVIM/U6Ngo29chJBzJYtECelrAPTVS42V6cKBFt4rrdKW/PVqZ+K3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795858213;
	bh=zgOM8vAhf19+9a0t5JbrihfRnYtAHBHB03GFJ5Sqe8M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hibYTCUZsNmkovpT6tWVUG1bZn6Xl4D32XiqMn2cJ6PpUPkv7Gp8MbWA9YDcWov7/
	 8GDCU74oPLImjEsxKxuKPE2G94PF5QsDeDZBDsjbInnAMK3mimRg+4PWtBMGnwYDpL
	 aSrvdEaKsJJaYcY4E8b/rciq/JcXC4BAADHlLPPb4iJ3yMkxL4fq2r1iXpK7lEqpr9
	 whpMICPDgHjtsyEiUTIZ2lsovzAr/VGX4qtaXSxIdA8B1wDLVkQawEwd8dcoVimqaD
	 eJj0gOjlTKaurrrUtzGj4oQ/0og2EL0YqRf36IAIw4niUkZfz+eEmtT3P97x4VIcLP
	 dP6lUdvNjhXzA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6212F4056A;
	Sat, 28 Nov 2026 09:30:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E141D2FE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6AC940112
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTrWT_TMwMEW for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 09:30:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E265400FF
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=etxzu4GT
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E265400FF
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E536601CB;
 Sat, 28 Nov 2026 09:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F6D1F000C1;
 Sat, 28 Nov 2026 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795858208;
 bh=zgOM8vAhf19+9a0t5JbrihfRnYtAHBHB03GFJ5Sqe8M=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=etxzu4GTQ3UAhayP6IwZ0T6LF9L1qSUo19CaH3iTmZJVZH5ESTqVbkZN1Vz0PxMaS
 2wBVe5sdp5u2WvEf9kxs8tEk56YVDrE1bHB6B7n08bE1kHEGaXkVcOOfNC3jgQ/5xc
 yfWMDm82Vg9ytJwKzhgAMEWJAJ9yvfDP0HKRFbwM7NIBnN5AR2F7vjwVMXXKRaLlEv
 bgDLY941y3JoOtLsHp7FN6R/7AjhTau+ObJnq7euXJXEvjk/IdcVTmWgW5MtLvzOpV
 qWbKKk6p4XzCq9UtK4o5u9Vg97vYnsBAgEvvFJzjgCKtuc1cNRHKRLPN2UUPSxwih6
 Ae19c48Z5xojw==
Subject: Re: [PATCH net v5 1/4] ice: stop the service task before the PF is
 unloaded
From: netdev-bot+sashiko@kernel.org
To: poros@redhat.com
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, horms@kernel.org,
 michal.swiatkowski@linux.intel.com, grzegorz.nitka@intel.com,
 pmenzel@molgen.mpg.de, wojciech.drewek@intel.com,
 marcin.szycik@linux.intel.com, martyna.szapar-mudlaw@linux.intel.com,
 ivecera@redhat.com, alice.michael@intel.com, jacob.e.keller@intel.com,
 jbrandeb@kernel.org, patryk.holda@intel.com, sx.rinitha@intel.com,
 aaron.ma@canonical.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Sat, 28 Nov 2026 09:30:06 +0000
Message-ID: <179585820637.3135.16053674648760900756@kernel.org>
In-Reply-To: <20261127085714.1207361-2-poros@redhat.com>
References: <20261127085714.1207361-2-poros@redhat.com>
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
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch moves the early ice_service_task_stop() only in
  ice_remove().
- [High] The patch handles the "last run re-arms the service timer after
  the stop, and the timer fires after the PF is freed" race only in the…
- [Medium] The early ice_service_task_stop() in ice_remove()
  (ice_main.c:5390) does not stop the service work from being queued…

--

ice: stop the service task before the PF is unloaded

This patch moves ice_service_task_stop() and ice_aq_cancel_waiting_tasks()
in ice_remove() back to right after ice_free_vfs(). The service task is then
stopped before the aRFS filters, netdev, LAG and VSIs are freed. The stop
in ice_deinit_dev() is kept so that it deletes a timer re-armed by the last
run.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 47c6798c97e8f..6dede87b78944 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5387,6 +5387,9 @@ static void ice_remove(struct pci_dev *pdev)
>  		ice_free_vfs(pf);
>  	}
>  
> +	ice_service_task_stop(pf);
> +	ice_aq_cancel_waiting_tasks(pf);
> +

[Severity: High]
The same ordering problem seems to remain on the other paths that unload
the PF. ice_devlink_reinit_down() in devlink/devlink.c does:

	ice_unload(pf);
	rtnl_lock();
	ice_vsi_decfg(ice_get_main_vsi(pf));
	rtnl_unlock();
	ice_deinit_pf(pf);
	ice_deinit_hw(&pf->hw);
	ice_deinit_dev(pf);

Nothing sets ICE_SERVICE_DIS before ice_deinit_dev(), so the service timer
keeps queueing serv_task during this whole sequence:

  - ice_unload()->ice_decfg_netdev() calls free_netdev(vsi->netdev).
  - ice_deinit_pf() destroys sw_mutex, tc_mutex and lag_mutex, frees the
    avail_txqs/avail_rxqs bitmaps and frees the misc IRQ.
  - ice_deinit_hw() destroys the control queues.

Can a run of ice_sync_fltr_subtask()->ice_vsi_sync_fltr() that has already
read vsi->netdev keep using netdev->flags and netif_addr_lock_bh(netdev)
after free_netdev()?

A devlink dev reload with action driver_reinit can trigger this while a
filter sync is pending, for example after a promisc or multicast change
through ice_set_rx_mode().

The probe error unwind in ice_probe() looks similar:

unroll_load:
	ice_unload(pf);
unroll_init:
	devl_unlock(priv_to_devlink(pf));
	ice_deinit(pf);
[ ... ]
unroll_hw_init:
	ice_deinit_hw(hw);
	if (need_dev_deinit)
		ice_deinit_dev(pf);

When this unwind runs, ice_init() has already cleared ICE_SERVICE_DIS and
armed serv_tmr. ice_load() has also queued serv_task through
ice_service_task_restart().

ice_deinit() only sets ICE_SERVICE_DIS, which does not wait for a running
work item, and then ice_dealloc_vsis() frees pf->vsi. After that come
ice_adapter_put() and ice_deinit_hw(), and only then the stop in
ice_deinit_dev().

Commit 8a37f9e2ff40, named in the Fixes: tag, is also the commit that moved
ice_deinit_dev() after ice_deinit_hw() in this unwind. Should
ice_devlink_reinit_down() and the probe unwind also stop the service task
before they tear down the PF? Neither path seems to change later in the
series.

[Severity: Medium]
Does a single ice_service_task_stop() here prevent serv_task from being
queued again before ice_remove_arfs(), ice_unload() and ice_deinit() run?

ice_service_task_schedule() tests ICE_SERVICE_DIS without a lock and only
calls queue_work() afterwards:

	if (!test_bit(ICE_SERVICE_DIS, pf->state) &&
	    !test_and_set_bit(ICE_SERVICE_SCHED, pf->state) &&
	    !test_bit(ICE_NEEDS_RESTART, pf->state))
		queue_work(ice_wq, &pf->serv_task);

Also, ice_service_task() does not check ICE_SERVICE_DIS when it starts.

At this point the netdev is still registered and the misc IRQ is still
live. That means ice_set_rx_mode(), ice_rx_flow_steer(), ice_misc_intr()
and the VF fdir handlers can all still reach ice_service_task_schedule().

One possible interleaving:

CPU0 (ice_set_rx_mode)              CPU1 (ice_remove)
set ICE_FLAG_FLTR_SYNC
test_bit(ICE_SERVICE_DIS) == 0
                                    ice_service_task_stop()
                                      test_and_set_bit(ICE_SERVICE_DIS)
                                      timer_delete_sync()
                                      cancel_work_sync() /* idle */
                                      clear_bit(ICE_SERVICE_SCHED)
queue_work(ice_wq, &pf->serv_task)
                                    ice_remove_arfs()
                                    ice_unload()  /* free_netdev() */
                                    ice_deinit()  /* ice_dealloc_vsis() */

The worker would then run ice_sync_fltr_subtask(), ice_sync_arfs_fltrs()
and the other subtasks against the state being freed. The second stop in
ice_deinit_dev() only runs after the VSIs are already gone.

The window is only a few instructions wide. Would a check of
ICE_SERVICE_DIS at the start of ice_service_task(), or quiescing these
scheduling sources first, be needed to close it?

>  	if (!ice_is_safe_mode(pf))
>  		ice_remove_arfs(pf);
>  
> @@ -5407,7 +5410,6 @@ static void ice_remove(struct pci_dev *pdev)
>  	ice_deinit_hw(&pf->hw);
>  
>  	ice_deinit_dev(pf);
> -	ice_aq_cancel_waiting_tasks(pf);
>  	set_bit(ICE_DOWN, pf->state);
>  }

[Severity: High]
The commit message says the stop in ice_deinit_dev() "stays and deletes a
timer armed by the last run". The ordering inside ice_service_task_stop()
has not changed, though:

	ret = test_and_set_bit(ICE_SERVICE_DIS, pf->state);

	if (pf->serv_tmr.function)
		timer_delete_sync(&pf->serv_tmr);
	if (pf->serv_task.func)
		cancel_work_sync(&pf->serv_task);

A work item that is running during the stop can re-arm the timer after
timer_delete_sync():

  - ice_service_task() calls mod_timer(&pf->serv_tmr, jiffies) at its tail
    when a run was long or an *_EVENT_PENDING bit is set.
  - ice_service_task_recovery_mode() always calls
    mod_timer(&pf->serv_tmr, jiffies + msecs_to_jiffies(100)).

Once that happens, ice_service_timer() keeps re-arming itself.

Some paths still stop only once. The first is the recovery-mode branch
of ice_remove():

	if (ice_is_recovery_mode(&pf->hw)) {
		ice_service_task_stop(pf);
		scoped_guard(devl, priv_to_devlink(pf)) {
			ice_deinit_devlink(pf);
		}
		return;
	}

After this, devres frees the PF (the devlink priv), and the recovery-mode
work re-arms every 100ms. Can serv_tmr then fire on freed memory, or, after
rmmod, on unloaded module text?

The probe error unwind also calls ice_deinit_dev() only once before devres
frees the PF.

In ice_devlink_reinit_down(), the single stop in ice_deinit_dev() is
followed by ice_devlink_reinit_up()->ice_init_dev()->
ice_start_service_task(). That calls timer_setup(&pf->serv_tmr, ...) on a
timer that may still be enqueued. Could this corrupt the timer wheel list
once mod_timer() enqueues it again?

Would it be better to fix this inside ice_service_task_stop()? One option
is a second timer_delete_sync() after cancel_work_sync(). Another is to
skip the tail mod_timer() calls when ICE_SERVICE_DIS is set. Either would
avoid relying on a double stop at the call site.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127085714.1207361-1-poros%40redhat.com
