Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B586CA6016
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD4B640911;
	Thu,  8 Oct 2026 21:11:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cD-2Mqn6DLr8; Thu,  8 Oct 2026 21:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3960040923
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493897;
	b=VecYt9y/k3//vULi5sE0P9n35+36nEBbKlo83Ss5u2H5sPwJhPyjN85AevBlfWqA2aKu
	 YINvdAeNlXMpXymIqgbJS06d/i4+o5vhxkgGskRBv96p2jk/zGfBGUGfOADMCBmv/uAMt
	 wRqfX1R+KbfIFZPtZMdQaJyVm+/eEUZGhK8aERHUTzS8vNuzojrnpXpDaLk+VEBnRap3l
	 oF8haNvhBS2hjoWma/QgRRdjUnq9CktLpUWQHhBw00C9vQANSaC2iYqVHkTk2vjFy5dnI
	 tP65ESGiZDGdbvUJoQZbo+So7fp9emodNIHXrBh6C5CWEIKsq3lVHSMkA2nGxVFUirw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493897;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lO9Q2e8Y8FPOsNAN94Y+ZK3KJEQqlWXugM2M+fiTfDI=;
	b=hE/pwxtg0nBgEhTa36LOFL38iHsruLmZE1VRs5sdsnTRI8i6rjr27qSIdg6LKoVNDbFp
	 Ywi6IJ8fDv+xIZK+RdsfiYYC5uwSLocE+TTZv5teEV2yX4/v8pIa5Ky/w4YVY3jqdfgv+
	 R24eIK9cEsFwp2TUdNW+iPimMSBHAbCQq21eWkkLyCQPbPTW4jxFw9NBKR5WrNzK5LFOX
	 Xezv1Fn0D/kqsOYcmU0Q9az5RQylJjyYO0QsUuSxOBIq3Wpc28d1aFBMexQaqQxmd2bKr
	 h+YGLT6RhMCKANt51UtRqoOjy5johwJ8ZmTqlHUk2EJwXdgGhF3FPgsC+nRJTdSJ0FA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493897;
	bh=lO9Q2e8Y8FPOsNAN94Y+ZK3KJEQqlWXugM2M+fiTfDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xnvzdFCwSDzRzRSUElgxwxeuVdGOdT2VfU1562Gj9WlFarri95BPdnv3pBzapvNwH
	 v8Imoiyr8WIpnojUMVB27QBONMtGlmQQAJJNYmhbToyGXFkecCkgnx2Hg5ehuFCiPW
	 6IwKbJOsg2T+qK97yHX0ye+VKQGHsoeUY8L7Q/3nund+NCaxbHqBgpYL1SQb1lH1n5
	 ry77MOp3nAooAGpUt1IC53dXT2xKE6i+1ZQzZDkS5fsJ1f1P3GdPTbktzyfgVr070v
	 CJGgVqBa85VSko6D2fx8KXRMcb68Hl+8MSxdqyY3aCLsOoUGGH/hbkHc3b1mvF/PcK
	 fwRFqNSqwfcgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3960040923;
	Thu,  8 Oct 2026 21:11:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E39562B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D531881329
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:11:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pc6ZB3Ve5RtG for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:11:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3B4AC812FE
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493894;
 b=ZgO+4Q/rISuEAZCefxlx0wp/8jTpzYH2iceXaARSnwxeZJekGyH8dYZFGxbd+gRlHOGw
 fnGPrUTS8l+h99D3YuuXlxUxw9QxhQVXxQk7wOpyNA/x7q8+8S7nmM7aUpQfAvCnu44+e
 JKl7Vhyg3emx1wjy2stYEaa87bFixO5vEwJ8A/jlNizaYznD0FQs5b+ZNBJYYwdp7dwPJ
 TGwF7h+lf8gmEmmRmi7Nxwyu7OKlI1IcqPjoLXx60tE+GnK/HviKYtPW1tQXHWnlsHgfd
 0gKaIEWuMFBew88IseSmNKmHjeE0lsSI8APmQq4Q/OHpbuT1h2M4U3EdG03PRRGmdLw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493894;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=lO9Q2e8Y8FPOsNAN94Y+ZK3KJEQqlWXugM2M+fiTfDI=;
 b=WgntF3NhyOBCa31B6UTgrvjm+18jsfpFu2dgnBBzD39Kk7oqhEePMt1GSoSHGuFTcuLM
 VVd6tlBakFL/pzd98j8ID6oD6/nlymX7nPaJWGgqN21mvEuzZSwM11xCfmBHvPAlQ3dI4
 H0+WgRd8nOfmFKOkIQlrbcvdN4J4jgl+6/5ukj2Ex8XSNChNz+XbtydwAxW6bQzwBZsgv
 FqWxOp/ktfaadOsUhc5kjoYrJ+kZ+qOnmNo6mFhlpdvcJKDJ0aD4X+187ShKB/dvr3k7n
 Y3wC4wk+mVvGF4bFy7yv4K9jr+T6869TMM9GWLs5WPssaNZBmymZ7vrF1XpuAUS75Bg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S706qOQl; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S706qOQl
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3B4AC812FE
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:11:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9CAC42D5E;
 Thu,  8 Oct 2026 21:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0CF1F000FF;
 Thu,  8 Oct 2026 21:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791493892;
 bh=lO9Q2e8Y8FPOsNAN94Y+ZK3KJEQqlWXugM2M+fiTfDI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=S706qOQl1KAdCZOgdDVMYgOE4hYOCFoLj0OyQ4qoN9BspPLdeodADinWXSjmhRHPm
 YK6++L4AqfMMStuF3wzAtgh6ofzYLZyTuNkxuyHRftbWxys9dfl71hAL2ADlumB2j4
 Tlf+AacXZTvAllcV36WUE+Y/a0IFDRwSp+VV1bOhp608vbuhGe4I50uG/6bjXTuRbU
 MgtwPQ9PON+9mJdWcdYRCA/L+ckiTY+6L5j/raZg/L3j8/d3+Hj0xoxEow7kB5Iox5
 crTPl9+UhAUBLNXTGVR130JjQDVJHP9OplaEfsJcnRyehfe3Di3kCPBvhOprydKfRb
 IRpNlHZe0yUqQ==
Date: Thu, 8 Oct 2026 14:11:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Manish Chopra
 <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v2 00/10] net: stop calling __pskb_pull_tail()
 from drivers
Message-ID: <20261008141131.0ac356dd@kernel.org>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 08 Oct 2026 21:02:47 +0000 Josef Bacik wrote:
> v1->v2:
> - New 1/10: skb_drop_empty_frags(). xen-netfront, netxen and qlcnic
>   relied on __pskb_pull_tail() releasing zero-length frags even when
>   there's nothing to pull, which pskb_may_pull() doesn't do (Sashiko).
> - xen-netfront, netxen, qlcnic: call skb_drop_empty_frags() after
>   pskb_may_pull().
> - skb_drop_empty_frags() checked with a boot-time test under KASAN and
>   kmemleak, on cloned and uncloned skbs.

Please keep in mind that we ask people to limit themselves to 15
outstanding patches per tree. You have 18 right now.
(200 active netdev contributors + an LLM) x 20 patches == insanity :/
