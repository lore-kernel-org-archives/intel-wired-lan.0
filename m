Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3CE606A31A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qTFfho+r;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q/i7sq6X
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFD296070E;
	Wed, 28 Oct 2026 22:13:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l6jBeypnC-QA; Wed, 28 Oct 2026 22:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F4F1606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793225628;
	b=CAhaw4T690k4xN3z95ICAshPNW6WBUAtZ1DXQp7t9Dv3IXSUl5+7xjNbzTUsoGzzeOVB
	 yj0IKW6c+J6C8Axjxq0M1H3j7e+1Hfo6LPRsLL4xqxF+oLQn6EaqGzehV8VQD5lQ7/WyA
	 NmLPgFY6jnIQdSiY1IFkA7tfWl6SdJ7YgFpFoa3OL/xLVl/1c65nAwtWDy6Mnk0YcC/VC
	 BEEbXDPMfIslK4knpxm5c/NMOf1O/CzCQ/4k95A1raiD1vlD/q5yfi8y/xQcVtQZN1H0b
	 wVCTPaXJzhpxoLz5XPv+AXupo0wyzVxCdbhhoCPetTXQ5BGiX+OOVwQeFyoa1/Jn3Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793225628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=M3Ck9eyVD75IOnRETh1mD4sLHe0E+TueuPB6Ea2RtIc=;
	b=UPcmwso1/intklYhsBqTkpLTDb0tlaMgg+wNz3nAifoXUhTaAbpfOa9X1Gz/8910KDM5
	 Qp6jJ+u4hVpW2QgZZ128u8lkjgJxtZVut0DMrgGRocw4a4EuLpzEM4EwmM2aFC2uwm81t
	 DG01luqkTrCf4QyOC6RWbkMIWPa9EcIjSJZKoLUHSNrhtPf6FqnfdzR9FNm3TwwjCLkSb
	 TwZIE34LrLtLOMZVoJaxVLPsfV7Nt26MjqN9Hh+8l+j98JMSqAIXfruj7hGVb9sFHWjNx
	 dOz118A+BzqONMrBn9+Q5HNiLowKVBE9t7BKgx+ujB4cpbh4krFzFmv2zPV0MheTXBQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793225628;
	bh=M3Ck9eyVD75IOnRETh1mD4sLHe0E+TueuPB6Ea2RtIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qTFfho+rV2W+9loHsEt9ZQaidSApuMGRaJ3cURn5Z6OIvEWefOlN16opEWwimzSTG
	 dtGVN1xUhmQecWZBKVoZLc4s4cyHiNN+c6DQ378QnTnYZ2zNBFbjT2UOGlPNIrJ92a
	 jjzZ6NTBJHqcjwv4zF1hnvTtmQy8Fct1wjiR3PyYPZjvwXNU7AUJ+dnMLH7pmDD0HZ
	 i7+k9VcH4crdLieBRKJd9xetQTtSIoLQuJfUAJbvwamspJxShBdHA9/p25TIsi2APb
	 piWXNRHEmfSRZ4t5qC4Ftokb8tq0OGy05HhO2WjlFoXN/WlJzc/kbHUjPSntAeV1K+
	 1wraDXCM3Sx8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F4F1606C2;
	Wed, 28 Oct 2026 22:13:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEA403AF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 22:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC420404EF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 22:13:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spPcqI0Rxg2a for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 22:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1F5E040433
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:41d0:1004:224b::d0"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793225626;
 b=UIBthbq/aP8dmtmQkpgoj7P/uC88UH6Luw8dz3DCCOfZk6gCTAdZcvnmejHUraVzPRcC
 umimY1BRKoibMLKJyPFNVA/8xoSE6IKUtm+zAqUX/EeOy5yz5GwDlUKwukw6VXxROC/Wm
 Ccg41HqTr6J9Jb3XKTjt6Wx+Z3aLj/Pz9Gn321Y0KMEzc9VLM15NKO+UfCcvFGsMVe6j2
 b0qRge/fpYgRe5796jfIqAKNMrmcm63Q6ah4G8sIIG3L0uUcY2uRw8+VoAZG+9FTinkNH
 +lGkB+4xoMccWNBLtNmjip64tWvd3QBUbYpynOfWS15EB8j3/Yvije/Rd4tDsp0sk7A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793225626;
 h=X-Greylist:Received-SPF:X-Envelope-To:DKIM-Signature:X-Envelope-To:
 Received:X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=M3Ck9eyVD75IOnRETh1mD4sLHe0E+TueuPB6Ea2RtIc=;
 b=pAxa+enqGf45MZQATYzy9KUJq4AVTYCepB+rXRWI3zZ4s7Oaf1E4TjA0Zab4HosHY9JK
 9YWxUvVHdG/1mWlbU6vWcglBH8GUf9DYPWyYGF/Ikjn6hM1mzBy7AVRkYp3rjIiD1iMR7
 UoytfKkwjLrVHKJ7jnNsejGcJpc4/J9NiCd/YBmAXmcRvCfWV3mF4w5IVAwX4ERL9Ilce
 hoXaR/dMWrB6Hsh7UiZQN4pWwbrU/6aGLrCGRp9/QlZ1t6UsvwQ7+DWHRTq40ScMtoWsQ
 PU08lFLoKWF7dFOux8laNe/uj5ZIRYn/72PJmasxghk7od2rs6jmEzlmM7aR4x9VT9w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linux.dev;
 dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b="Q/i7sq6X"; 
 arc=none smtp.remote-ip="2001:41d0:1004:224b::d0"
X-Greylist: delayed 66 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 28 Oct 2026 22:13:45 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=Q/i7sq6X
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::d0; helo=mta0.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
Received: from mta0.migadu.com (out-208.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::d0])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F5E040433
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 22:13:44 +0000 (UTC)
X-Envelope-To: intel-wired-lan@lists.osuosl.org
DKIM-Signature: a=rsa-sha256; bh=Y+Decs/7/+vp1xu4bxl9QSBsBoAQltojViXKsaLAsUQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793225620; v=1; x=1793830420;
 b=Q/i7sq6XOUb0sPhpgX/pjRgNruZs/4MGRFotHE/cX7gDREhCeO8ky5ut6+26eogCTULyXB3m
 WjB60N+RQb8Htl5G4Vh6pwztp4pQm5hYjopLkdwth6pYbNF+zZfcMuxOiOqW09BtnDAcNIjQA05
 t9LVNz4YXIL8OvxxLqC8kO9k=
X-Envelope-To: intel-wired-lan@lists.osuosl.org
Received: by smtp.migadu.com with ESMTPS id c8b5232d2f55aa01;
 Wed, 28 Oct 2026 22:12:36 +0000
X-Mizu-Trace-ID: c8b5232d2f55aa01
X-Migadu-Flow: FLOW_OUT
Message-ID: <6b9f70ca-86a5-465f-af09-2df49ee11628@linux.dev>
Date: Wed, 28 Oct 2026 22:12:31 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
To: Linkui Xiao <xiaolinkui@126.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20261028090455.2291659-1-xiaolinkui@126.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261028090455.2291659-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/2026 09:04, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> e1000e_config_hwtstamp() stores the requested configuration in
> adapter->hwtstamp_config right after the rx filter has been
> translated, but the two register writes that follow are verified by
> reading the registers back and each of them can fail with -EAGAIN.
> 
> When one of them does, the driver is left holding a configuration the
> hardware never accepted:
> 
>   - e1000e_hwtstamp_get() hands it back to user space, so an
>     application that reads the configuration back is told that
>     hardware time stamping is in effect while it is not;
> 
>   - e1000e_systim_reset() re-applies it after every reset, including
>     the ones the watchdog triggers, and keeps failing;
> 
>   - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>     filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>     time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>     are eventually dropped by e1000e_tx_hwtstamp_work() with a
>     "clearing Tx timestamp hang" warning.
> 
> Cache the configuration only once both registers have been verified,
> so that adapter->hwtstamp_config always describes what the hardware
> is programmed with.
> 
> Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before applying it")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 35f5590228eb..7ae33273734f 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>   		return -ERANGE;
>   	}
>   
> -	adapter->hwtstamp_config = *config;
> -
>   	/* enable/disable Tx h/w time stamping */
>   	regval = er32(TSYNCTXCTL);
>   	regval &= ~E1000_TSYNCTXCTL_ENABLED;
> @@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>   	er32(RXSTMPH);
>   	er32(TXSTMPH);
>   
> +	adapter->hwtstamp_config = *config;
> +
>   	return 0;
>   }
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
