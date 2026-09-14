Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51346C88E73
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Sep 2026 20:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1CC56061E;
	Mon, 14 Sep 2026 20:09:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaYBg1RXONlj; Mon, 14 Sep 2026 20:09:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3A2B2605FC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789416548;
	b=rHL7fCQzgEClZAgHV4mJwApjSqsUq+MWTyCwWTFqTcdbLnCneWgF3q3MVny0gQ8aR1QF
	 FWKumrgmaW3B/A4yqymb+cVLp2k9KfcqqMM3gkvYedEoPrgoDNVcGAgv0kXpsSqbEd64Z
	 Ho4msAU3UVY+BCRLUyZf+2zztn4mOXONBa3EzNIwbo6Kr9WUqXq5S9Wzq8XqqGe5z10ZO
	 gzZGTNdG31V2Od3JvWRdkAwDBqERUk5RGHvEbZfcRj6BRfKPlqLWGv7YW5wV7EvNsskAc
	 OcaphaIHtPhYVG63BVRNq/MIFBdq0miT1WCBl+dgno/0E66khttYU3YF5eQ32tsEX+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789416548;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=17omEsBkSdIGbP1denohxoZc3O5NXS7kzLEED9AccTg=;
	b=HBCobUHffit8RRHq7RZY+TZey9DZdoAXzRXxBKZbmKeMlPxUCy3MpL3/K8KYiZgyH2Rs
	 0Rv3kEVImdz1K0w6sDj8EFiPKl442ObReRvsumAxLhzu96NJOU0WtkSxVWLGlj7fWXQZU
	 QA16iN4MvkSNkmoGRiuqQJyIBF/AAn3Oa05m7+XWFVBf/LMhQMsdhDn8vdIR7NRQJTLaz
	 pvxEiQpP8UuTO7Mtn3Dt8CYT2wsPFqlLPKZP/Vfu2u0pFRs04m4TRRqrm6zUylhFkzDCg
	 MUIPaJBkduNfeWLD4P0RVLPO/A8FA/hzEEffjMW7nfsNrIL2sTawrV+428bYKVB9EfQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789416548;
	bh=17omEsBkSdIGbP1denohxoZc3O5NXS7kzLEED9AccTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=2WF+Ax1H1PiXQ7s9RDqd7gqNmPwXjoKcWpQzWSsCD/64w7hAJGqTsWhJ2W90Rl+8K
	 HtQhwIBLxynVPHeSy8/Uzl70kpOQ36n11pczTLnul7NTFVaZ5cJ3fqSyn0kL2yRBLr
	 ZoXTgaLl5pHlRtOuolNzC5sK0zc1WqqFMePN19MDr16BYJVtOVZD97Qz11F65VRkEr
	 df8ygJurSx0IctyQGtJ6ZE8L/jIJhc4mL2+73HI5Ej20PB2IDkeM2PzcEab/fn1Hzy
	 mxZvyWELtMYQPfKN5z07GBFqsaux1C4UtNwFpaZqoPRAXY2ku1RGnhqXM0niuRqU7/
	 5izxaqgHtfkAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A2B2605FC;
	Mon, 14 Sep 2026 20:09:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 471ED465
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 20:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2CCC680A75
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 20:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MhszmZr94NXv for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Sep 2026 20:09:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C7FC380A6D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789416545;
 b=C34yNM3ZC0WJwgV9xjF1akTSnw8bG3/5vrmXRp/3qwthdwKsSP6u9MpczWzsqmx0tRJL
 DQjuh6q4Mci7KOzlfeHr/VNhELQ0TAIg80DX189uu6oUMbMySc8VbxpgHXRhYOiPORe/t
 JYJCEzBuu2LY2LpVQAOnA7sa0L8mioh/NMptbVmqFAGxcmiTU2cwPceIw0TkfGBee9UCl
 AfsWwhssyPX3Z68RnL1Xz/IJAJFFDHTkq/rA7jpHn02xTQn/dMx/6soBNO6k6d/bzqwq1
 kUt/2BSM9zwvX1SZRIwHPJ6SPxPXQjF4I4DZg9qLn4bijQmcse61doer6THIFqMwEuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789416545;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=17omEsBkSdIGbP1denohxoZc3O5NXS7kzLEED9AccTg=;
 b=Gxh33o0yXQ0fYj4unDMbttOH9ZDi6qZJ3f0teH9lWqhFfoZUQVHwUPhlr3udXB2gWwjr
 hlODRL6UV41qo8Lm0hgSQOY7f4pMI3UwFkaN8DZuzIOdAeslNdbakIedAxtcKyr6IQq8H
 ndFHLS8eEPDRJ5rI1MnVGX8y71nOMkM2GTk3VUS61uUAJhAwWoDLoQI7/6unZskhdv+S7
 +H8Toe5VcyxOr5dezpKkUs2qOqZjz0yjerhTNTZGk3U+PvfvYvPDNaq2tdTxtJ3LXtIR6
 NP8U1C2WtYeaG5GEdIbHWyFr5jdwfvKwBJwLf4ETwzqMXeVufLNM+oN+h9sUJUWQ7QA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=molgen.mpg.de; 
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b="Onun/M5C"; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=Onun/M5C
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C7FC380A6D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Sep 2026 20:09:02 +0000 (UTC)
Received: from [192.168.0.150] (ip5f5af454.dynamic.kabel-deutschland.de
 [95.90.244.84])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 423EB4C2C37D66;
 Mon, 14 Sep 2026 22:08:23 +0200 (CEST)
Message-ID: <00e575df-526a-4e1f-87b1-a084ace25f96@molgen.mpg.de>
Date: Mon, 14 Sep 2026 22:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] e1000e: roll back registered MSI-X IRQs on failure
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260914142014.428184-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1789416503; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=17omEsBkSdIGbP1denohxoZc3O5NXS7kzLEED9AccTg=; 
 b=Onun/M5C3PXaFeWCaUYqBNJSGYuKCUsKfuSN8hRv3Cm+FjW+t9SeOYKrY0fiaGjmya/w78QMcFQh
 eTMZshh55uLQj9SiheBSpi4MurNPb3hYfCJYFUPy8FPxdvsLcACQ8Er1Cf6XU2AooIOYIpIdXUVHLQ
 yL3WfsTKCC5k/K6WWteEmAHsezm2Hp/HGas5Uvzef4nYWajBNDus1Q6UW/Dova5Ynq/2MItPbLrsT3
 Fiw6JceKiKY9ztRSasI+DstXyKzvBdliep4I0+n6LfK6kvO1lpqRuZOdijNIJbFTsjkAlHOwF/YDX4
 Vw1NgYEd4oY3gnvj9E4sU8ZQhExbEUKg==
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

Dear Runyu,


Thank you for your patch.

Am 14.09.26 um 16:20 schrieb Runyu Xiao:
> e1000_request_msix() requests the RX, TX, and other-cause interrupt
> handlers sequentially. If a later request_irq() fails, the function
> returns without releasing handlers that were registered earlier. The
> caller then disables MSI-X and falls back to MSI or legacy interrupts,
> leaving those handlers registered against disabled MSI-X vectors.
> 
> Free all handlers registered before the failing request in reverse order
> before returning the error. The failed vector is not freed, and the
> existing fallback path can then disable MSI-X without retaining stale
> handlers.
> 
> A QEMU e1000e test with deterministic failure injection at the third
> request_irq() reproduced a residual IRQ entry and warning on the
> unfixed kernel. The fixed kernel reached the same fallback without the
> residual entry. The injection is deliberate and does not claim that a
> third request_irq() failure occurs spontaneously during normal operation.

Could you please amend the commit message, and give more information how 
to reproduce this exactly, and get the warning?

> Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM Codex

Please add the version.

> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..f55aec340342b 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
>   			  netdev);
>   	if (err)
> -		return err;
> +		goto err_irq;
>   	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
>   	    E1000_EITR_82574(vector);
>   	adapter->tx_ring->itr_val = adapter->itr;
> @@ -2148,11 +2148,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
>   	err = request_irq(adapter->msix_entries[vector].vector,
>   			  e1000_msix_other, 0, netdev->name, netdev);
>   	if (err)
> -		return err;
> +		goto err_irq;
>   
>   	e1000_configure_msix(adapter);
>   
>   	return 0;
> +
> +err_irq:
> +	while (vector)
> +		free_irq(adapter->msix_entries[--vector].vector, netdev);
> +	return err;
>   }
>   
>   /**

The diff looks good.


Kind regards,

Paul
