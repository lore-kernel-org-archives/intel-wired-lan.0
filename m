Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F23ECA5FA1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Sep 2026 00:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 430F5606EA;
	Tue, 29 Sep 2026 00:56:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fgkbzeacqLKN; Tue, 29 Sep 2026 00:56:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A710B60707
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790643387;
	b=LzFU0t70daUpl3Ib2emv1IZuT69lFcakfqRvNTqRNrLFjXomdT5mV39LfFT26d6ur8sk
	 HWLjzwnYssy+YPEhUAkn6RlmdGPHwKbIPv3Oc9fgr51dvBxHPOtKc3FCe6HttI6sX1OEI
	 K5vVvKuXDZVqasUYvUxZvNw7lY1jzHiFG+STsKRoVVYuCIQYI23GagFToS9JcfKWxir66
	 DTrjvCDBb7sVmCNXhH3d5tyCQISCZz1iApWJfqp1/L1e/EfGr3XJaRkZFJwu9EaZUyCRc
	 k0WtMkGbgLmVpOmlxrxriMkIR/hFZaJN/BRFADXso+l7sbWduJhq2SxKUbHCY4MivoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790643387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3RP0bnqMIII/pg2ONC6Opo4xbcWoQQB6/I+wlhye0es=;
	b=KFzq/+es6LnGBL1ba8+qHlMBLi1jRgFXBryltX0b/s0cHvZaloGIJoOxeOb64Y+qffyx
	 bJ9OXrSqXWnfH7Ugzadpsv2ZHO1P70bdy3mbn8jvCdi1sisq9sFY5VJZWrHJfYP68W4U8
	 TpSvrzpWgl3rcpU1elDUO2lr6yrxqp0WqYksRJTmJoFgiXyoy2I2zysTOPjBaBkonGgZm
	 PUV9L13s+niioyGmzVE20P4T3K1W6MQBUjO07AXG5NvS4KrwI0/ezI7CDU2VKQvXSjJac
	 sN433W5vC39uMb4Cojajvhua5Ul4LPICUX/dhJMTkXfNVFXKc5f0muoPDwRhrTT79og==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790643387;
	bh=3RP0bnqMIII/pg2ONC6Opo4xbcWoQQB6/I+wlhye0es=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m1sHhfnIy7ennfEwxGCstVEXDBmcRdRL39n+hcOFQYhZ72eIsNIF47Ndjg5oqE0y8
	 IGEInTdYzVrOm0+2CAyuE+URgbnQsXDjGfpfQ5hKuHg2dd5Iguz/w4L2yYvTrownpU
	 OYeO8OdIbgdI4GKdfgb0a2+dLuPFplH7VMJwU494Zu5iFJrguG6TSSdscON3antHLi
	 EEE2xe6/ZvDKOzT7TDw3Ser8uJ2PmRYExx1oK4LpMqxsURsmLtKc2gXja/BFMdQmb3
	 h8tjq9L5sr8zRCimOxcWE93Danu4Iyqqs2Tgu1qrhOqpOhWVJayv/dIMtb0Cjk6b7/
	 kPkbSnBbFidhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A710B60707;
	Tue, 29 Sep 2026 00:56:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A970F72
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 00:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F5CE40252
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 00:56:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9thNZEtWRI1U for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Sep 2026 00:56:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 66E1B40247
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=220.197.31.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790643385;
 b=UAn//8fa5nBE10IXEEfvHYElf76AF57x+rr3smCytKOq0mVreYTVMIbzD1oKMRUWL2tQ
 n/FV3gTrYkTEBoTBIROcMdTJHrJwIQgf3P1X7Ln8qKFbdhBT5P0vdy74zBbep72Yx2LQV
 ECTjwav2R5pfnFfhuVmHzl3qbH2SsLDh+GAXiIzXvO2BVMO43eqdfTSVvNdKq8Y90lDqd
 EuWYw4g1aNXQPbNBa4d1USR5J1T8OSmRCalDk7EctJsXFo9BllfsJk/GzDvK8nhIc9IFH
 geR0dROnk5/qsks5b+LxBKsks4ljQLSSlnLU1/fq5v7NGFRuZLJiMKknhZlIseRC8WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790643385;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=3RP0bnqMIII/pg2ONC6Opo4xbcWoQQB6/I+wlhye0es=;
 b=bBcpDstUBOodHSVLPTCHNUVt/+XX5jzIo/nw9WuV6grA5KaVOR9jw2ibeRJGDBROxMob
 TTiCuQNe2G4vVioaKfg++Bqy80P1YXb0J0bq8oTldCC1LF6XcRC2dkeSs5NqQp1B4iyEL
 rHaQvIdmgfDtnHOq5nbr2t+pFL6+H8EPWYJdu5/IBJIGTofwHiEo1qCKFaZGJ50Of2hFs
 lMesG9hEmZN2DIDyavzUGOhvAtRfsCHb71qtOE8ey2yweOi3SpZsw22M5eoc612BZYAZt
 PZZS5bUoyc8W8fDMIe+BpowneXcIAGUKMQtuTQpdZzwT7bTfm4/wTHBlfVRfd6Spa8A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=UtkDfbvA; 
 arc=none smtp.remote-ip=220.197.31.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=UtkDfbvA
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 66E1B40247
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Sep 2026 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=3RP0bnqMIII/pg2ONC6Opo4xbcWoQQB6/I+wlhye0es=;
 b=UtkDfbvAzPIoQ1EEOd85g1MfunZokxLA2parXhp6dnZM5f87rdA8xY5jd96WzQ
 HdOhfTHQbOBziYufv1PyELXZMdJuzGLAcBeToOSTxx//5QdWfPldMlSabCMh/P0J
 MPR9q81X/F+CewOZ1XZHn0OTyCICAwRYMm4CxiuHviw3E=
Message-ID: <ee7cc693-864c-48ad-ac26-459396245c8f@126.com>
Date: Tue, 29 Sep 2026 08:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when
 ice_start_vfs() fails
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <20260928065306.1514795-2-xiaolinkui@126.com>
 <143280f0-1c93-405b-b03d-b6404893cdd7@linux.intel.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <143280f0-1c93-405b-b03d-b6404893cdd7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD3j6qNDLtq9SOUAQ--.43551S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4DCFyxKFW7WrWxuFW7urg_yoW8AF45pa
 yDXFy3Ar1kJFy3Wrn2qay8ZF95Wayxt3yF9340k3WSy398Ar1rtFyDtrW29348C397CF1a
 va1j9r43Crn8JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcBMNUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqQ6vhmq7DI6EtwAA3u
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



On 2026/9/28 21:08, Tomasz Lichwala wrote:
> 
> 
> On 28.09.2026 08:53, Linkui Xiao wrote:
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> index 95abc6704820..df84dbe12cba 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>> @@ -446,8 +446,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>>   		return -ENOMEM;
>>   
>>   	vsi = ice_vf_vsi_setup(vf);
>> -	if (!vsi)
>> -		return -ENOMEM;
>> +	if (!vsi) {
>> +		err = -ENOMEM;
>> +		goto free_irqs;
>> +	}
>>   
>>   	err = ice_vf_init_host_cfg(vf, vsi);
>>   	if (err)
>> @@ -457,6 +459,9 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>>   
>>   release_vsi:
>>   	ice_vf_vsi_release(vf);
>> +free_irqs:
>> +	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
>> +
>>   	return err;
>>   }
>>   
>> @@ -490,6 +495,8 @@ static int ice_start_vfs(struct ice_pf *pf)
>>   				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
>>   					vf->vf_id, retval);
>>   				ice_vf_vsi_release(vf);
>> +				ice_virt_free_irqs(pf, vf->first_vector_idx,
>> +						   vf->num_msix);
> 
> Nit: For consistency with the teardown: loop (which frees IRQs before releasing the VSI), consider swapping the order here too - currently this branch releases the VSI first, then frees IRQs, the opposite order. Not functionally significant, just readability.

Thanks for the review, Tomasz.

Agreed this is only a readability nit. The two calls are independent and
the current order is functionally safe, so I'll keep v2 as is.

No v3 planned for this change.

Thanks,
Linkui
> 
>>   				goto teardown;
>>   			}
>>   		}
> 
> Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> 

