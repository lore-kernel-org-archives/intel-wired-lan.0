Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0592C25B75
	for <intel-wired-lan@archiver.kernel.org>; Fri, 31 May 2024 13:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F356606D4;
	Fri, 31 May 2024 13:15:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhRNgzQkj7KC; Fri, 31 May 2024 13:15:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C62396075D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717161354;
	bh=0rfvYyZHY6maPrgBG1nd2dWzWigqBJaT0nrrNqHs6Nw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cAmCXp/BPl8wRKoCrKm8bRrp6W1yRM0z0d73ru29LZkkzoFND2XMZVHcdMkpcBgLE
	 STLYv/qd5fnfZQm3n55Cp9HFKDjLyg3lqBdy61j8Wda+yUPD/gxawj8/YI/nLuLRzO
	 QFQ/4LNiE860W5dldqptH19TNaR0vjf20vqgP7A/sJC71LaAMB4T7FfIjgPTbK9opL
	 BypGG3DhH0JSljGfEiBCAuhXyK7qXYFqcA5V3k0A+w13vKIFMOGv7Ay8FKN+PX1/h8
	 dMmYcSaf2bo7WDb3qNnSCPSlFsnlBbyEu+Z51nhei16QEVQ/tYbfHHFHbVrk6ZsIO+
	 BvyrBuRPgsGrA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C62396075D;
	Fri, 31 May 2024 13:15:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id DBBC51D529C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 13:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D49FD6075D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 13:15:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8BSvsNe3ww_j for <intel-wired-lan@lists.osuosl.org>;
 Fri, 31 May 2024 13:15:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 54B71606D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54B71606D4
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54B71606D4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 31 May 2024 13:15:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D9BB9CE1C6B;
 Fri, 31 May 2024 13:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDC6C116B1;
 Fri, 31 May 2024 13:15:44 +0000 (UTC)
Date: Fri, 31 May 2024 14:15:42 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Message-ID: <20240531131542.GF123401@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-5-ahmed.zaki@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527185810.3077299-5-ahmed.zaki@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717161346;
 bh=jicBXvi5RlbnZo0yegOKGBtoOQPvjAfIaE5jcq/MBts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O+iaJH+qfzIKMGzUi+mHyH/FycCxQa1ThAL8A86wXOPneOzl4Al/fkmlsSyuSQ6oO
 jKVSqXPZ+OvLfC4T5moysMq4GtsmL84izHgvDmE4OqjukFxwpkY3SN7oS+PjHutVRE
 XLDATJC1A7wgnp4DSLid9fKwFRyU9NjMp6Ww6t0Xw7iLKr6wRrLWh2ugn7yPl+mNUu
 x2QnyDCqthOPhurnwi214BXZe6E04AMR9PqHhdqJhG4cUbfjktYTCzI9quq7Wuhr1a
 NCE7+A7PWjQn2nu3o7u9EpmgLsQKQraSbRlcTl7Y6FC+WOc0cdyIxvgC8ImXhXGu7X
 W8gn7XF2PlPQw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=O+iaJH+q
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 04/13] ice: add parser
 internal helper functions
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
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
 Junfeng Guo <junfeng.guo@intel.com>, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>, anthony.l.nguyen@intel.com,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, May 27, 2024 at 12:58:01PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add the following internal helper functions:
> 
> - ice_bst_tcam_match():
>   to perform ternary match on boost TCAM.
> 
> - ice_pg_cam_match():
>   to perform parse graph key match in cam table.
> 
> - ice_pg_nm_cam_match():
>   to perform parse graph key no match in cam table.
> 
> - ice_ptype_mk_tcam_match():
>   to perform ptype markers match in tcam table.
> 
> - ice_flg_redirect():
>   to redirect parser flags to packet flags.
> 
> - ice_xlt_kb_flag_get():
>   to aggregate 64 bit packet flag into 16 bit key builder flags.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_parser.c | 196 ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_parser.h |  52 ++++--
>  2 files changed, 233 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index 19dd7472b5ba..91dbe70d7fe5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -957,6 +957,105 @@ static struct ice_pg_nm_cam_item *ice_pg_nm_sp_cam_table_get(struct ice_hw *hw)
>  					ice_pg_nm_sp_cam_parse_item, false);
>  }
>  
> +static bool __ice_pg_cam_match(struct ice_pg_cam_item *item,
> +			       struct ice_pg_cam_key *key)
> +{
> +	return (item->key.valid &&
> +		!memcmp(&item->key.val, &key->val, sizeof(key->val)));
> +}
> +
> +static bool __ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *item,
> +				  struct ice_pg_cam_key *key)
> +{
> +	return (item->key.valid &&
> +		!memcmp(&item->key.val, &key->val, sizeof(key->val)));
> +}

Hi,

The size of &item->key.val is 9 bytes, while the size of key->val is 13 bytes.
So this will compare data beyond the end of &item->key.val.

I think this is caused by the presence of the next_proto field
in the val struct_group of struct ice_pg_cam_key.

I do also wonder if there could be some consolidation in
the definitions of struct ice_pg_cam_key and struct ice_pg_nm_cam_key.
The main difference seems to be the presence of next_proto at
the end of the latter.

Flagged by Smatch.

...

> +/**
> + * ice_xlt_kb_flag_get - aggregate 64 bits packet flag into 16 bits xlt flag
> + * @kb: xlt key build
> + * @pkt_flag: 64 bits packet flag
> + */
> +u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag)
> +{
> +	struct ice_xlt_kb_entry *entry = &kb->entries[0];
> +	u16 flag = 0;
> +	int i;
> +
> +	/* check flag 15 */
> +	if (kb->flag15 & pkt_flag)
> +		flag = (u16)BIT(ICE_XLT_KB_FLAG0_14_CNT);

nit: It's not clear to me that this cast is necessary.
     Likewise twice more in this function, and elsewhere in this patchset.

> +
> +	/* check flag 0 - 14 */
> +	for (i = 0; i < ICE_XLT_KB_FLAG0_14_CNT; i++) {
> +		/* only check first entry */
> +		u16 idx = (u16)(entry->flg0_14_sel[i] & ICE_XLT_KB_MASK);
> +
> +		if (pkt_flag & BIT(idx))
> +			flag |= (u16)BIT(i);
> +	}
> +
> +	return flag;
> +}

...
