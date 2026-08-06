Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004CFC56208
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 10:45:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A92680A4C;
	Thu,  6 Aug 2026 10:45:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JIUCKc6OmZ0e; Thu,  6 Aug 2026 10:45:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5F1C280DB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786013127;
	bh=wJT54aJtI154/3zPtNxuIgbRnzyE574CP19Nus2JAoI=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U+Da2jXVqSp2jp9NpPWZT9LmhbVD4A/VD5fG18S9vU+hrQigqe4xd4OSjb7aszulU
	 idbV3fwOw3SmZUsbnPypnHfHMP3a5Tq/8f6RRIYX+yPgoNetPu+Q3w+tFWZqxt078h
	 Prc9iZyNvnxU221KhZiGmgLwJWrJG+KBjyb/0YdqTNQies7pBjY/U4xuZbAmIt7/nv
	 VdAtADG2T9lCFkHBNdVDpfG4COKkFrPHSey625Q95gCjYZd58K9Z/+UWfTa0Ensef9
	 PsnvPDkLsSh+el4Ez109e4+i48NyQn+Bl7HTOVocdWzhKATPUweSiwrAFKpwzqK0M/
	 pkWIvQU4tvE9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F1C280DB0;
	Thu,  6 Aug 2026 10:45:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D5C33397
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 10:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7A2240264
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 10:45:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rKRnjDvy3eTq for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 10:45:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6C83240262
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C83240262
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C83240262
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 10:45:22 +0000 (UTC)
X-CSE-ConnectionGUID: HoHMZAX5TEWb64qdxlINKA==
X-CSE-MsgGUID: 3SG4QshFT7WP5tltXMEX2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90275633"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="90275633"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 03:45:22 -0700
X-CSE-ConnectionGUID: XvIs5PM+TIGmrIcv8TB4xw==
X-CSE-MsgGUID: U8Rl7esWSHmzXg4Gkl3wmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="300287543"
Received: from linux.intel.com ([10.54.29.200])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 03:45:22 -0700
Received: from [10.102.88.243] (soc-5CG4396XFD.clients.intel.com
 [10.102.88.243])
 by linux.intel.com (Postfix) with ESMTP id 5477720BF398;
 Thu,  6 Aug 2026 03:45:21 -0700 (PDT)
Message-ID: <1b95d985-0a49-4222-a953-0aab18e414d2@linux.intel.com>
Date: Thu, 6 Aug 2026 12:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20260804153922.688462-1-tomasz.lichwala@linux.intel.com>
 <6fbdcda1-5310-42a2-975d-73ee49e84ee7@molgen.mpg.de>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <6fbdcda1-5310-42a2-975d-73ee49e84ee7@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786013124; x=1817549124;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=J4i2bwdPezVz0VAYIG/M2FXejSNyFYp2TlKqHzVsyOs=;
 b=MUjoebTJ1DiHatTlJ+gF1t3zrKIYrY1VFMpCHKeapIuX8ht9Z5w986oX
 kf++IuiWg+dHTI8W9fNVxAe7InPfZUDHZfnPqu39hKYbkrBadqi0QyIX/
 dWEQS1YLWomsMpdPrK74nH/vLPIlGh9bS25x3pGhZ8Qvk0qdTZyAWjjM1
 sIGYYk7/riG4JGF6R9FGYe69IvJYA3vQdcBpdyxZ3jM3LuJRx8K4t+6H4
 RyRm/Lq+5eyVWnmS4dFaNnHHhQeq2qlgEeAWTDW0NqRRa9DzHJbnskEJC
 tH1hXR2fjjsoPOuaB4Ex5VBLsPdj3W3raN1Fpw7VhVQPv72eoQVdpa7AR
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MUjoebTJ
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ixgbevf: fix link speed
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



On 5.08.2026 07:56, Paul Menzel wrote:
> Dear Tomasz,
> 
> 
> Thank you for your patch.
> 
> Am 04.08.26 um 17:39 schrieb Tomasz Lichwala:
>> On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
>> Instead, link status is exposed through emulated PCI config space at offset
>> 0x209 in VFLINKS register format. Read and decode it when checking link on
>> E610 VFs.
> 
> Is that emulated space documented somewhere? It’d be great if you added a reference.
> 

The emulated PCI config space layout is defined by the Hyper-V NetVSC synthetic NIC interface. I've expanded the commit message to mention the Hyper-V synthetic NIC and added before/after ethtool output.

> Also, it’d be great if you documented the commands and output without and with your patch in the commit message, and mention the Hyper-V environment.
> 

Expanded the commit message to describe the problem — VFLINKS does not reflect the actual negotiated speed on E610 VFs under Hyper-V, and how the fix reads link status from emulated PCI config space instead. I did not include specific ethtool output because the reported speed varies depending on  the NIC and link configuration.

>> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
>> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
>> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbevf/vf.c | 79 ++++++++++++++++++++++---
>>   1 file changed, 70 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
>> index f6df86d124b9..4c460ec62de3 100644
>> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
>> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
>> @@ -1,14 +1,17 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright(c) 1999 - 2024 Intel Corporation. */
>>   +#include <linux/unaligned.h>
>> +
>>   #include "vf.h"
>>   #include "ixgbevf.h"
>>   -/* On Hyper-V, to reset, we need to read from this offset
>> - * from the PCI config space. This is the mechanism used on
>> - * Hyper-V to support PF/VF communication.
>> +/* On Hyper-V the PF/VF communication is through emulated PCI config
>> + * space. The reset and link status are exposed at the offsets below.
>>    */
>> -#define IXGBE_HV_RESET_OFFSET           0x201
>> +#define IXGBE_HV_RESET_OFFSET        0x201
>> +#define IXGBE_HV_LINK_STATUS_OFFSET    0x209
>> +#define IXGBE_HV_LINK_STATUS_SIZE    4
>>     static inline s32 ixgbevf_write_msg_read_ack(struct ixgbe_hw *hw, u32 *msg,
>>                            u32 *retmsg, u16 size)
>> @@ -901,6 +904,40 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>>       return ret_val;
>>   }
>>   +/**
>> + * ixgbevf_hv_read_links_e610 - read link status from PCI config space
>> + * @hw: pointer to hardware structure
>> + * @links_reg: pointer to store read value
>> + *
>> + * On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
>> + * Instead, link status is exposed through emulated PCI config space at offset
>> + * 0x209 in VFLINKS register format.
>> + *
>> + * Return: 0 on success, negative error code on failure.
>> + */
>> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
>> +{
>> +    struct ixgbevf_adapter *adapter = hw->back;
>> +
>> +#if IS_ENABLED(CONFIG_PCI_MMCONFIG)
> 
> Can the check be done in C code, and the linker will remove the unused stuff? This way everything would be seen by the compiler and compile checked.
> 

Good point. Dropped the #if IS_ENABLED(CONFIG_PCI_MMCONFIG) guard entirely. Offset 0x209 is in extended PCI config space, so pci_read_config_byte() will return a PCIBIOS error if ECAM is not available, and the caller already handles read failures by reporting link down. This way the compiler always sees the full code path.

>> +    u8 data[IXGBE_HV_LINK_STATUS_SIZE];
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
>> +#else
>> +    dev_err_once(&adapter->pdev->dev, "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
>> +    return -EOPNOTSUPP;
>> +#endif
>> +}
>> +
>>   /**
>>    * ixgbevf_hv_check_mac_link_vf - check link
>>    * @hw: pointer to private hardware struct
>> @@ -909,6 +946,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>>    * @autoneg_wait_to_complete: unused
>>    *
>>    * Hyper-V variant; there is no mailbox communication.
>> + * For E610 VFs, link status is read from emulated PCI config space.
>>    */
>>   static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>>                       ixgbe_link_speed *speed,
>> @@ -923,13 +961,30 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>>       if (!mbx->ops.check_for_rst(hw) || !mbx->timeout)
>>           mac->get_link_status = true;
>>   +    /* E610 VFs always read link status from emulated PCI config space
>> +     * because VFLINKS does not carry valid speed for these devices.
>> +     * Skip get_link_status caching since PCI config reads are cheap.
>> +     */
>> +    if (mac->type == ixgbe_mac_e610_vf) {
>> +        if (ixgbevf_hv_read_links_e610(hw, &links_reg)) {
>> +            *link_up = false;
>> +            *speed = IXGBE_LINK_SPEED_UNKNOWN;
>> +            return 0;
>> +        }
>> +        goto decode;
>> +    }
>> +
>>       if (!mac->get_link_status)
>>           goto out;
>>   -    /* if link status is down no point in checking to see if pf is up */
>>       links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
>> -    if (!(links_reg & IXGBE_LINKS_UP))
>> -        goto out;
>> +
>> +decode:
> 
> How would the implementation without goto look like?
> 

Replaced goto decode with an if/else structure - the E610 path and the VFLINKS register read are now in separate branches, falling through to the common link-down / speed decode logic below.

>> +    if (!(links_reg & IXGBE_LINKS_UP)) {
>> +        *link_up = false;
>> +        *speed = IXGBE_LINK_SPEED_UNKNOWN;
>> +        return 0;
>> +    }
>>         /* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
>>        * before the link status is correct
>> @@ -941,8 +996,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>>               udelay(100);
>>               links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
>>   -            if (!(links_reg & IXGBE_LINKS_UP))
>> -                goto out;
>> +            if (!(links_reg & IXGBE_LINKS_UP)) {
>> +                *link_up = false;
>> +                *speed = IXGBE_LINK_SPEED_UNKNOWN;
>> +                return 0;
>> +            }
>>           }
>>       }
>>   @@ -956,6 +1014,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>>       case IXGBE_LINKS_SPEED_100_82599:
>>           *speed = IXGBE_LINK_SPEED_100_FULL;
>>           break;
>> +    default:
>> +        *speed = IXGBE_LINK_SPEED_UNKNOWN;
>> +        break;
>>       }
>>         /* if we passed all the tests above then the link is up and we no
> 
> 
> Kind regards,
> 
> Paul


Kind regards,

Tomasz

