Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE17C88E77
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 339D280F17;
	Wed, 16 Sep 2026 13:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrIdoA_TdUpd; Wed, 16 Sep 2026 13:09:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 979EA80F19
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564169;
	b=hqcXpwf1JqOnqS2pqxalpy2gQXn3/7DW5c79xz2xUMLmm7wT31KC8rITcVQlwahizlvX
	 emJVv4Wpln0hoDXHBcxigBa7BNMLQthI3eZMuRBsNj19rwT4UiHgZQLj+hRbCPSNSJVIN
	 7Y4U5s9oQE5tP0PVd+UJlHNzAh1bDDfLZquU9UTkjnmY/yj5qSu1QztWd3V7U2sHBJ2Wv
	 iY1FR/wcqdDhyhr4lIq0O7I2JI6gGmUoEcK6SZqfpGMGhx0fGZ/A5dSinwQ12uQdKrRnO
	 xCWKcCRe6ynaFBbt2ZpG5h6iDPwzVbLNBjC0kF4NSgTJ+SXCyywZD6fducYfyp4VNaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564169;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+Y5kA1pp9Xo5m9OKvmsrUgATLxAg0vALJGk4G9J2V9s=;
	b=ctPBnRpzcxmFf5OfdoS2xJ3Nwyp/6X/GEXNSpKgcScWfF/zGmq3NL9rncoN1p7teouTI
	 1Oal7gOiTRdLkHaWtB7cs04mOPkWzJjSu+fq0j3FFWx5Y/itn/7qB2bkqXu5eZ4xQQEyK
	 eV5fmlmcUdEqYjNpHFQvWj4EeUpBnv626KLm6fRFYNh0nf49odtkzffsHn3Jo4TBte7dC
	 Y3BGZLriIghh57gJmotwskOHpSr1sJhvlf6FYox39IfJ8baR0IasId+BGXKC5gfqVrO6e
	 45f4rvI5OqD7QFJp4hBeHKQ/eD6AETTsnAscSc9usd1IIMBD9k4syAPuC7J8YshbvBw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789564169;
	bh=+Y5kA1pp9Xo5m9OKvmsrUgATLxAg0vALJGk4G9J2V9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tE79sO1QmrMv9pfdyAU7t/Harbc2xCsgYYe/61YFPLN6Ti9/KgS5SDH2U/EqNPUJR
	 ly/VrPMSaWzAM+mSFksAZbW5y4Ne41VtfEIGBR5HRDkuJ5Z+Ef2Hg+N2ysqu1bQ6aA
	 IPofCqWN6TC0KXFiT2gNM/97IdJzIWc8gc/judBcxTVEowHZyl7gCI3TaqH67Wdw2z
	 wJXwO0RXLuBYPhfpNRJKrYIkYO2OCaeSMsH8jbbmtA33t9FjwFI4V4xsHTQ3LeH5/X
	 iKM4h7WVXYErq4XI0tGfX1iKMVH5jMvSPrXwOySBWP7VJkw7B49iLHQsIrtT0sYmRJ
	 dzBMbMWhivFUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 979EA80F19;
	Wed, 16 Sep 2026 13:09:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0758ADD7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE97460838
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iw3Ulrfnitd6 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 13:08:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7822E60837
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789564124;
 b=Wt4cAPE/SgxG+dPp1VF3QOUpU6Y7x7PGFt8p+2sfZnzZYELxecBrS4EAYDPEHo+EMR7X
 SSJ9+QpOvgOBQC4BBIBO71Vxd3KLfHGHdsyqiE8Hc5/UT+fcdMs2LiUO3de3ra++WSxlX
 FRKaB2kppLP+m+r6MJ7/VFjdAj9U7VeG19Bu0WvSlhi7UTUDZmnVpxY6D4sbDqDhM5SFB
 iw9Uw4t/K97Uxe0dSdHJVFo25LHyJumaJaNhBotZdL7NcmvsXQv1MRqyVkVZHUuE328U/
 Lo2tRGqp3W1H9YLgwy4a0vLUWWM/uWHK5LtwXVUUgoubD/zC3gL24ew+dpCV5G92T5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789564124;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=+Y5kA1pp9Xo5m9OKvmsrUgATLxAg0vALJGk4G9J2V9s=;
 b=jon5nG1l8QXxujevaPQAo2EvG+4SiNieDmeFAuwZv6HgjmdTcw7sUrD5TfLpR58lDD5Y
 J2DW5Kw369dPuFKyAbgI42aItBYVFmgSXzd2nBTSq3Q9cLhcPrT4T1px+NDlp06dwNcmx
 jLwDH6YKrFOl0O0RNpVh+I9O+4/CZzc3WsUBgjjmJGvYkP2ecAcZIenGgva5mnC82FEV+
 7h9EuM9ykl3eGLnUo1s8LCwD/vuHZChEp/4JpA/XQLHFsS/uK8/XSWBCLQHP69d81sPYb
 ylx9zuztV3XrmY1ddvbt/GKOY6i5BTyHZ+jAvO5n6iLnRWiCZOoyl137R9XIWXghcQQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Bt7xt5ll; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Bt7xt5ll
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7822E60837
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 13:08:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34256602D0;
 Wed, 16 Sep 2026 13:08:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1DB1F00898;
 Wed, 16 Sep 2026 13:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789564122;
 bh=+Y5kA1pp9Xo5m9OKvmsrUgATLxAg0vALJGk4G9J2V9s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Bt7xt5lllxaiKv/9PCjO9LXNOjaNMM86V27JA+z3A54F9tX+1Rm+/ksMxCxXxtTL0
 t5ojtB4yQvh/hHAGb5wO4zotggZBzulriIflhdifOX+HrraqDJ4Ch0M4jiEJOQDbbX
 jfiFK1KCkoWJtlbfoN6CT4s6D2hjq7wKEB09tw6waqeEIhTXLuauPRvZg6GRSCTUI9
 0xT6AtX+hc0n7t/mlA7QKcboYp1szbBzKKJdz1eatAaG7Ts/PLL4RPLGwZkPPdWKZ+
 JmPHmo5xqSnRnra+cfYaV66LwcVB3aE8s8p4taZ1DI5pNU/pjtdjEIzhHt+E+BJV4A
 HADfeyGVG0ABw==
Date: Wed, 16 Sep 2026 14:08:38 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jakub Staniszewski <jakub.staniszewski@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix FDB deletion
Message-ID: <20260916130838.GI51261@horms.kernel.org>
References: <20260915125519.3975583-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915125519.3975583-1-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:19PM +0200, Aleksandr Loktionov wrote:
> From: Jakub Staniszewski <jakub.staniszewski@intel.com>
> 
> Correct the logic in ndo_fdb_del() to align with other drivers in
> upstream. The condition was inverted — it was rejecting permanent
> (NUD_PERMANENT) MAC addresses while allowing non-permanent ones to be
> deleted, which is the opposite of the intended behavior.
> 
> The correct logic is to reject deletion of non-permanent entries,
> mirroring the fix applied to ndo_dflt_fdb_del() in commit 645359930231
> ("rtnetlink: Fix inverted check in ndo_dflt_fdb_del()").
> 
> Also add is_link_local_ether_addr() to the unicast branch of
> ice_fdb_del() to mirror ice_fdb_add(), which already handles link-local
> addresses as unicast via dev_uc_add_excl(). Without this, a link-local
> address added via ice_fdb_add() would fall through to dev_mc_del() on
> deletion and fail to be removed.
> 
> Fixes: e94d4478669357cd ("ice: Implement filter sync, NDO operations and bump version")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

