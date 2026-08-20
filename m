Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D5FC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Aug 2026 09:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA0B860623;
	Thu, 20 Aug 2026 09:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhMJEFKCRS0c; Thu, 20 Aug 2026 09:56:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787219804;
	bh=gyVyqlEHzyIIf6Yx9sL92curVmVQ1olYszP8Bxy3MoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMxydLghiPSXG5TowhqbFyKwZxsZBfATnKRAs4Pu3VP4jA+58MxOPUjShVSCzDcnG
	 CeOpke3hWgtD+JNsPPhBpvaCEKIKvjOsiuti1djCbIsfU6o3w6zk469KztlwfM9+Vw
	 JSklMTXaWnYjMrmp0yZq+Ma2Va6GC6h3o46G/5oPXfZ+1PI8GSpLyKOHyHQ/n4NUoH
	 7S3FANWgNQqcAVEYnWHGwcOYpvuqkH7PC5PziFaSFx8QjfF8ubDEy9NDMvT1JFa0Iv
	 06snwTGnlrlUfgh+5idn3n4/D6HF6u1cAWKvyejqYK1q3XX61rsOZ4sm3ODwUkzUNi
	 8KXgIggAIV7zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4137E60656;
	Thu, 20 Aug 2026 09:56:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54815263
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3A8A240281
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNpVW8EdtsUP for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Aug 2026 09:56:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71D9F40275
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Aug 2026 09:56:40 +0000 (UTC)
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de
 [141.14.13.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 210A74C1A2DF84;
 Thu, 20 Aug 2026 11:56:15 +0200 (CEST)
Message-ID: <11560b0b-515b-4f43-8f8d-1c84ecb57696@molgen.mpg.de>
Date: Thu, 20 Aug 2026 11:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2] igc: Support ACPI-based MAC passthrough
To: Dima Ruinskiy <dima.ruinskiy@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, allen.lan@intel.com, acelan.kao@canonical.com,
 kuba@kernel.org
References: <20260820092137.1835887-1-dima.ruinskiy@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260820092137.1835887-1-dima.ruinskiy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Dear Dima,


Thank you for the patch.

Am 20.08.26 um 11:21 schrieb Dima Ruinskiy:
> Some systems implement a system MAC address object in the ACPI table,
> using either \\_SB.AMAC or \\MACA object names. This system MAC address,
> when enabled, is intended to override the permanent MAC address of a
> network controller in a docking station connected to the system.
> 
> Implement lookup of the relevant ACPI object names and use them to
> initialize the MAC address. Limit the scope to I225/I226 device IDs used
> in docking stations, to avoid interfering with onboard I225/I226 NICs.

Please document a system where this can be tested on. Please also paste 
the new log line.

> On systems where the feature is disabled or unsupported, the ACPI objects
> do not exist or do not contain a valid Ethernet MAC, causing a fallback
> to the existing MAC address initialization path.
> 
> Assisted-by: GitHub-Copilot:claude-opus-4.7
> Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> ---
> v2: limit scope to dock device ids
> v1: initial version
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  1 +
>   drivers/net/ethernet/intel/igc/igc_base.c |  8 +++
>   drivers/net/ethernet/intel/igc/igc_hw.h   |  2 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 69 +++++++++++++++++++++--
>   4 files changed, 76 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 88291f775c22..05affaa04aa4 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -567,6 +567,7 @@ enum igc_tx_flags {
>   
>   enum igc_boards {
>   	board_base,
> +	board_dock,
>   };
>   
>   /* The largest size we can write to the descriptor is 65535.  In order to
> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index ab9120a3127f..c9067cc79b69 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -474,4 +474,12 @@ const struct igc_info igc_base_info = {
>   	.get_invariants		= igc_get_invariants_base,
>   	.mac_ops		= &igc_mac_ops_base,
>   	.phy_ops		= &igc_phy_ops_base,
> +	.is_dock		= false,
> +};
> +
> +const struct igc_info igc_dock_info = {
> +	.get_invariants		= igc_get_invariants_base,
> +	.mac_ops		= &igc_mac_ops_base,
> +	.phy_ops		= &igc_phy_ops_base,
> +	.is_dock		= true,
>   };
> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/ethernet/intel/igc/igc_hw.h
> index 62aaee55668a..d14b7666b5d7 100644
> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
> @@ -69,9 +69,11 @@ struct igc_info {
>   	struct igc_mac_operations *mac_ops;
>   	const struct igc_phy_operations *phy_ops;
>   	struct igc_nvm_operations *nvm_ops;
> +	bool is_dock;
>   };
>   
>   extern const struct igc_info igc_base_info;
> +extern const struct igc_info igc_dock_info;
>   
>   enum igc_forced_speed_duplex {
>   	IGC_FORCED_10H,
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 82800a4a6d6c..15d0815a2110 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -11,6 +11,8 @@
>   #include <net/pkt_sched.h>
>   #include <linux/bpf_trace.h>
>   #include <net/xdp_sock_drv.h>
> +#include <linux/acpi.h>
> +#include <linux/hex.h>
>   #include <linux/pci.h>
>   #include <linux/mdio.h>
>   
> @@ -44,6 +46,7 @@ static const char igc_copyright[] =
>   
>   static const struct igc_info *igc_info_tbl[] = {
>   	[board_base] = &igc_base_info,
> +	[board_dock] = &igc_dock_info,
>   };
>   
>   static const struct pci_device_id igc_pci_tbl[] = {
> @@ -54,8 +57,8 @@ static const struct pci_device_id igc_pci_tbl[] = {
>   	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K), .driver_data = board_base },
>   	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_K2), .driver_data = board_base },
>   	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_K), .driver_data = board_base },
> -	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), .driver_data = board_base },
> -	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), .driver_data = board_base },
> +	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_LMVP), .driver_data = board_dock },
> +	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LMVP), .driver_data = board_dock },
>   	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I225_IT), .driver_data = board_base },
>   	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_LM), .driver_data = board_base },
>   	{ PCI_VDEVICE(INTEL, IGC_DEV_ID_I226_V), .driver_data = board_base },
> @@ -7116,6 +7119,57 @@ static enum hrtimer_restart igc_qbv_scheduling_timer(struct hrtimer *timer)
>   	return HRTIMER_NORESTART;
>   }
>   
> +static bool igc_get_acpi_mac_passthru(u8 *mac)
> +{
> +	static const struct {
> +		const char *name;
> +		acpi_object_type type;
> +		u32 length;
> +	} sources[] = {
> +		{ "\\_SB.AMAC", ACPI_TYPE_BUFFER, 23 },
> +		{ "\\MACA",     ACPI_TYPE_STRING, 22 },
> +	};
> +	struct acpi_buffer buffer;
> +	union acpi_object *obj;
> +	bool mac_found = false;
> +	acpi_status status;
> +	u8 buf[ETH_ALEN];
> +	int i;
> +
> +	if (!IS_ENABLED(CONFIG_ACPI))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(sources) && !mac_found; i++) {
> +		buffer.length = ACPI_ALLOCATE_BUFFER;
> +		buffer.pointer = NULL;
> +
> +		status = acpi_evaluate_object(NULL, (char *)sources[i].name,
> +					      NULL, &buffer);
> +		if (ACPI_FAILURE(status))
> +			continue;
> +
> +		obj = buffer.pointer;
> +		if (!obj || obj->type != sources[i].type ||
> +		    obj->string.length != sources[i].length)
> +			goto free_obj;
> +
> +		if (!strncmp(obj->string.pointer, "_AUXMAC_#", 9) ||
> +		    obj->string.pointer[21] != '#')
> +			goto free_obj;
> +
> +		if (hex2bin(buf, obj->string.pointer + 9, ETH_ALEN) ||
> +		    !is_valid_ether_addr(buf))
> +			goto free_obj;
> +
> +		ether_addr_copy(mac, buf);
> +		mac_found = true;
> +free_obj:
> +		kfree(obj);
> +	}
> +
> +	return mac_found;
> +}
> +
>   /**
>    * igc_probe - Device Initialization Routine
>    * @pdev: PCI device information struct
> @@ -7279,9 +7333,16 @@ static int igc_probe(struct pci_dev *pdev,
>   	}
>   
>   	if (eth_platform_get_mac_address(&pdev->dev, hw->mac.addr)) {
> -		/* copy the MAC address out of the NVM */
> -		if (hw->mac.ops.read_mac_addr(hw))
> +		/* Look for a system-provided MAC in the ACPI table before
> +		 * falling back to reading the address from the NVM.
> +		 */
> +		if (ei->is_dock && igc_get_acpi_mac_passthru(hw->mac.addr)) {
> +			netdev->addr_assign_type = NET_ADDR_STOLEN;
> +			dev_info(&pdev->dev, "Using ACPI pass-thru MAC addr %pM\n",
> +				 hw->mac.addr);
> +		} else if (hw->mac.ops.read_mac_addr(hw)) {
>   			dev_err(&pdev->dev, "NVM Read Error\n");
> +		}
>   	}
>   
>   	eth_hw_addr_set(netdev, hw->mac.addr);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
