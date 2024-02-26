Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5105BC48BF6
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Feb 2024 13:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0029981F5A;
	Mon, 26 Feb 2024 13:33:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WYqCUq8k_nWh; Mon, 26 Feb 2024 13:33:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7418D81F75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1708954424;
	bh=b/OyXbcxfoXujip/lMu1PP3/Dg+snYbFZ5e/M1ZojoI=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=lHBr10SR+1mJ0Wj0Z7O94Hwxe6jzq7WeMnMbywUoTLzD+vaPVUKqe7GmF6NCmIAYd
	 5v+UbX5a8UEUE1/+lymNH9YhnJS7fD1GaorYuttIwGcEGuOoREH7H+IcEU5fSKg7TE
	 WP5eHcMZ2NTcJWPG3r40EfePufKcBjTBtuvhtU2lZwTI5uQz51Ejg0/QFuuDje3Rbl
	 jXC9MkjG9gVU/AknJn2Q6kEIwtJnj9iLTauYZ5tv/YvLhVs4J2O3yCKN6ohjsJ/Xf3
	 mDPyJJXoes/haJISlryWkwlLTd4Elvr0P3SyzD+tniEcxIJPRcEuuP7mispBvZum+f
	 L8rtKxjqjpMKw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7418D81F75;
	Mon, 26 Feb 2024 13:33:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 363821BF31C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Feb 2024 13:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2FDCF60ACC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Feb 2024 13:33:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V5cJCbDaO7c7 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Feb 2024 13:33:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 915E260A9C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 915E260A9C
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 915E260A9C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Feb 2024 13:33:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AAFED611B7;
 Mon, 26 Feb 2024 13:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14A3C433F1;
 Mon, 26 Feb 2024 13:33:38 +0000 (UTC)
Date: Mon, 26 Feb 2024 13:33:34 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240226133334.GC13129@kernel.org>
References: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
 <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222123956.2393-3-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1708954421;
 bh=3F3a2hjfNgnWwI7UM4NM18GlspXcpUia5Ij1lXCE6KA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tMnbHomak7nJGPkaweH+wRQekJ0YztQyRn3bODQ+JK6lV7pFOMI2AY2mlu2OmRe1d
 UZSmwsY8TwecieNXXTIad6NxJIduyB9Dj0cgDUgHnq3DeFJhP1skHatb6v3hFWRW/z
 Aq3Oz5iTuPZ4PlPbljMkhSFL97+GAqOyou+ynsID1jlrNq/thSo7FQawnwVr1+4GlY
 e16AKuUZn1uDooAYmMi3m/73yDuQZU8oIOx4wowxOSdm4h7sWcKG3BDTb+98FFss2+
 4qOab1OcmgIYrH/wbPur4TnpZd8C15WXYksBsDmGPI6O5rPneJYX0B4/+XMp4KM9rP
 iRlOp/ERslp1g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tMnbHoma
Subject: Re: [Intel-wired-lan] [iwl-next v2 2/2] ice: tc: allow ip_proto
 matching
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
Cc: pmenzel@molgen.mpg.de, wojciech.drewek@intel.com, marcin.szycik@intel.com,
 netdev@vger.kernel.org, Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 intel-wired-lan@lists.osuosl.org, sridhar.samudrala@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Feb 22, 2024 at 01:39:56PM +0100, Michal Swiatkowski wrote:
> Add new matching type for ip_proto.
> 
> Use it in the same lookup type as for TTL. In hardware it has the same
> protocol ID, but different offset.
> 
> Example command to add filter with ip_proto:
> $tc filter add dev eth10 ingress protocol ip flower ip_proto icmp \
>  skip_sw action mirred egress redirect dev eth0
> 
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

