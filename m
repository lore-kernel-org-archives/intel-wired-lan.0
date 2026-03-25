Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A89FEA803
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 03:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 803AB413EE;
	Wed, 25 Mar 2026 03:44:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3oy6t-aDUlHQ; Wed, 25 Mar 2026 03:44:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE9F5413D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774410286;
	bh=8qGfWg8X4KJtLew92ZFxzyzGqOExS2eUNwPHfxuPVJ4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0AR45BCtH9ODsteJjTNrXto7OMWk+p2PzD6yvTuycsqzpydHnFoVPevbJ/LRKjry0
	 UwPkVGq7Yl7CIu/XvVY+HZ51kp4eXY7dZ3O3XhzfibgjWWkfk+xo0imFEvZXOGsoJK
	 U7uxp6fCQJSoYeSC0GpoU2XDx1BhAhH/Xlz3uHxIHJYFcY55yqMpcyHE/OQSFviLEG
	 tnnhMt9hjwYJ414OvpF1KWKyOj6CncJBfdMJXAShOHI3whxBKKun04JvXUOPMdczfh
	 Pn4qyNvrY2GZ0z64MWKOw1+683OWBVIFkrC1HV2NSGjNzCmMHOk7+TlNVDEAGGPZY4
	 CghUOiad706yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE9F5413D6;
	Wed, 25 Mar 2026 03:44:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6B63F4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 03:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A41DC413D6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 03:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7ZVFxL8be6j6 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 03:44:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EFD23413C6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EFD23413C6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EFD23413C6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 03:44:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 127D360120;
 Wed, 25 Mar 2026 03:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B295C2BCB0;
 Wed, 25 Mar 2026 03:44:41 +0000 (UTC)
Date: Tue, 24 Mar 2026 20:44:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, alexanderduyck@fb.com, kernel-team@meta.com,
 johannes@sipsolutions.net, sd@queasysnail.net, jianbol@nvidia.com,
 dtatulea@nvidia.com, mohsin.bashr@gmail.com, jacob.e.keller@intel.com,
 willemb@google.com, skhawaja@google.com, bestswngs@gmail.com,
 aleksandr.loktionov@intel.com, kees@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon@kernel.org
Message-ID: <20260324204440.1752423d@kernel.org>
In-Reply-To: <acMU93XN02PHmAGi@mini-arch>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-4-sdf@fomichev.me>
 <20260323162003.0d155055@kernel.org> <acLUMN1BYkIVyOk8@mini-arch>
 <20260324142114.216fcb01@kernel.org> <acMU93XN02PHmAGi@mini-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774410282;
 bh=gQK6J5IvA9RmrkZN+cbxNmFla6H107ZP9bVcDvKPjRY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ZH5/BwS61g4MXioBvBtBh9BzuX2edP0Y5CNv8b7utbnLqKrt2Ig6FM1yb4aKlGtut
 H9/iJjjgJUKN+oYGIXfB106Cm4tMLptjuvkKcjmmeeMgI06minn5KC9OivyKstv8T/
 56u8jKtsopr7dN1CmbeRk9mGks61tQx6DNAZsG5vhWfD6vFFf5rPA0Fzb4+VxiSRwm
 ebUMaIeNpkbK7NRte7tgB1IjAyHiLu6z0CD/MOcfr0zRTopQ3iPJIaPkBeanBVXmTp
 /ahpZBDlBOHnGZrr7ICiuCAc6N7vajPt0ed93vZyxXubarOU6YqqqFSmQUkL6GJ0+A
 t4pIxs1A5yedg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZH5/BwS6
Subject: Re: [Intel-wired-lan] [PATCH net-next v3 03/13] net: introduce
 ndo_set_rx_mode_async and dev_rx_mode_work
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 24 Mar 2026 15:49:27 -0700 Stanislav Fomichev wrote:
> > > Not sure why cancel+release, maybe you're thinking about the unregister
> > > path? This is rtnl_unlock -> netdev_run_todo -> __rtnl_unlock + some
> > > extras.
> > > 
> > > And the flush is here to plumb the addresses to the real devices
> > > before we return to the callers. Mostly because of the following
> > > things we have in the tests:
> > > 
> > > # TEST: team cleanup mode lacp                                        [FAIL]
> > > #       macvlan unicast address not found on a slave
> > > 
> > > Can you explain a bit more on the suggestion?  
> > 
> > Oh, I thought it's here for unregister! Feels like it'd be cleaner to
> > add the flush in dev_*c_add() and friends? How hard would it be to
> > identify the callers in atomic context?  
> 
> Not sure we can do it in dev_xc_add because it runs under rtnl :-(
> I currently do flush in netdev_run_todo because that's the place that
> doesn't hold rtnl. Otherwise flush will get stuck because the work
> handler grabs it...

I was thinking of something a'la linkwatch. We can "steal" / "flush"
the pending work inline. I guess linkwatch is a major source of races
over the years...

Does the macvlan + team problem still happens with the current
implementation minus the flush? We are only flushing once so only
pushing the addresses thru one layer of async callbacks.
