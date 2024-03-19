Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10739C54E68
	for <intel-wired-lan@archiver.kernel.org>; Tue, 19 Mar 2024 19:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92B6E4149E;
	Tue, 19 Mar 2024 19:43:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MD5e1au6qsyN; Tue, 19 Mar 2024 19:43:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2F4541488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710877402;
	bh=cXi257JwpClcyBFTjwZNV/lnEYXUnxNwn0P+hzh0Jwo=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=uHbS52Sr0EFRCDXEgknf01YkjnOuqN7N4urpW9akaH+vpAWioQGuGt0YazrOpj/AS
	 IpOLKBV7x0SubXMkcd+Du8/fOY4A1UdYs8JDoO9VTxzuLo1ESdDk8a5vyZrdOpk8Tl
	 Tn59CZge05o8Df2EcO6TLX1SbvxY5Cw8Se6l70zOT8HgCagbMGaR1iBNS3t5tqTBNn
	 bviEb+fr60VmWph1EjCY2A++DuL5RwtZkyDybER6BKuh6dNqJ3Bo8HjpFtT5951oR7
	 CgLVHBNOsCaUAFBJM1J632KBECRFEOlILBYRmTxr2aQQ2HCrcCU5y2caLKsMqe7yEj
	 QzYUSR1o/g0Ig==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id E2F4541488;
	Tue, 19 Mar 2024 19:43:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 9A92F1BF3C6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Mar 2024 19:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83C2F400C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Mar 2024 19:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wfjOTh-Fw9PX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 19 Mar 2024 19:43:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BAB7E400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAB7E400B4
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAB7E400B4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 Mar 2024 19:43:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7CDCF60EBA;
 Tue, 19 Mar 2024 19:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A102DC433C7;
 Tue, 19 Mar 2024 19:43:18 +0000 (UTC)
Date: Tue, 19 Mar 2024 12:43:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <20240319124317.3c3f16cd@kernel.org>
In-Reply-To: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1710877399;
 bh=4c0gTY5ILrK0uD6EsujNoi/J2gWpLE0huRdLKPHIfwg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hPj5lcGsZBFbWYX9sTipBmth0flulHxveKZSdSIYL9f9rnIFdPotJ6AjMBKD9E1Wx
 Sfu6LWJqHTQmjEHpqD7W6UVFp526dSluffT6r6Lkpy/tN0s0b0eV8IT1jY2Iuy0ot7
 FnynRVm1UV0bQlEwjm7EfDD7x0rScmrqtfrz55YX5uqHh9z4my7KKb48L0CT3ZtJuj
 qhKbGM2CLqEXiHYNK2QyoEZaVjw82vdlfv2xfLQdrsFCy13lnNP+4BKRMzGuuO/lJx
 D309CxTY3kt0I5KXRslduxBgSvTFNf56Iju2LDEyAkGaQO0op5UzVkkZGzhYH46qsB
 6mtHcRQkiIalA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hPj5lcGs
Subject: Re: [Intel-wired-lan] [PATCH net] ice: Fix freeing uninitialized
 pointers
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
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sat, 16 Mar 2024 12:44:40 +0300 Dan Carpenter wrote:
> -	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
> -	void *mac_buf __free(kfree);
> +	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> +	void *mac_buf __free(kfree) = NULL;

This is just trading one kind of bug for another, and the __free()
magic is at a cost of readability.

I think we should ban the use of __free() in all of networking,
until / unless it cleanly handles the NULL init case.
