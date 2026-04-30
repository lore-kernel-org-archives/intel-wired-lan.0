Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCB1FF8873
	for <intel-wired-lan@archiver.kernel.org>; Thu, 30 Apr 2026 17:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DE286122E;
	Thu, 30 Apr 2026 17:21:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OoDSHMXcmvdw; Thu, 30 Apr 2026 17:21:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF5AA61216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777569673;
	bh=ppNwtIYpqmNzsyjJFtN7uxY11rsuQozEmkHk4j3PaLU=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nifeNJyBY2/wQTqXbQER6VKzHUyCBnxjzCjyapNeKRs7DHCXXPcUazl3PaT1B5x42
	 WsU9lKG26ESFNhu6l1c5u0iIXHkEkjGre7dn5K72av69SuyNVNxa+X/TPMOlJ7p8VT
	 XPgDjnKawuqy3KrwBMBv1HL6I+FAyUOcMDC9O7RyNo14RrDAnQOtnpJ5cu2qDTugTC
	 Lbrly+qnqZU+tNx4uNr0Lqe3QiH6lucFKrY6zaesXkNRVsmhn5r2lPvfk955o6tTSq
	 9kL7VsJA7mfDhGbBZtUN94mrw/xDYLS40LreHUSl5s/SoKxOJbVXgC8NVR8Yn9AoKR
	 97H+SsLnv0cpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF5AA61216;
	Thu, 30 Apr 2026 17:21:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CB6118F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 17:21:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A3A341124
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 17:21:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNpW0JC2l7Sy for <intel-wired-lan@lists.osuosl.org>;
 Thu, 30 Apr 2026 17:21:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CC07841123
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC07841123
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC07841123
 for <intel-wired-lan@lists.osuosl.org>; Thu, 30 Apr 2026 17:21:08 +0000 (UTC)
Received: from [192.168.44.251] (unknown [185.238.219.95])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 611884C2C37F04;
 Thu, 30 Apr 2026 19:20:58 +0200 (CEST)
Message-ID: <1737f22d-1eca-4dee-95cc-6bd397e655dc@molgen.mpg.de>
Date: Thu, 30 Apr 2026 19:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
References: <20260430142153.249062-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260430142153.249062-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=molgen.mpg.de
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: reject out-of-range
 ptype in ice_parser_profile_init
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

Dear Aleksandr,


Thank you for your patch.

Am 30.04.26 um 16:21 schrieb Aleksandr Loktionov:
> set_bit(rslt->ptype, prof->ptypes) operates on a DECLARE_BITMAP of
> ICE_FLOW_PTYPE_MAX (1024) bits. Nothing prevents a malicious VF from
> providing ptype >= 1024 through VIRTCHNL, resulting in a write past
> the end of the bitmap and a kernel page fault.
> 
> Reproduced with a custom kernel module injecting a crafted
> VIRTCHNL_OP_ADD_RSS_CFG on E810-C QSFP (8086:1592),
> FW 4.91 0x800214af 1.3909.0, ICE COMMS DDP 1.3.53.0,
> kernel 7.1.0-rc1.

7.1-rc1 (no need to resend)

> crash_parser: ice_parser_profile_init @ ffffffffc0d61b60
> crash_parser: setting ptype=0xffff (max valid=1023)
> crash_parser: calling ice_parser_profile_init -- expect OOB crash!
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> Oops: Oops: 0002 [#1] SMP NOPTI
> CPU: 56 UID: 0 PID: 165011 Comm: insmod Kdump: loaded Tainted: G S U OE 7.1.0-rc1 #1
> Hardware name: Intel Corporation S2600BPB/S2600BPB
> RIP: 0010:ice_parser_profile_init+0x2d/0x1d0 [ice]
> Call Trace:
>   <TASK>
>   ? __pfx_ice_parser_profile_init+0x10/0x10 [ice]
>   crash_init+0x127/0xff0 [crash_parser]
>   do_one_initcall+0x45/0x310
>   do_init_module+0x64/0x270
>   init_module_from_file+0xcc/0xf0
>   idempotent_init_module+0x17b/0x280
>   __x64_sys_finit_module+0x6e/0xe0
> 
> Bail out early with -EINVAL when ptype is out of range.

Is a warning logged now?

> Fixes: e312b3a1e209 ("ice: add API for parser profile initialization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_parser.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index f8e6963..3ede4c1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -2368,6 +2368,9 @@ int ice_parser_profile_init(struct ice_parser_result *rslt,
>   	u16 proto_off = 0;
>   	u16 off;
>   
> +	if (rslt->ptype >= ICE_FLOW_PTYPE_MAX)
> +		return -EINVAL;
> +
>   	memset(prof, 0, sizeof(*prof));
>   	set_bit(rslt->ptype, prof->ptypes);
>   	if (blk == ICE_BLK_SW) {


Kind regards,

Paul
