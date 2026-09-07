Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0DBC79F99
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Sep 2026 17:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E16E2605A7;
	Mon,  7 Sep 2026 17:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bd9vsndcyQ2g; Mon,  7 Sep 2026 17:34:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 27B3760609
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788802468;
	b=cga2/HpkpiERteBoHnPYBNTnFGcCd1QXnsmsR90Er9FMkdxPIql6o2hjiSMhNJOF4Yjr
	 WXO2KXtyvsNi06P2Lyy+mG6gCKxJpcWhd4Hz/NDdGuOF5jwlAwxEVKxbLKMLSvHxhEVJd
	 dOXyOnjU2aavWBySfW5AouIkdOfAdElKwrd7vz3UoZ2LjvnISKuk+Yc77sFgI0WTEZ7c4
	 wm/APeNjJSdSrCYlewrsXmPHd/zl3//XZfMonIuNepEdYvaInPVd1layWdGsEADVG9ylt
	 MvFxc6YdiN8kn7lbcJIS+vz06rR1+D3qTa5b40lg9oXB1No3uviAyFnT++hhw56D5Sg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788802468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w16HbRTZNk24gYHENslvNzYjNJGR1RDXFGDxYomI30I=;
	b=oB5qcYnd+ve+/eRsNJdVi+7ziezMaeQn4+5hDoycA+kCscBa85FruvipZ31NJ4/e6XwT
	 ZCsAnzEp9XYtcem+TWBLZmrj9v8AwjWs/MVM8r5eCqBsbC2P3z6ylk2QJu+rNlUXKhE8u
	 22eLZt/ZLCYMZv6NqJUJJ3TIchuvjJVIPsWEfyURXP39luMjr59aFhDoGEXWU55Rq09gz
	 9kejU4oi3SZkrYwFimxiP4m7u6ldxGdlyIt1aM6fFXctmZVEqOIwU+DeF5rRbIFZPAkge
	 Fj/ssvaCN3GzC8Qo5inH7v68ynIH4K3IUgC6XNHryfMCuukFG2piWdCoZzA+Mv0zfgw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qwMAw8d+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788802468;
	bh=w16HbRTZNk24gYHENslvNzYjNJGR1RDXFGDxYomI30I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mYW4hk/uzOMG5wpu6TscGmi63Mxld/kqM+DCiB8KW+NPhz3D0OG6ngOUVeP/3RVNr
	 2DNEOumsh57Gi7pRJJXvtKfiZB2FzNMMDXWXO5UelPaKtXyxbHp7rAQ4EQHWNT/XD3
	 zdd+xJk6mXM6ZH9LJ0ShhvAZaKT4I5IXYwxdYzGeUhqtbnfShqB4eWRmtsdlyzfTBR
	 9fSqzS5gZbZ0kWjJxRJXXS7jzikyH3QCbuiw/FFW1nJbcuTMn9qdtkklGle+OLT+T+
	 A8Dily2iWXhttM/vmrBDCQYGAMjUM1Uu+0c9A8qWvbyJx06kTTYeTaDo60jhfj9cm1
	 Xx78xMaVbbnpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27B3760609;
	Mon,  7 Sep 2026 17:34:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A56A6388
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:34:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8543C60609
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:34:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrWKLN5BgnES for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 17:34:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7207D605A7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788802465;
 b=X+mXB4SVQKpZSHzpS9JwUkmp6Aq8bRG62kxQbMwLtowb2DMRrURbQGsJfg0e1pXIirn+
 UR1CreqontNVpy8yeYE+VxLyypDoeHUQxM0l8/wjqvfdobFYBIgIlsse/b7Og0+Hf6I6A
 sq7anwm8Muq9IuOL59U9PXcCJqVffs8Y+lZ7ytlpswEOLOAqqhdR4znFpFpyuNEs2L3Ou
 uqOP2/GLCE5Z7WWo7dvYVCrgiDJbgU4WqwC5lvMz9i3aW0jq0onXL6xw/6EHig1WI6ups
 WzyZY/vLiJLkBwz3u9lVc5ojCugVJXZzZ2n2li82CvaSw3xIJncfXBQ3Ra8WHkanUVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788802465;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=w16HbRTZNk24gYHENslvNzYjNJGR1RDXFGDxYomI30I=;
 b=dLjEfgsiu0rsLom58PNHNgyTrS5QN0KysuHKtydMyO1XkuCe6vWSffUuoV0gANHOhmIO
 7RxAp4QBlQcSfz0MFhPIRgrMwHenyExzK4EOXb1+egvERgRQZGmIpDJJN0FwHj1GVA50/
 boebcG0amW8iaGuKDfPjc//3sj7qSK1uV3yRR/Za/U8Wq5qb99tBQ/vQakIj85073nXi/
 6RbSJwAGHYy1UYmPJRHr61HIeG894HFE2apOZdBEDfyKsjpFWTE21/CFLo94XSL1LIepv
 TqRnn5Q+B+wLcWwYgpc7A7Uef/Qp7QXemGXDBXRqhsxH77OVUt7uZnHcHG3PS8u0rxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=infradead.org; 
 dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=qwMAw8d+; 
 arc=none smtp.remote-ip="2607:7c80:54:3::133"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:3::133;
 helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qwMAw8d+
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7207D605A7
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=w16HbRTZNk24gYHENslvNzYjNJGR1RDXFGDxYomI30I=; b=qwMAw8d+42MYS2oG8Nf8XTmcEz
 evcY/5k4QE1GzQd8e+sml+VBEoNSv6zjnDXeutOfvKS8KPxfTcVD5SYeiFLhGfWDk1GnydiqagqGO
 Vqg7u7o2Yu8Aa1z4WClGpKVkKkUR5+zXPaXbV/6vw0rIiE6oJ+VmDg78BmpwJuxoe/LgUyWRTLPWW
 UrC+pI6O2EZ3Na3377iiJqv5uoxLtiAbNo37eWeZAI3OUEyoM0fgQcVn1hsgCSkhv99f66N0a+6Hm
 6HvW1vOSt/TuUdcoWubAc7DeGOhjO4Aj8tCtytBEhdKtEmI5+75nqY3UMJkNX6NGbQMLH6XkkOOj4
 f7IQl1NQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1x3cp2-00000007RIP-1xvw; Mon, 07 Sep 2026 17:07:56 +0000
Message-ID: <6fc6daf7-efb7-48c3-95d5-1beb01cc0924@infradead.org>
Date: Mon, 7 Sep 2026 10:07:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: intel: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260907064528.6602-1-hemanth.selam@gmail.com>
 <20260907064528.6602-2-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260907064528.6602-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 9/6/26 11:45 PM, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c     | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c    | 2 +-
>  drivers/net/ethernet/intel/ice/ice.h              | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c         | 2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c        | 2 +-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 8dadfef2c09f..026b35e5a000 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -676,7 +676,7 @@ int i40e_pf_reset(struct i40e_hw *hw)
>  	grst_del = FIELD_GET(I40E_GLGEN_RSTCTL_GRSTDEL_MASK,
>  			     rd32(hw, I40E_GLGEN_RSTCTL));
>  
> -	/* It can take upto 15 secs for GRST steady state.
> +	/* It can take up to 15 secs for GRST steady state.
>  	 * Bump it to 16 secs max to be safe.
>  	 */
>  	grst_del = grst_del * 20;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3da9ec49cc74..ef9d1e78c16a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2614,7 +2614,7 @@ static u64 i40e_eeprom_test(struct net_device *netdev, u64 *data)
>  	netif_info(pf, hw, netdev, "eeprom test\n");
>  	*data = i40e_diag_eeprom_test(&pf->hw);
>  
> -	/* forcebly clear the NVM Update state machine */
> +	/* forcibly clear the NVM Update state machine */
>  	pf->hw.nvmupd_state = I40E_NVMUPD_STATE_INIT;
>  
>  	return *data;
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index db3c7015c56c..e5f940d324dc 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -1105,7 +1105,7 @@ extern const struct xdp_metadata_ops ice_xdp_md_ops;
>   * ice_is_dual - Check if given config is multi-NAC
>   * @hw: pointer to HW structure
>   *
> - * Return: true if the device is running in mutli-NAC (Network
> + * Return: true if the device is running in multi-NAC (Network
>   * Acceleration Complex) configuration variant, false otherwise
>   * (always false for non-E825 devices).
>   */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index d88835482d3a..fe47ec0ba809 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -6202,7 +6202,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
>   *
>   * Features that need fixing:
>   *	Cannot simultaneously enable CTAG and STAG stripping and/or insertion.
> - *	These are mutually exlusive as the VSI context cannot support multiple
> + *	These are mutually exclusive as the VSI context cannot support multiple
>   *	VLAN ethertypes simultaneously for stripping and/or insertion. If this
>   *	is not done, then default to clearing the requested STAG offload
>   *	settings.
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..9ef1aa66fa2b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -924,7 +924,7 @@ static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
>   * is correct etc. Then disable old mapping (MSI-X and queues registers), change
>   * MSI-X and queues, rebuild VSI and enable new mapping.
>   *
> - * If it is possible (driver not binded to VF) try to remap also other VFs to
> + * If it is possible (driver not bound to VF) try to remap also other VFs to
>   * linearize irqs register usage.
>   */
>  int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 7ce46b4b4821..7eb4acf59dab 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -3995,7 +3995,7 @@ static void ixgbevf_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
>  	if (tx_flags & IXGBE_TX_FLAGS_CSUM)
>  		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_TXSM);
>  
> -	/* enble IPv4 checksum for TSO */
> +	/* enable IPv4 checksum for TSO */
>  	if (tx_flags & IXGBE_TX_FLAGS_IPV4)
>  		olinfo_status |= cpu_to_le32(IXGBE_ADVTXD_POPTS_IXSM);
>  

-- 
~Randy
