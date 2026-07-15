Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F69CC4450A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 02:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4653260602;
	Wed, 15 Jul 2026 02:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YsygBU8CdLCO; Wed, 15 Jul 2026 02:59:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCE1160663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784084377;
	bh=9xtif7wKWcaLEOyxIVo71CFUEZSMX5hpVYfkaAXiiXA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LRWdntPh+4PqSMQKm1qY3dtOTAdaYAcPhZW0sAvIpqpv2gKngXfKfoO1SlU9+DUl2
	 wdgZcztfjrOif/r5OF3JAgodxOPwfi05iIxrB81mrUOIqv7xagFDjeCekFLWaJN90a
	 6CgUJKccoTW0PKb+DzIa3z7qFxrSFkSJUbLcBoNiJGn7hPOhChvc7c8QFYu0WRaNko
	 wYp+3sLPyMC134phBwQ3AtStBmDxWlo/ky+ksqA4BAWw7MlxtsxtGmUV5ujmxSF+cw
	 mpWcp0Ke9AeZkmXfzL2DtpNRiNuCRGLKyy5dtrrycE7ln2Q/Geunrg2DB1FglF6yNa
	 +DmumvBcWoAWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCE1160663;
	Wed, 15 Jul 2026 02:59:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80CEC499
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 02:59:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5ECE760663
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 02:59:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K3zTKfYRdZt0 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 02:59:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=91.218.175.186;
 helo=out-186.mta0.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 823B160602
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 823B160602
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 823B160602
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 02:59:33 +0000 (UTC)
Message-ID: <2a1e5d38-1035-4f09-b4af-5a63ec04f1d1@linux.dev>
Date: Wed, 15 Jul 2026 10:58:32 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, sridhar.samudrala@intel.com,
 wojciech.drewek@intel.com, piotr.raczynski@intel.com,
 michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
 <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
In-Reply-To: <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784084365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xtif7wKWcaLEOyxIVo71CFUEZSMX5hpVYfkaAXiiXA=;
 b=Fa4VIWrwA70DjAtWZ6OLqi+x7I0FG2AAc4HkAt2Ya5VS11rRMFOUSxztd/U6TqXh40wKC3
 W3aJ3vLjjPPeywQZ6wUcxbDQtgpRROjdXaSBkI8LppJ0qCd3j9bNR+6gJfhUEqDtoCq9Ay
 MfIFCyr0D0BNc90gzhb3BTn2R2U+ANI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=Fa4VIWrw
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
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


在 2026/7/14 22:14, Marcin Szycik 写道:
> On 14.07.2026 08:39,xuanqiang.luo@linux.dev wrote:
>> From: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
>>
>> ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
>> port from pf->dyn_ports. However, it frees the VSI before reading the
>> index for the erase, resulting in a use-after-free.
>>
>> Follow the reverse of the allocation order in ice_alloc_dynamic_port()
>> by erasing the xarray entry before freeing the VSI.
>>
>> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
>> Cc:stable@vger.kernel.org
>> Signed-off-by: Xuanqiang Luo<luoxuanqiang@kylinos.cn>
> Reviewed-by: Marcin Szycik<marcin.szycik@linux.intel.com>
>
> Thank you!
> I wonder how such a glaring issue survived in the codebase for so long.
> Perhaps ice_vsi_free() exited early for some reason.

Thanks for the review!

Hard to say—maybe the window is quite small and the freed slab still
holds the old idx most of the time, so nothing obvious shows up.

>> ---
>>   drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
>> index 2a2e56777f9f7..3ede246490027 100644
>> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
>> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
>> @@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>>   
>>   	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>>   	ice_eswitch_detach_sf(pf, dyn_port);
>> -	ice_vsi_free(dyn_port->vsi);
>>   	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
>> +	ice_vsi_free(dyn_port->vsi);
>>   	kfree(dyn_port);
>>   }
>>   
