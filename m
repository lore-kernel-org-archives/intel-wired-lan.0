Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE6CA6017
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 14:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 782E960628;
	Sat, 10 Oct 2026 14:05:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xac4LNahplEC; Sat, 10 Oct 2026 14:05:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C5176062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791641137;
	b=gAoKgb7khzhY/ZOBdfSaLOwOEeVZmBsOqt5l0Fl9qwEjx3AURnyB/wBjS6qSef0ixqzU
	 St9AL3M9takY7a77yjB/axbd8LDCERNxNArttXHDZqc5msjcsge20+2iwEwm3ghBS7BuI
	 NH8slyVTG31fsPRoVp02DLwYNueDdNILhyXZPKxWscmN1ZAzG8vW7yUYdfgxWI4DBlzPR
	 6HIONZbQbmghy6pISVp/G6JFZgCeK9+RM+U2cGEmsPaaLvf9Bsk++MHfaLOXQKEIGKuhf
	 u6uHS+ednXNfXL6PnlW346iBNfBxaiVM9YsvqDE1qPcDAY138/9gNQX3G/y/PpF6G6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791641137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cvFPTAQxDXIlbchmR2MXtaPjfdx7iEJiJUHoag0ON9E=;
	b=D7c+kYg+5zOU9bRxjg8YiEZBzq2ppin8i4NP3UjSwG/I6tF4NhE2OgOZGID6ZnTcw2K+
	 4sJPjO7QbXaP/3SXlIV4uDeQMpKgtcAVGsf+w8bLY/9gsg1A+sgBSHCyq5BJ1erzwYMDF
	 5XJi2H9VIwGv87+WkhAcng9ixtyeZRp+lGJjBCq6b5V45mLzsToBYI7KhCWbKsYxAHWzu
	 sZEp1/67ZQG6e0zlQWoke+dF3VuC27d0WCc4PqBqneeZtBqFmgRz7hMmaHE7ul4S0rgq7
	 rTCX5tP0GqQGR6HMbIr6huUoGAaJ3SoPgnCld+tGkMJs639GSxUYYaVjrCY8NlBdhAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791641137;
	bh=cvFPTAQxDXIlbchmR2MXtaPjfdx7iEJiJUHoag0ON9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a3J0IVMHJoJ+K3pj1CWTttcctwXG9hxYdGiAUTnuIyjYYZpVBCLqUx+0IbmIURlpK
	 USqY50nPLxo+T8/KR9slqFvfBFyy/aG4oVLZY4kP47ThIG1fal4PEySwTARKfD4vvR
	 5OwGcv+iOMOYJ3BBPTGytO/P2NvK2gKOSE4sL/AE9C4WZhk8wISPu08gSk19oRIw+n
	 ZjkZfK4KoLf74l6XJTZfKD93yXwbn7SiGHqnJSZj/Ept55ZntnE8XQZrSG4DPiLx+4
	 n96QMr26E/FLaS8tt1ptKH2futwdKxp8M2s7rD5VRFgYhgKH28zsS2he4N/k4dL/9o
	 Ag03kcCDKjglg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C5176062B;
	Sat, 10 Oct 2026 14:05:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CA5FC235
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFF8A81208
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SevJKDcQ1Zd2 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 14:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA390811FE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791641134;
 b=dd08vfoF5K9b4CshJ+Jl8h8FIFx+eIezOOVBMHIBSkmCSLlUZDZ09cpHxbo695Ly2ryO
 YQ42FKvgkN5BDUrg/jp2vaCsBc8d6/CZh3r3bGL9EnZEJS8exaMUatmuDsXK5NlJaz7nI
 j72Ijg06kfbbraX1e2TktLEMTS7LOzRpRw06ZFnG/SrImfmk4pBf4BnPEzuKmz112lXOQ
 6/8jBulgIjCnAN/O/GkQLySuWfetVLuEKBv7r1L5zF7pfNhCjfy3JdKj6adGrk6e1ETji
 CO99XhEFWW1eVNi8cUmK/uYbswHJYPwqkL+TwIIafvf8Exb6VkMLJVxh4mL681bPwrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791641134;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=cvFPTAQxDXIlbchmR2MXtaPjfdx7iEJiJUHoag0ON9E=;
 b=k7K1ccV4PHR0BrYkFf89yzYtHaxnyR9Uk9Yja3FyBiAjE+RcX2mOYdB6WPXXi9EHQQVJ
 LikNT1NZOdTqdZy7jQcxULKzKTOhm+YgLJLInQFofKeaFtIQQFCd2nzSgvXjO/Cc3Z0EU
 srBeDz0+OI/U8t9iObDYJC0qmftW6JMrBmV4XP7YdFhDrlf2ELgASilz4JllRotled8Pa
 LVp0etJdgTQjVF5C1UHPwTGENIvWAfUQdUwdQKvIpPcLnsBV2o8zt/tCu+S8mqPNsNTxk
 hCx1uPpqNZOl83BCD++LqrApWIY9tT8NHeHKrok9ZbuyvDWhWW8ZlVtGyfVtBAeDfew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=l9C0CQ3V; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=l9C0CQ3V
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DA390811FE
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 14:05:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C32CF600D4;
 Sat, 10 Oct 2026 14:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9DF1F000FF;
 Sat, 10 Oct 2026 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791641131;
 bh=cvFPTAQxDXIlbchmR2MXtaPjfdx7iEJiJUHoag0ON9E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=l9C0CQ3V9qEMS3prByZE4s7cjQ5doUMT8vX0/ON3vo5JSN0MxXPRnE0G0C1RNCKbo
 JfQOTy+Dp9oJGgbSxLx4xV7P0dVwNAioGVM9n8gUMbNyJLBQKXfu8e/b0RFJrzFrNq
 r1i031BlsRAWs9y8MKYEze3BXh8SCQNcUjQm1XRdXBMB0WcgSmgh1f2Qaj9TxfvoDy
 nxjP07mKMUoUeBZzeNppTcw02+yPRRfp6EqCQKoqwivOx6h51lu07QRdXisn2tXSUR
 CJ15W9bevgEpvClxmsBzBNnk4kCwgV1XUVswH8FXnDqi6ZwxIbOnHAQ83xjMI3xk7l
 tE89tLD6USvYw==
Date: Sat, 10 Oct 2026 15:05:28 +0100
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: sashiko-reviews@lists.linux.dev, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH iwl-net v3 2/3] ice: detach the VF representor when
 ice_start_vfs() fails
Message-ID: <20261010140528.GP83879@horms.kernel.org>
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-3-xiaolinkui@126.com>
 <sashiko-outbox-165587@kernel.org>
 <c4f9c654-614a-44c9-b96a-31883df45e4b@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f9c654-614a-44c9-b96a-31883df45e4b@126.com>
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

On Sat, Oct 10, 2026 at 10:42:49AM +0800, Linkui Xiao wrote:
> 
> On 2026/10/9 21:05, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [High] ice: ABBA deadlock between pf->vfs.table_lock, devl_lock, and rtnl_lock
> > --
> > 
> > commit e31928012cb273c164e36248e1b33c296e805e8d
> > Author: Linkui Xiao <xiaolinkui@kylinos.cn>
> > 
> > ice: detach the VF representor when ice_start_vfs() fails
> > 
> > This commit modifies the error teardown path of ice_start_vfs() to explicitly
> > detach the VF representor. This prevents memory leaks, use-after-free
> > scenarios, and stale configuration states.
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > > index bf6410c0d85d4..13d97dbd517c8 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > [ ... ]
> > > @@ -520,8 +520,27 @@ static int ice_start_vfs(struct ice_pf *pf)
> > [ ... ]
> > > +		/* Mark the VF disabled before its representor and its VSI go
> > > +		 * away, the way ice_free_vfs() does, and take cfg_lock
> > > +		 * around it to wait out an ice_reset_vf() already in
> > > +		 * progress. pf->state has no ICE_VF_DIS on this path and the
> > > +		 * loop leaves ICE_VF_STATE_INIT set, so without the bit a
> > > +		 * concurrent ice_reset_vf() would pass ice_is_vf_disabled()
> > > +		 * and reach ice_eswitch_update_repr() on a destroyed
> > > +		 * representor, or trip WARN_ON(!vsi) in ice_dis_vf_mappings().
> > > +		 */
> > > +		mutex_lock(&vf->cfg_lock);
> > > +		set_bit(ICE_VF_STATE_DIS, vf->vf_states);
> > > +		mutex_unlock(&vf->cfg_lock);
> > > +
> > > +		/* detach outside of cfg_lock, see ice_free_vfs() */
> > > +		ice_eswitch_detach_vf(pf, vf);
> > 
> > [Severity: High]
> > Does this introduce an ABBA deadlock involving pf->vfs.table_lock, devl_lock,
> > and rtnl_lock?
> > 
> > ice_start_vfs() runs with pf->vfs.table_lock held. Adding a call to
> > ice_eswitch_detach_vf() here establishes a lock acquisition order of:
> > 
> > table_lock -> devl_lock (acquired in ice_eswitch_detach_vf) -> rtnl_lock
> > (acquired via unregister_netdev in ice_repr_rem_vf).
> > 
> > However, there is an opposing lock acquisition order during TC mqprio
> > configuration:
> > 
> > rtnl_lock (held during ndo_setup_tc) -> devl_lock (acquired in
> > ice_tear_down_devlink_rate_tree) -> table_lock (acquired right after
> > devl_lock in ice_tear_down_devlink_rate_tree).
> > 
> > If a user enables SR-IOV, triggering an error in ice_start_vfs(), while
> > concurrently configuring TC mqprio, could this opposing lock acquisition
> > order result in a deadlock?
> > 
> > > +
> > > +		mutex_lock(&vf->cfg_lock);
> > >   		ice_dis_vf_mappings(vf);
> > >   		ice_vf_vsi_release(vf);
> > > +		mutex_unlock(&vf->cfg_lock);
> > > +
> > >   		it_cnt--;
> > >   	}
> > > 
> > 
> Thanks for the review.
> 
> I agree that the three lock orders do not converge, but I do not think
> this patch introduces the inversion, and the cycle is reachable without
> it.
> 
> ice_start_vfs() already runs under pf->vfs.table_lock and already takes
> devl_lock with that lock held, before any failure can happen. Its
> forward loop does
> 
> 	if (ice_is_eswitch_mode_switchdev(pf)) {
> 		retval = ice_eswitch_attach_vf(pf, vf);
> 		...
> 	}
> 
> and ice_eswitch_attach_vf() takes devl_lock() around
> ice_eswitch_attach(). The teardown loop unwinds only the VFs whose
> attach succeeded -- it walks the VFs in the same order and stops once
> it_cnt reaches 0 -- so whenever the ice_eswitch_detach_vf() added here
> can reach devl_lock(), an ice_eswitch_attach_vf() has already taken it
> earlier in the same call, under the same table_lock. In legacy mode
> there are no representors to begin with: ice_eswitch_detach_vf()
> returns at its xa_load() before reaching devl_lock(), and nothing
> attached either. Either way, table_lock -> devl_lock is not a new pair
> here.
> 
> The full table_lock -> devl_lock -> rtnl_lock chain is pre-existing
> too. The other two callers of the same helper hold table_lock and reach
> RTNL through it:
> 
> 	ice_free_vfs()        table_lock -> ice_eswitch_detach_vf()
> 	ice_reset_all_vfs()                  -> devl_lock()
> 	                                     -> repr->ops.rem()
> 	                                     -> ice_repr_rem_vf()
> 	                                     -> unregister_netdev()
> 
> That is in the baseline, not added by the series, and the opposite
> order, rtnl_lock -> devl_lock -> table_lock in
> ice_tear_down_devlink_rate_tree() reached from ndo_setup_tc, is equally
> untouched. So "echo 0 > sriov_numvfs" racing a TC mqprio configuration
> can reach both halves today. This is the same pair that was raised in
> the v1 review, and the conclusion has not changed.
> 
> That said, the two orders do not converge, and converging them is worth
> doing. It means taking devl_lock outside pf->vfs.table_lock in
> ice_ena_vfs(), ice_free_vfs() and ice_reset_all_vfs(), plus variants of
> ice_eswitch_attach_vf() and ice_eswitch_detach_vf() that expect
> devl_lock() to be held, since devl_lock() is a plain mutex and the
> helpers take it internally. That is a lock hierarchy change across
> three callers and the eswitch API, and it is unrelated to the
> cfg_lock -> RTNL inversion this series is about, so I would rather send
> it as a separate series than carry it in an iwl-net fix that has to be
> backported to stable.
> 
> No code change in this series for this report.

Thanks for the detailed response.
This seems reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>

