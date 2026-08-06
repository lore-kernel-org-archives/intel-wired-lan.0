Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5732C56207
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 14:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6089980C44;
	Thu,  6 Aug 2026 14:32:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDGFTn_-dPwU; Thu,  6 Aug 2026 14:32:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBC3A80C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786026741;
	bh=w++qil5+r7DbsBITAHvQysC6L9AEhykXAVG2z04ObEI=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bqYQPdGy8ZCYstOx01A2vwLOQ8LK6bMiwDLQ7/33jDLp+VsHh4Ahv8zzs0j2ZLZ10
	 SUu618VMdf6xxsYsQzBxA75XxZSNa5003DpTz5Sx+TLb+GGsyTUvD0QKMZ2IOc3dr6
	 dyF1VRUBiktTNIktVe6/kYgC669g3mw+EFvH0lzo/0vBEXmKu93i5UVfq9TghevxPu
	 iOZilWcoXzZEwmZ0KyWTiqkg1DL0frqjR1tAZ+5H/tf1o3fwVwvjHngDo5CUdt24rO
	 6svHwzQaXGc3YiT245uSS0vnqvdsNfxclvg8flCCtfucgoVC1JVFEs/MSwQooMDx9e
	 g0IScqE+FS7IA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBC3A80C74;
	Thu,  6 Aug 2026 14:32:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0D7828C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:32:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 96DD04017B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:32:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqfU63N1yi2E for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 14:32:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3391A40112
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3391A40112
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3391A40112
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 14:32:17 +0000 (UTC)
X-CSE-ConnectionGUID: Eg05ffObTraT3uS/535oIw==
X-CSE-MsgGUID: 5mfsXO8dQSqWFq5fTOBZZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86829754"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86829754"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:32:17 -0700
X-CSE-ConnectionGUID: 1SYzp0QjSgW5PNsBN6EULA==
X-CSE-MsgGUID: WkTgm0QXRCeN7uRihIiPvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="286792944"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239])
 ([10.217.160.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:32:15 -0700
Message-ID: <2c551a5e-22f3-42c7-a6ef-daf246e57cc5@linux.intel.com>
Date: Thu, 6 Aug 2026 16:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
 <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
 <willemdebruijn.kernel.35c676937c974@gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <willemdebruijn.kernel.35c676937c974@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786026739; x=1817562739;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DoTLDoZAc8+Q60nsS97XWzusuz0k89fPZ3SCF59brQA=;
 b=RDHxy+ELiIhijFUVmMBJEf4CWh2iVvHoCuMrQsW14KyAuihSL3HiAqLD
 ZQceAoJ3nAvPxklRxG9NnO4hSrmKdBj+dacaoh07g9u0UYYOhtMT13X8y
 EOUyr5605Qjs+jpSq9f4Mv4Mu9pgOS8c51JwqE7GgcyECMv6J98UVmlci
 UJTzxwRpTDFdzkGepcq3Tbfh3p7+YpTDapTRDB+DIdwowtR9Mnlfp+aBT
 WBH0Wm/sKVdlDoMO6xSJ7SQkFpdLy28H53xKqVc5ad0grjIdbQ9Cf8e2u
 VeEvs33G28HnvbsZqhYVRFcxbORZEvuKN1msjMPj6txrQOVphxiIQF5rp
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RDHxy+EL
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
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



On 06/08/2026 16:19, Willem de Bruijn wrote:
> Marcin Szycik wrote:
>>
>>
>> On 03/08/2026 23:06, Willem de Bruijn wrote:
>>> From: Willem de Bruijn <willemb@google.com>
>>>
>>> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
>>> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
>>> field in a single operation.
>>>
>>> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
>>> __le32 to ensure the fields are written correctly also on big endian
>>> platforms.
>>>
>>> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
>>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>>> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>
>>> ---
>>>
>>> Changes
>>>   v1 -> v2
>>>   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
>>>   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
>>> ---
>>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> index c724d429a7aa..91ca75e45463 100644
>>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>> @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
>>>  				    struct idpf_tx_splitq_params *params,
>>>  				    u16 td_cmd, u16 size)
>>>  {
>>> -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
>>> +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
>>
>> While it technically works, I find it unreadable. Looking at this line
>> without reading commit msg, it looks like a bug where a 4-byte value is
>> written to u8 field. The intent to zero an adjacent, unrelated field is
>> not clear. Consider assigning these 4 fields manually, or adding a
>> comment/function doc.
> 
> This is a bug fix, which generally should be the smallest surgical
> change only.

Agreed.
> That said, I do agree on the style, and a follow-up for net-next will
> clean that up too:
> 
> 	@@ -2408,7 +2410,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> 					    struct idpf_tx_splitq_params *params,
> 					    u16 td_cmd, u16 size)
> 	 {
> 	-       *(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> 	+       desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> 	+
> 	+       desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
> 	+       desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
> 	+       desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
> 
> The fix is queued. If there is consensus, I can respin. But given that
> we will clean this up in net-next properly, my preference is to keep
> the minimal fix as is.

I'm fine with this. Was the cleanup patch already posted to next?

Thanks,
Marcin
