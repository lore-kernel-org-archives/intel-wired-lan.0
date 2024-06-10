Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1AAC27C5F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Jun 2024 09:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 683AB4025D;
	Mon, 10 Jun 2024 09:06:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LpJHJSCcPjiZ; Mon, 10 Jun 2024 09:06:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7521040364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718010388;
	bh=10MgWey1kOaVMCsMveAmbVMtIJ3Vk1w5cpO4pkLXMwc=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DbckZGt4f6eE3o7/iRPAFCHqy/Bd6Ie7PMutThUmEMIdf2XNifJsGhVfJDOhpt9ZB
	 RCHIcZhQxaKz7UsZHjlp0YTRfgcmigv4/PeMATx9CsEJXdeCbjNvG8g/4DaSLfg1Rn
	 t5p9/0kAM2PSuNIwGVzW6JRT0B8e2suYcmZMUrCMPqqoEItToBI+CqwRrRVgJxxxWg
	 0X5fVFAqTA3z8wIYzbf73ydWHzByoZa3BPXxjGuEenK0SKGCyd5nh/ubV0qqaeIxnQ
	 4jrrfqT1IBdzmW9Z30nDpIuLlQn+7QFLZMe6TPmBeXI7MlFDFyWXwa0UPZgiT/O5yw
	 uVRLVZZoo88ww==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7521040364;
	Mon, 10 Jun 2024 09:06:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 2FB261BF3C9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jun 2024 09:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2675840624
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jun 2024 09:06:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CGLiqdI8tens for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Jun 2024 09:06:26 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 108EF4061D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 108EF4061D
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 108EF4061D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jun 2024 09:06:25 +0000 (UTC)
X-CSE-ConnectionGUID: 4XcfPPpVQumMIYeDvwGHyQ==
X-CSE-MsgGUID: YAPP1OUUSf+ACOVspCJQmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14536097"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="14536097"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 02:06:24 -0700
X-CSE-ConnectionGUID: AQq912iBQ4WrL1Pp5Oy5ew==
X-CSE-MsgGUID: xUWi0rtKTuKZ3SfsK5CUGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="43430323"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.237.140.142])
 ([10.237.140.142])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 02:06:21 -0700
Message-ID: <ef9d16e6-186d-4ee3-9888-1c4aba1b4b88@linux.intel.com>
Date: Mon, 10 Jun 2024 11:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
 netdev@vger.kernel.org
References: <20240609173358.193178-1-ast@fiberby.net>
 <20240609173358.193178-6-ast@fiberby.net>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20240609173358.193178-6-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718010386; x=1749546386;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZZoMCm57vhKq8Re8WFm6bgqLkhWqYeEW5ceyn8ZeDVg=;
 b=V0Spc/yWO1RxLX37FBG7fO4+CBj0lLWWzJnsqA1M3L2XBCUmlIufZnQX
 swS/UEPhuMqK4oUNeXpILNbZOxq3PXfyRqyJuPgu6r8svcoVrlrXCuq6R
 afohSwt9mWTF86LwdvIqWz8GuZGu8XWSpNLioU25aDJvezTSM/N773kIu
 SQ0+z7b4H0HJ1p1CtY35ZSwSvbnflIL7YwX1sm1cAAHkDHDEQcnbl0Q6e
 y+ycxAbNnSs0/HmIL3VQ5ApCXugIS7unxMlPpZGKxY+FarhFAukw5RbbH
 owER+YLkRKG6+8zkpWYki/DjPzCRQ9ekHHYDs4M7O092KBVNDhlXGzssi
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V0Spc/yW
Subject: Re: [Intel-wired-lan] [PATCH net-next 5/5] ice: flower: validate
 encapsulation control flags
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
Cc: Louis Peens <louis.peens@corigine.com>,
 Davide Caratti <dcaratti@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 linux-net-drivers@amd.com, Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org, i.maximets@ovn.org,
 Edward Cree <ecree.xilinx@gmail.com>, oss-drivers@corigine.com,
 intel-wired-lan@lists.osuosl.org, Tariq Toukan <tariqt@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Martin Habets <habetsm.xilinx@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 linux-rdma@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 09.06.2024 19:33, Asbjørn Sloth Tønnesen wrote:
> Encapsulation control flags are currently not used anywhere,
> so all flags are currently unsupported by all drivers.
> 
> This patch adds validation of this assumption, so that
> encapsulation flags may be used in the future.
> 
> In case any encapsulation control flags are masked,
> flow_rule_match_has_enc_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> Only compile tested.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 8bd24b33f3a67..e6923f8121a99 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -1353,6 +1353,7 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
>  		      struct ice_tc_flower_fltr *fltr)
>  {
>  	struct ice_tc_flower_lyr_2_4_hdrs *headers = &fltr->outer_headers;
> +	struct netlink_ext_ack *extack = fltr->extack;
>  	struct flow_match_control enc_control;
>  
>  	fltr->tunnel_type = ice_tc_tun_get_type(dev);
> @@ -1373,6 +1374,9 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
>  
>  	flow_rule_match_enc_control(rule, &enc_control);
>  
> +	if (flow_rule_has_enc_control_flags(enc_control.mask->flags, extack))
> +		return -EOPNOTSUPP;
> +
>  	if (enc_control.key->addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
>  		struct flow_match_ipv4_addrs match;
>  
