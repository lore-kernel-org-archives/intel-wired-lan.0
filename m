Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6974CD342C
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 May 2026 06:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 903C281C2F;
	Wed,  6 May 2026 06:08:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KsppFOcGwFg4; Wed,  6 May 2026 06:08:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8777381836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778047684;
	bh=spr5B8mSugh1fwQ2DjlN5h25FdIEu29ZnaP0ONJd6AE=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mL+buwXIsTXiN5np/BJBeei16pAoDjWGEhnM0H+6x9J9gvn3BW1BJvtyzU6rgLl4G
	 KHuw4cM5Mf1Fo0HMswjo88jO0iLrr2HVK+pLLCTXA4HeKltfxpIvkhuvkhc2vqzfup
	 4CAr8YMyS5N0R43QCEMtd178kdPErks2pDPkv1QTeUIgbtD64rdTY2PtN2BdpXi1Pt
	 zXBeJw6RTMkXAuQqGyTNO2M55VhVBBLrvjySRLnn7LsUogfgN/dwLthAdKHIx8hkhr
	 6vrVq+PrupwGnWMC7RgHg/drfH+mOQc5ve8UaIKF5K4Ib7Br0SZgWst1+wxHv1xDs9
	 LlAnA+Hn3kzog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8777381836;
	Wed,  6 May 2026 06:08:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE42A280
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 06:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A85A860AF4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 06:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLmOQuJGeEWC for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 May 2026 06:08:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=faizal.abdul.rahim@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6520460889
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6520460889
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6520460889
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 May 2026 06:08:01 +0000 (UTC)
X-CSE-ConnectionGUID: xBNCoXg0TMeFcrGo0oz/tg==
X-CSE-MsgGUID: x7uuoHgdRES46l3Y/4P/HA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89247455"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="89247455"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 23:08:00 -0700
X-CSE-ConnectionGUID: GFIFB15hQMWeag8Ieo1NqQ==
X-CSE-MsgGUID: saKn+QjaRCGwwoiWrBMWNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; d="scan'208";a="274163659"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.247.37.237])
 ([10.247.37.237])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 23:07:57 -0700
Message-ID: <9645f07a-a124-4c0e-b88c-e4262e1b2df0@linux.intel.com>
Date: Wed, 6 May 2026 14:07:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: khai.wen.tan@linux.intel.com, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
 khai.wen.tan@intel.com, Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
 <20260428060009.311393-2-khai.wen.tan@linux.intel.com>
 <a9cfe2dc-f4dc-48fb-a374-0d2902baa0c5@molgen.mpg.de>
 <84b4f8bb-3c8c-4098-bc7f-7e9fd248c5ca@linux.intel.com>
 <d3d4915c-1bc5-4e04-bfc4-9d9787849c6f@molgen.mpg.de>
Content-Language: en-US
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <d3d4915c-1bc5-4e04-bfc4-9d9787849c6f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778047681; x=1809583681;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3ocJ7eGs7rV3DoF7D9r//mE2xjPMFa5UeFuNQI5fVWk=;
 b=OvJTaGRRRB/K976wdUjatrlxkICWtaScd7aA0EhFPWmufVottBfV+ZWx
 eMS2bENvWuTChgyUKYy9+LCzNda/g5rlT3LM8hvn92K6fNYHUDszEQG3R
 Klatyez5S1g4Nwlrv8GIVVzN5NcjVBGVQiBSmTcWmg1hIo7JTUwBseE2t
 dXXiPsYfYf7aSVU35Y41+BOkjVpz0qzXYK34RFFmqidPTTmIkkxuLFLUW
 +WQtfqlEEPiJtaJ3pLOgjsOK1/twFMHeNvunAMO4Y7Xr620WevQQY10zr
 rQiZZgWQJ68Z4Xmjd9rQsfE0M6sqyyF0BLdpvP9o/TIBgwOnVRb93H56w
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OvJTaGRR
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 1/3] igc: remove unused
 autoneg_failed field
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



On 28/4/2026 11:06 pm, Paul Menzel wrote:
> Dear Faizal,
> 
> 
> Am 28.04.26 um 12:39 schrieb Abdul Rahim, Faizal:
> 
>> On 28/4/2026 2:56 pm, Paul Menzel wrote:
> 
>>> Am 28.04.26 um 08:00 schrieb KhaiWenTan:
>>>
>>> (Should spaces be added in your name?)
>>>
>>>> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>>>
>>>> autoneg_failed in struct igc_mac_info is never set in the igc driver.
>>>> Remove the field and the dead code checking it in
>>>> igc_config_fc_after_link_up().
>>>
>>> Could you please elaborate. Why is removal the correct fix, and it’s not
>>> an incomplete feature? Does auto-negotiation always succeed?
>>
>> Auto-negotiation does not always succeed, but igc does not use
>> autoneg_failed to handle that case, the field was never set anywhere
>> in the igc driver.
>>
>> Before this patch, the only igc references to autoneg_failed were
>> the struct member declaration and the read in
>> igc_config_fc_after_link_up(). No igc code ever assigned it to true,
>> and git history shows no commit that added a setter since the code
>> creation in 2018.
>>
>> The field originates from the e1000/e1000e fiber/serdes forced-link
>> path: when MAC-level auto-negotiation on fiber times out, the driver
>> forces link up and sets autoneg_failed so the flow-control code knows
>> pause was not negotiated and must be forced. igc has no fiber or
>> serdes media, it only supports copper (igc_media_type_copper), so
>> the code that sets autoneg_failed was never ported.
>>
>> On copper, PHY auto-negotiation failure is handled differently:
>> - No link at all: igc_check_for_copper_link() returns before reaching
>>    flow-control configuration, there's nothing to configure FC on.
>> - Link present but autoneg not yet complete:
>>    igc_config_fc_after_link_up() checks MII_SR_AUTONEG_COMPLETE and
>>    returns early without resolving pause. The next link-status event
>>    re-triggers the check.
>> - Autoneg completes (including via parallel detection fallback when
>>    the link partner doesn't autoneg): the PHY still sets
>>    AUTONEG_COMPLETE but LP_ABILITY won't have PAUSE bits since the
>>    partner never sent autoneg pages. The existing flow-control logic
>>    in igc_config_fc_after_link_up() handles that correctly, it falls
>>    through to igc_fc_none or igc_fc_rx_pause based on requested_mode.
>>
>> None of these paths need autoneg_failed. Keeping the field would be
>> misleading to reader.
> 
> Thank you. For me the information about just supporting copper would be
> great to have in the commit message.

Will update.

> 
>>>> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
>>>
>>> Please order it to not use the comma: Hong Aun Looi
>>
>> Will do, thanks.
>>
>>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
>>>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/igc/igc_hw.h  |  1 -
>>>>   drivers/net/ethernet/intel/igc/igc_mac.c | 16 +---------------
>>>>   2 files changed, 1 insertion(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igc/igc_hw.h b/drivers/net/
>>>> ethernet/intel/igc/igc_hw.h
>>>> index be8a49a86d09..86ab8f566f44 100644
>>>> --- a/drivers/net/ethernet/intel/igc/igc_hw.h
>>>> +++ b/drivers/net/ethernet/intel/igc/igc_hw.h
>>>> @@ -92,7 +92,6 @@ struct igc_mac_info {
>>>>       bool asf_firmware_present;
>>>>       bool arc_subsystem_valid;
>>>>
>>>> -    bool autoneg_failed;
>>>>       bool get_link_status;
>>>>   };
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/
>>>> ethernet/intel/igc/igc_mac.c
>>>> index 7ac6637f8db7..142beb9ae557 100644
>>>> --- a/drivers/net/ethernet/intel/igc/igc_mac.c
>>>> +++ b/drivers/net/ethernet/intel/igc/igc_mac.c
>>>> @@ -438,28 +438,14 @@ void igc_config_collision_dist(struct igc_hw *hw)
>>>>    * Checks the status of auto-negotiation after link up to ensure that
>>>> the
> 
> Just for your information, that your mailer wraps the lines of the quotes.

Ohh okay, let me check, thanks!

> […]
> 
>>>>    * speed and duplex were not forced.  If the link needed to be
>>>> forced, then
>>>>    * flow control needs to be forced also.  If auto-negotiation is enabled
>>>> - * and did not fail, then we configure flow control based on our link
>>>> - * partner.
>>>> + * then we configure flow control based on our link partner.
>>>>    */
>>>>   s32 igc_config_fc_after_link_up(struct igc_hw *hw)
>>>>   {
>>>>       u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
>>>> -    struct igc_mac_info *mac = &hw->mac;
>>>>       u16 speed, duplex;
>>>>       s32 ret_val = 0;
>>>>
>>>> -    /* Check for the case where we have fiber media and auto-neg failed
>>>> -     * so we had to force link.  In this case, we need to force the
>>>> -     * configuration of the MAC to match the "fc" parameter.
>>>> -     */
>>>> -    if (mac->autoneg_failed)
>>>> -        ret_val = igc_force_mac_fc(hw);
>>>> -
>>>> -    if (ret_val) {
>>>> -        hw_dbg("Error forcing flow control settings\n");
>>>> -        goto out;
>>>> -    }
>>>> -
>>>>       /* In auto-neg, we need to check and see if Auto-Neg has completed,
>>>>        * and if so, how the PHY and link partner has flow control
>>>>        * configured.
> 
> Kind regards,
> 
> Paul
> 

