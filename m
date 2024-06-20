Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03D2C2BA18
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Jun 2024 06:48:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8139384651;
	Thu, 20 Jun 2024 06:48:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Thl1CmKU5gm0; Thu, 20 Jun 2024 06:48:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EB4784652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718866084;
	bh=HqDXcWzfMDQu5/vf3uwJLNGCHljBEKFnw9VIGyv4MSY=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=rZ26y0JsvBCePnRMJTg8+G9iSU12JCfBV1f0UWfJ4u+7tePyS6WCFqbDDSE/nSMr7
	 fGW3LvpzpSnNp6VImnhjgScXfbsmUCxhJ3CXNsSPQriGZuRaWhyN1XYALDykbxsIK9
	 7P/D7rMn2wnJFYxZNSceCQgZb8CGiwJ5jm9Haw8NyjzPc3FTQw0ngiiBiaq4lPYZaq
	 LQBWKLiSyi+r6jEB5eb0tclX8+BhQ2dR2290VS8BtKzoDf32o7Ng82ghrnFdbAOaBi
	 BvFJ/e2TyQ2oh76nvbmv/n98WyieEqxPpNeETV7SdQQHhPl6DQTcVG28KgOl9eW8mw
	 YWWbFlkyzBx0w==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EB4784652;
	Thu, 20 Jun 2024 06:48:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 251311BF29C
 for <intel-wired-lan@osuosl.org>; Thu, 20 Jun 2024 06:48:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11BB28464F
 for <intel-wired-lan@osuosl.org>; Thu, 20 Jun 2024 06:48:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6zwqd-Ha3YK1 for <intel-wired-lan@osuosl.org>;
 Thu, 20 Jun 2024 06:48:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 58CBE84651
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58CBE84651
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58CBE84651
 for <intel-wired-lan@osuosl.org>; Thu, 20 Jun 2024 06:47:59 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5af485.dynamic.kabel-deutschland.de
 [95.90.244.133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9A8F561E5FE01;
 Thu, 20 Jun 2024 08:47:38 +0200 (CEST)
Message-ID: <a964273e-8919-4586-825b-63cb3255be67@molgen.mpg.de>
Date: Thu, 20 Jun 2024 08:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Vitaly Lifshits <vitaly.lifshits@intel.com>
References: <20240620063645.4151337-1-vitaly.lifshits@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240620063645.4151337-1-vitaly.lifshits@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/1] e1000e: fix force
 smbus during suspend flow
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Hui Wang <hui.wang@canonical.com>, Todd Brandt <todd.e.brandt@intel.com>,
 intel-wired-lan@osuosl.org, Dieter Mummenschanz <dmummenschanz@web.de>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Dear Vitaly,


Thank you for your patch. For the summary, it’d be great if you could be 
more specific by saying it’s about limiting the scope.

Am 20.06.24 um 08:36 schrieb Vitaly Lifshits:
> Commit 861e8086029e ("e1000e: move force SMBUS from enable ulp function
> to avoid PHY loss issue") resolved a PHY access loss during suspend on
> Meteor Lake consumer platforms, but it affected corporate systems
> incorrectly.
> 
> A better fix, working for both consumer and corporate systems, was
> proposed in commit bfd546a552e1 ("e1000e: move force SMBUS near the end

SMBus

> of enable_ulp function"). However, it introduced a regression on older
> devices, such as [8086:15B8], [8086:15F9], [8086:15BE].

Sort the ids? Also, I do not have the ids memorized. Maybe also describe 
them.

Please summarize the regression, and maybe make it clear, that’s is the 
Bugzilla reports in the tags.

> This patch aims to fix the secondary regression, by limiting the scope of
> the changes to Meteor Lake platforms only.

So what makes Meteor Lake special? Why is it not needed for predecessors 
and successors?

As now three commits are involved, it’d be really nice to have an 
elaborate summary and also test matrix in the commit message.


Kind regards,

Paul


> Fixes: bfd546a552e1 ("e1000e: move force SMBUS near the end of enable_ulp function")
> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218940
> Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218936
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> --
> v2: enhance the function description and address community comments
> v1: initial version
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 73 +++++++++++++++------
>   1 file changed, 53 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 2e98a2a0bead..86d4ae95b45a 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -137,6 +137,7 @@ static void e1000_gate_hw_phy_config_ich8lan(struct e1000_hw *hw, bool gate);
>   static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force);
>   static s32 e1000_setup_copper_link_pch_lpt(struct e1000_hw *hw);
>   static s32 e1000_oem_bits_config_ich8lan(struct e1000_hw *hw, bool d0_state);
> +static s32 e1000e_force_smbus(struct e1000_hw *hw);
>   
>   static inline u16 __er16flash(struct e1000_hw *hw, unsigned long reg)
>   {
> @@ -1108,6 +1109,46 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>   	return 0;
>   }
>   
> +/**
> + *  e1000e_force_smbus - Force interfaces to transition to SMBUS mode.
> + *  @hw: pointer to the HW structure
> + *
> + *  Force the MAC and the PHY to SMBUS mode. Assumes semaphore already
> + *  acquired.
> + *
> + * Return: 0 on success, negative errno on failure.
> + **/
> +static s32 e1000e_force_smbus(struct e1000_hw *hw)
> +{
> +	u16 smb_ctrl = 0;
> +	u32 ctrl_ext;
> +	s32 ret_val;
> +
> +	/* Switching PHY interface always returns MDI error
> +	 * so disable retry mechanism to avoid wasting time
> +	 */
> +	e1000e_disable_phy_retry(hw);
> +
> +	/* Force SMBus mode in the PHY */
> +	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &smb_ctrl);
> +	if (ret_val) {
> +		e1000e_enable_phy_retry(hw);
> +		return ret_val;
> +	}
> +
> +	smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
> +	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, smb_ctrl);
> +
> +	e1000e_enable_phy_retry(hw);
> +
> +	/* Force SMBus mode in the MAC */
> +	ctrl_ext = er32(CTRL_EXT);
> +	ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
> +	ew32(CTRL_EXT, ctrl_ext);
> +
> +	return 0;
> +}
> +
>   /**
>    *  e1000_enable_ulp_lpt_lp - configure Ultra Low Power mode for LynxPoint-LP
>    *  @hw: pointer to the HW structure
> @@ -1165,6 +1206,14 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
>   	if (ret_val)
>   		goto out;
>   
> +	if (hw->mac.type != e1000_pch_mtp) {
> +		ret_val = e1000e_force_smbus(hw);
> +		if (ret_val) {
> +			e_dbg("Failed to force SMBUS: %d\n", ret_val);
> +			goto release;
> +		}
> +	}
> +
>   	/* Si workaround for ULP entry flow on i127/rev6 h/w.  Enable
>   	 * LPLU and disable Gig speed when entering ULP
>   	 */
> @@ -1225,27 +1274,11 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
>   	}
>   
>   release:
> -	/* Switching PHY interface always returns MDI error
> -	 * so disable retry mechanism to avoid wasting time
> -	 */
> -	e1000e_disable_phy_retry(hw);
> -
> -	/* Force SMBus mode in PHY */
> -	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
> -	if (ret_val) {
> -		e1000e_enable_phy_retry(hw);
> -		hw->phy.ops.release(hw);
> -		goto out;
> +	if (hw->mac.type == e1000_pch_mtp) {
> +		ret_val = e1000e_force_smbus(hw);
> +		if (ret_val)
> +			e_dbg("Failed to force SMBUS over MTL system: %d\n", ret_val);
>   	}
> -	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
> -	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
> -
> -	e1000e_enable_phy_retry(hw);
> -
> -	/* Force SMBus mode in MAC */
> -	mac_reg = er32(CTRL_EXT);
> -	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
> -	ew32(CTRL_EXT, mac_reg);
>   
>   	hw->phy.ops.release(hw);
>   out:
