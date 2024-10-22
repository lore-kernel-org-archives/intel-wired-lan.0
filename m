Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2A2D2CDF6
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Oct 2024 15:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48755605FA;
	Tue, 22 Oct 2024 15:56:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vh6EEYmjCs5S; Tue, 22 Oct 2024 15:56:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A696360604
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729612599;
	bh=hXwQzB2TWkDesIimcuKorfPzCWCcgc6NpqpM7k2y8YI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JQ0N2ReCNLwG5BmK8Js+DvmT+W0RyZyTP/+jkMp/9iIZCmum8KSbqWV6emN4d//aJ
	 rMLpduhtnOBTHv0kXwk0m3TJZ+9EsLucVeMXQ7AyTic/ygu5B4n6JWzWYx9Q2x5ZnW
	 sA22lJId9PHBkcidSAvkdc9nD0LZK8yGgBm4VB/VUAT5OMdW2H96irb4BsHkRxO6Gc
	 UDcvHmZdl2U+XQp9sYDPGpwU1n/nigm+ZL2Ep7ywZ7M7BtLzNR52TSDfGs7JSIX+ai
	 5kEZ9DFXHI2EP2/geXTkTjb3hEg0mkTZf7ijGYj8stg3/BXYFHC5AmtHc+2a1Bnil+
	 jG9E1U7LxIN4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A696360604;
	Tue, 22 Oct 2024 15:56:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 732DF963
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 15:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C3FA4022E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 15:56:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FmQw-4bwTjhk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Oct 2024 15:56:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 757594022B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 757594022B
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 757594022B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Oct 2024 15:56:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 08033A43D12;
 Tue, 22 Oct 2024 15:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0EDC4CEC3;
 Tue, 22 Oct 2024 15:56:32 +0000 (UTC)
Date: Tue, 22 Oct 2024 16:56:30 +0100
From: Simon Horman <horms@kernel.org>
To: Yuan Can <yuancan@huawei.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, cramerj@intel.com,
 shannon.nelson@amd.com, mitch.a.williams@intel.com,
 jgarzik@redhat.com, auke-jan.h.kok@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <20241022155630.GY402847@kernel.org>
References: <20241022063807.37561-1-yuancan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022063807.37561-1-yuancan@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729612595;
 bh=uCVIk7/ccIig2DOQ2XAujMwrdm+K7nR+OtKc6cpV5f4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I0BEtp0Pmnbl1mk0jjVZJ72/MvGmU271hvyxvJAWxKU9NbafEqaZxrgevHqJv32+w
 4Sv3tQ18yDv6DRKqMvjWgQD0+rUJ6LRuzMqUaYJCJOJfck2c9WBR0Sp1wrXyJzPeX9
 a3O4VU1uxlW6v1wUcs9khLhYahGWdNzl/ObqlOzKERZV24KLwdg1uQiTwgGaf69rpw
 3ytmQojljhlbyqxh75vUGXvYphABeU4+e9BgXioW8vD48WVUyWp8GJN+j7s6q2J3vU
 8W0J2ye7EX9pEE+4v2QOY2jgX12jqj7dlE/MFDdcNMa8/n8wVO4frVaGk9xHf4rz4z
 vK90WY+7ad6/A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=I0BEtp0P
Subject: Re: [Intel-wired-lan] [PATCH] igb: Fix potential invalid memory
 access in igb_init_module()
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

+ Alexander Duyck

On Tue, Oct 22, 2024 at 02:38:07PM +0800, Yuan Can wrote:
> The pci_register_driver() can fail and when this happened, the dca_notifier
> needs to be unregistered, otherwise the dca_notifier can be called when
> igb fails to install, resulting to invalid memory access.
> 
> Fixes: fe4506b6a2f9 ("igb: add DCA support")

I don't think this problem was introduced by the commit cited above,
as it added the call to dca_unregister_notify() before
pci_register_driver(). But rather by the commit cited below which reversed
the order of these function calls.

bbd98fe48a43 ("igb: Fix DCA errors and do not use context index for 82576")

I'm unsure if it is necessary to repost the patch to address that.
But if you do, and assuming we are treating this as a bug fix,
please target it for the net (or iwl-net) tree like this:

Subject: [PATCH net v2] ...

> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index f1d088168723..18284a838e24 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -637,6 +637,10 @@ static int __init igb_init_module(void)
>  	dca_register_notify(&dca_notifier);
>  #endif
>  	ret = pci_register_driver(&igb_driver);
> +#ifdef CONFIG_IGB_DCA
> +	if (ret)
> +		dca_unregister_notify(&dca_notifier);
> +#endif
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 
> 
