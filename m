Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D2810775E6
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Mar 2026 16:19:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B842440C0B;
	Wed, 18 Mar 2026 16:19:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jr_nxYAfxT2P; Wed, 18 Mar 2026 16:19:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EDA0D40BE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773850748;
	bh=JLN1/djnRyiEfWS/tjavuSdshlWrNC7Mv1TvEiDjg9s=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=988u0uDL6gX6g2pekp11u3FYILJf4/CkE9+BfBMhMf1MNVEm9Uo5FdGC7ya+Cu3sm
	 EE27caCnyJRKhXNs2Hw8qtxcBByD85p3ssjvqy+ihCU4SYv8kvY/8JRQxz3OAxSf/w
	 QC1mUu5Ark3j2gWSC9ZfJDSP9rH7OSaRiMflKLArsN+V1ZE12fCxVauwyEszPWk8R2
	 zX8yLeXOXR2x0/fvnm3wfa1qYSWOPYGR3UrzM4kpKasFGlZOAMp59lsBjXw1xKBkoI
	 PNqO193aljitLH68qL6qOZwYiapwZRjyMSJltSNuwQqeuumPvjLBo4kEhAend2vxe2
	 BAI+u8jAFfW/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDA0D40BE1;
	Wed, 18 Mar 2026 16:19:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BE091AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 16:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6D1B260A93
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 16:19:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAvxxIhJ08Qg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Mar 2026 16:19:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D4A6960A73
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D4A6960A73
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D4A6960A73
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Mar 2026 16:19:03 +0000 (UTC)
Received: from [172.20.10.225] (unknown [24.40.138.251])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 731644C2C37F0A;
 Wed, 18 Mar 2026 17:18:33 +0100 (CET)
Message-ID: <f26d4c73-99c3-4252-a880-f9e8eb57bf04@molgen.mpg.de>
Date: Wed, 18 Mar 2026 17:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Joshua Hay <joshua.a.hay@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Madhu Chittim <madhu.chittim@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260318155220.642160-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260318155220.642160-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH] idpf: fix UAF and double free in
 idpf_plug_core_aux_dev() error path
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

Dear Guangshuo,


Thank you for your patch.

Am 18.03.26 um 16:52 schrieb Guangshuo Li:
> If auxiliary_device_add() fails, idpf_plug_core_aux_dev() calls
> auxiliary_device_uninit(adev), whose release callback
> idpf_core_adev_release() frees the containing
> struct iidc_rdma_core_auxiliary_dev.
> 
> The current error path then accesses adev->id and later frees iadev
> again, which may lead to a use-after-free and double free.
> 
> Fix it by storing the allocated auxiliary device id in a local
> variable and avoiding direct freeing of iadev after
> auxiliary_device_uninit().
> 
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/net/ethernet/intel/idpf/idpf_idc.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index 6dad0593f7f2..0fcbf9f1ddbb 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -197,6 +197,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
>   	struct auxiliary_device *adev;
>   	int ret;
> +	int id;

Name it `adev_id`?

>   
>   	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
>   	if (!iadev)
> @@ -211,12 +212,16 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   		pr_err("failed to allocate unique device ID for Auxiliary driver\n");
>   		goto err_ida_alloc;
>   	}
> -	adev->id = ret;
> +	id = ret;
> +	adev->id = id;
>   	adev->dev.release = idpf_core_adev_release;
>   	adev->dev.parent = &cdev_info->pdev->dev;
>   	sprintf(name, "%04x.rdma.core", cdev_info->pdev->vendor);
>   	adev->name = name;
>   
> +	/* iadev is owned by the auxiliary device */
> +	iadev = NULL;
> +
>   	ret = auxiliary_device_init(adev);
>   	if (ret)
>   		goto err_aux_dev_init;
> @@ -230,7 +235,7 @@ static int idpf_plug_core_aux_dev(struct iidc_rdma_core_dev_info *cdev_info)
>   err_aux_dev_add:
>   	auxiliary_device_uninit(adev);
>   err_aux_dev_init:
> -	ida_free(&idpf_idc_ida, adev->id);
> +	ida_free(&idpf_idc_ida, id);
>   err_ida_alloc:
>   	cdev_info->adev = NULL;
>   	kfree(iadev);

Ether way:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
