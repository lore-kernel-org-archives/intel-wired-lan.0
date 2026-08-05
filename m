Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C77C55174
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Aug 2026 05:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA7CC606FF;
	Wed,  5 Aug 2026 05:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6pzh-PU-Od7Y; Wed,  5 Aug 2026 05:56:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A1BB60718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785909389;
	bh=Fy7q5oUdDdTwkba/8oxUvHzLPTWtlmjpZn4wEEkR7hk=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8d5xcXF/dI3oGNzFVLTYW+yIi7r7IzqbVYWe+7GY6sxZrbAEw7lm3+izem+LBFJBV
	 D0+vvduz9xjCfksbPUe3ZaqyXrSqTQAVjLfRs/hI8PLdZ/HgaSkJJKwNl9qF+VZw/v
	 6oiPXetqhSBkS6WwmXSp3S4cdaTcJLo6KsVi8klAIk4pYwSC7yI3dFi42uBQke/SLN
	 0kRG9krv1ffBEtDkGngIqPPY0/PKU6D463SnbS27aHKUoFozqxAsoQ04+xg6dgMJ7+
	 ijodSo8NMFPHqsX/u+maHZsjv0pwXuhl79MDY8xtMfTuu4IvhG4g5nt8dGbppxxSZu
	 TntwmfzP5MWSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A1BB60718;
	Wed,  5 Aug 2026 05:56:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DF0B23F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 05:56:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1742440435
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 05:56:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M6BowoVNSDYV for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Aug 2026 05:56:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4B9CA403FB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B9CA403FB
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B9CA403FB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Aug 2026 05:56:24 +0000 (UTC)
Received: from [192.168.2.228] (p57bd9ff3.dip0.t-ipconnect.de [87.189.159.243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8FCD24C1F29982;
 Wed, 05 Aug 2026 07:56:05 +0200 (CEST)
Message-ID: <6fbdcda1-5310-42a2-975d-73ee49e84ee7@molgen.mpg.de>
Date: Wed, 5 Aug 2026 07:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
References: <20260804153922.688462-1-tomasz.lichwala@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260804153922.688462-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
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

Dear Tomasz,


Thank you for your patch.

Am 04.08.26 um 17:39 schrieb Tomasz Lichwala:
> On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
> Instead, link status is exposed through emulated PCI config space at offset
> 0x209 in VFLINKS register format. Read and decode it when checking link on
> E610 VFs.

Is that emulated space documented somewhere? It’d be great if you added 
a reference.

Also, it’d be great if you documented the commands and output without 
and with your patch in the commit message, and mention the Hyper-V 
environment.

> Fixes: 4c44b450c69b ("ixgbevf: Add support for Intel(R) E610 device")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbevf/vf.c | 79 ++++++++++++++++++++++---
>   1 file changed, 70 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
> index f6df86d124b9..4c460ec62de3 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/vf.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
> @@ -1,14 +1,17 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright(c) 1999 - 2024 Intel Corporation. */
>   
> +#include <linux/unaligned.h>
> +
>   #include "vf.h"
>   #include "ixgbevf.h"
>   
> -/* On Hyper-V, to reset, we need to read from this offset
> - * from the PCI config space. This is the mechanism used on
> - * Hyper-V to support PF/VF communication.
> +/* On Hyper-V the PF/VF communication is through emulated PCI config
> + * space. The reset and link status are exposed at the offsets below.
>    */
> -#define IXGBE_HV_RESET_OFFSET           0x201
> +#define IXGBE_HV_RESET_OFFSET		0x201
> +#define IXGBE_HV_LINK_STATUS_OFFSET	0x209
> +#define IXGBE_HV_LINK_STATUS_SIZE	4
>   
>   static inline s32 ixgbevf_write_msg_read_ack(struct ixgbe_hw *hw, u32 *msg,
>   					     u32 *retmsg, u16 size)
> @@ -901,6 +904,40 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>   	return ret_val;
>   }
>   
> +/**
> + * ixgbevf_hv_read_links_e610 - read link status from PCI config space
> + * @hw: pointer to hardware structure
> + * @links_reg: pointer to store read value
> + *
> + * On Hyper-V E610 VFs the VFLINKS register does not carry valid link speed.
> + * Instead, link status is exposed through emulated PCI config space at offset
> + * 0x209 in VFLINKS register format.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +static s32 ixgbevf_hv_read_links_e610(struct ixgbe_hw *hw, u32 *links_reg)
> +{
> +	struct ixgbevf_adapter *adapter = hw->back;
> +
> +#if IS_ENABLED(CONFIG_PCI_MMCONFIG)

Can the check be done in C code, and the linker will remove the unused 
stuff? This way everything would be seen by the compiler and compile 
checked.

> +	u8 data[IXGBE_HV_LINK_STATUS_SIZE];
> +
> +	for (int i = 0; i < IXGBE_HV_LINK_STATUS_SIZE; i++) {
> +		int ret = pci_read_config_byte(adapter->pdev,
> +					       IXGBE_HV_LINK_STATUS_OFFSET + i,
> +					       &data[i]);
> +		if (ret)
> +			return pcibios_err_to_errno(ret);
> +	}
> +
> +	*links_reg = get_unaligned_le32(data);
> +	return 0;
> +#else
> +	dev_err_once(&adapter->pdev->dev, "cannot read link status, PCI_MMCONFIG is required for Hyper-V\n");
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
>   /**
>    * ixgbevf_hv_check_mac_link_vf - check link
>    * @hw: pointer to private hardware struct
> @@ -909,6 +946,7 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
>    * @autoneg_wait_to_complete: unused
>    *
>    * Hyper-V variant; there is no mailbox communication.
> + * For E610 VFs, link status is read from emulated PCI config space.
>    */
>   static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>   					ixgbe_link_speed *speed,
> @@ -923,13 +961,30 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>   	if (!mbx->ops.check_for_rst(hw) || !mbx->timeout)
>   		mac->get_link_status = true;
>   
> +	/* E610 VFs always read link status from emulated PCI config space
> +	 * because VFLINKS does not carry valid speed for these devices.
> +	 * Skip get_link_status caching since PCI config reads are cheap.
> +	 */
> +	if (mac->type == ixgbe_mac_e610_vf) {
> +		if (ixgbevf_hv_read_links_e610(hw, &links_reg)) {
> +			*link_up = false;
> +			*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +			return 0;
> +		}
> +		goto decode;
> +	}
> +
>   	if (!mac->get_link_status)
>   		goto out;
>   
> -	/* if link status is down no point in checking to see if pf is up */
>   	links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
> -	if (!(links_reg & IXGBE_LINKS_UP))
> -		goto out;
> +
> +decode:

How would the implementation without goto look like?

> +	if (!(links_reg & IXGBE_LINKS_UP)) {
> +		*link_up = false;
> +		*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +		return 0;
> +	}
>   
>   	/* for SFP+ modules and DA cables on 82599 it can take up to 500usecs
>   	 * before the link status is correct
> @@ -941,8 +996,11 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>   			udelay(100);
>   			links_reg = IXGBE_READ_REG(hw, IXGBE_VFLINKS);
>   
> -			if (!(links_reg & IXGBE_LINKS_UP))
> -				goto out;
> +			if (!(links_reg & IXGBE_LINKS_UP)) {
> +				*link_up = false;
> +				*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +				return 0;
> +			}
>   		}
>   	}
>   
> @@ -956,6 +1014,9 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>   	case IXGBE_LINKS_SPEED_100_82599:
>   		*speed = IXGBE_LINK_SPEED_100_FULL;
>   		break;
> +	default:
> +		*speed = IXGBE_LINK_SPEED_UNKNOWN;
> +		break;
>   	}
>   
>   	/* if we passed all the tests above then the link is up and we no


Kind regards,

Paul
