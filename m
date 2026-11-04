Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016D606A31B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Nov 2026 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=DVaenQyR;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZXiRsbTA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 703C480FB4;
	Wed,  4 Nov 2026 18:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4C0BtqQlhzcV; Wed,  4 Nov 2026 18:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BC50C81192
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793816098;
	b=CfgyjDQP3JJCSNUVX7OMXO30AyE/8dq25Xop9tLFQQDY5hkcaVhO0oo9Z0EI5DN5NY7L
	 IftsH9OP7IQOfz5Td6U2emJdkMZMqCI6jaW77F/ALhBvdXSf3ZqKdornFTWPIbqaKZquO
	 PZFueMBj3R0tON193KVre3LeC1v4qTU8n2fAW7/C6rxVwpYpqvmfutQwn5TcxnjnZKoTy
	 Sm9ttJO6+tSMswgF7ASfKy0KPNleW+Kg7/O6lggH+Uwp2tOwAITbYd8qXEliHYo8xVv7p
	 mxKtPbww2g62Fav4R0jBkyVyMATf3+TVbW6WhvOa5krgs8z1OTldbXbU/KxANeWnnKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793816098;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8Xk2BhnFQcAvjOS2lpYo+AylAGsPFOuTphs26Y5dcmo=;
	b=nDXFn4npVpScBj+EvmwHSEtNm6i7DDJZAZ/9pY49ee4EAiwD6Hn/1mXZgp3Qp7xQ1NOh
	 /gs4+FlykK9VucKchRXwP+7rRjxe3HPCZZnb26xDT+Vre0nXWznEHkndsUSsKeoMFJrWf
	 GzoHuQL0n+nSwv3SidrDhJgc5HrYqGowPucp6qJO1oNWruGRQSwV5MLPot4tHNCRNhptS
	 XDYDNY70jzyUHwb8J6psP66f4JmZ5GDnqx1cV6pmVBNd/t+bSb4bWqh2JVryxcIvTmUAi
	 rypgB1QrlAHP7H3CZaSCVGFeSErCUtJa7HNX/pvo1Ad1jQGIqY/qfXbogyM4EAi5RSw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793816098;
	bh=8Xk2BhnFQcAvjOS2lpYo+AylAGsPFOuTphs26Y5dcmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DVaenQyRY4O+SnVkLMJpPMRZcZuHcmbiTKX+Hlzkuubtk5XktQ8Wfpznwbv8kS5E6
	 dG6UJeBoUMoN0Rj8I1L+SlFF5k43IYPkGTqzdH72ypFD+S6VBbkgwSci6HW94gzeqE
	 t64gJqkxs+cR4fRkCrcAf+RrMjKc4639QgUQ24fa6bXliXPQINgFRRjU4zhtVVV3JN
	 ORI8i8xE8v6Pm+gA1XJ0Dzqc0VrX5yrNACV5kTbRIgOZg+sf0zFFN7guksYqDGA3Gn
	 lBUiH1MR3L2pI1f9YDIFPvkuQayjckGuqlWbQg2OfTNG/nKD475ip4JC1qmBIeXuBm
	 JG1N6kJrlh5bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC50C81192;
	Wed,  4 Nov 2026 18:14:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC7E71785
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDE6F4078C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t_pPZ_wZg4nM for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Nov 2026 18:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 149C540762
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=brianvv@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20260707 header.b=ZXiRsbTA
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 149C540762
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Nov 2026 18:14:55 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3ad41b47541so814067a91.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 04 Nov 2026 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793816095; x=1794420895; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Xk2BhnFQcAvjOS2lpYo+AylAGsPFOuTphs26Y5dcmo=;
 b=ZXiRsbTAx6mevqUXPhT/emcolnwty5w9Wj226odZrtZ7H8VmGCgzH8eBpQHhclY2FH
 UvqVbtsAQ1NSIul94i1GnlXZgBdkaALdOtpw3XCFPBvq8BTritHZkVSQxkFPpZhyxr+0
 y3cQJwBGzaQtwZ2PlSbWbieVf8fFCG7RiOcLlLsqbJkT/+NvbI3i5/PV11+mWI3VIdV/
 B2euCdE+SZ+bGaN6Ko3lMYxS09OVw56jBsregPvwTEgvH47AgZ02mqiOZhN4t4x4YsYq
 LkSzuRVvwo1Bs0q7hdoRPxdE7+uEKQCblQNoBkmrQ/iGf/bvi2skKMTUNZpa/l54oKQG
 tnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793816095; x=1794420895;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Xk2BhnFQcAvjOS2lpYo+AylAGsPFOuTphs26Y5dcmo=;
 b=EybGsC/nkYOcRQklvC+x14hc7Pqspd8YzCu2PF+H8/pozeAZ0ITKO2OTH4JtfOyoPE
 lqwY9sN3boQrhlPg3rMlhqnC/C5Te59qHFCFhetOVfk5MBKOONLaxG8O7lflu+vdqtDf
 s28TqWNzr4fm+CQigiSH1u0dlQTBiY1X5CLSDRk1rBXWVm2noQ6Rj8+Sn6nZwEArAdgP
 GBP4myEkX9pzPCwCpDCTlusqKcbrg36px5JJQ+3Ulysvwe9yImN1UlYaF4Go2uF0cH5X
 vB/nfW3zF4mNuOIT04eGunHAlgOyIhprmtkyQM7swU/f8Z/Ky4KN22dP7PIsi+iQJL6b
 NzGA==
X-Gm-Message-State: APuU4Z/JnBx2BJs5Fd8UW239kbo1+JrJ5Sn7SXXXF2FbcpREPzfnDzmf
 HIL8Z3c5eKCFmUyvg+E8/7fBYWg0IpVcqZ6RF/Yjp2QH8MK13ONLVSHbXK4WMqHN5w==
X-Gm-Gg: AYBFou0wmfXnGSOlh+b4YV8mOkK1DgdB1mz7k0ZPR8/ri55oiePLwLTbYVRbhDGPoWw
 bpAl+qYMUqNBrOZX3DcqP7lvfAqfMJsyBwamFLEPhyWNkPv6PY+uYNSK+FD49/5A1BDPE470AfW
 8+wJsWUKhj3SlQvqcigQMylcwRGLHYhZ4KTn9DxkL71rmEHuxAIQvxCY4qLhJF4+H1iuwUZMCUt
 YX1oKf5jI5LtqUiWm/wj6VAP6ldWfIfUQGYAOyOiKKnQ9/w0ZZ92HCp3s8KCZRUM2F5GxS9vbFd
 LcZOqi5h8+I0JJiufxmJC/jT8UHD/qCOEieLOOUu4FTPg1A1kzi2DefsHTG7Q5YonKpjEwM4zgm
 3no9j5r0shXs1JSca2nxSMce5RfRtn9GUm/RxMnnhBIuF3xLF5Sp7b51JWZcqs/0ByZXRLEfW5b
 D4Bslx9FWvllMl+6oFjOnuDqdfYCG8vpb4ZDVUrYbEW9q1pjvscl2usUkplMcfbAqFeBVijqcQ0
 JCRAGxD4V2o//W1lK7WptXX1m1C4tCwH/JtqJnTfglQ8wo7uTy7E2KjAR+HrHaTGRdnFGLB+sCE
 ak96wtcwE4UlHE9hf0C866e4lwunaOSppAd0syyEE3EqXVqaf2cmFSaJlTQA0E5h2A==
X-Received: by 2002:a17:90b:2805:b0:3ac:c03a:38b0 with SMTP id
 98e67ed59e1d1-3ae89574d99mr14239204a91.8.1793816094083; 
 Wed, 04 Nov 2026 10:14:54 -0800 (PST)
Received: from google.com (60.122.127.34.bc.googleusercontent.com.
 [34.127.122.60]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b32678ecsm73968a91.9.2026.11.04.10.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 10:14:53 -0800 (PST)
Date: Wed, 4 Nov 2026 18:14:48 +0000
From: Brian Vazquez <brianvv@google.com>
To: Naman Gulati <namangulati@google.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
Message-ID: <aut0VPowjLkQL5Oe@google.com>
References: <20261104013606.1527767-1-namangulati@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104013606.1527767-1-namangulati@google.com>
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
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 01:36:06AM +0000, Naman Gulati wrote:
> With header split, idpf_rx_update_bufq_desc() allocates the payload
> buffer for a buffer ID first and its header buffer second. If the header
> buffer allocation fails, it returns -ENOMEM and leaves the new payload
> buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
> consuming the refill queue entry, and the next NAPI poll retries the
> same buffer ID, again starting with the payload buffer.
> libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
> buffer is never returned to its page_pool.
> 
> Each such failure leaks one payload buffer. The pool's inflight count
> never drops to zero, so when the queues are re-created or the device
> goes away, the pool never finishes shutting down and
> page_pool_release_retry() keeps warning about a stalled pool shutdown.
> 
> This happens when the header buffer pool runs dry while the payload pool
> still has pages, for example under memory pressure: a header page holds
> several header buffers and only goes back to its pool once the skbs
> using all of them have been freed.
> 
> Release the payload buffer when the header buffer cannot be allocated,
> as ice_alloc_rx_bufs() already does, so that the retry starts from an
> empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
> teardown cannot release the buffer a second time.
> 
> Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
> Signed-off-by: Naman Gulati <namangulati@google.com>

Tested on an idpf PF (8086:11df), net-queue dev-queue (da74aaf50018),
TCP data split on, 16 TCP flows of Rx traffic:

1. A local debug hook makes the header libeth_rx_alloc() in
   idpf_rx_update_bufq_desc() return DMA_MAPPING_ERROR on every 20th
   call, 2000 times in total.
2. Recreate the Rx queues: ethtool -G eth1 rx 1024; ethtool -G eth1 rx 2048
3. After 120 s, check with tools/net/ynl/ynltool: ynltool page-pool stats

Without the patch:
    eth1[3] page pools: 253 (zombies: 13)
        refs: 150913 bytes: 618139648 (refs: 2000 bytes: 8192000)

With the patch:
    eth1[3] page pools: 240 (zombies: 0)
        refs: 152521 bytes: 624726016 (refs: 0 bytes: 0)

One page stuck per forced failure without the fix (2000), none with it.

Tested-by: Brian Vazquez <brianvv@google.com>

> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 885df6294ad94..7383d8241ead5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
>  	fq.truesize = bufq->hdr_truesize;
>  
>  	addr = libeth_rx_alloc(&fq, buf_id);
> -	if (addr == DMA_MAPPING_ERROR)
> +	if (addr == DMA_MAPPING_ERROR) {
> +		idpf_rx_page_rel(&bufq->buf[buf_id]);
>  		return -ENOMEM;
> +	}
>  
>  	buf_desc->hdr_addr = cpu_to_le64(addr);
>  
> -- 
> 2.56.0.398.g882cbad275-goog
> 
