Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD91C98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 09:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D64B780DEC;
	Tue, 22 Sep 2026 09:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6WgkgHZnTftJ; Tue, 22 Sep 2026 09:04:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B6AF880DCC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790067863;
	b=jDiNUioYCWhWu8/P60JwboDNChznWxvQdSFskPmeJ45ftVOFB9PFxWK7NWrpJH7e8iwy
	 5oGxmobaYF9AoksW1UxGW+PgGP2HvWLWK8P8tMXtimEvZTP6EkChSGATBjZmoEaPh7AAL
	 8DGpGeN5/L0VVGm1I/rGwZnGZUEGi4HhKuAg+2/bUrzCGtbBKgnREieBd1MrxLQwdUDB9
	 cxmZQnpKie7MiEtAHTpMp5RY5dmxt7x6WR8jP+9l2RQvNlbGE7rEnEkVILkhVK0vTK4+w
	 u62xQCUIrKUsimT0evCBrdg/eLk7R9c3SPrZymMmQ2MylFSGR/WtClDaoB2TLGtJdMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790067863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6VtLFD1vg5tvTIM6vKNjHT1kkApQA/KZte/hT3YtnlI=;
	b=ksgHSTIsKEr+dUOL9euvGrLOLemm/itVFO321FXY01BYwXMRLiX5pAE+jbHAx2NqONXl
	 WnymEqoWuJzGP2NyPs/OTjnvT3rTpO/fACUiye9fTLTeXm7HzsWsVRXsRFVaNVqPoYhry
	 kS4ZAaSfpNqgbXc6AIrdQK5kiBILCrAKFUbHDrdD2V5xiOffCmHaMI0vjul6/ajwF+++k
	 3rLtvP0f9V2Rzt4UAX7lhtmtA7VDlcpAOshRLBsPOGznenm31YwpOEWsVhNcyJWPHZ2e8
	 AelrpS4WN1pVWLCaaRgBroekqTQ/UnrxCcoZAxIfU/CEaWVS0YyGeZyUE7SJZxWLLGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790067863;
	bh=6VtLFD1vg5tvTIM6vKNjHT1kkApQA/KZte/hT3YtnlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sDkhmGOZQYD1Gwu0RCBRwe7yAMtRUgPtCHV4AZYCLEoNru/ivZSu4LFG3KR04sMLq
	 vTcMFNElTTQJ1qEH0kbhexxu6sKtjKQp5VdmV1KcgJD77m7Cv49WY2afrPrcaN+JPf
	 6JUpQlOY1Tenpe4JKaz0+VGTpNKMuzvrqC+QWkzLjk7QaBz4Fh9qHT9VtnUrANj/7G
	 gTF7VJw2PjFC7gHQcVMCvLMlHjiIpAkrgf1fjORVH3USvAq+/KJQoGG1/D0VSrSyo3
	 HpMfF0jbfJdVdpJz04gMt9obroGtwDxyfmMQF+E0CQbB5TOelUKTWnqTFBxzgPYaXD
	 lYUf3lW6C/ksA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6AF880DCC;
	Tue, 22 Sep 2026 09:04:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C098312C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 09:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A679A40814
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 09:04:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O_qowKHXCeyO for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 09:04:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C7DEC4070D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=117.135.210.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790067860;
 b=pTjZr7YAe+yiskPw6DnN63jTyTRtJ4urxbx/wHKTR2oAsAm2Tn6vMVo/E6n+huDP2O+4
 3IpzH6WbbODmbzWXglNoa+rUVp247ujfe3wepSJrpIg8gPf/WRmYRH2EFijPFCAaxtgnX
 uiTWzPHGEGcQRoEhRRLKZjbycbt/xnnr9+46wS2+UjWrETRtS8v+XNGNPwRHKd8/P6BI7
 Vpm7c/I4XjKNf4zZ2jy0MJF1Guwgp3ncFLq5fdYX0SLXn8t0nnTDxj/IqC6avNXxLmue8
 MyY9A0Tj93kdD0h6kMyPzzUle325ilvLzFAV2MJZrcxJN4tUiANKdrAznS3DsVhAvHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790067860;
 h=Received-SPF:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
 X-Coremail-Antispam:X-CM-SenderInfo;
 bh=6VtLFD1vg5tvTIM6vKNjHT1kkApQA/KZte/hT3YtnlI=;
 b=EYLWH8mC39hVIOuuD7UkYJvsNJhZiFUNUD2+Gy3mqG1TBPQxw2Pm7bMXd53LDZLpLEnL
 arRf1TudrqtL5NOIHCD8LqpkePTOhJeGynLJy30wjzBO3RLD/KTXaWRkaFdkVKe+z1lF8
 8OyFDzPB/KlDGI9dGG+6eCA+ztNkZZXKDoGaOgVUo7eA8YdcEozyJ9CCWazqcRL20eZe/
 ad4Ptn2o1ydGEkxffqp0sVSb0HRUVXWxmiDygPh9EZkKD+1RvY4IvnGniN8gSBjCYnBgW
 XfPo25uouKpDnSybxUT3C9vtKdmbIw+Grrfnd9Ps/43Rwco1njWGA2Cm6NvwEXqFrpg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=126.com; 
 dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=YxeMJOUD; 
 arc=none smtp.remote-ip=117.135.210.9
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.9;
 helo=m16.mail.126.com; envelope-from=xiaolinkui@126.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256
 header.s=s110527 header.b=YxeMJOUD
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7DEC4070D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=6VtLFD1vg5tvTIM6vKNjHT1kkApQA/KZte/hT3YtnlI=;
 b=YxeMJOUDVswV4aSX/zGsIOqW+2onEoHyh74L+dNKTTQ/bqwyBjcviEo/qcpcbV
 5t+4VlKk6aXVGaRoJK4XZmEBgC506vEmh5W3msN5gGjNf8AxMz3zvSCunY0BaqSh
 2HaLCz8GM7Os5Tm9D4riuyH1k9OKyy8Pi40SxkjF5zqzY=
Message-ID: <ef2b48b9-0f57-46e6-8209-8f4b9d6e42dd@126.com>
Date: Tue, 22 Sep 2026 17:03:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] i40e: limit the DDP profile
 count returned by the firmware
To: netdev-bot+sashiko@kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn,
 aleksandr.loktionov@intel.com
References: <20260920063244.1927792-1-xiaolinkui@126.com>
 <178997248483.2160803.11710552261264563604@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <178997248483.2160803.11710552261264563604@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wDXtwRvRLJqOwMZAA--.52160S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykWw1kWw4fXrykCF17KFg_yoW5Ar1rpF
 WYq3yDtrykK3y0kw1Ikr4xWa48uws3AFy5Xw1rKa4vk3y5Krs7Xry0qFs0qa47AFsaqr1I
 yF1293yUAF4DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBB0S2qyRHDs-gAA3F
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

Thanks for the review. Both findings are addressed in v3.

- [Medium] Incomplete fix in i40e_ddp_does_profile_exist() and
   i40e_ddp_does_profile_overlap()

   Agreed on the clamping half. Silently limiting the count and then
   returning 0 hands i40e_ddp_load() a definite answer derived from a list
   that was only partially read: the add path proceeds without having
   examined every profile the firmware reported, and the is_add == false
   path reports a profile as missing that may in fact be loaded. Both
   helpers already have an error return that i40e_ddp_load() turns into
   "Failed to fetch loaded profiles." and aborts the operation, so v3
   rejects the list instead: if the firmware reports more profiles than
   I40E_PROFILE_LIST_SIZE can hold, the helpers return -EIO and no scan
   happens at all.

   I did not plumb the response datalen out of i40e_aq_get_ddp_list().
   For this command the driver has to set desc.datalen to the buffer size
   it passes in, and i40e_aq_get_ddp_list() does not report the writeback
   descriptor back to its caller, so the length would have to come either
   from a new output parameter on that helper (declared in
   i40e_prototype.h) or from a wb_desc routed through cmd_details. Either
   way it adds a second firmware supplied number to validate on top of the
   one this patch is about, and if the firmware leaves the field at the
   requested 772 bytes the derived bound is exactly the bound we have
   today. That is a bigger change to the common AQ path than a net fix
   should carry, so I would rather bound the scan by the size of the
   buffer the driver owns.

   The remaining half - comparing against p_info[] slots the firmware
   never filled - cannot be detected independently of the count, because
   the driver is not told how many records were actually written. If the
   firmware reports a count of 16 or less while writing fewer records, the
   unread slots are indistinguishable from real entries. Zero
   initialization makes the outcome deterministic (an unwritten entry is
   all zeroes rather than stale stack) but does not make it correct;
   deriving the bound from the response length would be needed for that,
   and that is the larger helper change described above.

- [Medium, pre-existing] uninitialized buff[] handed to
   i40e_aq_get_ddp_list()

   Agreed, and fixed as suggested: buff[] is now zero initialized in both
   helpers. i40e_asq_send_command_atomic_exec() copies the full buff_size
   into the DMA bounce buffer and copies the full buff_size back on
   completion, so those 772 bytes of stack were both readable by the
   firmware and compared against afterwards. Both hunks touch these
   declarations and the root commit is the same (cdc594e00370), so it is
   handled here rather than as a separate patch; I can split it out if you
   would rather have it on its own.

v3 keeps the unsigned loop counter from v2, and drops the Reviewed-by tag,
as the code changed after the review.

pw-bot: cr

