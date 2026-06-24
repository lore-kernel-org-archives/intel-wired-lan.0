Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7A2CDB471
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Jun 2026 11:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9047D81EDD;
	Wed, 24 Jun 2026 11:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3hp2o7VyARf; Wed, 24 Jun 2026 11:36:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E570881F1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782300986;
	bh=x2SPnjdJ2mFh3yStRQ4BWwNs41WnNuEv8UcmyRcep1M=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAtWqZLvKSOc/3x6iIKOfksl8ZT1xx8kyzTJ08GKr22L2jSa+2rV8SwgxeOFWPVHL
	 FReeXGkNluqZADZ+9GBP/XBmF55ySPk++2FKdGYwWcsC7UkSrb+Cxs039wV+ZTlR0K
	 BCV0O/fFFYRDmk2UaLTFZ1VSL56V/CBLIklBKIEztoe6LvZbCRC2fTROtYlRCDy0gC
	 nZIFAeVhZVqqanWJcTtmiMwJZH0bJMah2i0iyyL4IBSyRBkR65sK00fwWARY5Q3hps
	 pEZygdpc8OnH/fvggQ6Lr7N8lRCLv13wminpN9OiGtOw1h0hS0oYWR3FPLxaIqL63K
	 SCAYGcr4fThJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E570881F1F;
	Wed, 24 Jun 2026 11:36:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05042363
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 11:36:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E291960BE0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 11:36:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jkIMP3ko5dPI for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Jun 2026 11:36:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.18;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0170B60BDF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0170B60BDF
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0170B60BDF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Jun 2026 11:36:23 +0000 (UTC)
X-CSE-ConnectionGUID: ZEEFFbQXSCq/+8eCOcTRqg==
X-CSE-MsgGUID: tTS2/CwhS4yIDAFLLkjXyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82172970"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="82172970"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:36:22 -0700
X-CSE-ConnectionGUID: 7sWNOukbToKXY6GPJzT6zg==
X-CSE-MsgGUID: BhncjoHVSmSrfhvYXt/OeQ==
X-ExtLoop1: 1
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239])
 ([10.217.160.239])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 04:36:20 -0700
Message-ID: <4a54f8fd-2779-41dd-9d5d-f19151b68976@linux.intel.com>
Date: Wed, 24 Jun 2026 13:36:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Doruk Tan Ozturk <doruk@0sec.ai>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org
References: <20260618145003.47471-1-doruk@0sec.ai>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260618145003.47471-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782300984; x=1813836984;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ED1Ki3ahuXOOZUi8v8sep7F0cikuaaUEWN1kwvcTpwU=;
 b=ZYrZKenj0QGzmakYbCb3IZLUNcOl48SMZh2DL59loRwZKyRNzUHHPjUf
 u3VhQPclrMwssROihMOqu4plSSvZ6lOIMFvMsl06ZXem5ErHKtFqw2tUw
 2U10lFdQ7AR25EpyZg/SyTPm3u1D1R7qljJj795qeFLU7JMJqq0dMislO
 ZR7cROWlNzSckmeEaOzeJgIDAWPpoKRvU/08JSYC7ddCBQMcKlzbohK0Y
 ZaOYzT1Ias79TaWReExn7PLJuwLSvBpeVtDVMvquGfVJPOwIYAhp4IW1e
 xlIPpynzSPi944R8ZSwoFUupl5yHH8CYtcHCAF36X5R3e4VRSpRDJh6ZK
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZYrZKenj
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix
 use-after-free of metadata_dst in repr release
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



On 18/06/2026 16:50, Doruk Tan Ozturk wrote:
> ice_eswitch_release_repr() frees the port representor metadata_dst via
> metadata_dst_free(), which directly kfree()s the object and ignores the
> dst_entry refcount. The eswitch slow-path TX routine
> ice_eswitch_port_start_xmit() takes a reference on this dst with
> dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
> is still in flight (e.g. queued in a qdisc) when the representor is torn
> down, the metadata_dst is freed while the skb still points at it. When
> the skb is later freed, dst_release() operates on already-freed memory.
> 
> Replace metadata_dst_free() with dst_release() so the metadata_dst is
> freed only after the last reference is dropped. The dst subsystem frees
> metadata_dst objects from dst_destroy() once the refcount reaches zero
> (DST_METADATA is set by metadata_dst_alloc()).
> 
> Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
> nft_tunnel: fix use-after-free on object destroy").
> 
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
> v2:
>  - Correct the Fixes: tag to 1a1c40df2e80 ("ice: set and release
>    switchdev environment"); the previously cited fff292b47ac1 only moved
>    the affected code rather than introducing the unbalanced free, and the
>    bug dates back to when switchdev support was added (Simon Horman).
>  - Add Simon Horman's Reviewed-by. No functional change.
> 
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f..41b30a7ca4a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
>  		return;
> 
>  	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
> -	metadata_dst_free(repr->dst);
> +	dst_release(&repr->dst->dst);
>  	repr->dst = NULL;
>  	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
>  				       ICE_FWD_TO_VSI);
> --
> 2.43.0

