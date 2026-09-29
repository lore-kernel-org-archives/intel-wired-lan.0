Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC190CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 11:41:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 702BB80C73;
	Tue, 29 Sep 2026 11:41:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFv-Qg5Kyubr; Tue, 29 Sep 2026 11:41:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 71FEC80C77
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790682068;
	b=Pne5Veedn1CrXOgSeUfTM4H64PlEA5G91INfxzqf4/aXjXP5c+cO0pqylLdnSUqYZ5d4
	 ekN/9zpQqEhPMOmoT575Pj0VXJRclfOgv6dqVhToDHQMGqnvlnY6DAr2TUEf5NvilFQ3N
	 tgYC2QTXCdO3DvX9joca8AHb1DMoeJwzRVhnBi94TroZRJ5Wv0H+WFkrC4ui4MjVJ88Rw
	 OhjPLych9Iyr3q5oQPa+U8yPot0aVnTtSsPhh+o4fXYScX5s9UEJp1+w7eNOBhJ0xC+Aa
	 RndmnbkXQXmnAwOym2/BRajOHWCkJz+JFgqGW7Hg8Y16oAkG+J+y5SnVBbBuXuxuiXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790682068;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YajkRf88ajtVJDW2GBmYe9Gx4OdPQQLdhTOJZupqZvk=;
	b=SeX0tcmFV5y7BKUH9A8N+RJG+S1PNIvswwSRXRsf4O3qqrwtfwLQaxF39KcecXKKT/wr
	 3H2F2wQCI/IMsgdGU8yOMa77mXRLstz08Hpt9u685D/MbyFCtbZHZ3vOsFK+nozjSB5Ke
	 6AqWdaJy5B36+1PkUw9SsSN2ecpGx3cYF/sLyfAtHpUEzu2jd2Cu7R3rnNiftNv/PrFlC
	 kGAwVs6sHNBiuanAOQyz+zth67ecucZqgFqLL0L3mcOVtvJoD0GEUgh5P3eK8GYZxnrA8
	 cetT2ZzGeLNW0jW57XZTgxIEaEuwK7KDM+R/hewYDCpjzw8YXgGBYVMYAasubNo/h0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790682068;
	bh=YajkRf88ajtVJDW2GBmYe9Gx4OdPQQLdhTOJZupqZvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g7pMXewW7v4KLLADDO9H4cxXBzojefkgJn/ACsgExZX0VB+gh6SIruo/I6VmTAgzQ
	 pUYUDRN3crycVkJAyqOILooXWP6zI/f6Ra7l2lDKmxTz4e/oTi44nDjN0rt8ee2OOa
	 QAngdzb/7HUaxWGsCUVht30dORCHO5cKTluZdloslfl3UxXkVNOtKkDyEg4TUgXPCI
	 4hJfQfPFEKOcIDDrKqbUnWE2JLuDot3HM4yOVo/pkqCuz4kVz+VmE9HUSc3J/I43Lo
	 WQO6eQxIxq6Mk+RR6AcXdSKiTXohRhiad2aeqcXSjkP7h9tAdyJLT+UOZtse3siSVZ
	 av4+CcZt0YOJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71FEC80C77;
	Tue, 29 Sep 2026 11:41:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 661E82E5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 11:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 573A26071B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 11:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id biicQGwni6t8 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 11:41:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 175A660774
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790682065;
 b=JPewQWJsPMCoKj6W+nnWB6XDxRz/JpKq88p9eh/D+M7KbLLnpSXhyncJ8f2asScRtEW8
 uhqsUGfncaVIe64Ywo91dujBaq8pHvfuPLK6erPAJuICrRTF2c2Y33V6LQ1PZB/tTEukR
 cozwHB5+zjwZ9cWs/FH7BSp2x9C1P7Yb+qJKt6jsmXDi8qANT7YlQXxNf7sFdApwSUiJR
 8E7iOdhw9ENea7vFu9pDKO65M2D6jphJojF7h6dnyZo2TRP4o/dIHKgn5nt6iKRVLeSB4
 gwemQayHWrn7zbaGNL/MealTuF2C7GmAwuJ4Hvg/4GzTh1+6I6pGAJPGUfa63NawIAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790682065;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=YajkRf88ajtVJDW2GBmYe9Gx4OdPQQLdhTOJZupqZvk=;
 b=XEP5iV82KEvMBVbVPH1vsltYHBRMlI2OQu3gO2WpR5X7BPUDiWqYU7LrrYI23A4WXJmj
 bWU5STqC1F/gCIA165UzPOOk6OtdwsD7L8vg4GgwNoF38JTrv5hfKHM+pkiA8wd2yPvaC
 n+tYO/EYz/IWtXApRj90oKDaJSo8f+cYVI34VsBQiOYZ4/GHrdwGO0Mro9u6QQxncDK3T
 SQ7jTRN2FMKcUCFMXRWsJDyyZhGFnzWzV6ffcKreDbqyec9BU/ToKAMwbc6IfLD/drDfC
 AGfT1alnm2GhYgN6tbOWyswonLNQgJjxJLoaYCBNc6rpmkKPn0k9yWT7TkZzaZtRLtw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=m3BD3xoV; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=m3BD3xoV
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 175A660774
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 11:41:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDF5C60136;
 Tue, 29 Sep 2026 11:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4191F000FF;
 Tue, 29 Sep 2026 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790682062;
 bh=YajkRf88ajtVJDW2GBmYe9Gx4OdPQQLdhTOJZupqZvk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=m3BD3xoVf5adZLLJLspFFFQ8xVDWkY7frxQhjiVgDVUJtGNib5/hFeT8BIeafT7sO
 elqBRpd+jh0AqlZEAMRd9DOOuY4R7USk0vD1GnpMOucxS1Llonzmxpyp0kTsb55DTz
 RhJNaOZgxxQfqg0YPXLTooImbpbJlcYJzNM1FyyQqcN8NLpbhbHZwRyoRpexmGJ4id
 Ks2wDdsmCwd/Dnwl2nkXNFFz8bTEoGp2IY5MXUImv3CIkZU43FnFHOc2VJCMGnCw7E
 0hUSSyc2woGKrRssUA679fkrCSkDqJptGCRF4FMenC50gX2poxWv6vFTGYOOkRZ7mZ
 eNHEUMtqGYoYQ==
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
From: netdev-bot+sashiko@kernel.org
To: danividanivi@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bhelgaas@google.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 29 Sep 2026 11:41:01 +0000
Message-ID: <179068206160.434549.1717741783856466607@kernel.org>
In-Reply-To: <20260925112850.189302-1-danividanivi@gmail.com>
References: <20260925112850.189302-1-danividanivi@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The widened condition in `__igc_resume()` (igc_main.c:7562-7563)
  makes I225-LMvP and I226-LMvP call the non-locked…
- [Medium] Adding `IGC_DEV_ID_I226_LMVP` to `igc_is_device_id_i226()`
  (drivers/net/ethernet/intel/igc/igc_base.c:450) changes more than the…
- [Low] In `igc_probe()`, `__igc_resume()` and `igc_io_slot_reset()`, the
  return value of…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch now
  exposes I226-LMvP to it.

--

igc: Disable PCIe L1.2 substate on I225-LMvP and I226-LMvP devices

This commit adds IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). It also
extends the ASPM L1.2 disable in probe, resume and PCI error recovery to
IGC_DEV_ID_I225_LMVP. The motivation is BadDLLP errors, link timeouts and
shutdown hangs seen when I225-LMvP negotiates L1.2 behind Thunderbolt/USB4
docks.

Link: https://lore.kernel.org/lkml/eb5a9805-3e53-ec22-696e-21c6b8cf0bfc@molgen.mpg.de/T/

> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index ab9120a3127f2..6865fef4049ff 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
>  	case IGC_DEV_ID_I226_V:
>  	case IGC_DEV_ID_I226_K:
>  	case IGC_DEV_ID_I226_IT:
> +	case IGC_DEV_ID_I226_LMVP:
>  		return true;
>  	default:
>  		return false;

[Severity: Medium]
Does this change do more than the L1.2 handling the commit message
describes? igc_is_device_id_i226() also selects I226-specific TSN/Qbv
register programming in igc_tsn.c. I226-LMvP now takes these paths:

drivers/net/ethernet/intel/igc/igc_tsn.c:igc_tsn_disable_offload() {
    ...
	if (igc_is_device_id_i226(hw))
		igc_tsn_restore_retx_default(adapter);
    ...
}

drivers/net/ethernet/intel/igc/igc_tsn.c:igc_tsn_enable_offload() {
    ...
	if (igc_is_device_id_i226(hw))
		igc_tsn_set_retx_qbvfullthreshold(adapter);
    ...
		if (igc_is_device_id_i226(hw)) {
			...
				tqavctrl |= IGC_TQAVCTRL_FUTSCDDIS;
			...
			hrtimer_start(&adapter->hrtimer, expires_time, HRTIMER_MODE_REL);
		}
    ...
}

Before this patch, 0x5503 matched neither igc_is_device_id_i225() nor
igc_is_device_id_i226(). So none of the following ran on that SKU: the
RETX_CTL QBVFULLTH/QBVFULLEN workaround, the FutScdDis programming, the
Qbv hrtimer and the double BASET_L write.

The new behaviour matches the other I226 SKUs, but the subject and body
only describe an ASPM L1.2 fix. Because of the Fixes: 0325143b59c6 tag,
these TSN register changes would go into stable trees without any
mention.

The TSN part also seems to fix an omission from when
igc_is_device_id_i226() was introduced, not one from 0325143b59c6.

Could the commit message describe the TSN side effects? Alternatively,
could that part be split into a separate patch with its own Fixes: tag?

[Severity: High]
This isn't a bug introduced by this patch. However, classifying 0x5503 as
I226 also exposes I226-LMvP to an existing problem with adapter->hrtimer.

igc_tsn_enable_offload() arms adapter->hrtimer when the taprio base time
is in the future. The only hrtimer_cancel() for it is in igc_remove().

__igc_shutdown() (system and runtime suspend) and igc_reinit_queues() call
igc_clear_interrupt_scheme() without cancelling the timer:

igc_clear_interrupt_scheme()
  igc_free_q_vectors()
    adapter->num_tx_queues = 0;
    igc_reset_q_vector()
      adapter->tx_ring[...] = NULL;

The timer is not cancelled across suspend, so it can still be pending
when resume runs. On resume or reinit, the queue count is restored before
the rings exist again:

igc_init_interrupt_scheme()
  igc_set_interrupt_capability()
    adapter->num_tx_queues = adapter->rss_queues;
    pci_enable_msix_range()
  igc_alloc_q_vectors()
    /* tx_ring[] repopulated here */

The timer callback loops over num_tx_queues without a NULL check:

drivers/net/ethernet/intel/igc/igc_main.c:igc_qbv_scheduling_timer() {
    ...
	for (i = 0; i < adapter->num_tx_queues; i++) {
		struct igc_ring *tx_ring = adapter->tx_ring[i];

		if (tx_ring->admin_gate_closed) {
    ...
}

The callback takes qbv_tx_lock, but the teardown and setup paths don't.
Suppose the timer expires between igc_set_interrupt_capability() and
igc_alloc_q_vectors(), or runs at the same time as igc_free_q_vectors().
Can it then dereference a NULL tx_ring in hardirq context?

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..6c4e046610689 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7172,8 +7172,8 @@ static int igc_probe(struct pci_dev *pdev,
>  	hw->subsystem_vendor_id = pdev->subsystem_vendor;
>  	hw->subsystem_device_id = pdev->subsystem_device;
>  
> -	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
> -	if (igc_is_device_id_i226(hw))
> +	/* Disable ASPM L1.2 on I226 and I225-LMvP devices to avoid packet loss */
> +	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
>  		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);

[Severity: Low]
This probably isn't a bug, but the return value of pci_disable_link_state()
is ignored here. The same is true in __igc_resume(), and for
pci_disable_link_state_locked() in igc_io_slot_reset().

__pci_disable_link_state() can return -EINVAL when there is no link state
(for example with pcie_aspm=off). It can also return -EPERM when the OS
doesn't have ASPM control:

drivers/pci/pcie/aspm.c:__pci_disable_link_state() {
    ...
	if (aspm_disabled) {
		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
		return -EPERM;
	}
    ...
}

In those cases L1.2 stays as firmware configured it on the newly covered
I225-LMvP and I226-LMvP devices.

The PCI core already warns on the -EPERM path. Failing probe, resume or
recovery would leave the NIC unusable, and the existing I226 handling
does the same thing. Is continuing silently here the intended behaviour?

> @@ -7559,7 +7559,7 @@ static int __igc_resume(struct device *dev, bool rpm)
>  	pci_enable_wake(pdev, PCI_D3hot, 0);
>  	pci_enable_wake(pdev, PCI_D3cold, 0);
>  
> -	if (igc_is_device_id_i226(hw))
> +	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
>  		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);

[Severity: High]
Can this take pci_bus_sem recursively during AER recovery?

__igc_resume() is also the runtime resume path, and igc runtime suspends
after link loss via igc_runtime_idle(). pcie_do_recovery() runtime
resumes devices from inside a bus walk that holds pci_bus_sem for read:

pcie_do_recovery()
  pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL)
    pci_walk_bus()
      down_read(&pci_bus_sem);
      pci_pm_runtime_get_sync()
        pm_runtime_get_sync()
          igc_runtime_resume()
            __igc_resume(dev, true)
              pci_disable_link_state()
                __pci_disable_link_state()
                  down_read(&pci_bus_sem);

A writer could queue between the two down_read() calls, for example
pci_device_add() from enumeration or hotplug, which is plausible behind a
Thunderbolt dock. The nested reader would then block behind the writer,
while the writer waits for the outer reader. Would that deadlock AER
recovery and PCI enumeration? Lockdep would also be expected to report
recursive locking here.

igc_io_slot_reset() already uses pci_disable_link_state_locked() for this
reason. The runtime resume step earlier in recovery isn't covered,
though.

The other I226 IDs already have the same pattern, and this patch extends
it to both LMvP devices. Could it be fixed for all of them at the same
time?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925112850.189302-1-danividanivi%40gmail.com
