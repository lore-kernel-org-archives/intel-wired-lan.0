Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CC7C88E41
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Jan 2026 09:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EB5D60F45;
	Tue, 27 Jan 2026 09:33:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uDgS8Q8p3fbU; Tue, 27 Jan 2026 09:33:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9253060F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769506410;
	bh=lLEEtZF8NjUwn0PIeqhUc7vSFwYON8x7rgvFU9I4Xkc=;
	h=Date:To:References:From:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UW6i6/Ga32qc0vLcmJy3/BP5jd/LEx5/vQAVTXwvOXaFFDOZXNVU54P1zZ8lX1jHh
	 kBWUFH/nz/MGaxwo4zC6wvrGEc3vhusloK4aM5D+cfUhmEA2BqfwDzaQ4mcOHvOv3o
	 dIc97GuqSAIf+jnkNsGk+SLI3MHEXc346qP3nnhUzaRBXjOHlIbvlfyZY9bPS4xC6+
	 fO56NPQo4gaNS1HInP6W3ABRygi4fIOgbGwFepcc6rR1y67X/I41J/LjRPBRUHI6vL
	 s+7eOIkKi7Jtk6m7MQiV4T/+Z92dvDw1DMiTHRfN/1cdc9lle47xLoaaPf0ks+qaRw
	 UL8KCw7FLcxLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9253060F3B;
	Tue, 27 Jan 2026 09:33:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB18733A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 09:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE6A982347
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 09:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h08DOnlaARzn for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Jan 2026 09:33:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 927CE8087E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 927CE8087E
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 927CE8087E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 09:33:24 +0000 (UTC)
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de
 [141.14.13.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9D07B4C4430329;
 Tue, 27 Jan 2026 10:33:08 +0100 (CET)
Message-ID: <5b1848e8-785c-4030-b496-b6fa83fffd86@molgen.mpg.de>
Date: Tue, 27 Jan 2026 10:33:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20260106141420.1585948-1-vitaly.lifshits@intel.com>
 <20260106141420.1585948-2-vitaly.lifshits@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20260106141420.1585948-2-vitaly.lifshits@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v4 1/2] e1000e: introduce new
 board type for Panther Lake PCH
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

Dear Vitaly,


Thank you for your patch.

Am 06.01.26 um 15:14 schrieb Vitaly Lifshits:
> Add new board type for Panther Lake devices for separating device-specific
> features and flows.

For the next time, it would have helped me to write, that in this patch 
it’s an exact copy from `board_pch_mtp`.

> Additionally, remove the deprecated device IDs 0x57B5 and 0x57B6, which
> are not used by any existing devices.

For the future, a separate patch would be nice.

> Fixes: 0c9183ce61bc ("e1000e: Add support for the next LOM generation")
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
> v4: fix commit message
> v2: edit commit message to clarify the changes
> v1: initial version
> ---
>   drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
>   drivers/net/ethernet/intel/e1000e/hw.h      |  2 --
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 20 ++++++++++++++++++++
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 15 +++++++--------
>   4 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
> index aa08f397988e..63ebe00376f5 100644
> --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> @@ -117,7 +117,8 @@ enum e1000_boards {
>   	board_pch_cnp,
>   	board_pch_tgp,
>   	board_pch_adp,
> -	board_pch_mtp
> +	board_pch_mtp,
> +	board_pch_ptp
>   };
>   
>   struct e1000_ps_page {
> @@ -527,6 +528,7 @@ extern const struct e1000_info e1000_pch_cnp_info;
>   extern const struct e1000_info e1000_pch_tgp_info;
>   extern const struct e1000_info e1000_pch_adp_info;
>   extern const struct e1000_info e1000_pch_mtp_info;
> +extern const struct e1000_info e1000_pch_ptp_info;
>   extern const struct e1000_info e1000_es2_info;
>   
>   void e1000e_ptp_init(struct e1000_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
> index fc8ed38aa095..c7ac599e5a7a 100644
> --- a/drivers/net/ethernet/intel/e1000e/hw.h
> +++ b/drivers/net/ethernet/intel/e1000e/hw.h
> @@ -118,8 +118,6 @@ struct e1000_hw;
>   #define E1000_DEV_ID_PCH_ARL_I219_V24		0x57A1
>   #define E1000_DEV_ID_PCH_PTP_I219_LM25		0x57B3
>   #define E1000_DEV_ID_PCH_PTP_I219_V25		0x57B4
> -#define E1000_DEV_ID_PCH_PTP_I219_LM26		0x57B5
> -#define E1000_DEV_ID_PCH_PTP_I219_V26		0x57B6
>   #define E1000_DEV_ID_PCH_PTP_I219_LM27		0x57B7
>   #define E1000_DEV_ID_PCH_PTP_I219_V27		0x57B8
>   #define E1000_DEV_ID_PCH_NVL_I219_LM29		0x57B9
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 0ff8688ac3b8..eead80bba6f4 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -6208,3 +6208,23 @@ const struct e1000_info e1000_pch_mtp_info = {
>   	.phy_ops		= &ich8_phy_ops,
>   	.nvm_ops		= &spt_nvm_ops,
>   };
> +
> +const struct e1000_info e1000_pch_ptp_info = {
> +	.mac			= e1000_pch_ptp,
> +	.flags			= FLAG_IS_ICH
> +				  | FLAG_HAS_WOL
> +				  | FLAG_HAS_HW_TIMESTAMP
> +				  | FLAG_HAS_CTRLEXT_ON_LOAD
> +				  | FLAG_HAS_AMT
> +				  | FLAG_HAS_FLASH
> +				  | FLAG_HAS_JUMBO_FRAMES
> +				  | FLAG_APME_IN_WUC,
> +	.flags2			= FLAG2_HAS_PHY_STATS
> +				  | FLAG2_HAS_EEE,
> +	.pba			= 26,
> +	.max_hw_frame_size	= 9022,
> +	.get_variants		= e1000_get_variants_ich8lan,
> +	.mac_ops		= &ich8_mac_ops,
> +	.phy_ops		= &ich8_phy_ops,
> +	.nvm_ops		= &spt_nvm_ops,
> +};
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 116f3c92b5bc..c066d820f53b 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -55,6 +55,7 @@ static const struct e1000_info *e1000_info_tbl[] = {
>   	[board_pch_tgp]		= &e1000_pch_tgp_info,
>   	[board_pch_adp]		= &e1000_pch_adp_info,
>   	[board_pch_mtp]		= &e1000_pch_mtp_info,
> +	[board_pch_ptp]		= &e1000_pch_ptp_info,
>   };
>   
>   struct e1000_reg_info {
> @@ -7926,14 +7927,12 @@ static const struct pci_device_id e1000_pci_tbl[] = {
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V21), board_pch_mtp },
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_LM24), board_pch_mtp },
>   	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_V24), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM25), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V25), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM26), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V26), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM27), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29), board_pch_mtp },
> -	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29), board_pch_mtp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM25), board_pch_ptp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V25), board_pch_ptp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM27), board_pch_ptp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27), board_pch_ptp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29), board_pch_ptp },
> +	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29), board_pch_ptp },
>   
>   	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
>   };

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
