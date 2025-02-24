Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02470C021A4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Feb 2025 13:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A033F812BB;
	Mon, 24 Feb 2025 13:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SxBMsB_iXtgI; Mon, 24 Feb 2025 13:53:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4AE5812B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740405205;
	bh=DMf6YG7WwRRhtIf0+RiWEfOdkifBxzEYoPVu9DoZYSg=;
	h=Date:To:References:Cc:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nG+Hb/a4yk8seDA9DxGu2MAmzNbe1Gm4LItzznwk4um7xgf7cgc1YP/n41rESShMx
	 jH705NConYIplUREDStryUbYEN7YMQcCpAJrAz0/jD440R7fJdMYbXTUbWomc7cEyM
	 h+DSjLt94Ay8kSbS2DX5uGqkgNw1LqHbfyp4X4o4M8B/+GLYxCQ13KMbW5faX0IxBJ
	 OXb3ErLfCqixS9VQxx6dLJBp9v5877gpTuxk+8JLEtcis9RfVk0OwukybvSbqxGxqK
	 APBoJhpeBekw1NacYqELMvPj2UM/jjFHN6B6zU/tqHNDL7vEu1GzEWfwiz+c/Axoo4
	 IPuPKm/Ee2Wew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4AE5812B7;
	Mon, 24 Feb 2025 13:53:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 280AD920
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Feb 2025 13:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07C0F40A35
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Feb 2025 13:53:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sqI_1GkTK-aR for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Feb 2025 13:53:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0F4B540159
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F4B540159
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F4B540159
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Feb 2025 13:53:22 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D602161E647A3;
 Mon, 24 Feb 2025 14:53:06 +0100 (CET)
Message-ID: <d18bf142-9185-4c81-8f9e-67f772bbddf4@molgen.mpg.de>
Date: Mon, 24 Feb 2025 14:53:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20250224101218.1915949-1-vitaly.lifshits@intel.com>
Content-Language: en-US
Cc: intel-wired-lan@lists.osuosl.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250224101218.1915949-1-vitaly.lifshits@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 1/1] e1000e: change k1 exit
 timeout on MTP and later platforms
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

Am 24.02.25 um 11:12 schrieb Vitaly Lifshits:
> LAN devices starting from Meteorlake the interface between the MAC and

Meteor Lake

> the PHY has a different frequency.

The sentences reads a little strange. Maybe:

Starting with Meteor Lake, the frequency of MAC and PHY of the LAN 
devices differ, cf. datasheet X section Y.

Also, I’d add a blank between paragraphs.

> This caused sporadic MDI errors when accessing the PHY and a rare case

cause*s*

> of packets corruption. To overcome this introduce a PHY K1 exit timeout

Does Linux log these errors and corruptions?

> reconfiguration in the init flow. The exit timeout is reverted during
> the hardware reset, thus, it is required to be called in a few places.

Excuse my ignorance, but what do different frequencies have to do with 
the exit timeout?

How did you test this?

> Fixes: cc23f4f0b6b9 ("e1000e: Add support for Meteor Lake")
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 78 +++++++++++++++++++--
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  4 ++
>   2 files changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 2f9655cf5dd9..d3636433938e 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -285,6 +285,46 @@ static void e1000_toggle_lanphypc_pch_lpt(struct e1000_hw *hw)
>   	}
>   }
>   
> +/**
> + * e1000_reconfigure_k1_exit_timeout - reconfigure K1 exit timeout to
> + * align to MTP and later platform requirements.
> + * @hw: pointer to the HW structure
> + *
> + * Assuming that PHY semaphore is taken prior to this function call.
> + *
> + * Return: 0 on success, negative on failure
> + */
> +static s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)

Why limit the variable length?

> +{
> +	u16 phy_timeout;

Please add the unit.

Why limit the variable length?

> +	u32 fextnvm12;
> +	s32 ret_val;
> +
> +	if (hw->mac.type < e1000_pch_mtp)
> +		return 0;
> +
> +	/* Change Kumeran K1 power down state from P0s to P1 */

What is Kumeran?

> +	fextnvm12 = er32(FEXTNVM12);
> +	fextnvm12 |= BIT(23);
> +	fextnvm12 &= ~BIT(22);
> +	ew32(FEXTNVM12, fextnvm12);
> +
> +	/* Wait for the interface the settle */
> +	msleep(1);

Any chance, of polling stuff instead of 1 ms sleep?

> +
> +	/* Change K1 exit timeout */
> +	ret_val = e1e_rphy_locked(hw, E1000_PHY_TIMEOUTS_REG,
> +				  &phy_timeout);
> +	if (ret_val)
> +		return ret_val;
> +
> +	phy_timeout &= ~E1000_PHY_TIMEOUTS_K1_EXIT_TO_MASK;
> +	phy_timeout |= 0xF00;
> +
> +	return e1e_wphy_locked(hw, E1000_PHY_TIMEOUTS_REG,
> +				  phy_timeout);
> +}
> +
>   /**
>    *  e1000_init_phy_workarounds_pchlan - PHY initialization workarounds
>    *  @hw: pointer to the HW structure
> @@ -327,15 +367,23 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
>   	 * LANPHYPC Value bit to force the interconnect to PCIe mode.
>   	 */
>   	switch (hw->mac.type) {
> +	case e1000_pch_mtp:
> +	case e1000_pch_lnp:
> +	case e1000_pch_ptp:
> +	case e1000_pch_nvp:
> +		/* At this point the PHY might be inaccessible so don't
> +		 * propagate the failure
> +		 */
> +		if (e1000_reconfigure_k1_exit_timeout(hw))
> +			break;
> +
> +		fallthrough;
>   	case e1000_pch_lpt:
>   	case e1000_pch_spt:
>   	case e1000_pch_cnp:
>   	case e1000_pch_tgp:
>   	case e1000_pch_adp:
> -	case e1000_pch_mtp:
> -	case e1000_pch_lnp:
> -	case e1000_pch_ptp:
> -	case e1000_pch_nvp:
> +
>   		if (e1000_phy_is_accessible_pchlan(hw))
>   			break;
>   
> @@ -421,6 +469,16 @@ static s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
>   		ret_val = hw->phy.ops.check_reset_block(hw);
>   		if (ret_val)
>   			e_err("ME blocked access to PHY after reset\n");
> +
> +		if (hw->mac.type >= e1000_pch_mtp) {
> +			ret_val = hw->phy.ops.acquire(hw);
> +			if (ret_val) {
> +				e_dbg("Failed to reconfigure K1 exit timeout\n");
> +				goto out;
> +			}
> +			ret_val = e1000_reconfigure_k1_exit_timeout(hw);
> +			hw->phy.ops.release(hw);
> +		}
>   	}
>   
>   out:
> @@ -4888,6 +4946,18 @@ static s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
>   	u16 i;
>   
>   	e1000_initialize_hw_bits_ich8lan(hw);
> +	if (hw->mac.type >= e1000_pch_mtp) {
> +		ret_val = hw->phy.ops.acquire(hw);
> +		if (ret_val)
> +			return ret_val;
> +
> +		ret_val = e1000_reconfigure_k1_exit_timeout(hw);
> +		if (ret_val) {
> +			e_dbg("Error failed to reconfigure K1 exit timeout\n");

This differs from the log above. Use consistent error messages?

> +			return ret_val;
> +		}
> +		hw->phy.ops.release(hw);
> +	}
>   
>   	/* Initialize identification LED */
>   	ret_val = mac->ops.id_led_init(hw);
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> index 2504b11c3169..dffc63e89ee2 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
> @@ -219,6 +219,10 @@
>   #define I217_PLL_CLOCK_GATE_REG	PHY_REG(772, 28)
>   #define I217_PLL_CLOCK_GATE_MASK	0x07FF
>   
> +/* PHY Timeouts */
> +#define E1000_PHY_TIMEOUTS_REG                   PHY_REG(770, 21)
> +#define E1000_PHY_TIMEOUTS_K1_EXIT_TO_MASK       0x0FC0
> +
>   #define SW_FLAG_TIMEOUT		1000	/* SW Semaphore flag timeout in ms */
>   
>   /* Inband Control */


Kind regards,

Paul
