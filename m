Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7D5E9D800
	for <intel-wired-lan@archiver.kernel.org>; Sun,  5 Apr 2026 18:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7862380E60;
	Sun,  5 Apr 2026 18:02:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pEoREC8PZ3CR; Sun,  5 Apr 2026 18:02:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC35F80E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775412174;
	bh=PrRRlohMkhEjm7NaDXtzh23cyOb4HkxrX9liPqLiX3E=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YA7WMgZkrLOP6k801Lle8lsdGseQHKvg0+p9LBkxHTHoyM8qUwqluwp94UyJLRFSS
	 NnUxRNElLKB+Ftp+iCZ1t/qLtqi+txvlUyHyH5WGzqxTduKGx4AMQwXOLX8qWY98NN
	 +c3lj91nR+K1KuE72JKBJPAkeXuLu3rcPmJhwO+qqFE2t75jX/DCH86N+22Yd2YfUy
	 K/uQAs2Lr4f1dsl+BIKO5QXZyhg6SFcVWw4AUIRp9fnfzghJM7ofrO4+7jzztiaNHP
	 NvFyFSJYmaUlcgpCndt9jOfoo67QLcPA5NxYGGN0hKx0NNta+/QKlV/chXGA2r+e7R
	 k3klsj+jsFoPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC35F80E42;
	Sun,  5 Apr 2026 18:02:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21B011EB
 for <intel-wired-lan@lists.osuosl.org>; Sun,  5 Apr 2026 18:02:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0759880E42
 for <intel-wired-lan@lists.osuosl.org>; Sun,  5 Apr 2026 18:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CdWBMQ4A6sHk for <intel-wired-lan@lists.osuosl.org>;
 Sun,  5 Apr 2026 18:02:52 +0000 (UTC)
X-Greylist: delayed 3538 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 05 Apr 2026 18:02:51 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C6F7A80E40
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6F7A80E40
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6F7A80E40
 for <intel-wired-lan@osuosl.org>; Sun,  5 Apr 2026 18:02:51 +0000 (UTC)
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 635H3mkF047151
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 6 Apr 2026 02:03:49 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Mon, 6 Apr 2026 02:03:48 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@osuosl.org
Message-ID: <adKGaJoGMhivmgBC@x1>
References: <f8ffc8de-4b1b-40fd-8807-ee8687fa984f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8ffc8de-4b1b-40fd-8807-ee8687fa984f@gmail.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=PrRRlohMkhEjm7NaDXtzh23cyOb4HkxrX9liPqLiX3E=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1775408629; v=1;
 b=lsyjIF/uWEtM43pTbIUMIJwQOn8uZHA5QoRaGBHeL2d5FpT6scjch6x5AZqoMA0m
 Ze+qFzeGM000flpWjHHT+EwnIXDFonP/jYk8WOaLdbVZl4GTJXi/rffCSV5CNpqG
 OstZHhyuFLvLbPcAHalfHt6Zc/qdPE1WGPnTJ0UzzqNXvxI40bDYaaIeC/eDaDW/
 sZkzJNnvnTilPe5x3b+/H27hpcSXMLFWuHAUeno/ow0plkvDBN8/LRueS1who1eo
 PM+BaQaWXqMtHe0SNEay6NI8xiWAUfrqIWJIx95L8v/NqB+NPHEMimkpD3+wuw9I
 opWBBecJUhd3xWWYtfNQaw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=lsyjIF/u
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: Cleanup PTP upon probe
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

On 04/04 11:19, Matt Vollrath wrote:
> Fix two conditions which would leak PTP registration on probe failure:
> 
> 1. i40e_setup_pf_switch can encounter an error in
>    i40e_setup_pf_filter_control, call i40e_ptp_init, then return
>    non-zero, sending i40e_probe to err_vsis.
> 
> 2. i40e_setup_misc_vector can return non-zero, sending i40e_probe to
>    err_vsis.
> 
> Found with coccinelle.
> 

Isn't a Fixes: tag needed?

> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 598739220dfb..dacdf5fad2ea 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* Unwind what we've done if something failed in the setup */
>  err_vsis:
>  	set_bit(__I40E_DOWN, pf->state);
> +	i40e_ptp_stop(pf);

Perhaps this is a separate issue from this one, but if i40e_probe()
fails and jumps to err_switch_setup, doesn't pf->ptp_pins leak?

Also, maybe because I'm not very familiar with this driver, I don't
understand why i40e_ptp_alloc_pins() is called this early, outside of
i40e_ptp_init(). It seems to make the error-path handling a bit more
complicated.

>  	i40e_clear_interrupt_scheme(pf);
>  	kfree(pf->vsi);
>  err_switch_setup:
> -- 
> 2.43.0

This diff seems mangled, and doesn't apply to my local trees.

Email header says:
  User-Agent: Mozilla Thunderbird
  ...
  Content-Type: text/plain; charset=UTF-8; format=flowed

It may be worth disabling format=flowed if you use Thunderbird.
See also: https://docs.kernel.org/process/email-clients.html
