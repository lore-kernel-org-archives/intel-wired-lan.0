Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BAA606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Pmk4y180;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyybpLlj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C065B80ED1;
	Mon, 23 Nov 2026 21:41:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GnKGygWQFFkY; Mon, 23 Nov 2026 21:41:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 483A280CD3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795470075;
	b=BIB72Bq5TbMCV5nsaUAxe8PuyiFbnCsQDrnlSrnM/hcLQp8nGRdxKPEn+beUlDYtQSSv
	 Go5ohujgxsB9hNaCsoqalxf0zp95ugokvDuSwVRF+e9WbvpS++y5wQbeDc5Mfhna3tE67
	 6OX9DWO2Hw38CZQIlJh2dg6Dn1S3MN55CD3W3mzVdS8fy7I1v3gcMEEpP/2qyM3i4wmAh
	 zJiM6o4Kp1KGM0S69UwlcEng4G88hbvCU3E2FeCF15hLLDZNwXsUTh8S/wSMN0CFu3t/J
	 GiWy1tJqp4kQzoaGOiZxlT/7BpP9OgwvWRNEJ23MSKBp7+GfkiruaaTW3fc+IVVf17A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795470075;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LimvVg+s1vOknWGyh+sfmyCPTBNengmVSYEeViDLewo=;
	b=V/r0yeFADa4bus6cvu5EtRgSVhwBumkjBZqTxhgIjC1SMnlb8Q8FzCEMZIQ28Fe5UI32
	 aPCPQomAeQIsn/Um6cyzkIG61FEi+Tc7RuY9gJGGi05SZtD/uM7FAE3RyP4B0tNe8eqKH
	 fna2JQJGZ5FvzK+uFs8cuOKRXB4vfcq7XhQ0iVfyXio1l9bgmbiW9aMGwjwkWdfOsjEbM
	 H4QrCrVLxgMt4rpfFWLVSyTrC8Mtt/46WGPzu9OZr4HHzJqmEIXGjp69F+SSQQe4dZfpa
	 lcT2ioZQwJZf+ZXhdDIAa7gMnihLUTKNbvVCe9AP3zk1MNqF8Qf5UAzLT0/n7fpLz4A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyybpLlj;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795470075;
	bh=LimvVg+s1vOknWGyh+sfmyCPTBNengmVSYEeViDLewo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Pmk4y180FCwybC5Nz8RvzBMrBL+5ls4E2qlApIxo+cmDRYnCGhXRRHhyfRdFZT2o5
	 V0CxnjnBatVglW6jRShRyKqzqpVa76Y7ghNwdvVAzyzTEFz7SQ5AYhl7KTBqdgN+Bn
	 CDqLvm9ZVR+K3Tg5tJ2uDKKePR4WDHr9NjeF1zcgYFaBv8+ri8pG5xC+hoEc0l0d5F
	 nVpQRh2vWN++5QWZ7a+DUhDqpv9za9PzzWjlk5xcvYA01B8j3VJiTOt7bB/fZJhun0
	 7CxvbE7Z6TIEjUwnf/YT40gRpcq9h6sS5loP4BK1ED+k2M7se0utmwI4Fush5XVIbK
	 dVvoNbGgGzyUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 483A280CD3;
	Mon, 23 Nov 2026 21:41:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 29837371
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1AC7680CD3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:41:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VzzFoWn0m6pL for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 21:41:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5A52480BD7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=SyybpLlj
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A52480BD7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 21:41:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C472C621C6;
 Mon, 23 Nov 2026 21:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276D71F000C0;
 Mon, 23 Nov 2026 21:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795470070;
 bh=LimvVg+s1vOknWGyh+sfmyCPTBNengmVSYEeViDLewo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=SyybpLlj0dMeIP8GJoBu6uprmCnuaNjnzt1j1hEy5Kk5vhc3WmQcwrbEKxJS09Vbz
 BkVsr/10Z4Uovb+4kcjs1EEuU10TRjtuyujCy34s0RjZEQ2dlFCrpwzuXLJCk4va9u
 +H30Fi+eVYuuqUtTAhq4gbi1lMY275L0B3OlLPO00D2je/HGU3dI4Bm5W6aNyYJyHD
 pAX8HXlaSDd0ecA86hYY1+sTDJofZ2dpEiNi23+qje4gDePrEnJNumppjJkFp4/yit
 YaX73d6p4HGQZmvEmz/T45OjhPVXyS7Z5xq1i7lVgb3+oAfw3CmZomaFB7/AQ3cEGB
 iaZnGF8J7g7Iw==
Date: Mon, 23 Nov 2026 13:41:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <ahmed.zaki@intel.com>, <jacob.e.keller@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net 1/2] ice: don't unintentionally switch to symmetric
 RSS hash
Message-ID: <20261123134109.30ba46d5@kernel.org>
In-Reply-To: <awSrrR6RfQYjhPU1@boxer>
References: <20261123205600.1794292-1-kuba@kernel.org>
 <20261123205600.1794292-2-kuba@kernel.org> <awSrrR6RfQYjhPU1@boxer>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 22:10:05 +0100 Maciej Fijalkowski wrote:
> Let's just get this damn thing fixed ;)

Thanks for the quick ack! 

BTW I started going down a rabbit hole of fixing more bugs in RSS
handling in these two drivers (eg ice assumes that rxfh->indir == NULL
means reset to default!?) but I gave up after 30min. There's certainly
a lot more left to do... let's see what Clashiko points out.
