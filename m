Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4DEC624D7
	for <intel-wired-lan@archiver.kernel.org>; Thu,  3 Sep 2026 10:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3823380DFD;
	Thu,  3 Sep 2026 10:27:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sn4dNWjeipzJ; Thu,  3 Sep 2026 10:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6362680E2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788431267;
	b=cM90NtNFi73+JQFbscMbWIKVoI8XaL/9ANk1Df9OfYKffxuUw2T1EzW61G5P69njTaPo
	 W2GWmUc5YZbu/r1oviryABWPx4npTx/ueEJ3/MniBe4a/8S76MlT1YL/ppOxD3TwYcayJ
	 y9J9H69vHz2YkE7UgbwetRXqw9T3VpVyqVNcq5rM6ghfSM6/JbMQriO1TH7YMo/DMFRFX
	 o419czwG8iGLH+Hxd+rMmY31SSJqGHZtp4oo9o4eeD934p2eW59YlxXMdU4Z8TGElnHbO
	 YxwXGkjOI3koFGqSzYoMF4O+Yko5b96okm7ynWNhp8s1SSrO7DE4NQjKWktOY+2psgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788431267;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=atJ2KXPXSgGiq2OqP7CMIUjSO8wmjaHoVZs8sAlmqBk=;
	b=dp2144aaeWT5v5P1wkgshdjImgCo2BgFcPJkDfhKQX6PSC38gwZb/Z10enOpA09iPBfJ
	 5FQZjyQdoZTetXG5PVg+EWUh7F/3vfMwtQ7JhYffTKRA4XFSbYKq1X6J71VZf8l+CsE/C
	 fpqFnuAgoU8R8+kCVEMBd8CvCr/DziV5Uruf75btYnMAydhsRXvqme9tbHiERUkJOygsm
	 rukD5yhaHJ1rWnhtDbuoZ/gMsEyGGlfdLEjftZKytaphMxm2HW3FLarHLuvX59mmoIDtJ
	 AN/Dnr+pM8AqQTbmPBkrOCd19LSa9wgrYFgAL2N4zmY46zOZe0U8/kklRhL2lzlXTUw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788431267;
	bh=atJ2KXPXSgGiq2OqP7CMIUjSO8wmjaHoVZs8sAlmqBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FTWHDBi8qDLISaAZSPFEn6TDZYWc0UpSgHBAjP6RQwuCiDmp3uln4DSrB90C6hWdH
	 X7pKtWJnku1lNNhyKPoeUm/decbgWrOQHHC3OMLebxRsQkhtpRHNeVYQNs5h+9JOi7
	 unh8TC5o1Sxfzmnk0Yq4kBwPlJqxhtul3+pFmrgRIyu9i2uQcFP3SRjvDgDseSsWr7
	 Ys5wh4Q/h1xwkrYOFctyrSU5bnPFir98UHBN64yh3rkSss9qeXvk1Yz+ebPhS69/R7
	 2Su2oUB6h5TUg9LAytXrBTZYbRrjv4FpISmDqHrpcVBdnd1utbwtpnDPfke0vP1xPa
	 LCHztkWeXjR0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6362680E2C;
	Thu,  3 Sep 2026 10:27:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEC31230
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A0EC2400CD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:27:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kZ5BAc579K7m for <intel-wired-lan@lists.osuosl.org>;
 Thu,  3 Sep 2026 10:27:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B9A9B40084
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788431265;
 b=gGCUyHOOiS2E3QoeU4kzJMcSYSdxMOZRYp2cRsn3/HI/D6FPyINjBKW61oRfbgUpjhI0
 zCXtWpu/PnEv1D+IuAAxZzzyIpozI8tbkTW4xMeJS5vN0P4cxeOtDgkMgsorqmfleAkvT
 R5sxn+vFSWs9XcPGjBX3RaN2AlD6UicTDwDiS7hsFrD3orl3ZCH4uVYt0Zr7kR3xonUQq
 gZ1nV87DbC4cWxnSKHp4dz/RlqRsKDyUIv2tvKiQTScnmeLYobx70x4zPDCbxRG5Jq6EC
 Mrbjus6uN8UGddBQacT3wZZNWryiR3eVgyDssb/9PWJTq9FOWbw4rI9Hui+Y+dW32+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788431265;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=atJ2KXPXSgGiq2OqP7CMIUjSO8wmjaHoVZs8sAlmqBk=;
 b=Ol0Aih1opHvSOwAHJAof4o6atOkewjeelXdXdEOq2orcRS03d92+s8EAQNrWyW0+So1c
 LmDuz1YxDM4IdP/cL3P/0nJwC9ikooYZS3+o5lRrUWkVKoGrIrUDWnXoS9kZdXMvXqhF5
 Ufjvfl8ioVjww878cmAoiPg72tATWHHVKthIfSfbAg5Gc++R5v5dVJinSaO6J2E3MS1QO
 2Z2aD+1whV9iskgVjoMkD8TfpO6H4VOpCuS7fedKO/tTV0xQB0/XKDwBmISGaNXqXqN01
 IdCz5dEZ1uFzn2oXVUoHUBYefcaj0N5fcO01P/PIMAqQbubhfmz/EgToXWay3GHEb/Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L0sleX8b; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=L0sleX8b
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B9A9B40084
 for <intel-wired-lan@lists.osuosl.org>; Thu,  3 Sep 2026 10:27:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 652BF600C8;
 Thu,  3 Sep 2026 10:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2B71F000E9;
 Thu,  3 Sep 2026 10:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788431263;
 bh=atJ2KXPXSgGiq2OqP7CMIUjSO8wmjaHoVZs8sAlmqBk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L0sleX8b5Wj/WKStYZA6hK9/wQDat30zobX24QjYj83n4y0YfoclGIR2uC6AU7EWr
 GfIKHI7LlqeAtyZPwuE5T2rYARl2SkP5tdg4pvqwGXKd6TYycldWoefRszGn92f6yu
 v1adk2QSVTj+NBgRAWA7JcKijrOfRJ9xxsDRADDFwbDiVvM4Zg02Hj+cimlU3aQVzm
 c7W++roFN1tZw2GjTQTmDMOTfo6fqZ1Rw9aCtr5WSTBR4ZpPA4bojM7EvnAHcQ3JXK
 ptsQofWLY43QHngnq8H4oALiBPZqNe5/57vq8AsvViaEnXvWWGo8QfWOPDq4sI4RYk
 Hw0UO0rCbisBQ==
From: Simon Horman <horms@kernel.org>
To: tactii@gmail.com
Cc: Simon Horman <horms@kernel.org>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 1/8] e1000e: add jumbo Rx CRC stripping
Date: Thu,  3 Sep 2026 11:27:30 +0100
Message-ID: <20260903102730.578872-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830232146.36948-2-tactii@gmail.com>
References: <20260830232146.36948-2-tactii@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260830232146.36948-2-tactii@gmail.com?part=1
---
e1000e: add jumbo Rx CRC stripping
    
When the hardware is configured to not strip the FCS (CrcStripping=0),
the jumbo Rx path would deliver frames with the FCS still attached.
Follow the standard path's convention by stripping the FCS at EOP and
leaving it out of the byte count.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab37ad4..599600ad695cd 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1631,13 +1631,23 @@ static bool e1000_clean_jumbo_rx_irq(struct e1000_ring *rx_ring, int *work_done,
>  			}
>  		}
>  
> +		/* strip the Ethernet CRC; it may span fragments */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
> +		    !(netdev->features & NETIF_F_RXFCS))
> +			pskb_trim(skb, skb->len - 4);
> +
>  		/* Receive Checksum Offload */
>  		e1000_rx_checksum(adapter, staterr, skb);
>  
>  		e1000_rx_hash(netdev, rx_desc->wb.lower.hi_dword.rss, skb);
>  
> -		/* probably a little skewed due to removing CRC */
>  		total_rx_bytes += skb->len;
> +		/* If configured to store CRC, keep the FCS bytes out of the
> +		 * total_rx_bytes counter
> +		 */
> +		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
> +		    (netdev->features & NETIF_F_RXFCS))
> +			total_rx_bytes -= 4;

[Severity: Medium]
Could these lockless evaluations of adapter->flags2 and netdev->features get
out of sync if userspace changes features via ethtool while a packet is being
processed?

If a concurrent change occurs between the first check and this second check,
it appears it could lead to an inconsistent state where a packet's payload is
incorrectly truncated by 4 bytes, or where the byte statistics are overcounted
or undercounted by 4 bytes.

>  		total_rx_packets++;
>  
>  		/* eth type trans needs skb->data to point to something */
