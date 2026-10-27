Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50E606A320
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=07MBvJe+;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=K4K6HT91
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CBE340363;
	Tue, 27 Oct 2026 16:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMjfIOlxBgi4; Tue, 27 Oct 2026 16:13:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1CBEA4060F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793117624;
	b=IU0SThww2wXOV+CGzqU/dginJ1IFe23jpVGUWddvIOZkwCIX29/1dZwcMPzhwf3kNg4E
	 kTh8bPCZvcQSoFpcyAjE/d6mH6ZbZ6SKjHq/kuPqP+yM5YamnOFX6AW6q2EgL/bMQQkWj
	 bBUR+Pxa8vEuMiLbfVWrLVk3HWXwAzcv6UN6NfFOEVFkmd7oYX/FtWfb50MyA+TGGoOgI
	 odTi3w3u/cYXxqI8tTDLNA0pkmQKBSoTywXXRMJfvDwW2PrWX0/zx8AQC2Kr/OIB5CUF7
	 Js5g6HfAHb84DhKZO9s1NDvZKyeJUC7lCGCya+F6/tDdOvSetzPR6uYhIQ5qzQQateg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793117624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MqwK0YNWl2/NE02weyhM1oThtkALeRvG2uaLxIj0uRA=;
	b=ED4RRd/1wGSJhHqvJvWLp2fzzP5/ZQjStmqj0iwLUpmZcXE2G14E088kGiVtuvjvVBwA
	 ImSkGKDTvvJaZxf0XYQnNS+o4qJvYYy9ofbsyPbUbpAKbjn9f73S2gyOR364jbFDgm8JD
	 RpKY2ZgJboq09yXCIrYrQU4/3Ib2IUpi4QXyE4+Ct9D7ClRR5PQ7BnzO1F0pp4CWljS2M
	 ZzT1De8rhCwPG7UKSl+4TjVb08WDlMmk2bVWZt37qvxR+uzMGa8zSodpYUPaJ5GCjLxl8
	 Cnye4e8Z5FT/6z3qw4s2BIfpEjRHO3/Y2Lu6XgM1rB7x7kAMJgn2bhAHcf+F05C/pcw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793117624;
	bh=MqwK0YNWl2/NE02weyhM1oThtkALeRvG2uaLxIj0uRA=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=07MBvJe+hnzRVpcBiC47kMmUcel58XFt7oZ3lYNbg086Vh+0jl108vd9jxe+Jzrde
	 1RB3kZKxRpp2B0dwI9IjSjf7TxmD4jvmuxWv4ID6Y3URMEfvHbdmYfdk7iY/0wb03T
	 JlsD7TQ31VXqv1TcQ+GkRy/hwa10DKYwaB/um4DLPvrYprMPlIadpJh8oqigqN2tOt
	 dCBdkyovE+QIaXqfApQj4f44y0wAtgC5MxmLJ/+urnEraggCVZR12vT9EKkydw1YMB
	 fSOGGnbo7o7qR/IGPBJgQMtLG04WJBKrASHXXYH9MZumPvS/2Vfp2Lf5cD98ErggC4
	 e0MdLzIlSI1xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CBEA4060F;
	Tue, 27 Oct 2026 16:13:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C223C279
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A816060768
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3631Dn6puvnd for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 16:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCADB60681
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.70.43.18
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793117622;
 b=o5yTZpemQ3gBADRgdCEyMmbevtS98KfcrfbR2SzxbVptW5KG/T/d7cFffW1l4ZDJqbQR
 xxAxDGUELbFJCv1k8Dtld1fXCqsL/PmVOO+KXLu7quyNBrLI4oXdYB46wqsO6GaygBe6U
 +ESDRkhhoC8tkncnngfwRmkrxG3oHiWgIWK2xEArw6+bvy9PLkXYtaMZwX0Ov6RgKNUoj
 HwpNnbrpvqJDAMDpGmYTDtHCtOvjcL3fwObapdxeGntkvxirVZlX0SoKiFkg8B4UPB64f
 uNNSSsxBdC6evmY0m55VSjOVxlUryk6tGgrYpuSsWgr1X56nI/AXDQfNeFzsEdIiPtQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793117622;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=MqwK0YNWl2/NE02weyhM1oThtkALeRvG2uaLxIj0uRA=;
 b=ix7+lDGlHeFw1mJmLQDOit2RaldczFy0gr9O3bIF/AcLZefcsVvRTxwVMz9ikzJJulUT
 4scH+cX1UStaNYQFPNXcbJser0zhPSGHxWLVrGmHCr1CzDLoVEdU7iZ5Y02tSSBmRPJlk
 ga1fV1RfLsvyWEXtTrgjPCpAjhkoKrdDxcD12n85bmqkPStr4qpddlaCmTll/Y29l2f7y
 tcq5IYx0nSzSxKr38en2gyf9RmQX6ZN99qx4N3ptNZv9YOvbDJxXiA10piWHxmbtwpfBH
 4arDSdLOkmZvQkc7TFCoF0XG4Nw3Cxeo9hETyoXZY/xHtQqFGaNN2cGQGGKJX4/rXag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=K4K6HT91; 
 arc=none smtp.remote-ip=185.70.43.18
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.18;
 helo=mail-4318.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=K4K6HT91
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCADB60681
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793117615; x=1793376815;
 bh=MqwK0YNWl2/NE02weyhM1oThtkALeRvG2uaLxIj0uRA=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=K4K6HT91ZSvpF239LDUA/XsXhFzCLcbafpzOOQ/XVAEjKD0JE+Biv6mxBOqa74kIu
 2/Xfu1zVu1iSCM1MzhExGAeCJVg8ZlUCIPa0C+9XiFeDZcujeweWS27QkbHjcvCAos
 yIolSMEKjQtGMXKWEwPrv87O92ib+27TV4gd4mbETVJ/MjwGMRFAUMhQtcBJZBazuP
 P1lFNlkCBn9t3bUO4bnVuaeeHP6XEiWDz22B+HEdqyKREHriSamrcrO4Mlfkca+D33
 n6hWHs98+789j93ND3FgvkuZfiJtAAY8LFSeIZqt6wui/wwAIp8AG5Ps5ZF/Ltr3km
 HBdiZMOkH7Amg==
Date: Tue, 27 Oct 2026 16:13:29 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
Message-ID: <A-quLtOuGUuzG62X2MBCsGRnqwsSRJWaFG20X4lGiqSibD0d8k6Sb9sJzSzWWmNfpifuBH1NP-3XQosT8qRxL6HsdS-bLkKDsM5qa-xKvHQ=@1g4.org>
In-Reply-To: <179310342759.3134.9480442291648763504@kernel.org>
References: <20261026091549.605810-1-p@1g4.org>
 <179310342759.3134.9480442291648763504@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5b15948b41f786a87601500785a121bdfe9fdade
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> [Severity: Low]
> Does this description match the tree this patch applies to?

It needs to be clear that it is affected by that commit.

> [Severity: High]
> With this patch applied on its own, igc_request_tx_tstamp() still runs
> before igc_tso() and igc_tx_csum(). Can the same shared skb problem come
> up here?
>=20
> When a GSO skb with a cloned header (for example with a packet tap or tc
> mirred active) is hardware timestamped:
>=20
> igc_xmit_frame_ring()
>   igc_request_tx_tstamp()
>     tstamp->skb =3D skb_get(skb);
>   igc_tso()
>     skb_cow_head(skb, 0)
>       __skb_cow()
>         pskb_expand_head()
>           BUG_ON(skb_shared(skb));
>=20
> igc_tx_csum() can reach pskb_expand_head() the same way, through
> skb_checksum_help()->skb_ensure_writable(), on a cloned skb.
>=20
> The next patch in this series, "igc: prepare TSO and checksum offloads
> before TX timestamps", moves igc_tso() and igc_tx_csum() ahead of the
> timestamp reservation. That fixes this by the end of the series. Should
> the two patches be backported together, since this one alone leaves the
> TSO and checksum paths exposed?
>=20

Yes, I maybe need to research how to properly denote this
