Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F4606A32E
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=9b6li/DZ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHvm+u5R
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A686F6061F;
	Sat, 28 Nov 2026 09:30:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZruS2gvOGgee; Sat, 28 Nov 2026 09:30:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9420760632
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795858214;
	b=gL7X/TRsu/Hlpe0H+UyPFgcTGUnNMrLe1NE8s1nSeLqd14pjs03HTtsizuzdNtVDzXzH
	 wa7iVEyktUOEGbYrCnL34OSFG5ZK8ktM+3lyinkcqXgIeVphQrNqDGcQUOM570CNUrAx6
	 tdNXkspG85hZNwC7obAUydmspZ7pYbBXUfsWID1VMJXTtJIKqQ4B1tiz5zaCtKOs5fNoL
	 TIfkgnCmWnXZEJIfCQ149zQ3UFvyi/YzhgZ6Y0juz2n9XH/aerpMbm+C4ARiP/XcL3a/k
	 JDKBbtpC0wY7Ipld1Bzpi7YiSrELRF4QqfW1jDRUhrsBmOwAnu5QiOtlxV6cQLNUj+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795858214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A5rYtmofrvIUFyhmWGcR3PlpZPgkJO+PijhIDMldm2Y=;
	b=tgSwztsHrPluJsMBEpIl/SwN0Yir7YLJmxH/auLALdTBDfs6kzZ0hVYmkPPtR7gYMOF3
	 ZtSRy5IhXRD7ACRupcK0ZEswJZ4xeiqFLc42Sx9cxN/9RRqaCw/HQ9AeyxW/sIvEBP77Z
	 yiQFf36GOsni+3s2W9H8uQws+PcXwWAeg+gkXm0U3MIWkXLkMkXckzsXmS80ZO3nIbKeD
	 tY5LfIYT+E5yOcgKfJ9xj4HzsN6UiAEkyide7f4UNaQFAOc6MBP5k/8D97Hx0w0Mne9oz
	 eeHOLNxgm8ovCHcMsVyvOtToTPdL5e/LaN6Ye+jsKtOBzcpC50sCNyCZxAvFZAM3c/Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHvm+u5R;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795858214;
	bh=A5rYtmofrvIUFyhmWGcR3PlpZPgkJO+PijhIDMldm2Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9b6li/DZrUqtfTMulVqvwFlX/fmA9gJgZxufL5q0HxVoIte3BSVFQOOXWA+kgyQPI
	 ZpLxL852FczvHUUkjOTu9hQJZUDpvFV2hzjvYiGrjY6gOb4mbuRdX1ym/mAjXceBvq
	 4UL+y9V5mIX4EALMKK/56Bb0OTAo5CVaMSqPSTiYMcATeQ8MPVu6i65D2T5q6uWHMd
	 30F9x9JzXLNfL7yusd/mMmvxO9qS1KEm5YtHYu4xTQyC8gHCGktHQ/Qu6zsI7B2oxC
	 eyLWPoUUttZPwlUkBpyPuLI7zn1giVE3WUi7R893JGOaDCMlpA4eUf3InUPpJfT8vn
	 2w8iWXTAtUUpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9420760632;
	Sat, 28 Nov 2026 09:30:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52DE42FE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38BF760632
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a7AGCihEMUsr for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 09:30:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A20436061F
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dHvm+u5R
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A20436061F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 09:30:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64F4660E4D;
 Sat, 28 Nov 2026 09:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34981F00898;
 Sat, 28 Nov 2026 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795858209;
 bh=A5rYtmofrvIUFyhmWGcR3PlpZPgkJO+PijhIDMldm2Y=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=dHvm+u5RvRSNSfxYyIJNDgl1oVQS4z17YRrU6ZdKkhUMLZGtcJVJFMSH69avJWPiA
 7mYaddu5flKEAvjr+oya3/xIEXlPpEDLAfbqojDD7ar0J+ceZh0KVuDzJQSimwseXz
 rEjq421poQEOaychfqxvmkhkri1jVsvqegU3t8uPQI1KfqafvI411fNNHQhUAGRBMb
 Fs+SNNl3jgjtiH2cnCjYWayZs9O5FXOBtTeX2A7HsDKGBtEoJAYOwARBSZhdHfz6wy
 wdzXvnQDtaJyFZLSDTL3Y1CwzObeRYdE6z8u1KqKGoLBlRq440Pm2THHzShpREzFTx
 d5xZD52m2LhwA==
Subject: Re: [PATCH net v5 2/4] ice: do not leave switchdev mode while
 representors exist
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
Date: Sat, 28 Nov 2026 09:30:08 +0000
Message-ID: <179585820824.3135.14448452752875011743@kernel.org>
In-Reply-To: <20261127085714.1207361-3-poros@redhat.com>
References: <20261127085714.1207361-3-poros@redhat.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `xa_empty(&pf->eswitch.reprs)` check in
  ice_eswitch_mode_set() is protected only by the PF devlink lock, which…
- [Low] The commit message understates what this patch fixes.
- [Low] In ice_eswitch_mode_set(), the new
  `!xa_empty(&pf->eswitch.reprs)` check (ice_eswitch.c:358) runs before…
- [Low] The new gate checks whether pf->eswitch.reprs is empty, not
  whether SF ports exist.

--

ice: do not leave switchdev mode while representors exist

This patch makes ice_eswitch_mode_set() refuse an eswitch mode change
while the representor xarray is not empty. Before the patch, switching to
legacy mode with DCB active could destroy the xarray under a running
switchdev session that still had a subfunction port representor.

> the representors export, but ice exports none while DCB is active. A
> switch to legacy then destroys the representor xarray under the running
> session, the representors leak, and the uplink stays in its switchdev
> configuration.

[Severity: Low]

Does "the representors leak" describe the whole consequence? Before this
patch, the later SF port deletion looks like it ends in a use-after-free
of dyn_port.

Once the switch to legacy has run xa_destroy(&pf->eswitch.reprs), a
devlink port del on the SF port goes through
ice_devlink_port_del()->ice_dealloc_dynamic_port(), which calls:

drivers/net/ethernet/intel/ice/ice_eswitch.c:ice_eswitch_detach_sf() {
	struct ice_repr *repr = xa_load(&pf->eswitch.reprs, sf->repr_id);

	if (!repr)
		return;
	...
}

So ice_repr_rem_sf() never runs. That means neither
unregister_netdev(repr->netdev) nor
ice_devlink_destroy_sf_port()->devl_port_unregister() is called.
ice_dealloc_dynamic_port() then does:

	ice_eswitch_detach_sf(pf, dyn_port);
	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
	ice_vsi_free(dyn_port->vsi);
	kfree(dyn_port);

The embedded dyn_port->devlink_port is still registered in devlink->ports.
The representor netdev is also still registered, and it keeps pointers
into the freed dyn_port: repr->sf, and the devlink port set through
SET_NETDEV_DEVLINK_PORT(). Driver removal takes the same path through
ice_remove()->ice_dealloc_all_dynamic_ports().

The code change closes this path. Could the commit message mention the
use-after-free, so stable and CVE triage can weigh the fix correctly?

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 6e7bba4738989..c96b201901f48 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -354,6 +354,13 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* subfunction ports have representors too */
> +	if (!xa_empty(&pf->eswitch.reprs)) {

[Severity: Medium]

Is the result of xa_empty(&pf->eswitch.reprs) stable under the lock held
here? devlink core holds only the PF devlink lock around
ice_eswitch_mode_set(). However, ice_eswitch_update_repr() changes the
same xarray from ice_sf_dev_probe(), and that path holds only the SF's
own devlink lock:

drivers/net/ethernet/intel/ice/ice_sf_eth.c:ice_sf_dev_probe() {
	...
	devlink = priv_to_devlink(priv);

	devl_lock(devlink);

	err = ice_vsi_cfg(vsi);
	...
	ice_eswitch_update_repr(&dyn_port->repr_id, vsi);
	...
}

drivers/net/ethernet/intel/ice/ice_eswitch.c:ice_eswitch_update_repr() {
	...
	if (repr->id != vsi->vsi_num) {
		xa_erase(&pf->eswitch.reprs, repr->id);
		repr->id = vsi->vsi_num;
		if (xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL))
	...
}

ice_sf_dev_remove() does not delete the hardware VSI. So if the ice.sf.N
auxiliary device is unbound and then rebound through sysfs, ice_vsi_cfg()
runs with ICE_VSI_FLAG_INIT and allocates a new VSI number. That takes
the erase/insert branch above.

With a single SF representor and no VFs, can a concurrent eswitch mode
change see the xarray empty between the erase and the insert?

CPU1 (SF rebind, SF devlink lock only)
ice_eswitch_update_repr()
  xa_erase(&pf->eswitch.reprs, old_id);

CPU2 (PF devlink lock held)
ice_eswitch_mode_set(LEGACY)
  !xa_empty(&pf->eswitch.reprs) is false, check passes
  xa_destroy(&pf->eswitch.reprs);
  pf->eswitch_mode = mode;

CPU1
  xa_insert(&pf->eswitch.reprs, new_id, repr, GFP_KERNEL);

The result is legacy mode with a live SF representor, and
pf->eswitch.is_running stays true because ice_eswitch_disable_switchdev()
is never called. The uplink keeps its switchdev configuration until the
SF port is deleted. This same check then refuses a switch back to
switchdev.

Would checking pf->dyn_ports instead close this? Its writers,
ice_alloc_dynamic_port() and ice_dealloc_dynamic_port(), run under the PF
devlink lock, so they would be serialized with mode_set.

[Severity: Low]

A related case: if that xa_insert() fails, ice_eswitch_update_repr() only
logs an error:

		if (xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL))
			dev_err(ice_pf_to_dev(pf), "Failed to reload port representor %d",
				repr->id);

If that was the only SF representor, pf->eswitch.reprs is now empty. The
SF devlink port is still in pf->dyn_ports, and pf->eswitch.is_running is
still true.

Would ice_eswitch_mode_set(LEGACY) then pass both ice_has_vfs() and the
new xa_empty() check? If so, it would run xa_destroy() and switch to
legacy without calling ice_eswitch_disable_switchdev(), leaving the same
orphaned session this patch is meant to prevent.

The dropped-entry handling in ice_eswitch_update_repr() predates this
patch, but a check on pf->dyn_ports would also cover this case.

> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Remove all subfunction ports before changing eswitch mode");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	switch (mode) {

[Severity: Low]

Should the requested mode be validated before the representor check? The
devlink policy accepts DEVLINK_ATTR_ESWITCH_MODE values up to 2
(NLA_POLICY_MAX(NLA_U16, 2) in net/devlink/netlink_gen.c). So
DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE reaches the driver, and ice
rejects it only in the default branch:

	default:
		NL_SET_ERR_MSG_MOD(extack, "Unknown eswitch mode");
		return -EINVAL;

With the PF in switchdev mode and an SF port present, a switchdev_inactive
request now fails with -EOPNOTSUPP and "Remove all subfunction ports
before changing eswitch mode". If the SF ports are removed as the message
says, the retry still fails, this time with -EINVAL.

The existing ice_has_vfs() check has the same ordering, but this patch
adds a new path that reports the wrong reason. Would it be better to
validate the mode first, or to apply the representor check only to
supported transitions?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127085714.1207361-1-poros%40redhat.com
