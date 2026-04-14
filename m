Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B68FF531F1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 14 Apr 2026 06:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB79342989;
	Tue, 14 Apr 2026 06:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V9hnQjh-hU-L; Tue, 14 Apr 2026 06:55:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4962842943
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776149730;
	bh=NPOxW66OC5+qt/FYwtAj6gqnS+FknS6WgNOVN+0ojIU=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mSiWkQKuY5ftAFHazN+FezdHeY5qr0XYEv7NpcpOs2pWqdS1ThU3KdvjPesrMVHCT
	 UXp9wTYRgkMbUQroDtfatJLyV/gXdkGf/HcDezCgV7Xkail/na99sC/RAd7DCk3Ipn
	 3w67Hr/v7kz6AwCBhxw8P55BcsDNCNNoxicDvoVJavo3I5HX2ic28l4b4nJ3//6mfq
	 6h/5drsBtahJEiIR+y4XaOeWjpNX6kt/gzE9dtgTE4xJVpUavE44q1drDDXvp/JB92
	 NOakVhEM88ZdpYcdrxkcBdXQ1ZM0HD9f0rU48k8+Rc4ZHDutmCK9e9TVHLq2l8rMdV
	 k9+HuWn73z0OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4962842943;
	Tue, 14 Apr 2026 06:55:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D8E2283
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 06:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C2A761CA0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 06:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M8EUYLZA4hYM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 14 Apr 2026 06:55:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4855661C9F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4855661C9F
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4855661C9F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 14 Apr 2026 06:55:25 +0000 (UTC)
Received: from [192.168.0.192] (ip5f5af0da.dynamic.kabel-deutschland.de
 [95.90.240.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EA7B24C2C37D56;
 Tue, 14 Apr 2026 08:54:55 +0200 (CEST)
Message-ID: <afefe8b5-5bd9-4019-9d12-5ee2a7f577a2@molgen.mpg.de>
Date: Tue, 14 Apr 2026 08:54:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 stable <stable@kernel.org>
References: <2026041116-retail-bagginess-250f@gregkh>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <2026041116-retail-bagginess-250f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH net] idpf: fix double free and
 use-after-free in aux device error paths
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

Dear Greg,


Thank you for the patch.

Am 11.04.26 um 12:12 schrieb Greg Kroah-Hartman:
> When auxiliary_device_add() fails in idpf_plug_vport_aux_dev() or
> idpf_plug_core_aux_dev(), the err_aux_dev_add label calls
> auxiliary_device_uninit() and falls through to err_aux_dev_init.  The
> uninit call will trigger put_device(), which invokes the release
> callback (idpf_vport_adev_release / idpf_core_adev_release) that frees
> iadev.  The fall-through then reads adev->id from the freed iadev for
> ida_free() and double-frees iadev with kfree().
> 
> Free the IDA slot and clear the back-pointer before uninit, while adev
> is still valid, then return immediately.
> 
> Commit 65637c3a1811 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev

The commit hash is pasted twice.

> deinitialization") fixed the same use-after-free in the matching unplug
> path in this file but missed both probe error paths.
> 
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: stable <stable@kernel.org>
> Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, these cleanup paths are messy, but I couldn't see a simpler way
> without a lot more rework, so I choose the simple way :)
> 
>   drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 7e4f4ac92653..b7d6b08fc89e 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -90,7 +90,10 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
>   	return 0;
>   
>   err_aux_dev_add:
> +	ida_free(&idpf_idc_ida, adev->id);
> +	vdev_info->adev = NULL;
>   	auxiliary_device_uninit(adev);
> +	return ret;
>   err_aux_dev_init:
>   	ida_free(&idpf_idc_ida, adev->id);
>   err_ida_alloc:
> @@ -228,7 +231,10 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   	return 0;
>   
>   err_aux_dev_add:
> +	ida_free(&idpf_idc_ida, adev->id);
> +	cdev_info->adev = NULL;
>   	auxiliary_device_uninit(adev);
> +	return ret;
>   err_aux_dev_init:
>   	ida_free(&idpf_idc_ida, adev->id);
>   err_ida_alloc:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

gemini/gemini-3.1-pro-preview has two comments [1]. Maybe the driver 
developers could judge their relevance.


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/2026041116-retail-bagginess-250f%40gregkh
