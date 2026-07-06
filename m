Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238CAC43458
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jul 2026 13:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8E05608BB;
	Mon,  6 Jul 2026 13:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cb9dEnu7nSpV; Mon,  6 Jul 2026 13:14:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEEA3608A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783343650;
	bh=rd1eU5fXUVGlzNSRLp2SVbgeNmB9RghvaveOS3kWy5M=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8658R5RlDRfhgzGvzobs9d32hbuU1yryjCGqmCJXkhf/IUY6crRmLUkF+YguxuaS
	 UNlWBuExn5sH/86Bzw8sC1ih4icx3o6VQAD3YwZGDMEKlfeqoqtbCbtupJW5xUINxR
	 aoC3oFVutdBZ12gmUgHvaV5OeiQBrOZkWgdb6vVktvlWTebs557WN9gs8nXq2BpGEU
	 htycIY2rz4Ua+tBeJORKHTWaSValMnJlfuTNyeP4DS0P7jb91wJXH9ewAEEhZrM7s+
	 ApuRq1g66UbA8r/HbH2ycSFZFx17RN7J86Ed5NOVjSG2yhJc4G9bJenM+OXqqqLw4w
	 7kF37dgoqMt4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEEA3608A4;
	Mon,  6 Jul 2026 13:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C407B316
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 13:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACD3440A4C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 13:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CHzHC3RiGV2T for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Jul 2026 13:14:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8082340830
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8082340830
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8082340830
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 13:14:07 +0000 (UTC)
X-CSE-ConnectionGUID: xcuD1mfVQymjn3rxUwFqgQ==
X-CSE-MsgGUID: sbnDUSgmRUSjZTw7vQQ0XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="101521530"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="101521530"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 06:14:06 -0700
X-CSE-ConnectionGUID: WQzG8MpsTY6n1o1gH5Jpzg==
X-CSE-MsgGUID: wJjsyAA6R2qcUYQWgyxI8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="251963225"
Received: from linux.intel.com ([10.54.29.200])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 06:14:06 -0700
Received: from [10.102.88.191] (soc-5CG4396XFD.clients.intel.com
 [10.102.88.191])
 by linux.intel.com (Postfix) with ESMTP id 8E28720C5DC7;
 Mon,  6 Jul 2026 06:14:03 -0700 (PDT)
Message-ID: <80a56d5b-da01-4ece-a7f4-56b357e654a7@linux.intel.com>
Date: Mon, 6 Jul 2026 15:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Marcin Szycik <marcin.szycik@linux.intel.com>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
 <9750092f-264e-45a1-af11-2f574ab67fa4@linux.intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <9750092f-264e-45a1-af11-2f574ab67fa4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783343647; x=1814879647;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/gzse8Hbg6PtoujjX4AgsuIwqG3oGT1yLJT6Vw3slKo=;
 b=KXM+DUnL4MWuXk55ExkiTexIV8SC5R148UzYA34x6vtz1x7g05sQS3ZT
 vg7c1h0aySfK2FxPsJN75kgSyzfCKjK0YtdGEJyMaEhTvVZ3U13/PRlX4
 hCkJYzWDaXZcbC4PyeBhbqCUynxRx9hi+d8VLfCZuZAv4A2FwlVFmNLlg
 v1QCTaSGUEwPwIPtwmpF8rcXL/AbTy4cDQH54OOTgNto9z/djnN+Xr4eO
 znt/aN9T6xUPTtQPKQkOocCProdKlTHQrxnjCjLyvhD42kYq/C712uB/t
 Bw/IzjH9QceLuB+z8i/J/ON1YilIu8pV8Yrg+wRZityVXX6UAPsnrShzj
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KXM+DUnL
Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: validate E610 PFA TLV bounds
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



W dniu 6.07.2026 o 12:02, Marcin Szycik pisze:
> 
> 
> On 06/07/2026 11:25, Pengpeng Hou wrote:
>> ixgbe_get_pfa_module_tlv() walks E610 PFA TLV records stored in
>> EEPROM.
>>
>> Stop parsing malformed TLVs whose header or declared value length would
>> exceed the PFA boundary.
>>
>> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> index 4d8ae5b56145..03e88bdf5a43 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
>> @@ -3895,6 +3895,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>>  	while (next_tlv < pfa_end_ptr) {
>>  		u16 tlv_sub_module_type, tlv_len;
>>  
>> +		if (pfa_end_ptr - next_tlv < 2)
>> +			break;
> 
> This check could go in the while condition above.
> 
>> +
>>  		/* Read TLV type */
>>  		err = ixgbe_read_ee_aci_e610(hw, next_tlv,
>>  					     &tlv_sub_module_type);
>> @@ -3917,6 +3920,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>>  		/* Check next TLV, i.e. current TLV pointer + length + 2 words
>>  		 * (for current TLV's type and length).
>>  		 */
>> +		if (tlv_len > pfa_end_ptr - next_tlv - 2)
>> +			break;
>> +
>>  		next_tlv = next_tlv + tlv_len + 2;
> 
> Would be nice to define the magic number (2), since we're reusing it now.

There is a pending patch in review that defines IXGBE_E610_SR_PFA_TLV_HDR_SIZE, which fits perfectly here.

> 
>>  	}
>>  	/* Module does not exist */
> 
> Thanks,
> Marcin

Thanks,
Tomasz
