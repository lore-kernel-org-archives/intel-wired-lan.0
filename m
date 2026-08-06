Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA7CC56205
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 12:26:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFC2080965;
	Thu,  6 Aug 2026 12:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sGfqR-zGSQOE; Thu,  6 Aug 2026 12:26:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9ECA080A82
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786019166;
	bh=lBiLlYbgGII7K9IEBn83RT81OSGixr/KYUW5mcF/XGo=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lIMc9ITmZYb1iOKlJ61NveGycnV3d7cSQpbcPVvOnq9x+oQpdeEK3mgHPhJlJe1Yj
	 SsAKimjvDOxlyFJhmqifNiXwhWPSHDTlH+rr7nBom8u65an1l1wuwOgHiKMGdIyOMI
	 jYar0+9wR8d7Pc9N+b2lGrEQyiM1WUgSW7tI2wepVw2uF7BP6LrxobZqvka9Km3hg5
	 xEJXSHxMhAMy7Gd1ZJ4l/7fCZvkOuoELAvC6AbF9iUbzxbi8W2plR8RFgSLgBlLFVI
	 6IuZZG+5rDdBKi+rP4pXxJQsSdb42mddOmA9Gc9Ll2pODUrPSbpe1ZbNf0lUoLxFB6
	 svGC3iVXXjikA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9ECA080A82;
	Thu,  6 Aug 2026 12:26:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CA87C194
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 12:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0B8340277
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 12:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S5qUJogYEfm5 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 12:26:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 754E840275
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 754E840275
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 754E840275
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 12:26:04 +0000 (UTC)
X-CSE-ConnectionGUID: KTouqcpRSqKjVzOBgy608g==
X-CSE-MsgGUID: 63v/9a1ERGeyxssBGNTA7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="104012467"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="104012467"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 05:26:03 -0700
X-CSE-ConnectionGUID: lWkq9/2dS9Ck+NueEFhJ3w==
X-CSE-MsgGUID: 1u/nZzh1Ra2rZsZ+kxtCgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="258218161"
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239])
 ([10.217.160.239])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 05:26:02 -0700
Message-ID: <3f784e80-69b1-48b4-bc82-a3536363518a@linux.intel.com>
Date: Thu, 6 Aug 2026 14:26:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
References: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786019164; x=1817555164;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Zv5DFhapJz8Taxh8olUlK2mi02VNMV8KBv8WGvglWiY=;
 b=mwVXZn3omto23gcaHGJ7CLFUfgvu666RoDYazcm1QrR9i86CXhKLtvQZ
 QK1l7iBv+rFU5V0SzbL+i5UCu2Ztf5ROstLyxJymCYzkzpbi5qvGa/eVl
 TWfFjHO7PSKc6vpsYr76Od+NyYeFmM6dSYZxsFydkFGsVRSr8GjF3uTdI
 B9RAcqXWhKv7Ig9Y6ERZ2pbqIV7hV8Gh1RfqQ+daj5QjGySVEW5tec1DR
 DGsMmQeCVaB59kBpvDth/Kn+xWxLm5NiALILNEh93BCduV9N7d3QDx91b
 p8acJMe0MYRW/NaAd9sdq6icIU6Ru5oFovpCOflauLR4h88qlJfMY//3e
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mwVXZn3o
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing
 cpu_to_le32 in idpf_tx_splitq_build_flow_desc
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



On 03/08/2026 23:06, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> field in a single operation.
> 
> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> __le32 to ensure the fields are written correctly also on big endian
> platforms.
> 
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> ---
> 
> Changes
>   v1 -> v2
>   - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
>   v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index c724d429a7aa..91ca75e45463 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
>  				    struct idpf_tx_splitq_params *params,
>  				    u16 td_cmd, u16 size)
>  {
> -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));

While it technically works, I find it unreadable. Looking at this line
without reading commit msg, it looks like a bug where a 4-byte value is
written to u8 field. The intent to zero an adjacent, unrelated field is
not clear. Consider assigning these 4 fields manually, or adding a
comment/function doc.

Thanks,
Marcin

>  	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
>  	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
>  }

