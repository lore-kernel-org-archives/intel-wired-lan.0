Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEBCC4725D
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 Jan 2024 16:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A44C845F2;
	Fri, 19 Jan 2024 16:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A44C845F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1705680168;
	bh=PVqAGi1H3WMpAZgG/gSZkhkdSC15sMO7Wm6VHXWnUBY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=aUyLDSLzakeQqb7UJnhLYyzna/TCyUzePsVU/9M9RExm/UYnESESxsKHcaE/tp2aw
	 zUYxxhZTGIgPUY4W0d3unwFDGx3dROEuEHDimWjWIynS4xaXWD3NcBiJ2RrTHQRjYr
	 V/KcSyov/hoCZ6t+gkXXUmXawBUZRuDsblcMMgle77LQNL2zevyk4cYwwXZAOtuWRH
	 91D8GBMt9SspIqTcsL6F1bUxYEy07vlY4tS9HsQnOT0LoWBAYPt1gsQ7K7SnOJSvZ6
	 D+Q8i351O5Ptet9LEvaD8lAqte70wEBwRFNj2sxn9KHXjEjnebXyVY1jyHXtcVIXSb
	 tH6dCJT+bv/tA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SW001raya9RM; Fri, 19 Jan 2024 16:02:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71C1884607;
	Fri, 19 Jan 2024 16:02:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71C1884607
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id DE4001BF47A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 16:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B403F40970
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 16:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B403F40970
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gHmLtSW2e-r2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 Jan 2024 16:02:24 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6156240948
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 Jan 2024 16:02:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6156240948
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 351E4619EE;
 Fri, 19 Jan 2024 16:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCE1C433C7;
 Fri, 19 Jan 2024 16:02:21 +0000 (UTC)
Date: Fri, 19 Jan 2024 16:02:19 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Message-ID: <20240119160219.GE89683@kernel.org>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
 <20240118134332.470907-3-jedrzej.jagielski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118134332.470907-3-jedrzej.jagielski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1705680143;
 bh=j99FGhsPkO0OdUev0nx6o0lc9b/hSGs9dBHLOK576NE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pEXasTp7IODwPDJCcr/saQ0HTTuJ6LL/sax4pFl7yesDohz1mj5FcnwUnZ3h5ExKU
 w1ACeMJSYIb6O2z9urWVD+F8fTFOgdrgxMxZYlg4MMasSfqMajVGvhBJsRUbrH2fWT
 uU4mLXxzkCO+vOyT97q0ylYF/1cJU0TLeHtvTbfnYSXSi1Me8YV/cQ9RvBmdncbdxd
 5TsTnHMVGtbYxvt/FmlBxr1cBgyupwR6KhnMSVej/VdmMa4PX6ZAx7b6BRdUpmefgj
 k4mD/PNxQKKEkRF/0kFr4ukg9+9Ajgj85gL2nls+Iflc1VV0aTCFjhNNKi87tx6k26
 auCr3DxcLL2hA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=pEXasTp7
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ixgbe: Cleanup after
 type convertion
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
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jan 18, 2024 at 02:43:32PM +0100, Jedrzej Jagielski wrote:
> Clean up code where touched during type convertion by the patch
> 8035560dbfaf. Rearrange to fix reverse Christmas tree.
> 
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

...

> @@ -771,12 +771,12 @@ static int ixgbe_setup_mac_link_82599(struct ixgbe_hw *hw,
>  				      ixgbe_link_speed speed,
>  				      bool autoneg_wait_to_complete)
>  {
> -	bool autoneg = false;
> -	int status;
> -	u32 pma_pmd_1g, link_mode, links_reg, i;
> -	u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
>  	u32 pma_pmd_10g_serial = autoc2 & IXGBE_AUTOC2_10G_SERIAL_PMA_PMD_MASK;
>  	ixgbe_link_speed link_capabilities = IXGBE_LINK_SPEED_UNKNOWN;
> +	u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
> +	u32 pma_pmd_1g, link_mode, links_reg, i;
> +	bool autoneg = false;
> +	int status;

Hi Jedrzej,

In the new arrangement above autoc2 is used before it is declared.
Perhaps this could be:

	ixgbe_link_speed link_capabilities = IXGBE_LINK_SPEED_UNKNOWN;
	u32 autoc2 = IXGBE_READ_REG(hw, IXGBE_AUTOC2);
	u32 pma_pmd_1g, link_mode, links_reg, i;
	u32 pma_pmd_10g_serial;
	bool autoneg = false;
	int status;

	...

	pma_pmd_10g_serial = autoc2 & IXGBE_AUTOC2_10G_SERIAL_PMA_PMD_MASK;

>  
>  	/* holds the value of AUTOC register at this current point in time */
>  	u32 current_autoc = IXGBE_READ_REG(hw, IXGBE_AUTOC);

...
