Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C29C47258
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 Jan 2024 11:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8BA18400FC;
	Thu, 25 Jan 2024 11:07:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BA18400FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706180875;
	bh=dErJIlU0i24tc1Kan8yh5cAvfFDS97y0aS0daApABwY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=j/A7m0PvoYjX/Tdhvi5x6Zdzem3Uek1zQyQh47cBKwRpITtOQYr88QigqVrbTN5sM
	 7Nmgl7/6lwJ0OzL3ijIkZT4u2dFkeNn1Hi3vtT0XTdOJuPSvYEqRKQhlnTgGnDdbFR
	 TCcGT2phoEeepoGkx6WVcV+Xs4C+nL3uGs7XcCy5ewuAg1m2A9/nODVRzwJh6KT1G/
	 18Ye2ZemitrN5BBCQ+toeumYO+rn14A9IfQUQlbMrfmbulirGyhlnmP1f2Amhnt7Ql
	 ZagngKmFo9sGLkI70TvPInA9oWgcZA2cW6vYL/NS3UVGY6l+ZAvxKdHhh8z+dpLJqL
	 aslzT8MOrpCLA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kZ41EWxMgREB; Thu, 25 Jan 2024 11:07:55 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id D091E400D7;
	Thu, 25 Jan 2024 11:07:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D091E400D7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 8C4621BF39A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E3C24012F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:07:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E3C24012F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ibVAxbBwau8W for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 Jan 2024 11:07:52 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFEBA400C4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 Jan 2024 11:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFEBA400C4
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4E7CFCE32A6;
 Thu, 25 Jan 2024 11:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E9EC433F1;
 Thu, 25 Jan 2024 11:07:44 +0000 (UTC)
Date: Thu, 25 Jan 2024 11:07:41 +0000
From: Simon Horman <horms@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Message-ID: <20240125110741.GE217708@kernel.org>
References: <20240123111849.9367-1-wojciech.drewek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123111849.9367-1-wojciech.drewek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706180865;
 bh=aYYCJudU8yAUgkMyhB1YwN2Sg7x602RYmD/3GTG+plA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pC33db9xAAvNYuBouA84sGa2BAY23nEQ2wCPOlhGs2/nc4PqxRaufVBH7n5noAnsY
 jnYeqjCKVWODNd83CoyWUM9qYJ3poP1F2G7XxprkXa+qExe5JtwJ7u4LrOZWGEVELr
 fXX7z83WvvTiwXjbZGuwIhwOa5HSb346qLCZ57yYPuZf/kRRvY38Vx2tH35bL2N17m
 Q180MYgkv1UJ+hAM1mZSkebsCOKDLnt4q5lAa9mKII7eR4FxU1bbc/t+90OmkxsE/m
 QCXAkH4W5HeVwyliIeRcPo+X1xoCQTb9JC9vUdV6yIpBPTvHi3aA2zO/bOk8JCsNW7
 +xtpvHWkiQ6HA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=pC33db9x
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Remove and readd netdev
 during devlink reload
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: jiri@resnulli.us, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jan 23, 2024 at 12:18:49PM +0100, Wojciech Drewek wrote:
> Recent changes to the devlink reload (commit 9b2348e2d6c9
> ("devlink: warn about existing entities during reload-reinit"))
> force the drivers to destroy devlink ports during reinit.
> Adjust ice driver to this requirement, unregister netdvice, destroy
> devlink port. ice_init_eth() was removed and all the common code
> between probe and reload was moved to ice_load().
> 
> During devlink reload we can't take devl_lock (it's already taken)
> and in ice_probe() we have to lock it. Use devl_* variant of the API
> which does not acquire and release devl_lock. Guard ice_load()
> with devl_lock only in case of probe.
> 
> Introduce ice_debugfs_fwlog_deinit() in order to release PF's
> debugfs entries. Move ice_debugfs_exit() call to ice_module_exit().
> 
> Suggested-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

