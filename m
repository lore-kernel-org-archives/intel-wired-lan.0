Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC576C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 15:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 600934078C;
	Tue, 22 Sep 2026 15:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sh8cvqV1zig3; Tue, 22 Sep 2026 15:18:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6980C407FE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090287;
	b=RetL7sZZEK7RMyAVL+Pdi9oQHYvpNmsz6rFCWuN9tnOeBnJyutExDqxvznW4JZu6b05n
	 CzNE/k4/X90Y8HvSZkU0jL4TQ9tq9FejYvT3ACNe/R7Dyz2b3n+Fdxs6JJHRZ0cButXXr
	 30LQwWr+rBOfiUR5nylmqf1a0nhQ4rw8ZSCeJYlD2Ew3E+iTlPCu0wB4SiZHZ3UbxlxuB
	 heuQ1tQEAiCWiR+bkvkAPkce/hA3Gt5TIHtDPR6UGbkygmA4HNVrXkB3kZDwjXBw/tkZT
	 6SGBh6/0G8atC0boQ/Vl8yN8r//hVj5a+5w1sBPNdZ/w4Gi++AkiN/h2KkkxHWES5lA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SCUskFf4P9uSaGgRY2DVcZeibiyVC9XecefXdSM92Hg=;
	b=FnF5YuSBOaJ+UvGxEBJJtio4nfyI4h+6Cq7SeXay0PBECOYhUTLDWfNKIh4pSrqLFoyB
	 d8uoJtRzPBfCD7Ny3Cjq+IYqS8cUdnrkfpPGKj2XKfp+E2GtFZaSPCTT8RKR39ogs/+7q
	 lpolyCV02DpQk1WQC4FEI3K4RTZCI5EVsLyrOOvTR4j5xLwhB8Hw8eoFzHjQkdpG5lPPV
	 1S9X3x+Cy+o37v9FcR6sc0MlZTUSaKGeZaHZFUbDiE/QHGgvR2rjEgW31wWb0Deifa4/a
	 ASYr/be2l8bKIFd0bK3vdGH6zIcU5htRK2wTLko6Mzjh/vZEyjdABjyGX2RzHzICiSQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790090287;
	bh=SCUskFf4P9uSaGgRY2DVcZeibiyVC9XecefXdSM92Hg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M+OSgzYrkFDk5wvN9XKqXEkFggQIvlZdF1KzYFguK0eCxIiFqfJQPF2zRL9/cH4E7
	 AVeW0XLuJuox59DrrqzlnoGms1dPflvb1U6AbpbsGg3OHRpCthkd9QBjw86Ajwo//v
	 Yymx0IDXn37r5LMC2kWxT9eSbRbrIwsB5wub02GeOM58IQ4ILbpTdwxFM3/hB9ey6Q
	 q5BjSI6ATz5VOixVu8PUig6SOSDqntG6ANIYWgFmoHemXaOVwx2VoHP/xvz2mj8Ndf
	 cr2JzdCBV1Ey9XYbNE741Qt4L6iHwPG2bglLXpAYKjmux6+/CndsEzhzYdQsIC2c4z
	 xXlznRSmVbFIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6980C407FE;
	Tue, 22 Sep 2026 15:18:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 144C135A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDB7980C6A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVbgfz_xVb9J for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 15:18:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0784580C68
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790090285;
 b=fbajQQM1AQn3gAcGhaxF/QoEI0JRYOU5MI9YaclBz2+raTO6u7ZtG9tDl9Qfw9TsmAdK
 K7uECbrjya2ZY4g0G1jm85KrkiJhSyOglKUktTm51ugTgdPwKdVZni93nHUsdKERKw47u
 TfpTmeOPFu0V9syggNd8jhGRF6kVXveQtAQ5A7ZJCPPvaBM4SU6u6QjWbHfY4pNhxE8r3
 7RwXWOgl1181xAOFT+sM0n+eb/m2tb4j81WCkwt/CgTX2hvLv36vzvWlrJgmBQjF6D3W+
 K4RRDRzbUlPJoZDmpbacAhH6vEc6S5uKEudGbB+E/50dOCNPaYVaxPuEy102mOHA/yQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790090285;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=SCUskFf4P9uSaGgRY2DVcZeibiyVC9XecefXdSM92Hg=;
 b=PkQmVQerruNmcTajAtixjtz5tXMBqAWfGIcCtg28Aui7wLDZZ18Aa0K1sCK5zDNz7twK
 EsadTIrRkSdPhSFDJ1da56Gx+tFcY/m1QHRkEpXADdxRHTKJaoFO0ZAcQdC3d/JAYhUIn
 NJBYHJr3vJoPRfoLVz8pjIGCfkzBHbiF1KEsl8Ioou/uDAw87HIF5GVWTHFEB8NHzbiA0
 r9po8wlznE8oNJgwVa+sY3Pqi4WIDHMvnsouxWH133Vik8BSeA8PmHlW4JKPEOZD3DT4x
 WZV4fa5wJGR08aIqgslBOlAOzqq5mzCM/BO3t2Mbs+77rsU3Cr5Sk5dGh1pedFbrC/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k6CXXqI5; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=k6CXXqI5
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0784580C68
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 15:18:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B06B940198;
 Tue, 22 Sep 2026 15:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98AD1F000FF;
 Tue, 22 Sep 2026 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790090282;
 bh=SCUskFf4P9uSaGgRY2DVcZeibiyVC9XecefXdSM92Hg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=k6CXXqI5y/J0EJrREtniefQG6Xg6CdtuQprCHaleooshSYJWEUL04kAFvwXdyB2PU
 lbNAnhPKZ4SpEThqh06cABShaNf5S1kfH7G4mCtN0xULjmZ++sW5ZxoxzEmcrwvBSm
 QxKFai5SDu+iH96dCDJPNue7ShuxbQ+MBQ6u3g7uF6XvwwfJAyKPBB3mbuGKhTkvl/
 dK56IVjCbEWDgKzcYqj/TEpotv8SG/KNy/qS/tY/jZU2DLgO0Ov7tN93TjXaTRYT7O
 ccfyQVWRje1ZYZ0PZfUES2qJixyraN+hLoC/ej+Ke7RNHQK/dsLf8WfIiGuuBIkU4O
 eTlYRZexoknJw==
Subject: Re: [PATCH net] ice: detach the VF representor when ice_start_vfs()
 fails
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 stable@vger.kernel.org
Date: Tue, 22 Sep 2026 15:18:01 +0000
Message-ID: <179009028142.2160803.9147341738754348504@kernel.org>
In-Reply-To: <20260921031616.3390259-1-xiaolinkui@126.com>
References: <20260921031616.3390259-1-xiaolinkui@126.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The newly added ice_eswitch_detach_vf(pf, vf) in the
  ice_start_vfs() teardown loop…

Pre-existing issues:
- [High] AB-BA lock ordering inversion between pf->vfs.table_lock and the
  devlink instance lock.
- [Medium] ice_start_vfs() teardown loop
  (drivers/net/ethernet/intel/ice/ice_sriov.c:507-515) still never…

--

ice: detach the VF representor when ice_start_vfs() fails

The patch adds a call to ice_eswitch_detach_vf() in the ice_start_vfs()
teardown loop so that port representors created by ice_eswitch_attach_vf()
are destroyed when VF startup fails. It is placed ahead of
ice_vf_vsi_release() so that repr->src_vsi is still valid. A few questions
about the new call site below.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..1b563aba3bbd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -508,6 +508,7 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt == 0)
>  			break;
>  
> +		ice_eswitch_detach_vf(pf, vf);

[Severity: High]
Should this call be made with vf->cfg_lock held?

ice_start_vfs() only holds pf->vfs.table_lock (see the
lockdep_assert_held(&pf->vfs.table_lock) at the top of the function). Both
existing callers of ice_eswitch_detach_vf() hold vf->cfg_lock across it:

drivers/net/ethernet/intel/ice/ice_sriov.c:ice_free_vfs() {
	ice_for_each_vf(pf, bkt, vf) {
		mutex_lock(&vf->cfg_lock);

		ice_eswitch_detach_vf(pf, vf);
	...
}

and ice_reset_all_vfs() in ice_vf_lib.c does the same.

cfg_lock rather than table_lock is what serializes VF reconfiguration:
ice_vc_process_vf_msg() in virt/virtchnl.c takes only
mutex_lock(&vf->cfg_lock) before dispatching through vf->virtchnl_ops, and
the ndo handlers ice_set_vf_mac(), ice_set_vf_trust() and
ice_set_vf_port_vlan() take cfg_lock and then call ice_reset_vf(), which
reaches ice_eswitch_update_repr().

Since pci_enable_sriov() has already run by the time ice_start_vfs() is
called, and ice_sriov_configure() does not take rtnl, can the following
interleave?

CPU0 (sysfs sriov_numvfs, teardown loop, no cfg_lock)
ice_eswitch_detach_vf()
  ice_eswitch_detach()
    xa_erase(&pf->eswitch.reprs, repr->id);
    ice_repr_destroy(repr);   /* free_netdev()/kfree() */

CPU1 (ip link set dev ... vf N trust on, cfg_lock only)
ice_reset_vf()
  ice_eswitch_update_repr() {
	repr = xa_load(&pf->eswitch.reprs, *repr_id);
	if (!repr)
		return;

	repr->src_vsi = vsi;
	repr->dst->u.port_info.port_id = vsi->vsi_num;

	if (repr->br_port)
		repr->br_port->vsi = vsi;
  }

Does this write through a freed struct ice_repr? The VFs this loop walks
still have ICE_VF_STATE_INIT set and ICE_VF_STATE_DIS clear, so
ice_check_vf_ready_for_cfg() succeeds on the concurrent path; unlike
ice_free_vfs(), the new loop never sets ICE_VF_STATE_DIS.

The same unlocked window also has ice_repr_rem_vf() calling
ice_virtchnl_set_dflt_ops(repr->vf) while ice_vc_process_vf_msg() reads
vf->virtchnl_ops under cfg_lock.

[Severity: High]
This isn't a bug introduced by this patch, but it adds one more instance of
it: ice_eswitch_detach_vf() takes the devlink instance lock internally,

drivers/net/ethernet/intel/ice/ice_eswitch.c:ice_eswitch_detach_vf() {
	...
	devl_lock(devlink);
	ice_eswitch_detach(pf, repr);
	devl_unlock(devlink);
}

so this call establishes table_lock -> devl_lock, the same order that
ice_eswitch_attach_vf() in this function and ice_eswitch_detach_vf() in
ice_free_vfs() already use.

The reverse order exists in ice_tear_down_devlink_rate_tree():

drivers/net/ethernet/intel/ice/devlink/devlink.c {
	devl_lock(devlink);
	mutex_lock(&pf->vfs.table_lock);
	ice_for_each_vf(pf, bkt, vf) {
	...
}

which is reached from ice_setup_tc_mqprio_qdisc() in ice_main.c and from
ice_pf_dcb_cfg() in ice_dcb_lib.c, neither of which holds devl_lock
already and neither of which is excluded while switchdev/SR-IOV is active.

Can this deadlock?

CPU0: write to sriov_numvfs -> ice_ena_vfs() -> ice_start_vfs() rollback
      holds pf->vfs.table_lock, blocks on devl_lock

CPU1: tc qdisc ... mqprio hw 1 mode channel, or a DCB reconfiguration
      holds devl_lock, blocks on pf->vfs.table_lock

ice_sriov_configure() runs under the PCI sysfs device_lock and takes no
rtnl, while the TC/DCB paths run under rtnl, so the two sides do not seem
to be mutually exclusive. Would it make sense to converge on one hierarchy
here, for example acquiring devl_lock outside table_lock in ice_ena_vfs()
and using lock-held attach/detach helpers?

>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
>  		it_cnt--;

[Severity: Medium]
This is a pre-existing issue, but since the loop is being made symmetric
with ice_free_vfs(), does this loop also need to return the VF MSI-X
window?

ice_init_vf_vsi_res() reserves it:

	vf->first_vector_idx = ice_virt_get_irqs(pf, vf->num_msix);
	if (vf->first_vector_idx < 0)
		return -ENOMEM;

ice_virt_get_irqs() does bitmap_set() on the PF-wide
pf->virt_irq_tracker.bm, and the only release helper,
ice_virt_free_irqs(), is not called anywhere on this failure path: not in
this teardown loop, not at the release_vsi label of
ice_init_vf_vsi_res(), not in the ice_eswitch_attach_vf() failure branch,
and not in the caller, where err_unroll_vf_entries -> ice_free_vf_entries()
-> ice_put_vf() -> ice_sriov_free_vf() only does mutex_destroy() and
kfree_rcu().

ice_free_vfs() pairs the two calls the new loop now half-mirrors:

		ice_eswitch_detach_vf(pf, vf);
		ice_dis_vf_qs(vf);
		ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);

The tracker bitmap is allocated once per PF in
ice_init_virt_irq_tracker() and freed only in
ice_deinit_virt_irq_tracker(), and ice_set_per_vf_res() sizes VFs from
pf->virt_irq_tracker.num_entries rather than from the number of free bits.
Does each failed "echo N > sriov_numvfs" therefore leak
num_vfs * num_msix_per_vf entries of the VF MSI-X range until
ice_virt_get_irqs() starts returning an error and SR-IOV can no longer be
enabled without a driver reload?

Note also that ice_dis_vf_mappings() clears VPINT_ALLOC/VPINT_ALLOC_PCI and
re-points GLINT_VECT2FUNC of exactly those vectors back at the PF, so the
hardware mapping and the software bookkeeping end up disagreeing.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921031616.3390259-1-xiaolinkui%40126.com
