Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F4DC5AC7A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 13:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C547A405C4;
	Thu,  6 Aug 2026 13:19:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uGNIbQpUIxAH; Thu,  6 Aug 2026 13:19:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04CAF405BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786022395;
	bh=IGZ8eiN3A0h0pYzTUmF74l3wc3gjw7/12tIZT4AePqs=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cbBIrJtsLiV/4RlpqwLQfX3UCcCPZB8IUtKaTunnjbyUMjc976VDobnCZQ4NRGB0U
	 jaJ2G6NnpVSRlRFvO/KNQFY/B+kOxUVwwJ8q2ZTncuRwkL6DOdoPyo7rM0CN+5sKe4
	 9BF9f95TD5MuWnLIwleeFs30Q3Ear3uNIpMFwi61ASujW+MkfdZNsxX56GMUXyU32C
	 sLrV6ekBK5ZiNSXgGMnz1gfwzpNeEFobtdOvnJwaYa9pobDBcScgBxJS4YzkDVBmy/
	 Wl2d44JrU31DkLk4I3dOQrQfhm2owXiVwLvq6Ir5DheapqzjOSuGY24aylAXSk7yL4
	 pCZKoMXTK8MAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04CAF405BD;
	Thu,  6 Aug 2026 13:19:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DEA4E218
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 13:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D07DE4027C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 13:19:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PRAps3SvT6kF for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 13:19:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F29EB40112
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F29EB40112
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F29EB40112
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 13:19:52 +0000 (UTC)
X-CSE-ConnectionGUID: eot/b9RQTOu+2qpixd0OmA==
X-CSE-MsgGUID: wiGV3ROcS7ebz/UddVPICw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74149669"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="74149669"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 06:19:52 -0700
X-CSE-ConnectionGUID: QlmF3fhaSC2ilVNJuLh2ig==
X-CSE-MsgGUID: Yyh/oUSgRzWWm8kl8dBqIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="286775959"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 06:19:52 -0700
Received: from [10.102.88.243] (soc-5CG4396XFD.clients.intel.com
 [10.102.88.243])
 by linux.intel.com (Postfix) with ESMTP id DA67420BF398;
 Thu,  6 Aug 2026 06:19:50 -0700 (PDT)
Message-ID: <539e7fa9-2443-4577-88e3-da024c992036@linux.intel.com>
Date: Thu, 6 Aug 2026 15:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260806104621.700901-1-tomasz.lichwala@linux.intel.com>
 <a1abe12d-fa5e-4f53-af12-45793d8f8e1a@intel.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <a1abe12d-fa5e-4f53-af12-45793d8f8e1a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786022393; x=1817558393;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=wGA/hDhK+bJByyCuOH3VcmDdlWghDBjmeV2U23CxvLk=;
 b=RqOzbEgIw/A03pq571IzI6Ji4FA+smf60vb8+UX6Xhug/t911xVKg8HG
 QMeEwBrsUQ5ojIIBKeexQiwt7fp0J7tyUCLTBRPdwogos43LdPv1J2JZH
 PznZ+dIC9wELzp+Pq8CXAwZhxAH5UA+fesLcrOqIVK1d+J1xWQuMUjwI5
 //0BqVSankniakYMBmw6xBxyRANe7eUPRBOShX99h2QrL1URSIWlFAbRr
 jHYIdjMixGIMzFZU+SR+JZqQhI13VDtLZR6hHn8/LhFEJriGHcJ7HNWxN
 A8tT16MTWkcGBcb15kuzw/xrXqezwrWh6FANGmCMb2XPwGJbw9kFBlyeN
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RqOzbEgI
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] ixgbevf: fix link speed
 reporting for Hyper-V E610 VFs
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



On 6.08.2026 15:04, Przemek Kitszel wrote:
> On 8/6/26 12:46, Tomasz Lichwala wrote:
>> When an E610 VF is running under Hyper-V, the VFLINKS register does not
>> carry valid link speed. The existing code reads speed from VFLINKS, which
>> does not reflect the actual negotiated speed. This results in ethtool
>> reporting a stale or incorrect link speed.
>>
>> The Hyper-V synthetic NIC exposes the actual link status through
>> emulated PCI config space at offset 0x209 in VFLINKS register format.
>> Read and decode link status from there when checking link on E610 VFs.
>>
>> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
>> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
>> ---
> 
> next time please provide changelog section here
> 

Noted, will include changelog in subsequent versions.

>>   drivers/net/ethernet/intel/ixgbevf/vf.c | 77 +++++++++++++++++++++----
>>   1 file changed, 65 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
>> index f6df86d124b9..8ad06e28b5de 100644
>> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
>> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
>> @@ -1,14 +1,17 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright(c) 1999 - 2024 Intel Corporation. */
>>   +#include <linux/unaligned.h>
>> +
>>   #include "vf.h"
>>   #include "ixgbevf.h"
>>   
> 
> [..]
> 
>> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
>> +{
>> +    struct ixgbevf_adapter *adapter = hw->back;
>> +    u8 data[IXGBE_HV_LINK_STATUS_SIZE];
> 
> following Paul's suggestion, you could add:
>     if (IS_ENABLED(CONFIG_PCI_MMCONFIG)) {
>         dev_err_once(&adapter->pdev->dev, "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
>         return -EOPNOTSUPP;
>     }
> 
> and this will give user more information
> 
> IS_ENABLED() is really nice macro :)
> 

I think you meant !IS_ENABLED() here. Without MMCONFIG, pci_read_config_byte() at offset 0x209 (extended config space) will return a PCIBIOS error anyway, and the caller handles that gracefully by reporting link down. I could add the explicit IS_ENABLED check for a friendlier diagnostic message, but the behavior is correct either way. Let me know if you'd prefer I add it in a v4.

>> +
>> +    for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
>> +        int ret = pci_read_config_byte(adapter->pdev,
>> +                           IXGBE_HV_LINK_STATUS_OFFSET + i,
>> +                           &data[i]);
>> +        if (ret)
>> +            return pcibios_err_to_errno(ret);
>> +    }
>> +
>> +    *links_reg = get_unaligned_le32(data);
>> +    return 0;
>> +}
>> +

Thanks,
Tomasz

