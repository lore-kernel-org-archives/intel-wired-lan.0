Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D7EFEEF34
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Apr 2026 13:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 385036065C;
	Tue,  7 Apr 2026 13:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fLtTgVUdnTUV; Tue,  7 Apr 2026 13:26:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 931C660BEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775568378;
	bh=xBSmT4yOaqX3ajWdenBEJqZ7B8ZGAJfIK5QUNMvE6Mw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uKixVgsN1nm7C7srOMkyXWIXlFr1P3Lja4eDowwOZu4+72oOdrOur/K1Nftgd9b3e
	 6K5ppUt06/yZaUSj9+jvkhN2BvuD7XsalADFZzh42iNyklJQlOwnTNXR6Y4Znrlazx
	 kYt3j1kVUjV8hDVmb8yYAh75jMFL8FepBcCi+vWFWSIfTx3uYoqAgYL9dJ95m+iI9d
	 JTMtSzYJKU6QY5t0rt79bQAnE810bWMFhCE5j+7htX5PuN/i3AUDc23tDZR8E8D/a6
	 F4jpCWAQeKvIpwz2raNTeTl7AahqIfgg3/Qn3zJaZnEl0hGNrXzOM0xTrq82msjj0B
	 MjGO+O0OPV5KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 931C660BEC;
	Tue,  7 Apr 2026 13:26:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC8C21F6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Apr 2026 13:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A243C406AE
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Apr 2026 13:26:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlwUEJGbxB1Q for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Apr 2026 13:26:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6B000406A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B000406A3
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B000406A3
 for <intel-wired-lan@osuosl.org>; Tue,  7 Apr 2026 13:26:15 +0000 (UTC)
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 637DQ9Jn093068
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 7 Apr 2026 22:26:11 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Tue, 7 Apr 2026 22:26:09 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@osuosl.org
Message-ID: <adUDfCHA-xewMp3k@x1>
References: <20260406035130.2255713-1-tactii@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260406035130.2255713-1-tactii@gmail.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=xBSmT4yOaqX3ajWdenBEJqZ7B8ZGAJfIK5QUNMvE6Mw=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1775568371; v=1;
 b=ZvrvcPGhUnU3Scv98hxl+ByC/VS+bxA0Iem9l8EfTyfXCn+6b0nLKe2HqrJYG3c6
 p4pXBFGpXHqH/cAVJPaI1nY4hsBogdsA5fIOVMpJAINat9Hmdk1L8JfAt14CEfIB
 e07seQ65J/2SRgPeVqP2b2ydzLzG03o8xIflGlr5CDBjzgqaadHOfBtgB0SwmFT7
 QMU9FfQrBF7nlLXQ0y18nC8faxcI0uKEBDyvqL0YvknECYH2nEzeTYvPY6TLjVHK
 TIRF1YTsXhTVaetybhjnG2fdPv2OGWRia/9F79uVEV8GmJEERe/i9S5Z45R8OfbP
 frlomYQTFF/kivJ6RwKV7w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=ZvrvcPGh
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Cleanup PTP pins on probe
 failure
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

On 04/05 23:51, Matt Vollrath wrote:
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -940,12 +940,15 @@ int i40e_ptp_hwtstamp_get(struct net_device *netdev,
>   *
>   * Release memory allocated for PTP pins.
>   **/
> -static void i40e_ptp_free_pins(struct i40e_pf *pf)
> +void i40e_ptp_free_pins(struct i40e_pf *pf)
>  {
>  	if (i40e_is_ptp_pin_dev(&pf->hw)) {
> -		kfree(pf->ptp_pins);
> -		kfree(pf->ptp_caps.pin_config);
> +		if (pf->ptp_pins)

Not a big deal, but I don't think this guard is necessary, because kfree
accepts NULL safely.

> +			kfree(pf->ptp_pins);
> +		if (pf->ptp_caps.pin_config)

Same here.

Thank you for addressing!

> +			kfree(pf->ptp_caps.pin_config);
>  		pf->ptp_pins = NULL;
> +		pf->ptp_caps.pin_config = NULL;
>  	}
>  }
>  
> -- 
> 2.43.0
> 
