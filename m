Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D632606A323
	for <intel-wired-lan@archiver.kernel.org>; Sun,  8 Nov 2026 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gdxb/Ljf;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4+6hr11
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27C8A60675;
	Sun,  8 Nov 2026 17:25:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IbzCbiee9a4s; Sun,  8 Nov 2026 17:25:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8BC4160699
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794158712;
	b=ogctu8RrTv6Qu6We1dEbYs59XvG05NNpaJr4sYtR21Rtj89P/k3PkGfZQ7T0xWuUDW5z
	 UTP8T4+BUvcCYyCNfBa/txPWEOIIkq3gyqxFgzUuylZFWRHIBjeVfZTLUfktFnemNMY+g
	 xoR9Yq9G7q27USAqzDKEPT6hE4pD76gMuJHRTt4+dm1oejemwSJDTH1Vxfzlck7Q1FOd0
	 pmeB3sY6xZZw5slzFd5h6fAc14dc85/HyRc3pZHXAG+PG9aj5muTwAi2gIA0+H+925y2j
	 gR6ys6NwemSK+XpbsGeRtR9CSUQnSG4dXkFbHaxyi9FoSW7OPnggfP0aC9hkJG9xrqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794158712;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=a9BmaB1EJPYoiOj3efcL7rpt7e9jF03SzioViwlwS24=;
	b=UwWhWh5y0oIEoNo2afY3tIMhbtnMl2RtioUP5BqHHOX/gfHAs90JUmCRzGo+V0nxpkbG
	 uDduQTHZaYeyKi1IFmeRFfjXmYJqjb3MsqztLzsmAT33x23y5dCzQswLu67+CRfTP6GJ9
	 XAMXIX6FfxWe9RVm+xzVc1vGJ5uFqstzzyFhQYUww+w7dwDVRqb2UnOs0ac7k+yyM7I7d
	 6iR38Jyd16/Bjuzr+paCMt9tDjZKtt44gf9Oqfvvzy1YBM+V4FS6ZhqTbtpr9fVkvTC4A
	 gIIU4N1DVEH1BSK2HPAafqjf5NnHO8n81yeEUu5U15QrzGrq/gfNBg+OSXQWIJXpGwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794158712;
	bh=a9BmaB1EJPYoiOj3efcL7rpt7e9jF03SzioViwlwS24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gdxb/Ljfu6gySCpOkZiHK5R2HfZWc+6JtQ2IghRO7O6xYfbK2lDnsqN7zsnMjt+vA
	 yDKBE5GUydNGE9JnwdABNo/+WLQs0BAX6T21+LG0iw7jehBuQDOKFiesLjSPCuJ8dM
	 6mCkRQj1mdtrT9gud/8YzywjsobK62VUlvgiUlbOB0PJAwC6SZPU050afBP0GnQKLN
	 FydxOm7KX/YgVeuSo62oij6MexYSLIbUdfAr/0zaP8nJh4f6Kt/LC8zworWocImo8D
	 nW2UegZMJmaE7baY0/o+5gE15oQbVOrTKrQzDeNVf90e2X3zV/9+2b7tcishltoKhl
	 D9tIk5EaxGhQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BC4160699;
	Sun,  8 Nov 2026 17:25:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 15F5F9D1
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 17:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 075BC80E33
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 17:25:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VXe6PzTRb7do for <intel-wired-lan@lists.osuosl.org>;
 Sun,  8 Nov 2026 17:25:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4BEC980DDD
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=a4+6hr11
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BEC980DDD
 for <intel-wired-lan@lists.osuosl.org>; Sun,  8 Nov 2026 17:25:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0FA841A6F;
 Sun,  8 Nov 2026 17:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD71F0089F;
 Sun,  8 Nov 2026 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794158708;
 bh=a9BmaB1EJPYoiOj3efcL7rpt7e9jF03SzioViwlwS24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a4+6hr11zxzaXk/87oSBanVR5Ij+H4hcZj9K75Zb41mVoRWL8jZWzndQ0SVY0+G0O
 O5UkvoFMnmfL3tNka6df5RB0Vtg2ZJ4oB+zo+C5XvvkJh1na9BDvq5jwGLHYQwHNZn
 UHmzfg3N5YXU1BgPvdktrVDaZbRW6KqeNF5sb/GSGQLMp4rSGQFVl3zEKPk4ymb+fn
 nR2PjmOapU5qdH7Wg2xPXzGwfJUtfzFPlUQ5UMKi70xB5hLDz5YXvXuVCGnN2QR9zm
 pph19OHBCCmR3+JZlb/afLcLZypLwc/NiZ8MhvzXmS+bd48gD8Jsr7UrGhe9NzKmoJ
 KJROYU3B7mACg==
Date: Sun, 8 Nov 2026 17:25:04 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Message-ID: <20261108172504.GH18859@horms.kernel.org>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
 <179405014554.994134.10719290719575125531@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179405014554.994134.10719290719575125531@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 07, 2026 at 11:15:45AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] This patch fixes the SA reference leak in only one of the two
>   copies of this Rx code.

I lean towards this being a pre-existing issue that can be handled
separately from this patch. But I do note that taken at face-value
it severely impacts the reliability of the  teardown path and the
usefulness of this patch in practice.

> 
> Pre-existing issues:
> - [High] ixgbe_ipsec_del_sa() unlinks the rx_sa from the RCU hash table
>   with hash_del_rcu(&rsa->hlist) (line 783) and then zeroes the same…
> - [High] ixgbe_ipsec_find_rx_state() finds rsa->xs only under
>   rcu_read_lock() and takes its reference with xfrm_state_hold(), which…
> 
> --

...
