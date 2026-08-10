Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D604C5AD55
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 19:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3757160778;
	Mon, 10 Aug 2026 19:41:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SnoYqdVkhlYB; Mon, 10 Aug 2026 19:41:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CC57D60774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786390863;
	bh=aQkbAL8gDFRxpXIIle+bm2wnXM0lq6rIv0I7IeHxRts=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YxPPBHauJBh4u24qzS3Db846eMHAaS2A/+UcdowICxwBP6zHzijmEtzKQeKPVWzzi
	 dD3gLzrhfliA0OFjTXfoGObo4z3puHZXuDaGsiQ8cCAz3JTrROoMlWBNF55HRRjNdj
	 ifnS9CKIt1Ox1J6XCr4zQC3sak3DvcRgLaYy+U3BD+pzXrOSPGAgNFNWKlSmO/rptt
	 Aq9RqGamCb+lfDKvrs66y8jhQmNqprX66IuQNYd915vrWmrZzLoTxcNH54VezSvGql
	 0fX3qkDC4lMmZ15XW6NC9xP0xpGy9EhNigI/pUhCYlARKHdFIpdaztrifTfDaP8eyP
	 +2x6VKj4SKefw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC57D60774;
	Mon, 10 Aug 2026 19:41:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CAD32345
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 19:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC0B260765
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 19:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5L32MwlF8nGG for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 19:41:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1AB4D60774
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AB4D60774
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AB4D60774
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 19:40:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 173844140A;
 Mon, 10 Aug 2026 19:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF201F000E9;
 Mon, 10 Aug 2026 19:40:56 +0000 (UTC)
Date: Mon, 10 Aug 2026 12:40:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 alice.kernel@fastmail.im, dtatulea@nvidia.com, witu@nvidia.com,
 martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Message-ID: <20260810124056.469fc9a4@kernel.org>
In-Reply-To: <anodof8GsDZHZb-S@devvm7509.cco0.facebook.com>
References: <20260810184753.135756-1-sdf@fomichev.me>
 <anodof8GsDZHZb-S@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786390858;
 bh=aQkbAL8gDFRxpXIIle+bm2wnXM0lq6rIv0I7IeHxRts=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=LOoKrRiYuDgUfvBRlZ4LwZbOfjNQeTCquT58/+SCiWtzUlO7Pm0sAMjtC0i4Chvey
 rDhUlVnfXNhfG3oJaRFwr7DOiXl0bJlyyzVAasYb2FdUuRTSLii0fH3dTI8TOF3t0Q
 9XqNyxp2KIbMwjtCZ4s9+hvDj0bVXGV5qQ+Hpy/NbPPcW7tZvOGnitOs+YNQ8s95QF
 d0nMri9FbdSbVw6Ggqc5RbQ6qKIDDtLJTRFk/BxYqgjhHnniaBNvruhP9SDD2h4USF
 8F2RiDbWegBBBDZoS6TPkmVDavKW9k8CZhHRrqXL4Ei2Xi1vUeyPAd9Y++rIcFA0kL
 cUqINYnzLeVqw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=LOoKrRiY
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] xsk: pre-existing AF_XDP
 TX metadata fixes from Sashiko
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

On Mon, 10 Aug 2026 11:52:01 -0700 Stanislav Fomichev wrote:
> On 08/10, Stanislav Fomichev wrote:
> > A few fixes to address pre-existing issues from Sashiko review.
> > 
> Ooops, this should've been targeted to net tree. Will resend in a few
> days in case there is any review feedback.

Please make sure you look at the Clashiko review before you repost.
Looks like it got kicked off already so let's not waste it.
