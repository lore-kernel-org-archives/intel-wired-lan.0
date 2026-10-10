Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D134CA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 14:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48EBA60653;
	Sat, 10 Oct 2026 14:04:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jUsxh-0-KWtE; Sat, 10 Oct 2026 14:04:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D5F76062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791641095;
	b=OJZ4Oq+2gj/bVXOUdNIgFbzEIgDmK+fVqdxQ4RPlPTtwVoFhQMrSTMYz3ZR0SVgi7SkB
	 q0pzQX8TV8E52jqg6phBjtiPr6gyp4GdeT1ElOhUiCb3w/UzkA0OalUYeuGrVwToZbxtc
	 SlXzGC/vkICnXLD0ZqzVlSFvKjV/fBgTto6IXVnDYDhQiHNQTlX6i7Qy5TEl5QWhnh/QU
	 /k+U86SSw+Ksxy7BwpbekAEzfXVu7CTOebUmoSErXid5ZBwtth0MXX1ywiDuczPIi4h2e
	 hnGN+CFtJJlZUM92Sf+JTlFRKyweUiE6G0rQDooheVy5wJ3AZF1SX5Cu77faLmjtSjw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791641095;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=n4yE8HuEQ3KUgwharztXW8BxktHwko7gnKBIcbLgqOk=;
	b=p7peSefZzklb2YRlz6mjRMMA3xNNy0zjbL/xGvQ02+sqG9bd/k5GzVsFGRury1ltkUpQ
	 aGBYl4TQ0029i1quGY3j8eVwo+wQBvTkWb0vCIM4JKQsau2uQgGudd1S+1KfaZ8E+t0fK
	 WZvMzuVKaQ6CLRB8g7sthDk3N1jAWcV8wi9V77M5kIvh2SGuKHNvbeOrNlpWI7hvGhF01
	 fX7lqRjA7WViW5C/aZQpHsVuZelZxHGx2lTDALDICib83PCCbvGElhzm9Cf7OtTqLp9u9
	 9zQnzoNkA80hahMZ128+9fpPxR5bkKQDtOCcfOnpQH0jfeIa5Z2MZjWeWGLlQBP1bIg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791641095;
	bh=n4yE8HuEQ3KUgwharztXW8BxktHwko7gnKBIcbLgqOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dEDVzsBm7NOqp9zbfoKr7U71Kjq6W87HJzVYrqNAVy5XjbNeCczT8ms92bGPY8OcY
	 epP+jktYOFtfGebr0s2U1FgtgJNc9A7CGXHVutArlr28tPJclM2Ui4Duj+KBxNT4Jm
	 q9Gm+kj5OhujyEVHCPjXPVgpYdamYCI5DQBhmJJVzc24kSJ/+IaxNOLruxKN/nn/ud
	 EC0sDJ1q9jsoYmqGINBJ/npT3ETd+/kGwIzvWqX6jYNuAkt92Xld80jTH7GuVq8wXY
	 2DYu07cM0IEolIh2GmT2MrrW6tYCvuLnELpZkC2+LQrLTOg5F2EUFoT4BxgMmXUWmb
	 pkL5Y0J51Gfhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D5F76062B;
	Sat, 10 Oct 2026 14:04:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 28A2D235
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0E2E881208
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:04:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id matEpCBSRgNp for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 14:04:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08EF6811FE
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791641093;
 b=M2BDRd3WI3qs+976qSLKit5x3+K+DPRabS881Uc4JW9S47KO5l2kDI2p0AFqpp5NIsp5
 NMoVSsy+MQH5U2i4lnfT1+iHCAJu2yVZCMZ9pzeRgRykBNtJuRWQqbkPHPQjEY9gNpaPF
 YrJDVAWXmG87oVOw5e0TNKONX+MRUrPR1tRKfiG8des6lWcZud8Zg+wYEy5ny4IsZM5o0
 5WasCJJg0iVCHEXUCmgSFQaiq/jU6Z7PcvZNoYgYbA2RMKUXYR79Xm8w4CAshJEFHsPmw
 CGgOMZMueGnWRTcyQTC9f90hi6okKcz83S3KMls2YIBGSQw8WiLkJKuPsuAEnmRtaDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791641093;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=n4yE8HuEQ3KUgwharztXW8BxktHwko7gnKBIcbLgqOk=;
 b=WPcJbdTYBv/SPdKhXwihgCRvd8/abGw9Q6llRkwZByS3NW+ThXF/CP/fL3qyCWzZ2L7L
 WaPYxEBeTuW7Tv9cPRtJSZczO/gU7GTq8oJtDL+mkZzR1F6FFs+yhHrkDtYf2g57/FsaZ
 BIgz3CNE9TTtc42LsyCuvS3X/GoQCKELsGW8EFXdN1BZQQkSmDS8B7RTasuGMyMlgBtsO
 Qc4JbcbvK9oncxwC5iKJMFhheGKoItAqgEM4rUYkNKdcbgPKhwCUTGcAzSphmQRb4WOH7
 NJj8Xu1wAvdJp2VFgIfnUsybmegtm51Dz68VllsVc3eASQYJL6h3qKgd0nIxwnTzZgg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VmPknaD1; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=VmPknaD1
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 08EF6811FE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:04:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13FD442AF5;
 Sat, 10 Oct 2026 14:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A9B1F000FF;
 Sat, 10 Oct 2026 14:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791641092;
 bh=n4yE8HuEQ3KUgwharztXW8BxktHwko7gnKBIcbLgqOk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VmPknaD1ZiprxyihZtL3D8N0kow2X7YV1Zf3VqlTCPrqEz3pgghA3AuD9SRZldv/v
 He+WWZmwcrDh+taLLHYLdi+a+uCbgk8LPSeOin5gV3/m+RNDLDhTt0KlihDtXHvWB8
 MCjl34jMyNWAo2RktqUaRZvFzTqDkcNT4XEJraRAjWDg5rcjmXCEWvERJLBYP/9wkU
 EPmgyOHb6eg18kBbs52v9ynJdz+UhE7UO9nHTXpy5cJ0hwpdpIVc4aVv2dtYEDQ0xK
 tOhdf4btgqgka5l/vmvqHyUzNhrQv+3CS9N9GFp6aOZ4cXbs0L3RwFmzNWQYojFoPa
 qR9qKFgYM+m7Q==
Date: Sat, 10 Oct 2026 15:04:48 +0100
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: sashiko-reviews@lists.linux.dev, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH iwl-net v3 1/3] ice: attach and detach VF representors
 outside of vf->cfg_lock
Message-ID: <20261010140448.GO83879@horms.kernel.org>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-2-xiaolinkui@126.com>
 <sashiko-outbox-165586@kernel.org>
 <3163779c-c7cf-4727-8b42-499f6d4d4101@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3163779c-c7cf-4727-8b42-499f6d4d4101@126.com>
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

On Sat, Oct 10, 2026 at 11:00:23AM +0800, Linkui Xiao wrote:
> 
> 
> On 2026/10/9 21:05, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> > - [High] ice: UAF in NAPI Rx path due to missing RCU grace period after xa_erase
> > - [Medium] net/ice: silent failure to apply VF MAC/VLAN to hardware due to TOCTOU race
> > --
> > 
> > commit 32649319eb3be01d6b10e730f49f29871e5cb572
> > Author: Linkui Xiao <xiaolinkui@kylinos.cn>
> > 
> > ice: attach and detach VF representors outside of vf->cfg_lock
> > 
> > This patch moves the detach and attach of VF representors outside of
> > the vf->cfg_lock to resolve a lock inversion between cfg_lock, the
> > devlink instance lock, and RTNL.
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > > --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > > @@ -789,9 +789,21 @@ void ice_reset_all_vfs(struct ice_pf *pf)
> > >   	/* free VF resources to begin resetting the VSI state */
> > >   	ice_for_each_vf(pf, bkt, vf) {
> > > +		/* Detach the representor before cfg_lock and attach it after
> > > +		 * releasing it again: both take the devlink instance lock and
> > > +		 * then RTNL, while __ice_set_vf_mac(), ice_set_vf_port_vlan()
> > > +		 * and the representor ethtool reset take cfg_lock under RTNL.
> > > +		 * Take cfg_lock once ahead of the detach to wait out a reset
> > > +		 * that is already inside the lock; ICE_VF_DIS, raised above,
> > > +		 * keeps later ones out.
> > > +		 */
> > >   		mutex_lock(&vf->cfg_lock);
> > > +		mutex_unlock(&vf->cfg_lock);
> > >   		ice_eswitch_detach_vf(pf, vf);
> > 
> > [Severity: High]
> > Does this code leave a window for a use-after-free in the NAPI Rx path?
> > 
> > During teardown, ice_eswitch_detach() calls unregister_netdev() which
> > waits for existing RCU readers. However, the representor pointer remains
> > in the eswitch.reprs XArray during and after unregister_netdev().
> > 
> > Because the pointer is still in the XArray, a concurrent NAPI Rx thread
> > calling ice_eswitch_get_target() can successfully fetch it via xa_load()
> > even after unregister_netdev() completes.
> > 
> > The teardown path then removes the pointer via xa_erase() and immediately
> > calls ice_repr_destroy(), executing free_netdev() and kfree() with no
> > additional RCU grace period. If a NAPI thread fetched the pointer just
> > before xa_erase(), it will dereference freed memory.
> > 
> > > +
> > > +		mutex_lock(&vf->cfg_lock);
> > > +
> > >   		vf->driver_caps = 0;
> > >   		ice_vc_set_default_allowlist(vf);
> > >   		ice_vf_fdir_exit(vf);
> > >   		ice_vf_fdir_init(vf);
> > >   		/* clean VF control VSI when resetting VFs since it should be
> > >   		 * setup only when VF creates its first FDIR rule.
> > >   		 */
> > >   		if (vf->ctrl_vsi_idx != ICE_NO_VSI)
> > >   			ice_vf_ctrl_vsi_release(vf);
> > >   		ice_vf_pre_vsi_rebuild(vf);
> > >   		if (ice_vf_rebuild_vsi(vf)) {
> > >   			dev_err(dev, "VF %u VSI rebuild failed, leaving VF disabled\n",
> > >   				vf->vf_id);
> > >   			mutex_unlock(&vf->cfg_lock);
> > >   			continue;
> > >   		}
> > >   		ice_vf_post_vsi_rebuild(vf);
> > > +		mutex_unlock(&vf->cfg_lock);
> > 
> > [Severity: Medium]
> > Does this sequence leave a window where a concurrent VF MAC or VLAN update
> > can silently fail to apply to the hardware?
> > 
> > If a user configures the VF MAC, __ice_set_vf_mac() calls
> > ice_check_vf_ready_for_cfg() before acquiring vf->cfg_lock.
> > 
> > If a PF reset occurs simultaneously, ice_reset_all_vfs() sets ICE_VF_DIS
> > globally. If this happens right after __ice_set_vf_mac() passes its check,
> > __ice_set_vf_mac() will wait to acquire vf->cfg_lock.
> > 
> > As seen in the lines above, ice_reset_all_vfs() acquires vf->cfg_lock and
> > rebuilds the VF VSI using the old MAC address. After ice_reset_all_vfs()
> > releases the lock, __ice_set_vf_mac() acquires it, updates the software
> > MAC, and calls ice_reset_vf().
> > 
> > Because ICE_VF_DIS is still set by the PF reset, ice_reset_vf() aborts
> > the hardware reprogram. __ice_set_vf_mac() then returns success based on
> > its earlier check, leaving the hardware enforcing the old MAC while
> > software tools report the new one.
> > 
> Thank you.  Both reports are about code this series does not touch: the
> series only edits ice_sriov.c and ice_vf_lib.c, ice_eswitch.c and
> ice_repr.c are unchanged.
> 
> > [High] ice: UAF in NAPI Rx path due to missing RCU grace period after
> > xa_erase
> 
> The window is real, but it lives in ice_eswitch_detach(), which neither
> this patch nor the other two change:
> 
> 	ice_eswitch_stop_reprs(pf);
> 	repr->ops.rem(repr);                    /* unregister_netdev() */
> 	xa_erase(&pf->eswitch.reprs, repr->id);
> 	...
> 	ice_repr_destroy(repr);                 /* free_netdev() + kfree() */
> 
> That order is deliberate, and it was chosen for this class of problem:
> commit e9942bfe4931 ("ice: Fix use after free during unload with ports in
> bridge") moved unregister_netdev() ahead of xa_erase() so that a lookup
> racing with the teardown still finds the repr while it is being
> unregistered.  Moving that pair, or adding a grace period between the
> erase and the destroy, is a change to ice_eswitch_detach() with its own
> Fixes: history, not something a cfg_lock ordering fix should carry.
> 
> One correction on the mechanism.  ice_eswitch_get_target() is a plain
> xa_load() reached from ice_process_skb_fields() when ICE_RX_FLAGS_MULTIDEV
> is set on the ring, and a NAPI poll is not an RCU read-side section:
> __napi_poll() calls n->poll() directly, and neither net_rx_action() nor
> napi_threaded_poll() takes rcu_read_lock().  xa_load() also takes no
> reference on the object it returns, so an extra grace period after
> xa_erase() would not close this window as the code stands.  The lookup
> itself has to be made safe first, and that is a different patch.  I can
> send it if you want it.
> 
> What this series changes is when ice_eswitch_detach_vf() is called, and
> that does not widen the lookup: the NAPI Rx path never took vf->cfg_lock,
> so it raced with the detach both before and after.
> 
> > [Medium] net/ice: silent failure to apply VF MAC/VLAN to hardware due
> > to TOCTOU race
> 
> The sequence is right, including the outcome: both handlers throw away
> the return value of ice_reset_vf(), so once ICE_VF_DIS is up they still
> report success while the MAC or VLAN only exists in software.  But every
> part of it is baseline.  __ice_set_vf_mac() and ice_set_vf_port_vlan()
> call ice_check_vf_ready_for_cfg() outside cfg_lock, ice_reset_vf()'s
> ice_is_vf_disabled() test sits after the lock is taken, and ice_free_vfs()
> and ice_reset_all_vfs() raise ICE_VF_DIS before entering the loop; the
> patch does not move any of the three.  The same window is reachable today
> with "echo 0 > sriov_numvfs" in place of a PF reset.
> 
> Closing it means changing those two handlers, and probably how the reset
> result is reported, which is unrelated to where the detach and the attach
> are placed.  I would rather send that on its own than fold it into an
> -net series that fixes a lock inversion.
> 
> No code change in this series for either report.

Thanks for the detailed response.
This seems reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>

