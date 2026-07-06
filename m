Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBE8C43458
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jul 2026 10:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D036608D1;
	Mon,  6 Jul 2026 10:02:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f3RSsMV4BVTt; Mon,  6 Jul 2026 10:02:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B737C608CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783332161;
	bh=L3Jq0FfeffkUQzy5szPZvvw3VgtEVHTtS7CaQRHYrPQ=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MI92KwQTs24pnDjLtgOKQo6y67QCy+57LvnUjuAv8BQf0T2X3cfXVZHvWGMDNHmbC
	 dTFm7VhQMdxclqpRyqGqYF+e5pniWLIL+nGLKyICq8s0EsXM11JAHgtbD/g9qUdEV6
	 CYewvH9d/zXQT5AChZ7Cfu3qpwIcQ4zxZvm5fiV61TLOLIdTlMyg82EgNRB7XZ0QSb
	 eQi2li/d2gmRzYaOXQ7T90rjM50t6IiZoK5gtqdvbpo/0WO01X+88T1YzBkhlhSE0m
	 pTfyGANJC1BJFYFNaIrqhE8z2vE7wBrm0Ss/Km87/n9YwKmbK/DVFSnlxTig2oe+fE
	 /aF2zu3UHYKcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B737C608CC;
	Mon,  6 Jul 2026 10:02:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 265AF316
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 10:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17FD5608CC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 10:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a0fcCY2fLVOx for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Jul 2026 10:02:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0F372608AE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F372608AE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F372608AE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jul 2026 10:02:38 +0000 (UTC)
X-CSE-ConnectionGUID: n5omv2kBQMKMNP0fKuiBxA==
X-CSE-MsgGUID: mMYExahdSpmBzarcWYNKXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="84055366"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="84055366"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 03:02:34 -0700
X-CSE-ConnectionGUID: Afkzqs84QcGnajqTOJ2OWQ==
X-CSE-MsgGUID: GcR4ICQ3T3eN2tYPofjV/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; d="scan'208";a="283768848"
Received: from unknown (HELO [10.217.160.239]) ([10.217.160.239])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 03:02:31 -0700
Message-ID: <9750092f-264e-45a1-af11-2f574ab67fa4@linux.intel.com>
Date: Mon, 6 Jul 2026 12:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260706092500.79044-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783332160; x=1814868160;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9qm6US3OrG2rDjRIGBpWm7uNjbIkQkBQoEZAQyT/jcA=;
 b=XGuDcHErtSZxq709d4owrssM6GLmd9oNxNmY+JHzkjiFASekyY4ypEkH
 iEwCOLTHOIC/Y1SsM1OfYVjD42Sv+5k6xaLGHsssvx/TaFZItJise0PBO
 gXHy54K1VA8h5ee/4hkQoQf5qZj9XGSLsVNnBvTjATtExjdrK9BnHU0JT
 ij5sW1uiRYzJTi/w8xbdb0Vagi45YA8+4MHU6SsO/jvQ4fNM/GSJ4/eDa
 CeqF8kIzJBf0xG/3EKcusWkhHVnASRIEHhSQZr6RhTeLe2KH5q264GF3O
 acW5V+Zvyv0mQBW+WKG5t9FztvDgAMB706vhG/YFo2/YkYWnMb4/Cx72G
 Q==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=XGuDcHEr
Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: validate E610 PFA TLV bounds
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



On 06/07/2026 11:25, Pengpeng Hou wrote:
> ixgbe_get_pfa_module_tlv() walks E610 PFA TLV records stored in
> EEPROM.
> 
> Stop parsing malformed TLVs whose header or declared value length would
> exceed the PFA boundary.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 4d8ae5b56145..03e88bdf5a43 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -3895,6 +3895,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>  	while (next_tlv < pfa_end_ptr) {
>  		u16 tlv_sub_module_type, tlv_len;
>  
> +		if (pfa_end_ptr - next_tlv < 2)
> +			break;

This check could go in the while condition above.

> +
>  		/* Read TLV type */
>  		err = ixgbe_read_ee_aci_e610(hw, next_tlv,
>  					     &tlv_sub_module_type);
> @@ -3917,6 +3920,9 @@ static int ixgbe_get_pfa_module_tlv(struct ixgbe_hw *hw, u16 *module_tlv,
>  		/* Check next TLV, i.e. current TLV pointer + length + 2 words
>  		 * (for current TLV's type and length).
>  		 */
> +		if (tlv_len > pfa_end_ptr - next_tlv - 2)
> +			break;
> +
>  		next_tlv = next_tlv + tlv_len + 2;

Would be nice to define the magic number (2), since we're reusing it now.

>  	}
>  	/* Module does not exist */

Thanks,
Marcin
