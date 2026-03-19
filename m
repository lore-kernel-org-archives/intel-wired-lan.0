Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F31109024D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Mar 2026 16:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BBEA615CA;
	Thu, 19 Mar 2026 16:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Si-2beG8-zhD; Thu, 19 Mar 2026 16:11:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9B9760832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773936708;
	bh=+uJV5Xe7gQWTCMHG6+xbB/d+8dWxbGlHK1aQ15M8eP4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e7jc0lvj72jN/atxg+reTmP3EcbSj72RMfdkxXBe5MiC5GwkCpazK5se4ymBtpDw/
	 dfUyd0/oEBJCa2lYxwAHbLDIBd+GsitQo++ikLMXNc2VF+Q98INCQaKpNHqChziD2w
	 u9KXsTAn+4nwlmcAKtLF05Arlld4PcN8/Pi2sdE0TDbIFUcGvo9Tc5uG173XZE4AkT
	 f1UwnDfjxYP3AK4OJ6jsDQAtIsOotRXlymZYSeOo2v2VQiVJldeWpkbYpJ8bImVCP2
	 vmm+UXrcdtfvItK+84wEYFPsqR0N+6/m8bNpv8/07AMFfS193HeRzUiMP1oKkM+tVN
	 LSR+Wbw2AgMug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9B9760832;
	Thu, 19 Mar 2026 16:11:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D2F751B6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 16:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4C0681100
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 16:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qayu0bs-hcVF for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Mar 2026 16:11:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 022C6810F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 022C6810F6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 022C6810F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Mar 2026 16:11:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id ADCAD60103;
 Thu, 19 Mar 2026 16:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11518C19425;
 Thu, 19 Mar 2026 16:11:42 +0000 (UTC)
Date: Thu, 19 Mar 2026 16:11:40 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 dima.ruinskiy@intel.com, kohei.enju@gmail.com
Message-ID: <20260319161140.GI1753385@horms.kernel.org>
References: <20260317062205.39406-1-kohei@enjuk.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317062205.39406-1-kohei@enjuk.jp>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1773936705;
 bh=DmPtrmZY6UcsDvB3lw9MrBjgn6B96H+aMlBoOISwdEI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VfTAj4VQUuTajDs54uw7NsY40deWRP7gKiPAG14A3wTcb5vY79zkKzFkhQkGwMkqb
 g098++lNB5X9KnjanuQgbjw4iZ1k4XquOytTb4IIWbKXiFlsFpQoRr6dEfXMEfbmEd
 m0OgOoQQRFD+DaLGVGT6bC0IxNT9FmEBxvYzbVxmnyfZisj9sLCv99Ysj2FHs0Zp2z
 G/02SxM1z6HMcUt5PVh7Xx8+gGeGqT752pHG9b77lsk3TmX/mHepb/g5UhqcOyj0VA
 pfnR75ffzo7nEaLkczuSUDn+UbAesFOL1gGzKIzqzexLWP9ZW3O6YoNssLtCgafK/s
 ZFAvWgHSwmywA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=VfTAj4VQ
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 0/2] igc: enable build_skb
 path
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

On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
> This series enables the build_skb RX path in igc, which is currently not
> enabled in any configuration.
> 
> Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> path.
> Patch 2/2 enables the build_skb path when XDP is inactive and other
> conditions are met.
> 
> Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> 
> Changes:
>   v2:
>     - don't insist on reverse christmas tree, reducing net diff in the
>       patch 1/2 (Dima)
>   v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> 
> Kohei Enju (2):
>   igc: set RX hardware timestamps in igc_build_skb()
>   igc: enable build_skb on the non-XDP small-frame RX path

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>
