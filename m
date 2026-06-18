Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693BECD98F2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 18 Jun 2026 10:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA96741358;
	Thu, 18 Jun 2026 10:12:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DIaKaxdxIeEG; Thu, 18 Jun 2026 10:12:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5B104134F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781777544;
	bh=85ppLKVGJW40dGSGwyT9zJK+BiMuiKESQ/JsDwgk/u8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJ3M2TCgxKqobY/DBQCK2Exk3hSHY6cY4nQp9jESUTIAFCyP7S8Nop2C/JaT38ECf
	 KBJaEF4Wh2DZ83L22u5wAjQXarp8P8p+gcUlayd3wYXtxhiGwhGfyPiXVEw3JkIx4U
	 /aVdZ4v0OciGTj/M+o9wqvDWjvKmdxQ1OzN/XQUR/UC+Vd/z+RrVH+P2c0HKpnW46x
	 mbho6RFzX6jZmYRtrrn+88Ly4GKDwRwnKyeDysJY4UtAckxUfpe2dYrDX7COixkxDc
	 HKRU6Gz+9hRVCZ+BTk+sgG/3H1bw618ra+tZkiO1ZKOiunRw9FCkvsbf+aqxa2M2e6
	 nsKel9JF+ThUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5B104134F;
	Thu, 18 Jun 2026 10:12:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D8EC1F3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jun 2026 10:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2A5B9839DB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jun 2026 10:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VffEToEfPz5R for <intel-wired-lan@lists.osuosl.org>;
 Thu, 18 Jun 2026 10:12:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AA0F7839D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA0F7839D8
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA0F7839D8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 18 Jun 2026 10:12:21 +0000 (UTC)
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de
 [141.14.13.172])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 78B684C2887192;
 Thu, 18 Jun 2026 12:11:41 +0200 (CEST)
Message-ID: <a9f9da7b-d55f-4f8b-8db3-c33b623168d0@molgen.mpg.de>
Date: Thu, 18 Jun 2026 12:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260618073324.1843310-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough
 after reset
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

Dear Chia-Lin,


Thank you for your patch.

Am 18.06.26 um 09:33 schrieb Chia-Lin Kao (AceLan) via Intel-wired-lan:
> Some systems support MAC passthrough for dock Ethernet controllers by
> having firmware rewrite the receive address registers after the controller
> reset completes.

Please give one example system.

> igc resets the controller before reading RAL0/RAH0, so that reset can
> restore the controller native MAC address temporarily. If the driver reads
> the registers immediately, it can race the firmware rewrite and keep the
> native dock MAC instead of the host passthrough MAC.
> 
> For LMVP devices, poll RAL0/RAH0 after reset and before reading the MAC

What is LMVP?

> address. Stop once the address registers change to another valid Ethernet
> address, allowing firmware a bounded window to complete the passthrough
> update.

What are the downsides of this approach? Longer reset times?

Please add instructions how to test this.

> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 48 +++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 2c9e2dfd8499..fa9752ed8bc5 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -11,6 +11,7 @@
>   #include <net/pkt_sched.h>
>   #include <linux/bpf_trace.h>
>   #include <net/xdp_sock_drv.h>
> +#include <linux/etherdevice.h>
>   #include <linux/pci.h>
>   #include <linux/mdio.h>
>   
> @@ -69,6 +70,52 @@ static const struct pci_device_id igc_pci_tbl[] = {
>   
>   MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>   
> +static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32 *rah)
> +{
> +	*ral = rd32(IGC_RAL(0));
> +	*rah = rd32(IGC_RAH(0));
> +
> +	addr[0] = *ral & 0xff;
> +	addr[1] = (*ral >> 8) & 0xff;
> +	addr[2] = (*ral >> 16) & 0xff;
> +	addr[3] = (*ral >> 24) & 0xff;
> +	addr[4] = *rah & 0xff;
> +	addr[5] = (*rah >> 8) & 0xff;

This looks like a common pattern, but there does not seem to be a 
generic Linux implementation. Maybe `igc_read_mac_addr()` in 
`drivers/net/ethernet/intel/igc/igc_nvm.c` can be used?

> +}
> +
> +static bool igc_is_lmvp_device(struct pci_dev *pdev)
> +{
> +	switch (pdev->device) {
> +	case IGC_DEV_ID_I225_LMVP:
> +	case IGC_DEV_ID_I226_LMVP:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
> +					      struct igc_hw *hw)
> +{
> +	u8 addr[ETH_ALEN] __aligned(2);
> +	u32 orig_ral, orig_rah;
> +	u32 ral, rah;
> +	int i;
> +
> +	if (!igc_is_lmvp_device(pdev))
> +		return;
> +
> +	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
> +
> +	for (i = 0; i < 100; i++) {
> +		msleep(100);

Up to ten seconds delay(?) sounds excessive. Please elaborate in the 
commit message.

> +		igc_read_rar0(hw, addr, &ral, &rah);
> +		if ((ral != orig_ral || rah != orig_rah) &&
> +		    is_valid_ether_addr(addr))
> +			return;
> +	}

No error in case this didn’t work?

> +}
> +
>   enum latency_range {
>   	lowest_latency = 0,
>   	low_latency = 1,
> @@ -7259,6 +7306,7 @@ static int igc_probe(struct pci_dev *pdev,
>   	 * known good starting state
>   	 */
>   	hw->mac.ops.reset_hw(hw);
> +	igc_wait_for_lmvp_mac_passthrough(pdev, hw);
>   
>   	if (igc_get_flash_presence_i225(hw)) {
>   		if (hw->nvm.ops.validate(hw) < 0) {


Kind regards,

Paul
