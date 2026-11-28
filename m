Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4468606A681
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=q20JxZJI;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3SI0uNJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE30C40541;
	Sat, 28 Nov 2026 09:30:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wie4sH_P6irU; Sat, 28 Nov 2026 09:30:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5DA5540611
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795858216;
	b=D9z7aeAiQgGux23MpvFfEVPmyjWSO5pMFHS92REagQZEmDR/6KfFybWWd7armQEDzG4Q
	 soGqtCvkHHKuh98aJcWdfo8I0RajBRUOs5b7pukHQdARthBpoXphesZzu8LtloGM4ORZr
	 s1E59yBTVcNJ8+gIl4CC7li/4x7pXCLpnxHE3xXMYRZzG5JgjMnsSaooUJlfelZCgAD3B
	 3+nDhCxF+VTbJghQZq7zav+7iwR4MtRt8NaKYgjOe/UYWUgIAl+a8Rx9C27vRBFUB0nHy
	 rrnaZQdHrZNuGOO+OOWpC+mn876PIFdxvOWvNY3xIZSrIN/jvwvCOl7gfVZQ/XAGyYg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795858216;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0E50zM9a4bvLU3GTf4CVJ0IWGjMHMzi4/Gl2IyHbiDg=;
	b=H8ns5ark4pEqXdJ/ZI0sfl1lfl9QwGt0ePuqvHT/mnc2BiP5o+edaG+fBbVbCV/P0obJ
	 85KiIBFVwsBPxUBCYU7uqYiam/VgL6ad5ARCdmIjvn6JP2zEbeVYVdMiFUY6U3NoKcG5i
	 5Kyw4CI47PfmuKTMv1nfJ/8gPTiDvakBjdmTNaF55oe+rrrKmDkU+Sy0Xf47dhy3tZGh7
	 lmFATCttVoEndShq+lgY2eTDf9TMr+8kj1BD7CAiBDpQQiwgdBw3QxzlpCtpKIjaXFZIR
	 9CGID3QQA1cppWW80C1LwmjTqR+OO0kf+lBdPbVgJRPLkmkUZP1O4fENrnVMPlCELgw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3SI0uNJ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795858216;
	bh=0E50zM9a4bvLU3GTf4CVJ0IWGjMHMzi4/Gl2IyHbiDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q20JxZJIK8zqyUNCYHDz+z7jVLLiHI9V88PHb/1vX4POjuojrkSio00/4o4CdYb+G
	 we6a3KMHV0ldWlLAxwtmGb6SQsgBGyxb+ueq2oXfaug/30BGGu3IgFhkAtgMT59Z4O
	 LOY57sN9yMerXL7aMyl+sF2qOmdbzXIWv1o20cndphpW6znKFNQwMqHKqnjWHaXyZj
	 gYqzdn7QHdgUUJvr3vJjJASi6D+2rEci6qBV9sKGvUBuclPQsFx3lKK6I4BCJZ8hLN
	 9Pq2lKHgSGS6Zo5mJEN7AYGO0loLZhri6i+eSH3bXlYE/eDD/VZVUOMfAjeOn8plSf
	 CrR4XiMvWAryA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DA5540611;
	Sat, 28 Nov 2026 09:30:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4023F2FE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31CE9405AD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CWw_kLx80wO for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 09:30:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 84A4F40598
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=W3SI0uNJ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84A4F40598
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D398419B3;
 Sat, 28 Nov 2026 09:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CF31F00893;
 Sat, 28 Nov 2026 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795858212;
 bh=0E50zM9a4bvLU3GTf4CVJ0IWGjMHMzi4/Gl2IyHbiDg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=W3SI0uNJohDuz6RxTNGTisoaauR7xcJ0tZGQ6AhI42XiQ22rR3f+GRcGOZhso8nSp
 H5+Fby3WN4GnPuWOMi/gpuC9hxyMtKnxD15yphdJe/PCraDoyaA/aGVhv+asBITGs5
 tv/LmRsmcsb3jbGUkZaGShmeB8FEAxWl2eLENfyyt3GemwmT0VURacQb7j/kTZEN7i
 V3nsg6bNxU5KOy3EPn5vfkeTAVoccauZFWgLHsR75nPTMByDrZdIZzTfx9q0Owu6Tj
 Ie7a/X/muyj9o1wLDXhUX86DSxqqGYP0LYM/8ApjcBBegEfHvVOdpeaPb8u729vUZT
 JW4ukqiKQNfag==
Subject: Re: [PATCH net v5 3/4] ice: resync uplink filters after a switchdev
 session
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
Date: Sat, 28 Nov 2026 09:30:10 +0000
Message-ID: <179585821029.3135.15212524449373068553@kernel.org>
In-Reply-To: <20261127085714.1207361-4-poros@redhat.com>
References: <20261127085714.1207361-4-poros@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The end-of-session uplink resync is not retried if its promisc
  step fails.
- [Medium] The patch adds two more open-coded `while
  (test_and_set_bit(ICE_CFG_BUSY, vsi->state)) usleep_range(1000,…
- [Medium] When a session ends, the uplink's primary unicast MAC filter
  is rebuilt for port_info->mac.perm_addr, not for netdev->dev_addr, and…
- [Low] The commit message does not say that this patch needs the earlier
  patch in the series, "ice: stop the service task before the PF is…
- [Low] In ice_vsi_sync_fltr(), the ICE_VSI_ESWITCH_UPLINK gate sits
  after the uc/mc MAC-list sync, and ice_eswitch_resync_uplink() leaves…
- [Low] A promiscuous VSI that already holds the DFLT Rx rule never has
  VLAN pruning turned off.
- [Low] The new comment in ice_eswitch_disable_switchdev(), "after
  is_running is cleared, so no rx mode change is lost", assumes…

--

ice: resync uplink filters after a switchdev session

This patch adds a new VSI state bit, ICE_VSI_ESWITCH_UPLINK. While it is
set, the eswitch owns the uplink promisc configuration and
ice_vsi_sync_fltr() leaves it alone. When the session ends,
ice_eswitch_resync_uplink() clears the bit and queues a full filter sync,
and the patch also changes how ice_vsi_sync_fltr() handles multicast
subscription and VLAN pruning for promiscuous VSIs.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index c96b201901f48..d55c70edb7f7f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -10,6 +10,34 @@
>  #include "devlink/devlink.h"
>  #include "ice_tc_lib.h"
>  
> +/**
> + * ice_eswitch_resync_uplink - hand the uplink filters back after switchdev
> + * @uplink_vsi: the uplink VSI
> + */
> +static void ice_eswitch_resync_uplink(struct ice_vsi *uplink_vsi)
> +{
> +	struct ice_pf *pf = uplink_vsi->back;
> +
> +	while (test_and_set_bit(ICE_CFG_BUSY, uplink_vsi->state))
> +		usleep_range(1000, 2000);
> +
> +	/* VLAN changes during the session may have added these */
> +	ice_fltr_clear_vlan_vsi_promisc(&pf->hw, uplink_vsi,
> +					ICE_MCAST_VLAN_PROMISC_BITS);
> +	ice_fltr_clear_vsi_promisc(&pf->hw, uplink_vsi->idx,
> +				   ICE_MCAST_PROMISC_BITS, 0);
> +	uplink_vsi->current_netdev_flags &= ~IFF_ALLMULTI;

[Severity: Medium]
Is a state bit the right tool to lock this? This patch adds two more
open-coded ICE_CFG_BUSY sections, here and in ice_eswitch_setup_env():

    while (test_and_set_bit(ICE_CFG_BUSY, uplink_vsi->state))
        usleep_range(1000, 2000);
    ...
    clear_bit_unlock(ICE_CFG_BUSY, uplink_vsi->state);

These sections pass ownership of ICE_VSI_ESWITCH_UPLINK, and the
current_netdev_flags read-modify-write above, back and forth with
ice_vsi_sync_fltr(). Lockdep cannot see them, and the eswitch side
sleep-polls on the bit while it holds the devlink instance lock.

The section they pair with in ice_vsi_sync_fltr() releases the bit with a
plain clear_bit(), which has no release ordering:

exit:
	clear_bit(ICE_CFG_BUSY, vsi->state);
	return err;

So the store "vsi->current_netdev_flags = vsi->netdev->flags" made inside
ice_vsi_sync_fltr() may not be visible to the next holder. Could the
current_netdev_flags &= ~IFF_ALLMULTI here then write back a stale value?

The last patch in the series drops that read-modify-write, but the ad-hoc
lock sections are still there in the final state. Would a real mutex or
spinlock fit better here?

> +
> +	clear_bit(ICE_VSI_ESWITCH_UPLINK, uplink_vsi->state);
> +	set_bit(ICE_VSI_PROMISC_CHANGED, uplink_vsi->state);
> +	set_bit(ICE_VSI_UMAC_FLTR_CHANGED, uplink_vsi->state);
> +	set_bit(ICE_VSI_MMAC_FLTR_CHANGED, uplink_vsi->state);
> +	clear_bit_unlock(ICE_CFG_BUSY, uplink_vsi->state);

[Severity: Medium]
What happens if the promisc stage of the queued sync fails? This function
queues one ice_vsi_sync_fltr() pass and relies on it to install the DFLT
Rx rule and multicast promisc from the netdev flags.

ice_vsi_sync_fltr() clears UMAC/MMAC_FLTR_CHANGED at the top. If
ice_set_dflt_vsi(), ice_clear_dflt_vsi() or
ice_set_promisc()/ice_clear_promisc() then fails, it only re-arms
PROMISC_CHANGED:

out_promisc:
	set_bit(ICE_VSI_PROMISC_CHANGED, vsi->state);
	goto exit;

ice_sync_fltr_subtask() then sets ICE_FLAG_FLTR_SYNC again. But the next
run only syncs VSIs for which ice_vsi_fltr_changed() is true:

	if (pf->vsi[v] && ice_vsi_fltr_changed(pf->vsi[v]) &&
	    ice_vsi_sync_fltr(pf->vsi[v])) {
		/* come back and try again later */
		set_bit(ICE_FLAG_FLTR_SYNC, pf->flags);

ice_vsi_fltr_changed() only tests UMAC/MMAC_FLTR_CHANGED.

Wouldn't the uplink be skipped then? Its DFLT and multicast state would
stay out of sync with netdev->flags until some unrelated rx mode or
address change.

The final state of the series does the same through
set_bit(ICE_VSI_PROMISC_CHANGED) in the DFLT and mc_err branches. The last
patch adds the comment "retried by the next sync, with the allmulti
change", and its commit message says a failed DFLT install is kept "before
the retry". There doesn't seem to be an automatic retry, though. That same
commit message shows ice_set_dflt_vsi() failing with -EIO once the switch
lookup table is full, so this failure can happen in practice.

> +
> +	set_bit(ICE_FLAG_FLTR_SYNC, pf->flags);
> +	ice_service_task_schedule(pf);
> +}

[Severity: Low]
Should the commit message say that this patch depends on the earlier
patch in the series? On driver removal this schedule runs inside
ice_free_vfs():

ice_remove()
  ice_free_vfs()
    ice_eswitch_detach_vf()
      ice_eswitch_detach()
        ice_eswitch_disable_switchdev()
          ice_eswitch_resync_uplink()
            ice_service_task_schedule()

In this tree that is only safe because the earlier patch, "ice: stop the
service task before the PF is unloaded", added ice_service_task_stop()
right after ice_free_vfs(). Since 8a37f9e2ff40, the only other stop on the
remove path is in ice_deinit_dev() at the very end of ice_remove().

Without that patch, wouldn't the queued ice_sync_fltr_subtask() walk
pf->vsi[] and the uplink netdev while
ice_unload()/ice_deinit()/ice_vsi_release_all() free them?

The dependency is only mentioned below the cut line ("relies on patch 1
when the PF goes away"), and that text is dropped on apply. The Fixes:
tags go back to 1a1c40df2e80, so stable could pick this patch up on its
own. The earlier patch does carry Fixes: 8a37f9e2ff40, which helps.

[ ... ]

> @@ -77,6 +111,8 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
>  	if (if_running)
>  		ice_up(uplink_vsi);
>  
> +	ice_eswitch_resync_uplink(uplink_vsi);
> +
>  	return -ENODEV;
>  }

[Severity: Medium]
Does the resync restore the uplink's primary unicast filter for
netdev->dev_addr?

ice_eswitch_setup_env() removes every ICE_SW_LKUP_MAC rule on the uplink
with ice_remove_vsi_fltr(). That includes the dev_addr filter installed by
ice_set_mac_address(). This error path and ice_eswitch_release_env() only
add back the permanent address:

	ice_fltr_add_mac_and_broadcast(uplink_vsi,
				       uplink_vsi->port_info->mac.perm_addr,
				       ICE_FWD_TO_VSI);

ice_set_mac_address() never updates port_info->mac.perm_addr. Only
ice_aq_manage_mac_read() fills it, at init. The sync queued by
ice_eswitch_resync_uplink() only walks dev->uc and dev->mc, and dev_addr
is in neither list.

Suppose a locally administered MAC was set on the PF, with ip link set
address or by bonding. After the session, wouldn't the switch forward
only the factory MAC to the uplink? Unicast to the address the netdev
actually uses would then be dropped while promisc is off.

The perm_addr restore predates this patch. Still, the commit message says
setup_env removes "the address filters" and that "these are not installed
again", and the resync leaves the primary address out.

[ ... ]

> @@ -331,6 +368,9 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
>  	ice_eswitch_release_env(pf);
>  
>  	pf->eswitch.is_running = false;
> +
> +	/* after is_running is cleared, so no rx mode change is lost */
> +	ice_eswitch_resync_uplink(pf->eswitch.uplink_vsi);
>  }

[Severity: Low]
Does this ordering give the guarantee the comment describes?

pf->eswitch.is_running is cleared with a plain store. The caller holds
only the devlink lock, not rtnl. ice_set_rx_mode() reads the flag with a
plain load:

	if (!vsi || ice_is_switchdev_running(vsi->back))
		return;

On the rtnl side, __dev_change_flags() stores dev->flags and then reaches
ice_set_rx_mode() via
dev_set_rx_mode()->netif_addr_lock_bh()->__dev_set_rx_mode(). The acquire
in spin_lock does not order the earlier dev->flags store before the later
is_running load.

This looks like the store-buffering pattern:

CPU A (rtnl)                 CPU B (teardown)
W dev->flags                 W is_running = false
R is_running (true)          test_and_set_bit(ICE_CFG_BUSY)
return early                 queue_work()
                             service task reads old netdev->flags

On weakly ordered CPUs such as arm64 or ppc, couldn't a promisc or
allmulti change made during teardown be lost, with nothing scheduling
another sync?

Would smp_store_release()/smp_load_acquire() plus a full barrier work
here? Or could the is_running early return in ice_set_rx_mode() be dropped
now that the ICE_VSI_ESWITCH_UPLINK check exists?

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 6dede87b78944..2ce2b7138f668 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -394,6 +394,10 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  		}
>  	}
>  	err = 0;
> +	/* the eswitch owns the uplink promisc config during a session */
> +	if (test_bit(ICE_VSI_ESWITCH_UPLINK, vsi->state))
> +		goto exit;
> +
>  	/* check for changes in promiscuous modes */

[Severity: Low]
Should this check come before the uc/mc address list sync above it?

ice_eswitch_resync_uplink() leaves UMAC/MMAC_FLTR_CHANGED and
ICE_FLAG_FLTR_SYNC pending, and nothing clears them when the next session
starts. ice_reset_all_vfs() runs detach and attach for each VF back to
back:

ice_eswitch_detach_vf()
  ice_eswitch_disable_switchdev()
    ice_eswitch_resync_uplink()   <- sets UMAC/MMAC, FLTR_SYNC
ice_eswitch_attach_vf()
  ice_eswitch_enable_switchdev()
    ice_eswitch_setup_env()       <- sets ICE_VSI_ESWITCH_UPLINK,
                                     ice_remove_vsi_fltr(),
                                     __dev_uc_unsync()/__dev_mc_unsync()

The stale sync then runs inside the new session. ice_vsi_fltr_changed()
is true, and __dev_uc_sync()/__dev_mc_sync() rebuild tmp_sync_list from
every address. ice_fltr_add_mac_list() then installs them as FWD_TO_VSI
rules on the uplink before this goto exit is reached.

Doesn't that leave per-address forwarding rules on the uplink during the
session, after setup_env meant to remove them?

The same thing already happens when the uplink is admin-up, because
setup_env's ice_up()->ice_vsi_cfg_lan()->ice_set_rx_mode() runs while
is_running is still false. The stale resync adds a trigger that also fires
when the uplink is admin-down.

> @@ -438,6 +442,12 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  						      ICE_MCAST_PROMISC_BITS);
>  				if (err)
>  					goto out_promisc;
> +			} else if (ice_is_vsi_dflt_vsi(vsi)) {
> +				/* still the default VSI, so subscribe it */
> +				err = ice_set_promisc(vsi,
> +						      ICE_MCAST_PROMISC_BITS);
> +				if (err)
> +					goto out_promisc;
>  			}

[Severity: Low]
This subscribes an already-default VSI to multicast. Should it also turn
off VLAN pruning, as the ice_set_dflt_vsi() branch above does?

The commit message says DFLT ownership and pruning can get out of step,
and fixes the promisc-off direction. The opposite case, DFLT held with
pruning on, looks reachable at the end of a session.
ice_eswitch_release_env() enables pruning first, then removes the DFLT Rx
rule and ignores the result:

	vlan_ops->ena_rx_filtering(uplink_vsi);
	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
			 ICE_FLTR_TX);
	ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, false,
			 ICE_FLTR_RX);

The err_override_local_lb path in ice_eswitch_setup_env() does the same.

If that removal fails, the resync sees ice_is_dflt_vsi_in_use() return
true for a promiscuous netdev. It then takes this branch and skips
dis_rx_filtering().

Wouldn't tagged frames for VLANs without a filter be pruned even though
the netdev is promiscuous? After a session that is every non-zero VLAN,
because setup_env wiped the VLAN filter table.

The last patch in the series replaces this branch with
ice_vsi_wants_mc_promisc(). The final promisc-on path still only calls
dis_rx_filtering() when it installs the DFLT rule itself.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127085714.1207361-1-poros%40redhat.com
