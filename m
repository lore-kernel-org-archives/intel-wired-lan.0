Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832A3C25B76
	for <intel-wired-lan@archiver.kernel.org>; Sat,  8 Jun 2024 12:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2484481DF0;
	Sat,  8 Jun 2024 12:56:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ad3Txw_fC3OL; Sat,  8 Jun 2024 12:56:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C7D981E69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1717851398;
	bh=K/7JTVAnlUvLvzDCVtCaO8sIwzsBQ/zjvsk4Hmznxlw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HM3v5gJ9Jj4iQPFgSqZM5jPc+u/wi0bcA6Sd+Aoo7yTwsnOFxPndnWiJWRqWbSXnD
	 GNcK6s7GJfnlNZAvOqX3phQVpcITJd472oHMdVCnbhPixH95GdQnKv4M7GNHj9Iysh
	 9JqtZLAqseReaWGEIEU3yI2J9oTJQfKkth8N3KEa118kWVhn2bd3BUqLg92DoSAJv9
	 l5V7LE62cdvJNrhTlSzkEayaDBQJUBMttoD5pNVuEv33xteR9HYWR9w0t6Uhac2jIU
	 jJQDEOs0+w4ETsMWLh47X+mPgClrA/pFZlo7WBmru1Fo9Mf3Pshx4qsgryTiJBc3LL
	 IWdVnk7J2i1Xw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C7D981E69;
	Sat,  8 Jun 2024 12:56:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D52CE1BF47E
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:56:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE076426DC
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:56:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O7YWIBgCQgdU for <intel-wired-lan@lists.osuosl.org>;
 Sat,  8 Jun 2024 12:56:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 966B5426DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 966B5426DB
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 966B5426DB
 for <intel-wired-lan@lists.osuosl.org>; Sat,  8 Jun 2024 12:56:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8932260BB5;
 Sat,  8 Jun 2024 12:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F367C2BD11;
 Sat,  8 Jun 2024 12:56:32 +0000 (UTC)
Date: Sat, 8 Jun 2024 13:56:30 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Message-ID: <20240608125630.GT27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-5-mateusz.polchlopek@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-5-mateusz.polchlopek@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1717851394;
 bh=/RlJo9WnsSn1XLBS9ggjnNyuELQapyKJA1TQXRzbb/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CBH9ukbS+pWltnD58a99574ux2Cqp7Oj2cdcLWswGA2JX7apSIvtPjkWOdWPaG1E+
 oDiVmlmInCaW2MyLR60rOxKAk1RT+WHCNgFLoVU58N7sfcZKuwSkM+T7kKBzTjvhiJ
 mlL/F8+D9em/5xi22XWCluelGmndMDzaapIxrAtKkJ2jeujVkc5X7e5fDSOJEjpdm5
 O5GObw10hWQgcYFqOZxbvlpdnicVv2O7Og3DRSXv2/9Yi2oQ2CewXCC3UcGq6mNWLJ
 RL+WTz0lRQlfYxCqVwlcgmrmUjA24fN6YY7dqohz7CYvksAJ4ObMcpcziFF1ux5Eaw
 +e7kLoD6PrHPw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CBH9ukbS
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 04/12] iavf: add support
 for negotiating flexible RXDID format
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Wojciech Drewek <wojciech.drewek@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jun 04, 2024 at 09:13:52AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Enable support for VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC, to enable the VF
> driver the ability to determine what Rx descriptor formats are
> available. This requires sending an additional message during
> initialization and reset, the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS. This
> operation requests the supported Rx descriptor IDs available from the
> PF.
> 
> This is treated the same way that VLAN V2 capabilities are handled. Add
> a new set of extended capability flags, used to process send and receipt
> of the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS message.
> 
> This ensures we finish negotiating for the supported descriptor formats
> prior to beginning configuration of receive queues.
> 
> This change stores the supported format bitmap into the iavf_adapter
> structure. Additionally, if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is enabled
> by the PF, we need to make sure that the Rx queue configuration
> specifies the format.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Hi Mateusz, Jacob, all,

The nit below notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -262,6 +276,45 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
>  	return err;
>  }
>  
> +int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter)
> +{
> +	struct iavf_hw *hw = &adapter->hw;
> +	struct iavf_arq_event_info event;
> +	enum virtchnl_ops op;
> +	enum iavf_status err;
> +	u16 len;
> +
> +	len =  sizeof(struct virtchnl_supported_rxdids);
> +	event.buf_len = len;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
> +	if (!event.msg_buf) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	while (1) {
> +		/* When the AQ is empty, iavf_clean_arq_element will return
> +		 * nonzero and this loop will terminate.
> +		 */
> +		err = iavf_clean_arq_element(hw, &event, NULL);
> +		if (err != IAVF_SUCCESS)
> +			goto out_alloc;
> +		op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
> +		if (op == VIRTCHNL_OP_GET_SUPPORTED_RXDIDS)
> +			break;
> +	}
> +
> +	err = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
> +	if (err)
> +		goto out_alloc;
> +
> +	memcpy(&adapter->supported_rxdids, event.msg_buf, min(event.msg_len, len));

If you need to respin for some other reason,
please consider wrapping the above to <= 80 columns wide.

Likewise for the 2nd call to iavf_ptp_cap_supported() in
iavf_ptp_process_caps() in
[PATCH v7 06/12] iavf: add initial framework for registering PTP clock

Flagged by: checkpatch.pl --max-line-length=80

> +out_alloc:
> +	kfree(event.msg_buf);
> +out:
> +	return err;
> +}
> +
>  /**
>   * iavf_configure_queues
>   * @adapter: adapter structure

...
