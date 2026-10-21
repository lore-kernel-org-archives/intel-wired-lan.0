Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBC0606A319
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2JMSW82o;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=Qx+Ai6JE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8D1D80F49;
	Wed, 21 Oct 2026 08:21:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k53UpWquvTCc; Wed, 21 Oct 2026 08:21:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6D0880F7E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792570860;
	b=hkCss06QSlWSprOFkzmWhz9p4P6yPAs7ETARFvU7B1YFJEFYXONutE6rBzOYhvF+tOok
	 BkO2E6cSbsjkLC0/b9XdV+jgQHy3FFhPj0KuuC4Pv1aqphO9Kk1PZf5nKBcyQAX8oTetV
	 ehFg2ysTR9BNvbT61BwF28trnFMaEPOOJANCqMtZdKgVIgeNyQyAkeWBpBkT3EJ1yxnkk
	 DZ+vqdRvuRjXVwnyW1eOHMAiKP/bkpW1+tepAqX9Fwqi18J+herGnaaFEeIgxXtFAcHBG
	 ltg0tz6DE6TiHZ2yzdzQJjD4faN6rFyqZXnNRRRzjP4Rfyrg3XCUEeQbvf3A0e0+8ZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792570860;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0961khO16PkdzOShYW1kFf3MmaVSSQ4+4dmHU+OQtRA=;
	b=ZqkSN+fw652wFNDSpFE3kSj+tBHIU23vLkTwOPT1OvGDaXcI6ijVe3C/we66cp7irdD1
	 YubNZhLgnP96IsBVaMExNVcN4LeUNApY/VA72vWlcjwDfcK7Wzg1Drbw0UyWlG2yZshaP
	 GXYgKGxcaOM1OUHKB4N4bVosqk+qNDLs/Z3uEONEDM/zVS+GVkn7zcxTUS3PsN9L7d53s
	 IlvtVryC0ZNNQqOlxffl8KaPugPIp88EHBPSSu6zCQry9KOSS3AKPDydb/EB3sNBv3i+w
	 4Ovh3MH8jksaU/e/LIHraZLk7EYKwEuDrlXjxXBT9CTvazT5l/AVOX6FUnRhkohr2IQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792570860;
	bh=0961khO16PkdzOShYW1kFf3MmaVSSQ4+4dmHU+OQtRA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2JMSW82oEfW+lAjc3pW/MeGmZvehj/PV3NeS6H8S59cLb3mBoiehkzDGEj81PbMwV
	 d5zAkmoRZP/k9w1D8CACgwj3ACsfY5Z1/nTvxgJJ2BScdMWVJTmnmt2l93z4QFV+Vg
	 BbXEmoI2BxX3ZT6ViPJ+llFH61dlBNOfUPhS0wxwNsgyqxKBwgDK+2QyHyCcWm0eLz
	 7kAIvvgrvAXj+ahvNFooqsoFuSXF0v7uxPiFZAzAI4W4HcizHtpCrVyK1ml8HizdVM
	 pjV3+bB1jzJIteAQv34lk/4t6mEtIQM/yRaLOt/yD7YLSI96Ky1OyRb5GrROg1F7VE
	 vb55NzDLZA25w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6D0880F7E;
	Wed, 21 Oct 2026 08:21:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C67853AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 08:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB2AE4078E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 08:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZM8_y4uLM6g for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 08:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 74B2E4077C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792570857;
 b=EztOOoyVrXLEJxvJbTAQSv/Ne8UpfzcR/5H7moXleJXwUE6OKd2yxuk8q7pRvjfmkFwF
 Rtoh5PluOc/9l2vkwOWqEJ/00MpPs3vnZPu5zMaa3FwKfNXjZLvc90ZTi6W2o1Tip2tHG
 Eonel3yOvo0/PnHt0yP0wpGwzRVKq7hboEyKeixxHSnNVikKZLRFIu2LVqjDawa+cjWnq
 RhkPMeTE0BqBmLDRQi5eujgyNYYZXW25r8sQnTXiif2EvNSYDMq5RRcTtjSd5Pu3OyY6L
 pqr3HR+lJ4RA8ssOitq8HmJAi4/wDkrOPCo1YBeT3VXG4B4vdWnuhhrQ0nR8jFce6jA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792570857;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=0961khO16PkdzOShYW1kFf3MmaVSSQ4+4dmHU+OQtRA=;
 b=i8FTXjAtGFOunPSUeCtkLqVssRpraix0uWpYeC6SchYI9l5vIIrRYwkgVQqc9mo925TG
 sFm0YjIK73xJHx4duCcyyisJ0aqBWAmPRc5b1UCjztAlOz0wq4RSt5Nrp4M2dikHOY/5H
 xc0R0Qko14EBfEinC1GL8I5sSWCPm5zBYcMIDO76PSqNFXYRewCXiqRsX0ZO7IdwiKJ6i
 HhxNviVo/mwSUFpr3URy1ZizvD1+LJpK5BDv81hXxxNffB2GURNL/dog+bdte6Wl2KZ6N
 Jj+GNh2a3RFxfY7G4Ou9y2ZEfvDINSP2Jd+S+qhhbF1VD64pZACvq6IUSy5m7AzLvWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=126.com;
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=Qx+Ai6JE; 
 arc=none smtp.remote-ip=117.135.210.7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.7;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=Qx+Ai6JE
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74B2E4077C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 08:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=0961khO16PkdzOShYW1kFf3MmaVSSQ4+4dmHU+OQtRA=;
 b=Qx+Ai6JEFX2UmZU/hmO7oEhJBviTZLFFvJd5qi1XUfoF058nyoS8dF7anvcKif
 +f5Zd2MXQIcNp3/daxTw1pGmgbW7A5RYnZBPf8eqEaJmOx0w8mPfxyyAP8FzcdXL
 2KjTroJvNfwEagAjIg7mavn4ck5pNciHM541Re727hr0U=
Message-ID: <62b3a378-f911-4c2f-85c7-53aa3f51ee43@126.com>
Date: Wed, 21 Oct 2026 16:20:19 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: do not report success for a VF setting that
 was not applied
To: Jacob Keller <jacob.e.keller@intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
References: <20261012082910.283229-1-xiaolinkui@126.com>
 <2b9f2117-1bc0-4d83-a30d-1c8f7b295ab2@intel.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <2b9f2117-1bc0-4d83-a30d-1c8f7b295ab2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3dyHDddhq9iGuBg--.32140S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw1ktryrWr47trWrWr1UAwb_yoWrKr48pa
 93KFn0kr4DGrWIv342vr42vr1FkrWrKF43Jr15Gr90ywn8WrWIvF4rKr4qva48Aw4fG34a
 vFsxXw4DZrWDX3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv38UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlARfNmrYdcT5nQAA3e
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jacob,

thanks for the review. v2 follows your suggestion, with one adjustment.

On 2026/10/21 03:10, Jacob Keller wrote:
> On 10/12/2026 1:29 AM, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> __ice_set_vf_mac(), ice_set_vf_trust() and ice_set_vf_port_vlan() all
>> check that the VF is ready for configuration, take vf->cfg_lock and then
>> call ice_reset_vf() to push the new setting into hardware. The result of
>> ice_reset_vf() is not looked at, and it could not be: it returns 0 both
>> when the reset ran and when it bailed out because the VF is disabled.
>>
>> The check runs before the lock is taken, so a reset can disable the VF
>> in between. ice_reset_all_vfs() raises ICE_VF_DIS in pf->state before it
>> walks the VF table, rebuilds every VSI and clears the bit again. An
>> ndo_set_vf_mac() that passed ice_check_vf_ready_for_cfg() just before
>> that then waits for cfg_lock, stores the new address in vf->dev_lan_addr
>> and vf->hw_lan_addr and calls ice_reset_vf(), which sees the VF
>> disabled, stops its queues and returns 0 without reprogramming anything.
>> __ice_set_vf_mac() reports success, so ip link and the devlink port
>> function now show a MAC address the hardware never got, and the switch
>> keeps enforcing the previous one until something else resets the VF.
>>
>> ice_set_vf_trust() and ice_set_vf_port_vlan() have the same shape: the
>> port VLAN lands in vf->port_vlan_info and the trust flag in vf->trusted
>> before the reset is skipped.
>>
>> Re-check ice_is_vf_disabled() once cfg_lock is held and fail with
>> -EINVAL, the same code ice_check_vf_ready_for_cfg() returns for a
>> disabled VF. The VF is being reset or removed at that point, so the
>> caller should retry rather than be told the setting is in place.
>> Changing what ice_reset_vf() returns on that path is not an option, too
>> many callers rely on it meaning "nothing to do".
>>
>> The race was found by code inspection of the ndo VF handlers, it was not
>> reproduced at runtime and no error message was observed.
>>
> Hm. My recollection is that we should set something on the PF side that
> stores the new address so that the VF would get that value when next
> configured.. But I guess that isn't how ice works.

It is how ice works, and that store is why one of the two interleavings 
is harmless. __ice_set_vf_mac() already keeps the address in 
vf->dev_lan_addr / vf->hw_lan_addr, and every rebuild replays it through 
ice_vf_rebuild_host_mac_cfg(). The bug needs a window where nothing 
configures the VF again: ice_reset_all_vfs() rebuilds VF n under its 
cfg_lock, drops the lock, moves on, and only clears ICE_VF_DIS after the 
last VF. If the ndo handler takes cfg_lock in that gap, it stores the 
setting, its own reset is skipped, and the PF-wide reset is already past 
this VF, so no rebuild ever replays it. If the handler instead wins the 
lock before the rebuild loop reaches this VF, the follow-up rebuild does 
replay the store. That is why v2 fails the request rather than trying to 
re-arm a reset of its own.

Worth noting the ICE_VF_STATE_INIT half is not what catches this window: 
ice_vf_set_initialized() has already run for the VF by then, only the 
PF-wide ICE_VF_DIS bit shows the reset is still in flight.

Two things I would like your opinion on:

-EINVAL is what ice_check_vf_ready_for_cfg() returns for a disabled VF, 
so v2 keeps it, but -EBUSY would say “retry” more clearly. Easy to 
switch if you prefer.

ice_repr_ethtool_reset() has the same shape and also reports success 
when the reset was skipped. It stores no setting, so I left it out of 
this patch, but happy to fold it in.
> 
> Why not just move ice_check_vf_ready_for_cfg() inside the mutex though?

v2 moves the flag tests inside cfg_lock, but not the sleeping half. 
ice_check_vf_ready_for_cfg() starts with ice_wait_on_vf_reset(), 40 x 20 
ms of msleep polling for ICE_VF_STATE_INIT, and the resets that clear 
that bit set it again from ice_vf_post_vsi_rebuild() with cfg_lock held. 
Under the lock the wait could never observe the transition, it would 
burn the full 800 ms and still return -EINVAL, while stalling the reset 
and the VF mailbox that ice_vc_process_vf_msg() serves under the same 
lock. So the wait stays outside, and the flag tests are repeated inside 
by ice_check_vf_ready_for_cfg_locked(), which replaces the three ad-hoc 
ice_is_vf_disabled() tests of v1.

v2 is posted as “[PATCH iwl-net v2] ice: do not report success for a VF 
setting that was not applied”, rebased on top of 0a01e1df137f (“ice: 
skip unnecessary VF reset when setting trust”):

https://lore.kernel.org/netdev/20261021081248.261762-1-xiaolinkui@126.com/

Thanks,
Linkui

