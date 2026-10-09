Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967E2CA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 13:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39AD160684;
	Fri,  9 Oct 2026 13:05:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKc1BL6wzp-r; Fri,  9 Oct 2026 13:05:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D34E360680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791551137;
	b=RLhMb9A3CWJDlxUmyEcUukYBxKXc2vcYBL63ezD7VTnzy69jFMcoVXHo7+lkZjNCgukH
	 C79WY7jYUq8VHuHo8CzNCtFPX5zdoAd9iXHEdGB2kJPhPiOhJjt52K2Q+V8oh5mdHjv5p
	 TxR6G2fzxcbN33DvQ9Yvjw0AmkXhr70A4xcZJM5ZyEib0TgSFR5ByxARaSl8Ynw+Jyzcw
	 497nmQv9IOdyRf9Kjx84AzoLSyLrr9xe52lxfYKdPbcj+IAw9uMHvVZCF9QQYD1TTcaso
	 3+ZUmO46VmdPmLPgB4WF+yBrhTKdw/HwLIvnxMCIZiXYffZTuKnDxl1LWhM5Dw1Q38Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791551137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=zpT5wLYjyJiM8SmMzuf7+D7Wsq0A0vy9kyPknCiInGg=;
	b=gE2B7z+Gibef5blVxXu5GYMz+O+yiV9Cy1nUzOU21OG3sOa3XEgqucPlL+k/aEJzIbX/
	 Mxi8T8NNKVnJA2YUJCECu5gT6CYakdYmOH7KAvKiTpn+EGKoiSYdtHNPlihkQSkwBUelx
	 s1aaVfS002A1+2aQokmX/c9hN6+uWXG2oi5X9/F3ESZyCsRLu2fid0gq+JYYOhdSBQCI4
	 vTTLy+fjHnFeWotJkwZ73WrXFasCSG0YhY3wwGC0ISHaFYdRllGqCqflQngMpQFbdjKhw
	 aY1ggOwNetZ4aklhCxCWU2DV6Lg8n9zVBNxgKRzbKYZyCSO/cLdpAO34eadm5FHYceQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791551137;
	bh=zpT5wLYjyJiM8SmMzuf7+D7Wsq0A0vy9kyPknCiInGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DZH3sBVlVZZCvtJvlmoZKAwGVfXtwzpV4pdp/D313BQvs9guBv0ocIQcJWm8jB2GJ
	 sgxfDzG4s/vyD96O8z0BZTlFDtf8nMr//oR/ixRiSVR+Rrlg9M6NcxsbwoRVMgLGvl
	 gwnuZ86NJ22xjE+JsgVZMqgxiNGjiNAzlopCfX32fLLNIKbXsbGWdGWVGW2+bodRjB
	 VTprMVMqNGPN/36qT9MTWVVHR0X1blQFdB7aA/Kma+HsFwPA6at2toNf2CjhMA2kql
	 ebgH5gt2AvXAsy0asE7likFte2A5TmDYJd58yvsDH+x48f7lBuDVkxS9bi9YnlnS33
	 h1T/UlMpz/PTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D34E360680;
	Fri,  9 Oct 2026 13:05:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D811317
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1E02408AB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DtzBXV8QCOdG for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 13:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8332408A2
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791551134;
 b=Hy4dHJ1AiFdVogevRwEHiXHIDEpWxDn764p1zvUbwLAU8xt1ixncGE5KxHBHZSWa6eo9
 +YFez4d/mnMXClSK29Hv6B1j72Isrs/h4V6Aqpva/uWfxA1DyehZzkI9ZDGJA7Lf2I89v
 QTiR//IRzE/IQDyM2TsTWF6+Rk6dzoKkmaXTKw3gEaql9shV7LoQOlbPRcL6oXDDCVlwy
 YVvhn1mokKmBYUIqnLsNqGpGm0SijDPigTAKzL80AT6VGLMjof+PhlWcRV+1RrBkxSKu2
 gUh8+WNWZO1OscQ9i30sKAb5ph0vPM7WFB6rTLeHOwOp8U3OnQKljjSvzjqqz3O9lmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791551134;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=zpT5wLYjyJiM8SmMzuf7+D7Wsq0A0vy9kyPknCiInGg=;
 b=iZiWCll4+FCKf0sfKeRBClHRb0cYCp6cyvPjlGIvvkjc9HpI7N3UqxycHt4l6AFwqIf4
 P2rBf/yzh5ZSmrQOm5UocokRUUYOXkzZDOkAnqkSI0oo0gIKqUQF60Ih6l07vez4xi3ph
 EtvH0l/lA3uT+E42zKnpU6kzA/ILKSxvqbRUfzo5jRiY1a89Fo35SaD1Ukgdex+OKKeIl
 uBdJoT5q7Z6ZHXFjJh+8bcIe/VlB63bwYVBW2a/eoDjrLhFkAaH+fzELir08uB2W4pVu7
 fcdpAihFD3JTVmvKiuwx5UbObIe4NdvMZz6T+6MMjva715A//JyP6wjxzJo18aRKgRg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CBJBhU3m; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=CBJBhU3m
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8332408A2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:05:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F86460A55;
 Fri,  9 Oct 2026 13:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1CB1F000FF;
 Fri,  9 Oct 2026 13:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791551132;
 bh=zpT5wLYjyJiM8SmMzuf7+D7Wsq0A0vy9kyPknCiInGg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CBJBhU3mInrfDNPs6EVGFAwuSXHWB+FsGMI4YT+KJnxqqySPnxhwTV4szZeku4HKt
 rNwfsZrUcErwTiuoesIVuBZh1xlhBishvoH1Zri28zCr/qMGtkz+KV61a6W+Ee/zSs
 8eUpLF1SlCFos8rUelemUoG3PMlAFCOdcmRnL5hvXiznyvytsMnwFhw/MOod7BDeid
 aizktvaePbP9DOpu1piqVRc5mD3jzEvNO0vWIrzmfcxjGFQMokoJFz2Ybq7eTQhjyu
 Oo/OSV+nXmRnBoSnS5ptA5JtSA6QtU9a1XF3p4Z+aM5mWwyRuqBcdRFMYZ5GaokAsr
 PJC2Zr4pTaSdA==
Message-ID: <sashiko-outbox-165587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3 2/3] ice: detach the VF representor when
 ice_start_vfs() fails
To: "Linkui Xiao" <xiaolinkui@126.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008125754.3520773-3-xiaolinkui@126.com>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-3-xiaolinkui@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:05:31 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ice: ABBA deadlock between pf->vfs.table_lock, devl_lock, and rtnl=
_lock
--

commit e31928012cb273c164e36248e1b33c296e805e8d
Author: Linkui Xiao <xiaolinkui@kylinos.cn>

ice: detach the VF representor when ice_start_vfs() fails

This commit modifies the error teardown path of ice_start_vfs() to explicit=
ly
detach the VF representor. This prevents memory leaks, use-after-free
scenarios, and stale configuration states.

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/eth=
ernet/intel/ice/ice_sriov.c
> index bf6410c0d85d4..13d97dbd517c8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
[ ... ]
> @@ -520,8 +520,27 @@ static int ice_start_vfs(struct ice_pf *pf)
[ ... ]
> +		/* Mark the VF disabled before its representor and its VSI go
> +		 * away, the way ice_free_vfs() does, and take cfg_lock
> +		 * around it to wait out an ice_reset_vf() already in
> +		 * progress. pf->state has no ICE_VF_DIS on this path and the
> +		 * loop leaves ICE_VF_STATE_INIT set, so without the bit a
> +		 * concurrent ice_reset_vf() would pass ice_is_vf_disabled()
> +		 * and reach ice_eswitch_update_repr() on a destroyed
> +		 * representor, or trip WARN_ON(!vsi) in ice_dis_vf_mappings().
> +		 */
> +		mutex_lock(&vf->cfg_lock);
> +		set_bit(ICE_VF_STATE_DIS, vf->vf_states);
> +		mutex_unlock(&vf->cfg_lock);
> +
> +		/* detach outside of cfg_lock, see ice_free_vfs() */
> +		ice_eswitch_detach_vf(pf, vf);

[Severity: High]
Does this introduce an ABBA deadlock involving pf->vfs.table_lock, devl_loc=
k,
and rtnl_lock?

ice_start_vfs() runs with pf->vfs.table_lock held. Adding a call to
ice_eswitch_detach_vf() here establishes a lock acquisition order of:

table_lock -> devl_lock (acquired in ice_eswitch_detach_vf) -> rtnl_lock
(acquired via unregister_netdev in ice_repr_rem_vf).

However, there is an opposing lock acquisition order during TC mqprio
configuration:

rtnl_lock (held during ndo_setup_tc) -> devl_lock (acquired in
ice_tear_down_devlink_rate_tree) -> table_lock (acquired right after
devl_lock in ice_tear_down_devlink_rate_tree).

If a user enables SR-IOV, triggering an error in ice_start_vfs(), while
concurrently configuring TC mqprio, could this opposing lock acquisition
order result in a deadlock?

> +
> +		mutex_lock(&vf->cfg_lock);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
> +		mutex_unlock(&vf->cfg_lock);
> +
>  		it_cnt--;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008125754.3520=
773-1-xiaolinkui@126.com?part=3D2
