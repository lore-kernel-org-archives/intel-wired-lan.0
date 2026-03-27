Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C908F10ED64F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 10:10:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80B1F612A5;
	Fri, 27 Mar 2026 10:10:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3qUTCjLAXDwf; Fri, 27 Mar 2026 10:10:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B399761229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774606235;
	bh=J5ZWrvbEeJCofrbrGmOSHLWyHltr+KXby4i2bFEGsAo=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJzkr5+GE3ltTtP5KGF0VJV5gbZBzx7hUjkW79Nuy6lXF3IoySATP9X+VIMP3bJBY
	 XSWxKfMnaNG5DflX/+3wC+cl4+lOleHYuo7tbHufBchUNl5vM3tuVlo6hervXBkOI+
	 O2/fc6GAGlGR5iuzYVdIST90bkpNX/9dc+pdgQVYUyFxUYsOOnU8IrdSNEDVDipW/u
	 Oe1k3IpoLXKcie7V809AzgMte1Y2dzIdyux0S9OK7LkGJu8eLr5ZJkL1/6iQEH8gjd
	 RP9Lz9LlogaHHxel4Ri1Uf6CARq4HSHjLGXEZ7W+ZQ7Y4hfcPrZOXsM1ebIpbPg1CK
	 v5g6TXFu6UiBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B399761229;
	Fri, 27 Mar 2026 10:10:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67B071D3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 10:10:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5945583B86
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 10:10:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9OLGsRM0XLE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 10:10:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B5D1683B7C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B5D1683B7C
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5D1683B7C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 10:10:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BD1440891;
 Fri, 27 Mar 2026 10:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23853C19423;
 Fri, 27 Mar 2026 10:10:31 +0000 (UTC)
Date: Fri, 27 Mar 2026 10:10:29 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260327101029.GE111839@horms.kernel.org>
References: <20260320051455.427282-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320051455.427282-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774606233;
 bh=5qndRQUCI/S9WQE+YEGeO8WuGVF0l+SDDd3ePJMUvaA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TiNOaueVhRQAZ6rHjt5rniIZci+Y9tuafAn2G7tnO+PH2B0H0y2HnjYJYvnaBMDzk
 jXNgoxevO/SeLCkmr4h76WC1tsBSorb/MdwX8tsp6lsuQw79VreKhmFwhM7/H/y4oO
 +ClCibO8ouNO+RhmD1oKItLzAxxnS83qAN4/WYgTHnwfi0Uut0PqsskDnyuKBdXLRz
 pHKCBACaHdiGXl5uQxlOg0Ryjh/gW6cmnqHWoO2FgUhpVh/ibLtzZGNI8bQ1zPlOjU
 hgPu6QsJjk9Py/jvkT65Br44yXF3XDSHoitKQpNzr0g71dIvgbtRqWu8TSEppGRGKT
 BdJ2mnXgh9gsg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TiNOaueV
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbe: fix eeprom_id
 staleness and non-fatal EMPR reload failure
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

On Fri, Mar 20, 2026 at 06:14:54AM +0100, Aleksandr Loktionov wrote:
> Three related bugs around FW version reporting after EMPR reset on E610:
> 
> 1. ixgbe_refresh_fw_version() silently discarded the error return from
>    ixgbe_get_flash_data(), so a failed NVM re-read left adapter->eeprom_id
>    with whatever stale data it held before the reset.  Propagate the error
>    and set eeprom_id to "unknown" on failure so that ethtool -i and
>    devlink dev info never show a version that no longer reflects reality.
> 
> 2. ixgbe_devlink_reload_empr_finish() returned 0 without ever refreshing
>    the FW version after the EMPR completed.  Add the refresh call, but
>    treat it as best-effort: a failure to re-read flash does not mean the
>    EMPR itself failed.  Log a netdev_warn() and return 0 so devlink
>    reports the correct reload outcome.
> 
> 3. ixgbe_reinit_locked() never refreshed the FW version for E610.
>    Because E610 has no FW event that notifies peer PFs when an EMPR
>    triggered by another PF's devlink reload completes, any PF that
>    subsequently goes through reinit would keep stale data in hw->flash
>    and adapter->eeprom_id.  Add the same best-effort refresh here,
>    gated on ixgbe_mac_e610, with a netdev_warn() on failure.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 56aabaa..40d593b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1155,12 +1155,30 @@ static int ixgbe_set_eeprom(struct net_device *netdev,
>  	return ret_val;
>  }
>  
> -void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
> +/**
> + * ixgbe_refresh_fw_version - re-read flash data and update eeprom_id cache
> + * @adapter: board private structure
> + *
> + * Re-reads the NVM/flash and refreshes the cached adapter->eeprom_id string.
> + * On failure the cache is set to "unknown" so that ethtool -i never shows a
> + * stale version string after a failed reset.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
>  {
>  	struct ixgbe_hw *hw = &adapter->hw;
> +	int err;
> +
> +	err = ixgbe_get_flash_data(hw);
> +	if (err) {
> +		strscpy(adapter->eeprom_id, "unknown",
> +			sizeof(adapter->eeprom_id));

nit: I think you can omit the size argument to strscpy
     because eeprom_id is an array.

> +		return err;
> +	}
>  
> -	ixgbe_get_flash_data(hw);
>  	ixgbe_set_fw_version_e610(adapter);
> +	return 0;
>  }
>  
>  static void ixgbe_get_drvinfo(struct net_device *netdev,

...
