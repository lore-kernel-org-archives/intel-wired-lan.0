Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F14DCA0EFF
	for <intel-wired-lan@archiver.kernel.org>; Wed, 27 Aug 2025 15:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17932409A3;
	Wed, 27 Aug 2025 15:20:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cjYrAxUpdnsX; Wed, 27 Aug 2025 15:20:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9447440BFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1756308026;
	bh=wRyOvCfbnXiTEsh6EI2/hPJ7unoXkR4HwiqNELHT+0E=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6EVOwRERpd6X6pEXT3QiWttE6AG/orKegU0WGbOjDyqi1Ot1H9WEnZZw+0MOfZrKh
	 qz52a8SmJdEIHuBgd1Qw+L7tD3sTvWatWA9A5z+B0vfMCjeL1FUL6h80XSG3ijUD33
	 HENdjU0hJuKC0o3F+D/fjt1dIYIA/RWszK2+0aU9CJlZPsSXqHbR4Hb4NYs9rT3ENN
	 iu+Jbk4euDYG+X4mPnucASX/o1Gn7ZH96yuAusuxJo5eTPx+HJDiQxV10G9NmthsKV
	 X0VjB4afFWJXuawc+UAb5KaXoVExtAfLi4zvgwUYGGnZK579JyizjqEbT1ytp45hQ1
	 VF/A/zC8AiRHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9447440BFB;
	Wed, 27 Aug 2025 15:20:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13E1F17D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Aug 2025 15:20:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE44D4057E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Aug 2025 15:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kii9VzS42WhF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 27 Aug 2025 15:20:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4040040578
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4040040578
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4040040578
 for <intel-wired-lan@lists.osuosl.org>; Wed, 27 Aug 2025 15:20:24 +0000 (UTC)
Received: from [192.168.2.202] (p5dc558dd.dip0.t-ipconnect.de [93.197.88.221])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 70BDD60213AC3;
 Wed, 27 Aug 2025 17:19:57 +0200 (CEST)
Message-ID: <a8fa64e8-d6d4-4269-9e57-19eaec822303@molgen.mpg.de>
Date: Wed, 27 Aug 2025 17:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
References: <20250827032348.1374048-1-zhen.ni@easystack.cn>
 <20250827115631.1428742-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250827115631.1428742-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] i40e: Fix potential
 invalid access when MAC list is empty
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

Dear Zhen,


Thank you for your patch.

Am 27.08.25 um 13:56 schrieb Zhen Ni:
> list_first_entry() never returns NULL — if the list is empty, it still
> returns a pointer to an invalid object, leading to potential invalid
> memory access when dereferenced.
> 
> Fix this by using list_first_entry_or_null instead of list_first_entry.
> 
> Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP driver")
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
> Changes in v2:
> - Replace the list_empty() pre-check with list_first_entry_or_null()
> ---
>   drivers/net/ethernet/intel/i40e/i40e_client.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 5f1a405cbbf8..518bc738ea3b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -359,8 +359,8 @@ static void i40e_client_add_instance(struct i40e_pf *pf)
>   	if (i40e_client_get_params(vsi, &cdev->lan_info.params))
>   		goto free_cdev;
>   
> -	mac = list_first_entry(&cdev->lan_info.netdev->dev_addrs.list,
> -			       struct netdev_hw_addr, list);
> +	mac = list_first_entry_or_null(&cdev->lan_info.netdev->dev_addrs.list,
> +				       struct netdev_hw_addr, list);
>   	if (mac)
>   		ether_addr_copy(cdev->lan_info.lanmac, mac->addr);
>   	else

That’s even better.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
