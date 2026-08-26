Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA98C5DF97
	for <intel-wired-lan@archiver.kernel.org>; Wed, 26 Aug 2026 20:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09CF940707;
	Wed, 26 Aug 2026 20:58:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fuRwc3zjE758; Wed, 26 Aug 2026 20:58:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787777890;
	bh=6BSYdpEPt01McAnG4u8lln5Yld57nZzWrLhCayqxD+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OCsbaW9O7ixXAfwPjkA1nnHW7ssEyJZSh0PJ8bEmhoFjk+w/RjU2N+5V/CJc5xhPw
	 zhgzDP0ClDFlnt26ATKahkrKtN7hiZOkDuh3l8bHjRbtAaBrObuK2eRQOA4gqZ4pz8
	 s3GhhQVHUBkPNJEoav8LZMR4IwrLSvxwldxQq6xpgfRdCgrRAFd4KMvJoGaJAe+eq2
	 ot+WMCwCzvvpvQKKPubxJ+IwIOzI7R25XFD7HhTR7s+C0+dyekvNOlpxn1UDJgiBGz
	 XmoQcjn2VXbcImLBKkBqwMBe3Xyc9z3O8lVaNiSHQlLdixvS9Ksabn0K6Tizgrt+wI
	 HvrAEZNFNW9Yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6673406C5;
	Wed, 26 Aug 2026 20:58:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D6BC529B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 20:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9137606BE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 20:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fr6TrP-qp3-z for <intel-wired-lan@lists.osuosl.org>;
 Wed, 26 Aug 2026 20:58:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.67.10.101;
 helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=Gk++gNb7
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B236760649
 for <intel-wired-lan@lists.osuosl.org>; Wed, 26 Aug 2026 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=6BSYdpEPt01McAnG4u8lln5Yld57nZzWrLhCayqxD+0=; b=Gk++gNb7sGZR1YerBxsUPWVOAv
 UOLsd1KSFlgVFGFo/4Dm7AT9R5ueV3ELForjXbWCOik5M3t7GhBzcbhrDpk6H5obJIo838smYoKG9
 390FgaW/u4wyOhISwb+DP4JolTFF9jLWkY8P5JQLIqmEqKIli3ytdmFt7jXYDAAzgGfQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1wzKgm-001Zg2-1Q; Wed, 26 Aug 2026 22:57:40 +0200
Date: Wed, 26 Aug 2026 22:57:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org,
 magnus.karlsson@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 guoren@kernel.org, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 linux-csky@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH net v3 3/3] net: stmmac: document oversized AF_XDP frame
 handling
Message-ID: <0c17200b-105b-463a-8677-45f575c294f0@lunn.ch>
References: <20260819160535.1472459-1-sdf@fomichev.me>
 <20260819160535.1472459-4-sdf@fomichev.me> <aoceSoSFMx69Z9up@boxer>
 <aoeoJ6-njBxcWs4w@devvm7509.cco0.facebook.com>
 <aogpDsa8hz6CPpD3@boxer>
 <aoiIarzdjk92RkCN@devvm7509.cco0.facebook.com>
 <20260824111443.34bffe04@kernel.org>
 <dc2ccb14-c7c0-402b-93b3-afba52df78fa@bootlin.com>
 <20260826132043.39fb435a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826132043.39fb435a@kernel.org>
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

> Also if you try running driver ksfts - please keep us posted on what
> the blockers are. I _think_ we just need to teach ksft to cross compile
> C binaries?

It would be nice to make it not give out 1000s of warnings on 32 bit
builds. At least that is my experience doing a native ARM 32 bit
build.

	Andrew
