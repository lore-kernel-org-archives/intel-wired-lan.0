Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B130CCA9ED0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 08:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E7F680CDC;
	Mon, 12 Oct 2026 08:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aC6czdKnlqrK; Mon, 12 Oct 2026 08:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 552FA80D13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791795279;
	b=g6j7BF23WFRWIcOQSqg0IMldLTYr1VL/dpDk8cBX7UnyrwB2QcpWBhO0g0yair50UjHG
	 4hacz4Rnhkbw3oY7HDU+jQ88zrX4XjUaCu+tcGZ+9oqhgQkAw0Yb7tnqKuIvPHb4QV07r
	 200ONpKSWzyd/OohvCsZ7hSPRURSQNuOdZuS5MeRYxIehAefIqfivhLFzewf9zQdeaarK
	 NZfqXIZlEmnJKL4dxYLzMJdIDnhJt4vf8SZ6rH1lIuFf9l3XAtYVfN5TKJis7hypIS3W1
	 4/aM60NaG0/gSu0ZfeoIpJFTujUi+CaOKOxiIbLUFToQCG7wvPQCpTj9hy3QIN9HhFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791795279;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BJxenIXhdUqi9K52gMrSLjgLCaVLYoX3mxZ0/mSG73Y=;
	b=JR6zpyXJyGBK/49bpxlFQQicSl0GxeabpDdO5uxly/70rQJU3mTCfoRsor4DHTGq3Ov0
	 BvREpX3qe0MAOVGvo4HQpHjQCdqMBS+kQ+rymK6HqEO63EFPTK+wwdDvb2uSMCEbgGlb2
	 VK7/bwVBBXQqd7BnrbwysfIk8nQ9wOfWZD28vZqx1Qjx7XaI4nVQy6+n2TqY1Xd+PGryg
	 9g20jDH/WqqoyRBwJ1ln24O0+4+gCPqaGdsNHve0hbhXVlSmFxR4RRtFH+eIxvQW5QR3Q
	 4praBiROackksO0qofygfpHpN67n33iubmWx92ClLfDNzPm2AvVdi9UaXhc9IJbQeNA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=iM5qQkUt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791795279;
	bh=BJxenIXhdUqi9K52gMrSLjgLCaVLYoX3mxZ0/mSG73Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Skm5XhSWAeBombYD1kWXm6iEZ2e6HCLI06pJCobw1U3UlFuOHLrDKBLn0QAvhHSAx
	 QrEQc3jFGhpNFyy3GSK5514Tnv/YyQtaZjF0YcQazVph9EWcRNLSZ0dUVWFOFZNt2J
	 vKnSdPtj/gVjfulKE8xVkH5aIuoAHMtlizvShOn1V/5JR55k0X6/8sSu0LLh1FMbqv
	 4S8LXguR/xeCa20QeDtxGJ7A2fQ8TimBgcxhRyBDv8YdKrH58CSDh68v12hxHZDDrR
	 9H4l2pGLIiihsMRXE8K4DD2qRa2piuOZGFPGG21BEcxCldBAyctkRXM8sqnABpAMU7
	 ys2vMkEe3B0AQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 552FA80D13;
	Mon, 12 Oct 2026 08:54:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA8DF9CF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9473980D05
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sAWZgXXvp2N8 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 08:54:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8FD9780CC5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791795276;
 b=WCXuHGILd37TT6cou70C5neFowD+kGpJBEJ2l6m7V4c047wJui1bS+iw7gfP9P0uUtHt
 l93hq7OMxYcn+bvO0q45lYtaMyyPipfknSrukGNiIJuY5JpWoDvML2sh6p9er+uCNjplI
 jBxA9252MbsCRQKN2PkSUT4MJ/Mkzl3m4Whvmxaz89N1/mYu0dDhjnb4saEkffHods1mv
 a6kKLspXOvIUgfwOtu/3pd9PjkdtNXDoGLYtBcza2BF0BNqKkCoddaDTMNtQoKHpJybY8
 IKpwbWRhzzqbk54zkfXppS7cK+K2GH4a7/Mqgg1m2Tbe21LoK+TnYdez4+nzQH4goiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791795276;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=BJxenIXhdUqi9K52gMrSLjgLCaVLYoX3mxZ0/mSG73Y=;
 b=gBFDt7B7mc600AVU2Noa9mlhdyAlwvjA2g/rGVsUWc0ux6gTBKrTi80/u1w3lfPiK2J0
 VfnMKLf4PdEbKCC+v/C3BBu2ryRfgpYSci0NCWyoCQ6EcPzimV4Taos94zeifM77+vB8V
 g0VBLUfuTUqE2tXByD+4hSBc+mC18YZMBpcNjoVW/HufTqfnbZXv5GgpjqZBCWvQeO5NK
 MhGiZWEIf8B24uYSW66lXVBjShDpJhM83Br9QpU4scFDC7wVf65I6C9XALJdR78ywFnsP
 oqHay6zJDlaHZb6gMz67m7TLUV+7Sf4AVz4fqBwMSV71iKtxAGN1elhnIb/yORCWoTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=iM5qQkUt; 
 arc=none smtp.remote-ip=117.135.210.6
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.6;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=iM5qQkUt
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FD9780CC5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 08:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=BJxenIXhdUqi9K52gMrSLjgLCaVLYoX3mxZ0/mSG73Y=;
 b=iM5qQkUtnmRfurR4SEl7gFzbI+fELaJvsrHpjL7Ut01XlmZG/SxCLYxnii5oZH
 4YCleWZiV7XUPnRNevE5LfShrLedB2m4LhcPxE1J/IO95bXfr420KcxdTwNluXtP
 glCDioV7z7eLZ1RNbKAvdjM/QEn4vVz1G7q6mqk/9M/L0=
Message-ID: <33c171df-0687-4fbc-9650-1b692dfab3b1@126.com>
Date: Mon, 12 Oct 2026 16:54:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 1/3] ice: attach and detach VF representors
 outside of vf->cfg_lock
To: sashiko-reviews@lists.linux.dev
Cc: intel-wired-lan@lists.osuosl.org
References: <20261008125754.3520773-1-xiaolinkui@126.com>
 <20261008125754.3520773-2-xiaolinkui@126.com>
 <sashiko-outbox-165586@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <sashiko-outbox-165586@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wD31wQ9oMxqhvfGBA--.54952S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuryDKw47ur1rtF4fGF4fGrg_yoW7JFykpa
 95XFWjkrykXr1Ig3srXw4UuFy0934rKFy5Gr1rKF4S9an8Cr1DAr47KFWjvFy8A3s3A3Wa
 vr4DZwn5ZF98JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UhXocUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqB4F22rMoD6pmAAA3h
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



On 2026/10/9 21:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] ice: UAF in NAPI Rx path due to missing RCU grace period after xa_erase
> - [Medium] net/ice: silent failure to apply VF MAC/VLAN to hardware due to TOCTOU race
> --
> 
> commit 32649319eb3be01d6b10e730f49f29871e5cb572
> Author: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ice: attach and detach VF representors outside of vf->cfg_lock
> 
> This patch moves the detach and attach of VF representors outside of
> the vf->cfg_lock to resolve a lock inversion between cfg_lock, the
> devlink instance lock, and RTNL.
> 
>> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
>> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
>> @@ -789,9 +789,21 @@ void ice_reset_all_vfs(struct ice_pf *pf)
>>   
>>   	/* free VF resources to begin resetting the VSI state */
>>   	ice_for_each_vf(pf, bkt, vf) {
>> +		/* Detach the representor before cfg_lock and attach it after
>> +		 * releasing it again: both take the devlink instance lock and
>> +		 * then RTNL, while __ice_set_vf_mac(), ice_set_vf_port_vlan()
>> +		 * and the representor ethtool reset take cfg_lock under RTNL.
>> +		 * Take cfg_lock once ahead of the detach to wait out a reset
>> +		 * that is already inside the lock; ICE_VF_DIS, raised above,
>> +		 * keeps later ones out.
>> +		 */
>>   		mutex_lock(&vf->cfg_lock);
>> +		mutex_unlock(&vf->cfg_lock);
>>   
>>   		ice_eswitch_detach_vf(pf, vf);
> 
> [Severity: High]
> Does this code leave a window for a use-after-free in the NAPI Rx path?
> 
> During teardown, ice_eswitch_detach() calls unregister_netdev() which
> waits for existing RCU readers. However, the representor pointer remains
> in the eswitch.reprs XArray during and after unregister_netdev().
> 
> Because the pointer is still in the XArray, a concurrent NAPI Rx thread
> calling ice_eswitch_get_target() can successfully fetch it via xa_load()
> even after unregister_netdev() completes.
> 
> The teardown path then removes the pointer via xa_erase() and immediately
> calls ice_repr_destroy(), executing free_netdev() and kfree() with no
> additional RCU grace period. If a NAPI thread fetched the pointer just
> before xa_erase(), it will dereference freed memory.
> 
>> +
>> +		mutex_lock(&vf->cfg_lock);
>> +
>>   		vf->driver_caps = 0;
>>   		ice_vc_set_default_allowlist(vf);
>>   
>>   		ice_vf_fdir_exit(vf);
>>   		ice_vf_fdir_init(vf);
>>   		/* clean VF control VSI when resetting VFs since it should be
>>   		 * setup only when VF creates its first FDIR rule.
>>   		 */
>>   		if (vf->ctrl_vsi_idx != ICE_NO_VSI)
>>   			ice_vf_ctrl_vsi_release(vf);
>>   
>>   		ice_vf_pre_vsi_rebuild(vf);
>>   		if (ice_vf_rebuild_vsi(vf)) {
>>   			dev_err(dev, "VF %u VSI rebuild failed, leaving VF disabled\n",
>>   				vf->vf_id);
>>   			mutex_unlock(&vf->cfg_lock);
>>   			continue;
>>   		}
>>   		ice_vf_post_vsi_rebuild(vf);
>>   
>> +		mutex_unlock(&vf->cfg_lock);
> 
> [Severity: Medium]
> Does this sequence leave a window where a concurrent VF MAC or VLAN update
> can silently fail to apply to the hardware?
> 
> If a user configures the VF MAC, __ice_set_vf_mac() calls
> ice_check_vf_ready_for_cfg() before acquiring vf->cfg_lock.
> 
> If a PF reset occurs simultaneously, ice_reset_all_vfs() sets ICE_VF_DIS
> globally. If this happens right after __ice_set_vf_mac() passes its check,
> __ice_set_vf_mac() will wait to acquire vf->cfg_lock.
> 
> As seen in the lines above, ice_reset_all_vfs() acquires vf->cfg_lock and
> rebuilds the VF VSI using the old MAC address. After ice_reset_all_vfs()
> releases the lock, __ice_set_vf_mac() acquires it, updates the software
> MAC, and calls ice_reset_vf().
> 
> Because ICE_VF_DIS is still set by the PF reset, ice_reset_vf() aborts
> the hardware reprogram. __ice_set_vf_mac() then returns success based on
> its earlier check, leaving the hardware enforcing the old MAC while
> software tools report the new one.
> 
Hi,

Thanks for the review. I did not modify the original patch, but both issues
reported here are now addressed by separate patches sent to netdev:

[High] UAF in NAPI Rx path:
   https://lore.kernel.org/all/20261012072959.254206-1-xiaolinkui@126.com/

   This patch erases the xarray entry first, then adds synchronize_net()
   before the representor is freed, and holds the RCU read lock around the
   netdev usage in ice_process_skb_fields().

[Medium] silent failure to apply VF MAC/VLAN due to TOCTOU race:
 
https://lore.kernel.org/netdev/20261012082910.283229-1-xiaolinkui@126.com/

   This patch addresses the race between 
__ice_set_vf_mac()/ice_set_vf_port_vlan()
   and the PF reset path.

Both patches are independent of the original series and were not included in
a repost of it.

Thanks,
Linkui

