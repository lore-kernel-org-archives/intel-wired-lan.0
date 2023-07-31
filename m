Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65BBC001E0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Jul 2023 15:16:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83F426106F;
	Mon, 31 Jul 2023 15:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83F426106F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690816579;
	bh=dQEkEa12gg/3x7NWada5iC6ZhRTDWW7dSfwX/tG+idE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qqZ/WBS1P/Der09c5YmdNSBwlTl37Qp6ccWIMZOTKJpYO3myz0pXeKPGBPylymfBI
	 UOfK3oVm9Cmw3kJEY+DAWhk4v+NMgc2v7teFuvFEdlWiaJQQ56XKXn8LvaMc0UkXUe
	 vyhWqclmRPXfs8RNVfNMJAQrdXoja+WJlSBs1GA64iv6ecmVUAqNoXC8O8Ydc5S7oc
	 Axh76TTrO3RgyzPPwtnwE7W/yAa3S+wgSlYTjo8oHMvzhUzEYUBvPKfdCGY7JzP24b
	 g1cLqA4aUrlTtso7b0BtNUKucjcXYa7Vahwq/OdlQBbRC2rd8SBOsq13LFqGb/4B0V
	 ihAePzhUJU4FQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t4dOZOFNvpAl; Mon, 31 Jul 2023 15:16:18 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 81E866108D;
	Mon, 31 Jul 2023 15:16:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81E866108D
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id BA85E1BF3A6
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 07:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 91D9A400A4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 07:16:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91D9A400A4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqpFd3nAAXaD for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Jul 2023 07:16:38 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B856740298
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Jul 2023 07:16:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B856740298
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9390260ED3;
 Mon, 31 Jul 2023 07:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38C0C433C7;
 Mon, 31 Jul 2023 07:16:32 +0000 (UTC)
Date: Mon, 31 Jul 2023 09:16:30 +0200
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Message-ID: <ZMdfznpH44i34QNw@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230726080522.1064569-1-linma@zju.edu.cn>
X-Mailman-Approved-At: Mon, 31 Jul 2023 15:16:02 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1690787797;
 bh=Kbl3vl8F9PAkSdvmheeUSu12turbgGYFzXBz/7n21cE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=me8WSfKgL7EuiAQCQk2k/wnTmUfKNmqXGsSpWG+gwMjoqU2XRNroqffRh+zTdKxd8
 oirX0a+WPlMLaE2hG+crYRWK7ZFqJ52ztSd0t97QlHdVZ7WTr1BUOTKOsFav4gJqV7
 tAOuDZgo3GGo40lrlp9cTc30WF0OFHYIyEhjeSi0lXjNzRfV11TbmVBQmD8Ear9yXT
 X5bKETveI6O1oBCq2xOvNQFld4CHQ6XqneB/PuhrMmpIooWTEHshbQSZw/aymC+Q91
 mImzaPZbGlu9cvWP9D1Xo2cAdfCP09ucDLlx+5UIlq8aXkgUFqSBR26PMv1uEobcwg
 H+wx/shfBal6Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=me8WSfKg
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] rtnetlink: remove
 redundant checks for nlattr IFLA_BRIDGE_MODE
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
Cc: ajit.khaparde@broadcom.com, simon.horman@corigine.com,
 bigeasy@linutronix.de, somnath.kotur@broadcom.com, edumazet@google.com,
 anthony.l.nguyen@intel.com, michael.chan@broadcom.com,
 louis.peens@corigine.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 pabeni@redhat.com, huanhuan.wang@corigine.com, tglx@linutronix.de,
 yinjun.zhang@corigine.com, na.wang@corigine.com,
 sriharsha.basavapatna@broadcom.com, netdev@vger.kernel.org,
 oss-drivers@corigine.com, linux-kernel@vger.kernel.org, saeedm@nvidia.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jul 26, 2023 at 04:05:22PM +0800, Lin Ma wrote:
> The previous patch added the nla_len check in rtnl_bridge_setlink, which
> is the only caller for ndo_bridge_setlink handlers defined in low-level
> driver codes. Hence, this patch cleanups the redundant checks in each
> ndo_bridge_setlink handler function.
> 
> Please apply the fix discussed at the link:
> https://lore.kernel.org/all/20230726075314.1059224-1-linma@zju.edu.cn/
> first before this one.

FWIIW, the patch at the link above seems to be in net-next now.

> 
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
