Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BCEC05027
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Jan 2023 20:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A10B81FCC;
	Mon, 23 Jan 2023 20:03:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A10B81FCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1674504205;
	bh=XLLuSG4TkscmeLOjVz0UYVYUBxzdH/BRrYoQzZM/ymU=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9Ryg5jj+/OlxFXudFEvhnIb5X9UAFgvTlvL1GJbSZ6MUaq/EVA6F2CzMF9sdKPdIi
	 DsQUqa+/x1cGWD0WC1QB9cyQylw9lrprbx1jh1DO1Er+gQkj4aXUvarSWPe/vB/wXF
	 SAAHjEn+3ZNivZNo2v9+aB4TOZKzFi45rBt74RUaXdNONLvvYTqYzyE+725wKi/+cr
	 H8CcTWz+wSZt6OSidlePi2Gme1uXiFxQgPztTNxjXLnNPXy5IZpojR4EKTMvZhjQhc
	 tKlpYAQmz5rrcXc0+1QEplAAkwVUBT6SomMQ88eVAM55MFpi3ExDBmPsvTBb2x4KwC
	 4DB83CJZ9zEuw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Tasb4uwNSNK; Mon, 23 Jan 2023 20:03:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EFEE81FDB;
	Mon, 23 Jan 2023 20:03:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EFEE81FDB
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 35BBB1BF3AF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 20:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10C8240B2E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 20:03:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10C8240B2E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 45hw7ptpJGUS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Jan 2023 20:03:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6CBEE404BB
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CBEE404BB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Jan 2023 20:03:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B4D016102F;
 Mon, 23 Jan 2023 20:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91EDC4339B;
 Mon, 23 Jan 2023 20:03:19 +0000 (UTC)
Date: Mon, 23 Jan 2023 12:03:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Message-ID: <20230123120318.358ef9a8@kernel.org>
In-Reply-To: <Y80iwBNd3tPvEbMd@lore-desk>
References: <cover.1674234430.git.lorenzo@kernel.org>
 <861224c406f78694530fde0d52c49d92e1e990a2.1674234430.git.lorenzo@kernel.org>
 <20230120191152.44d29bb1@kernel.org> <Y80iwBNd3tPvEbMd@lore-desk>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1674504201;
 bh=ZHGRoFsn+EUQs1iGPUoTvzLYTnpaq6FISKkR45iFTro=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=qM6i+IIDqjcH4mojlWNvMQdFGCyzWZIhEo9WKN0AIWy6r1P2EzK6hmhI6K7e05/u+
 yuAlLEc1mXRUW3OD9VXgQFvd4UMYSVNaNeKBL5caMIs4NmZN1xhi1z4BEzf/Uf1akh
 U9iHLMURGhZBiFJ16l/rEiwQBx5/6PHFqZ1QrM76gWz99gXClgUt6pTraqfaKIH+ed
 1m5G4I0oj39ZAhs7MilDbE2YVziYHW01OnWMKI8Atjv2qoKla8pJ2OyjfVPqucNJcV
 I1bfIYUL9PJbPHao3HYvbFrsnC7Ee5/xWNiaHH0uamhQim2dA/dPNe70zuwN0fRol4
 KLd28kbao71Zg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=qM6i+IID
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 2/7] drivers: net: turn on
 XDP features
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
Cc: mst@redhat.com, vladimir.oltean@nxp.com, ast@kernel.org,
 edumazet@google.com, anthony.l.nguyen@intel.com, daniel@iogearbox.net,
 niklas.soderlund@corigine.com, andrii@kernel.org,
 intel-wired-lan@lists.osuosl.org, simon.horman@corigine.com, pabeni@redhat.com,
 aelior@marvell.com, hawk@kernel.org, christophe.jaillet@wanadoo.fr,
 memxor@gmail.com, john@phrozen.org, bjorn@kernel.org, bpf@vger.kernel.org,
 magnus.karlsson@intel.com, leon@kernel.org, netdev@vger.kernel.org,
 toke@redhat.com, ecree.xilinx@gmail.com, alardam@gmail.com, gospo@broadcom.com,
 saeedm@nvidia.com, davem@davemloft.net, nbd@nbd.name
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun, 22 Jan 2023 12:49:20 +0100 Lorenzo Bianconi wrote:
> > Shouldn't these generate netlink notifications?  
> 
> ack, I would say we need to add NETDEV_XDP_FEAT_CHANGE case in
> netdev_genl_netdevice_event routine and maybe add a new
> NETDEV_XDP_FEAT_CHANGE flag in netdev_cmd. What do you think?

No strong preference between a full event or just a direct call until
we have another in-kernel user interested in the notification.
The changes are wrapped nicely in helpers, so we can change it later
easily.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
