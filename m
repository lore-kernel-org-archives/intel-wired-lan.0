Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046F0C55184
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Aug 2026 14:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A881A80C73;
	Tue,  4 Aug 2026 14:59:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2rXHXWlJtzEa; Tue,  4 Aug 2026 14:59:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE91F80C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785855554;
	bh=iDhCHeDpQYTtej18tBdbNaEkQ1Eerhj3Tg1dYJtFg3g=;
	h=Date:From:References:To:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KbsGOhDq3zIj9O8cNbsqFFNgefGqNTksKOctQkHExfT4R6JTrhID74tAe3RH/NDd3
	 0ddhCGYGqOuTXDlrIe2jWFQDfy5OtxCyHSMyKwA3BQLzLmy2Eq9V1YI0Mlg9MC+b5k
	 LC1noZ4gPnAtpHvyQ2QmsOoc9zvfZpsh6ZI7KhXSnT63WnXjF9Ky2b7LhOka+ezDCT
	 x9z/6Vxtr3S6NnYwZwfo2yKXrQCJ1k0XiiutoZP8rpnIvkC904Ztt2f3GIViV/vO+z
	 ZSGjVOguXrYiP11DJ/FnDquArLZSyp07lIMo7qsiiRR7BAKJ74TzOZ10qVoidnvNTA
	 RB86J4D7ZRPWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE91F80C6F;
	Tue,  4 Aug 2026 14:59:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB4CE2BF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 14:59:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD41240071
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 14:59:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id goyDc-gaf0HT for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Aug 2026 14:59:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B873740064
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B873740064
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B873740064
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 14:59:12 +0000 (UTC)
X-CSE-ConnectionGUID: ujNUpzxZTz6zgr13BdTxqQ==
X-CSE-MsgGUID: Ps9rNvEsR5CF2q/4R/Qdug==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97001610"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="97001610"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 07:59:12 -0700
X-CSE-ConnectionGUID: PSuefZOsTQaWNb9TkeQxrw==
X-CSE-MsgGUID: Wqbclx+OTDGy0ZThz67f1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="266647395"
Received: from linux.intel.com ([10.54.29.200])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 07:53:14 -0700
Received: from [10.102.88.243] (soc-5CG4396XFD.clients.intel.com
 [10.102.88.243])
 by linux.intel.com (Postfix) with ESMTP id 8478820B93EB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Aug 2026 07:53:13 -0700 (PDT)
Message-ID: <012d4087-5713-4500-8afd-63dfc74f7382@linux.intel.com>
Date: Tue, 4 Aug 2026 16:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
References: <0de48a53-695a-4ba2-b2f3-8750334fa7a7@linux.intel.com>
Content-Language: pl
To: intel-wired-lan@lists.osuosl.org
In-Reply-To: <0de48a53-695a-4ba2-b2f3-8750334fa7a7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785855552; x=1817391552;
 h=message-id:date:mime-version:from:subject:references:
 reply-to:to:in-reply-to:content-transfer-encoding;
 bh=1fjVVJZEDQDCphzuvommgXenQRne/cHwRLtyqg0KnwA=;
 b=PMxVbUe/tfq4klpMxUdwKtPalfRvUE/pFriIRe5+r20Mb9BLL0kHT241
 rF3t12h1l/Lrzm7zLz6gqgsFmIHq5OBSG+0EtXKyviK47zSgi2UPZy3ZP
 4Xwadbg08LUJR4XaGbRmOu+5VC5jn1Z0NFZxqT3JMXr4zQrwD3yU/YaoQ
 asTRfUxaGeRysx/JwMFQ8ajLvha7HxEzGPbMtUqXeJElX60VtaUM1j9F1
 rF87nmAD2GDvNubSfyxwiGKnVar7vGiXcbWY/dVNcGHW6YzTfIEB48ppc
 vNh+LaOrbAxqCAkDx2UiCiQicVsD6lfPoY1pqGyDmUwuQMQBXMt02j1Mc
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PMxVbUe/
Subject: [Intel-wired-lan] [PATCH iwl-net] ixgbevf: fix link speed reporting
 for Hyper-V E610 VFs
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
Reply-To: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>




On 30.07.2026 23:19, Tony Nguyen wrote:
> 
> 
> On 7/23/2026 7:51 AM, Tomasz Lichwala wrote:
> 
> ...
> 
>> +/**
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
> 
> I ran Sashiko locally on this and it reported the following:
> Should a failed link read here return a fatal error to check_link, or
> report link down and return 0?
> When built without CONFIG_PCI_MMCONFIG this returns -EOPNOTSUPP on every
> call, and it also returns an error on any persistent
> pci_read_config_byte() failure.
> 

Good catch, you are right. Before this patch the Hyper-V check_link
callback always returned 0, so propagating the error is a regression
in the degraded case.

v2 will return 0 with *link_up = false and *speed =
IXGBE_LINK_SPEED_UNKNOWN on read failure. The dev_err_once() still
logs the root cause for diagnostics.

Thanks,
Tomasz

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
>> @@ -923,13 +961,32 @@ static s32 ixgbevf_hv_check_mac_link_vf(struct ixgbe_hw *hw,
>>       if (!mbx->ops.check_for_rst(hw) || !mbx->timeout)
>>           mac->get_link_status = true;
>>   +    /* E610 VFs always read link status from emulated PCI config space
>> +     * because VFLINKS does not carry valid speed for these devices.
>> +     * Skip get_link_status caching since PCI config reads are cheap.
>> +     */
>> +    if (mac->type == ixgbe_mac_e610_vf) {
>> +        s32 ret = ixgbevf_hv_read_links_e610(hw, &links_reg);
>> +
>> +        if (ret) {
>> +            *link_up = false;
>> +            *speed = IXGBE_LINK_SPEED_UNKNOWN;
>> +            return ret;
>> +        }
>> +        goto decode;
>> +    }
>> +
> Can this cause a repeating reset loop on the degraded configuration?
> The non-zero return propagates up through mac.ops.check_link() into
> ixgbevf_watchdog_update_link():
>     err = hw->mac.ops.check_link(hw, &link_speed, &link_up, false);
>     ...
>     if (err && time_after(jiffies, adapter->last_reset + (10 * HZ))) {
>         set_bit(__IXGBEVF_RESET_REQUESTED, &adapter->state);
>         link_up = false;
>     }
> A device reset cannot make CONFIG_PCI_MMCONFIG appear at compile time, nor
> fix a persistent config-space read failure, so wouldn't every watchdog
> cycle re-arm __IXGBEVF_RESET_REQUESTED roughly every 10 seconds, leaving
> the interface permanently down and continuously resetting?
> Before this patch the Hyper-V check_link callback always returned 0, so no
> reset request was triggered. Would returning 0 with link_up=false and
> speed IXGBE_LINK_SPEED_UNKNOWN for the unsupported/degraded case avoid the
> loop?
> One related note: the dev_err_once() reads as a benign one-time notice,
> but the underlying -EOPNOTSUPP is returned on every poll and drives the
> repeating reset behavior above.
> 
> Thanks,
> Tony

