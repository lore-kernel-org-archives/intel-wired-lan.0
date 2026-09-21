Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F5C982DE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 06:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 06D9480C81;
	Mon, 21 Sep 2026 06:51:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o7KwimW1u7Hn; Mon, 21 Sep 2026 06:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D659380D6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789973470;
	b=Eh5vxscCO3edVLXOylkETVIVmlQ0SlrT26oQmIDQLGFYuSmxqRTpDL3JIRGwI8PcJ1IW
	 vFwzKHprrkRxQxxzfUCf95yVFg7xicExKsjrJWVz+A2NYVgIb6lml2zV/ylXapHFLk0/l
	 IkyG4RrAG/uiIokPw9SXL44ucG3SGwpSpsabUXd6+6R6nw+pdbEEvdah9n2hdAIFsS7P6
	 12EVS5Dhe5UnFXtwk7LF7I4LreAei77I4GkNLRPPyB08HyVbhU2VJOmli1wZzGwF+Sp+H
	 kPbsZxZjg/z41DChpVesu54iQmipRi3/+c9efdbSN2KD5tm/OtgcGIRh3XqvgRA/4HQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789973470;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yrFrf31CzAGMwRVxOb97SRJtR701Pk6b6btKA5i372s=;
	b=iCTanseh7UWRLamOcNrY56BP7VUuIijCgdpRwIZnOGGDXZwFYBsQyYrzyDxMozG8nUfk
	 80Q3SXinsDjiWz84ptuNVuSKuk2qk5rfJtyPGCNFrjck8OM52VCoNKSTnRoApp785C0P9
	 Gz/0hcoobjF90b5Vx3Nmoqc81rHDBQ2CBI1Udv2ORn1fHunkIw+pTDNA4wUXQy9EYnTa7
	 fVLD5mAEMpVZEweqFKIUXI+mtYDUmNr3h1/KaLziapyJzrHptHst0E6b01Zmsq9wQiBc+
	 NB2rONfWKp3MWH0EPBF+ABrCUHscsYSU7kzQ2JbT1jlc8QJnkdZcmwsU0XELTDRuKmQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789973470;
	bh=yrFrf31CzAGMwRVxOb97SRJtR701Pk6b6btKA5i372s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0HOHr8j/9ZraKZ+FRzttRzY4huog6WdL2s/I5p2DPljod6aeB9WfUKpjQjIiSf80X
	 DQvg2RRUT3kEW9mkQp36S41oGO+cy6n7zFPR8dlsFGjJlF2i+ZBorWGk4R+plxHiPz
	 l8lytyMK0MXCO7c4aHdYFUDvxOl6mn/cfWHxNqEeMeWSqvdLbDM2bv9FUUGYaugo9B
	 xBrIJHhY1DwqL7tE2/J5jHGq1nxNKoq0qPBbsJbrgWB0c1z1Sb+nKLkBE1fLwrKazv
	 Ta9dgcdIO5utBIDKt769s5KSH98xZeo+toM/DQFQphAATfJ9wmIjvYD+Z9Cr8kZ8FX
	 XL1FFKnj1q8KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D659380D6E;
	Mon, 21 Sep 2026 06:51:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B498C28C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 06:51:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B24B760617
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 06:51:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1d2fCyz1Bh55 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 06:51:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 87E226060B
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789973468;
 b=ORMbPKtdqpLOcYhW9BOuxq8XglL6DQk3G1TS/SXXa4Rglbn+Ya7fqvUEFE6uKegkz2eb
 eKXCQ5j6zd5HfAnVbPu7mNyjt0IcfD08H8kXZPCkeTayJOfvozGoNP7zOrJT9m4XGA9+M
 mytbIyDZHZ5MFlsy22dI6q/AmqHdLoBX7kPQD7Y/YUMbiPvDYjvrjnF/ZfpwcXsdra4/n
 YukRJLDWJtKxgO6DevlQln+JLlAOQJOwp0BdnbE1DR2lpLvy7zLX1nI8h/d44yF9DB1Gz
 82zlt3bOnTuEMeHYVP6uI6qExzfspkiNC29Bu/opX25tLh1GqXBtpqBzSpixzETZ6fQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789973468;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=yrFrf31CzAGMwRVxOb97SRJtR701Pk6b6btKA5i372s=;
 b=rL8lZSDD8F1GMXA5ixEMB5Iei7v0MLufC3TUw4yc6KgwAk10E1nrZFgqK+uFVDF4SQfQ
 ebOIIGIaisVfc0gkrbwPy2fMBZ2YY1XDFtmYnG8G5mEUy2O+YLLtQPHDbQ1ZwCb9e+J1B
 /o2dPq56tbcBRJ3ws6M1cTGH3G28NBsB8WHS4Qb9lYACJGXTSVJlKGu2NqCJIa0PNfxQp
 fsA4E+pdFZVGEN7xLB1YAzIzz3m65eUsUHcey/NSbSAeXupdtH6ODqCAkyJEYLoCMp2LH
 T5JfkuIt9mYeHXOrJLktHdsNrKK01B4GaFyydix5RT7Co1PAzPtqZD9AH9drUlACxuQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=X2o1yf3U; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=X2o1yf3U
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87E226060B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 06:51:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B9D840F63;
 Mon, 21 Sep 2026 06:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895251F000FF;
 Mon, 21 Sep 2026 06:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789973466;
 bh=yrFrf31CzAGMwRVxOb97SRJtR701Pk6b6btKA5i372s=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=X2o1yf3UWx/O/Wfs2sgXcw7A9oUbDTMmCY1FsrvYF2M7TvotQyraSaFEayUrfssUN
 fa00hrqjtmQ9DWugzLfLAcmkwQ8e/MN99UbjF3qxj8PDecQ6yqXULn/mHjn2NsGIyn
 l/J/nZkxmcjXMi9F+XaL6n2nfCNj3s2pWO14wcxEDlAf6gpWv2rlwIA0ev4a/9JkIZ
 B193k4tnt6LJs8J3QJuKVem3/k6zj9GHf70Fs5uBy5hnr4eG+TqllZKPWAlnfEp/QH
 7zGAnuXlTyGjvyMCe8NARC0TXpGcytfLIrE4nXXPVMZNx27mePx3SuoAu1/35Ly+nc
 o3b2cyN3jehSw==
Subject: Re: [Intel-wired-lan] [PATCH net] ice: roll back the port VLAN when
 ice_eswitch_br_set_pvid() fails
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 stable@vger.kernel.org
Date: Mon, 21 Sep 2026 06:51:05 +0000
Message-ID: <178997346505.2160803.11431169848249487697@kernel.org>
In-Reply-To: <20260920064754.1935818-1-xiaolinkui@126.com>
References: <20260920064754.1935818-1-xiaolinkui@126.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete rollback of the VLAN ops table: the commit message
  states the patch fixes the case where "in Double VLAN Mode, the inner…
- [High] ice_eswitch_br_set_pvid() mutates and dispatches through the
  per-VSI VLAN ops function-pointer table while holding only rtnl_lock,…
- [Medium] The newly added err_clear_port_vlan label in
  ice_eswitch_br_set_pvid()…
- [Medium] The new unwind assumes the VF VSI was not already in port-VLAN
  mode before ice_eswitch_br_set_pvid() ran, but…

--

ice: roll back the port VLAN when ice_eswitch_br_set_pvid() fails

This adds two unwind labels to ice_eswitch_br_set_pvid() so that a failing
set_port_vlan() or add_vlan() clears the port VLAN from the VSI context and
hands the VLAN ops back to ice_port_vlan_off(), instead of returning the
error with the VF VSI left in port VLAN mode.

A few questions about the new unwind path below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> index 1d8a6b95ccda..53ce98ba7007 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
> @@ -679,16 +679,23 @@ ice_eswitch_br_set_pvid(struct ice_esw_br_port *port,
>  	vlan_ops = ice_get_compat_vsi_vlan_ops(port->vsi);
>  	err = vlan_ops->set_port_vlan(port->vsi, &port_vlan);
>  	if (err)
> -		return err;
> +		goto err_disable_port_vlan;
>  
>  	err = vlan_ops->add_vlan(port->vsi, &port_vlan);
>  	if (err)
> -		return err;
> +		goto err_clear_port_vlan;
>  
>  	ice_eswitch_br_port_vlans_flush(port);
>  	port->pvid = vlan->vid;
>  
>  	return 0;
> +
> +err_clear_port_vlan:
> +	vlan_ops->clear_port_vlan(port->vsi);

[Severity: Medium]
Is it intentional to drop the return value of clear_port_vlan() here?  The
op is declared fallible in struct ice_vsi_vlan_ops:

	int (*clear_port_vlan)(struct ice_vsi *vsi);

and both implementations can fail.  ice_vsi_clear_outer_port_vlan() and
ice_vsi_clear_inner_port_vlan() start with:

	ctxt = kzalloc_obj(*ctxt);
	if (!ctxt)
		return -ENOMEM;

	ice_restore_vlan_info(&vsi->info, &vsi->vlan_info);
	vsi->info.port_based_outer_vlan = 0;

and end with:

	err = ice_update_vsi(hw, vsi->idx, ctxt, NULL);
	if (err)
		dev_err(...);

So on an ice_update_vsi() failure vsi->info has already been mutated while
hardware keeps the port VLAN and the RX_VLAN_PRUNE_ENA bit programmed by
the preceding set_port_vlan(), with no matching prune filter (add_vlan() is
the call that failed).

Since port->pvid stays 0 and the VLAN was never inserted into port->vlans,
can any later path retry that clear?  ice_eswitch_br_vlan_cleanup() only
reaches ice_eswitch_br_clear_pvid() when:

	if (port->pvid == vlan->vid)
		ice_eswitch_br_clear_pvid(port);

The ops table is then handed back unconditionally, which also restores the
real dis_rx_filtering().  ice_port_vlan_on() deliberately replaces it while
a port VLAN is active:

	/* all Rx traffic should be in the domain of the assigned port VLAN,
	 * so prevent disabling Rx VLAN filtering
	 */
	vlan_ops->dis_rx_filtering = noop_vlan;

Could the VF then use virtchnl to clear the prune bit while the hardware
port VLAN is still programmed?  Would it be better to only call
ice_vf_vsi_disable_port_vlan() when clear_port_vlan() succeeded, and log or
propagate the failure otherwise?

[Severity: High]
Can vlan_ops->clear_port_vlan be NULL by the time this new call runs?

vlan_ops points at the live table (&vsi->outer_vlan_ops or
&vsi->inner_vlan_ops), not a snapshot, and clear_port_vlan only exists
while the port VLAN flavour is installed by ice_port_vlan_on():

	vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
	vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;

ops_unsupported in ice_vsi_vlan_ops.c has no .clear_port_vlan initializer,
and ice_port_vlan_off() never assigns it either.

The bridge path holds only rtnl (ice_eswitch_br_event_blocking ->
ice_eswitch_br_port_obj_add -> ice_eswitch_br_port_vlan_add ->
ice_eswitch_br_vlan_create -> ice_eswitch_br_set_pvid) and
ice_eswitch_br.c never takes vf->cfg_lock, while set_port_vlan() and
add_vlan() sleep (kzalloc(GFP_KERNEL) plus an admin queue wait).

A VF-initiated reset runs concurrently under a disjoint lockset:

ice_vc_reset_vf()/ice_process_vflr_event()
  ice_reset_vf()                      /* vf->cfg_lock + pf->lag_mutex */
    ice_vf_reconfig_vsi()
      ice_vsi_cfg()
        ice_vsi_cfg_def()
          ice_vsi_init_vlan_ops()     /* reinstalls ops_unsupported */

If that lands inside the window, does the new err_clear_port_vlan label
dereference a NULL function pointer?  The same missing serialization also
lets a virtchnl handler fetch one flavour of the ops and execute it after
the unwind flipped the table back.

> +err_disable_port_vlan:
> +	ice_vf_vsi_disable_port_vlan(port->vsi);

[Severity: High]
The commit message says this hand-back addresses the case where "in Double
VLAN Mode, the inner add_vlan() and del_vlan() stop doing anything".  Does
ice_port_vlan_off() actually restore those two?

ice_port_vlan_on() sets them in DVM:

	vlan_ops = &vsi->inner_vlan_ops;

	if (ice_is_dvm_ena(&pf->hw)) {
		vlan_ops->add_vlan = noop_vlan_arg;
		vlan_ops->del_vlan = noop_vlan_arg;
		...

ice_port_vlan_off() re-points its local vlan_ops at the outer table before
it assigns del_vlan, and never touches the inner add_vlan at all:

	vlan_ops = &vsi->inner_vlan_ops;

	vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
	...
	if (ice_is_dvm_ena(&pf->hw)) {
		vlan_ops = &vsi->outer_vlan_ops;

		vlan_ops->del_vlan = ice_vsi_del_vlan;
		...

So after the unwind a DVM VF VSI keeps inner add_vlan/del_vlan ==
noop_vlan_arg, where ice_vsi_init_unsupported_vlan_ops() installs
op_unsupported_vlan_arg for a DVM VF VSI without a port VLAN.

Those pointers are live for the VF: ice_vc_process_vlan_msg() calls

	status = vsi->inner_vlan_ops.add_vlan(vsi, &vlan);

and the matching .del_vlan() for legacy VIRTCHNL_OP_ADD_VLAN/DEL_VLAN, with
DVM explicitly allowed there.  Is the VF's C-tag filter add/del then
reported as success while ice_fltr_add_vlan() is never issued and
vsi->num_vlan is not updated, until the VF VSI is rebuilt?

Should ice_port_vlan_off() also restore the inner add_vlan/del_vlan, which
would additionally cover the same residue on the existing
ice_eswitch_br_clear_pvid() path, or should the commit message be narrowed
to what ice_port_vlan_off() really restores?

[Severity: Medium]
What happens here when the VF VSI was already in port VLAN mode before
ice_eswitch_br_set_pvid() ran?

ice_vf_vsi_enable_port_vlan() is a plain ops-table overwrite with no
nesting or refcount:

	void ice_vf_vsi_enable_port_vlan(struct ice_vsi *vsi)
	{
		if (WARN_ON_ONCE(!vsi->vf))
			return;

		ice_port_vlan_on(vsi);
	}

ice_set_vf_port_vlan() has no switchdev or bridge guard, it just records
the VLAN and resets the VF:

	vf->port_vlan_info = ICE_VLAN(local_vlan_proto, vlan_id, qos);
	...
	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);

after which ice_vf_vsi_init_vlan_ops() calls ice_port_vlan_on() because
ice_vf_is_port_vlan_ena(vf) is true, and
ice_vf_rebuild_host_vlan_cfg() programs it:

	if (ice_vf_is_port_vlan_ena(vf)) {
		err = vlan_ops->set_port_vlan(vsi, &vf->port_vlan_info);

ice_eswitch_br_set_pvid() only inspects the bridge-tracked port->pvid,
which is still 0 in that configuration, so it proceeds.  On a failing
set_port_vlan() the new path calls ice_port_vlan_off() while the SR-IOV
port VLAN is still active in hardware and vf->port_vlan_info is still set,
which makes dis_rx_filtering the real ice_vsi_dis_rx_vlan_filtering()
again.  On a failing add_vlan() the clear additionally zeroes
vsi->info.port_based_{outer,inner}_vlan.

Does the unwind need to restore the actual prior state rather than assume
"port VLAN off" was the baseline?

> +
> +	return err;
>  }
>  
>  static struct ice_esw_br_vlan *

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920064754.1935818-1-xiaolinkui%40126.com
