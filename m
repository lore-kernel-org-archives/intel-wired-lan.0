Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7018C4167D
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Dec 2023 18:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C5F481842;
	Tue, 12 Dec 2023 18:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C5F481842
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702404971;
	bh=iIC9GwQso2pCL+waaJHGudgMXHYW3qWUlAjcN4HBmEE=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=BGxEXh1d0rmg9+EQJQWjqflWYfixpf81Sep9ocgIP3CtKe/bJX1MmC8np+G9HCt5N
	 NvZSffS7dM8DkzjaI9ksaUxamkXYIf4MmZCZdBvRnwsV9obZnTJZavQnZP1XJ66JuK
	 7LRktnys1zBntgxN9/XmtBfFGWHQ8ivvx3CIdDLKmS1642ZBxNHjXTBuHKxbS+fiDf
	 W+2URf8A6mMJ8SlbW9q1HJCxgoSVodmVK5OZL157shj9CFuTTJHa2iZ6py0qCLER0m
	 BpiLp3GdULwy3V0QVW4NUjShOztPOJc10etU1n+jgCidzFW22o5rCgI8gBk4CrA5Hg
	 XHgNjakNpggwQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rFGEYZQwa0Of; Tue, 12 Dec 2023 18:16:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48E8B81801;
	Tue, 12 Dec 2023 18:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48E8B81801
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 21BBB1BF3D2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 18:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECD1860AC0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 18:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECD1860AC0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id da2X-nYy5s22 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Dec 2023 18:16:07 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A566C607C1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 18:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A566C607C1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E5D1F61877;
 Tue, 12 Dec 2023 18:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2F8C433C7;
 Tue, 12 Dec 2023 18:16:05 +0000 (UTC)
Date: Tue, 12 Dec 2023 10:16:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20231212101605.766fbbcc@kernel.org>
In-Reply-To: <20231212142752.935000-1-aleksander.lobakin@intel.com>
References: <20231212142752.935000-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702404966;
 bh=55v2YEAEajqeqknulyuWsJXXATDMpGT7WsJUIr0GI/E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cKwKGBqs/hXYX/mV4mPQ1ZwkgUJrnnfWNcTPTyuiWBMJ/leiYEQSgENKdG3sfmvuE
 bSxth5b7ltOcRFcXTlP8+X9n+jOnsalASL5N2T8+CKUnwMTofd6ykO/MA3iEjkEH1I
 vyEo/J55wTxQRcgS8Z26G14QuLjkeJL/++nkTRr5TV82egehIoXsWMvKeHxZW1Xyid
 HlrXsxTNt0sQBUanT+A3LL7p35sHXf4ZvAD3mpjk4w5JT0X9ECdORpdYkQ6uqWc+hj
 S+MdnAXBQoDEF/jxjxTWyYFWDxeb6TrrrvUcE3mDsEqhmpugczKoOVcl1o+k1jfZrz
 hwp9ZTajSJYBA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cKwKGBqs
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/2] idpf: add get/set for
 Ethtool's header split ringparam
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
Cc: Michal Kubecek <mkubecek@suse.cz>, Andrew Lunn <andrew@lunn.ch>,
 Jiri Pirko <jiri@resnulli.us>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Michal Kubiak <michal.kubiak@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 12 Dec 2023 15:27:50 +0100 Alexander Lobakin wrote:
> Currently, the header split feature (putting headers in one smaller
> buffer and then the data in a separate bigger one) is always enabled
> in idpf when supported.
> One may want to not have fragmented frames per each packet, for example,
> to avoid XDP frags. To better optimize setups for particular workloads,
> add ability to switch the header split state on and off via Ethtool's
> ringparams, as well as to query the current status.
> There's currently only GET in the Ethtool Netlink interface for now,
> so add SET first. I suspect idpf is not the only one supporting this.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
