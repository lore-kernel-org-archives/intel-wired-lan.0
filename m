Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B160A2623
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iAGUKdtB;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=tmpzVkCV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CBC8680F86;
	Tue, 27 Oct 2026 16:05:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sT5ZIG3Ai3P9; Tue, 27 Oct 2026 16:05:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18D5A80F87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793117112;
	b=qATStBmzNq9IMeqFL9FFss1XJnhDV4tK1NauRnJE/m/QT0WcH0mw+3ohev2uZNxZYxG1
	 adOpvicVANwBJQuTW6aVtYOIsdZQhpqRYHD8eRSO1/LgkOqHTPzh6ibJ/uLqjIAgSj1DQ
	 D+oXdA1rQXZ2VItRtqNS7tgWnLN5YUkZHu8TTO2VOiSF3PicdHjNHkdYaH5E2vNGM9Ah1
	 0dK5c2va1YutrZtjq+xoo2jD8XqEyqZLq63E8k8pjIsDyeRIA3BmmsfuboH7N9O1utMYc
	 PLR3FJzqJW+gNzsLjSddsE/3PT4CmOOCc2IShtc+QATL63Tmjn8RWrUqcozPlvx90zA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793117112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nH+VUOwPiLWELl3Tmh6lF2sEqX8N/UojmX/Q6srT+o0=;
	b=QS/1LMG+K+c0TeLbjJcvorrkZAt39R10rCMzoxMn/JEis3O0UCDe2jUwRPqRcuUhW4DG
	 uKTI/fInbn1njJbZ25M8zr5trLFHXIjjnpdsXE0QWt+FcPNL897Y4hwRfeVqeoPj+whRR
	 xndUj48hDIymskXZELlZyI+TWKmjigUq8BHgizZ7MgJq78YI6gMlG+YCwBM6xvrdAR/fG
	 K22MbtL67iQfw0ZgYl8YJtpYjOmqxFQOmaAjsN1Dk9cmmm4k47nn9kZWDWcbn3u7LFT8J
	 rab9qgeUhvO3iRiUbqeWRSDChu6MUOqcX5n6mGDrf3VZnBfUsnFWCeiORWkk9t7MUEg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793117112;
	bh=nH+VUOwPiLWELl3Tmh6lF2sEqX8N/UojmX/Q6srT+o0=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iAGUKdtBeeHmf/ZXX9knJzt06uMbMnEF9K7aTEdnoT0ejceQd6IwutjR4kIGYVznW
	 IoBcKK9JPQWiGn/66MRu+s+FBM4/JU/bHQ0VFpPgfwS2W9rX61BsdSFCXUImSjfxUo
	 BLGoBxxKVVDMxyaaoB+uK/KLKZKnsQ4UqehZlyzmiEIUYAiOW8BQJQ17mYPsLzKvW3
	 TdKDZtDEhGjWpYEO3/aYv2ChUSvUqz2ONDIWXEU/JdAeSrYTNHATsv/iSKoAFqDwoX
	 eYXxk/Ze60JYZKaphC55PI8OwCVZOMyGEDVBJh9USmxr3LxcCIn1byqCSzGIrWajOn
	 hu6WNivCfpe1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18D5A80F87;
	Tue, 27 Oct 2026 16:05:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F281F72
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:05:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8A4560794
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YXU-ytZCNmcC for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 16:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C33DA60768
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793117108;
 b=mAzpA/YSnWIDEcTMfEox2cwIx7Q5FKmGlCRvQwk0j+OYmvnHuzl2nPPx2WTWSjdvuZgz
 9POhYfKlXXqNG9OBWbFXj1wFIUZpUBHVw9f8+CNGiy2+jykPTadWwxPJ1uDpw/vCgtzuB
 8rpHvacwAmBMND//rd7LjjHSxYV0H5O84nUtL8n+u1LW9j3rSRu9IVyLN570KS4snl7Fs
 P/U6CRLMai+5JOz899WuQlIV9nOiukxjhffA6+jFk6/eYhigi5oKVyOLSB0t4mm1Yjz0A
 RSF1SDFLsVxP+WhqLqP/fPaFb5Xwj4jqqD0bfCOad4eJBJEcPC7Bxih+TYoRgTxdNRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793117108;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=nH+VUOwPiLWELl3Tmh6lF2sEqX8N/UojmX/Q6srT+o0=;
 b=DIrMVtvnWRDtZ9pjMPxH9a6kLIZvzZLENTh8XYRDQAsl1S9rSdcfFQ3CX4fp/renyomP
 Wz4nORzUfiTIGBV4bM9PE6xO69v7ADJtK8Ypvv7WG3Vr+OUSeX5bE0UB2CeLBbQh/Sx0+
 opUrzmti40k74P8Hex5a+7x4nv71M3gEIfT8QZxROntYkJWBbOUduyfQpBpd+6z4gyoL9
 eiUmYHgGMcrev7bQdgDkhtHIkUJGlbPpkC2wZOFRrU+J4ZqU7ec0BBwJqhNCKz8cFN1qf
 GOfdfhVbsUB8sdPm4SZn21jrT+PxsPPV6ctKGV4FnfDxP6guMR340rlmf+CTQHSu4tA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=tmpzVkCV; 
 arc=none smtp.remote-ip=109.224.244.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.21;
 helo=mail-24421.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=tmpzVkCV
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C33DA60768
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793117104; x=1793376304;
 bh=nH+VUOwPiLWELl3Tmh6lF2sEqX8N/UojmX/Q6srT+o0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=tmpzVkCVtFh8fUl4Zw3KkD/B61mnXrSGU3g1xMp8Bi6peJUc9iZhhdrWzm+Pu4SM3
 6Kw2lLpVlKLplc5a3WYkYIPp7N1YSo/ImoZzlt649QL6OEsTYG7Jx+t/2wbTP1Y0OS
 n96sS8bSVk1JKuQTneyTNREkq85X+qYRgg/HljvhJ0MxvuunFvDDtsjaH1CP1EuRYL
 1qvbLOWo8AAh00ALfFOfQbx7jCZk5KjcVc8gvFlg+BvZRjMipTzxLNRxPN+ZdWBBww
 v4VlrJfG4pY3hLL6VBc9b+OW/Ib9byNfSneONKg7/btwAX788g06UD9pkJrb1FEbxE
 cmo5RSTfjHc6w==
Date: Tue, 27 Oct 2026 16:04:55 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: Re: [PATCH net 3/3] igb: prepare TSO and checksum offloads before TX
 timestamps
Message-ID: <i3Glqm96F2TwAGa6takMMBWz5Fe0r5gw23k57lIUGuQSqsiCFRrzCutLPLR09oErj81K8M1EocaXjYXMH0omemFq_0aqO9HSat904_5_c0k=@1g4.org>
In-Reply-To: <179310343105.3134.12907560938189136535@kernel.org>
References: <20261026091549.605810-3-p@1g4.org>
 <179310343105.3134.12907560938189136535@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5577dc02ccf452cd87aa75f780246daa3d7ea01b
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> [Severity: Low]
> Does this description match the tree this patch applies to?

It needs to be clear that it is affected by that commit.

> - [Medium] igb_tx_csum() still ignores the return value of
>   skb_checksum_help() (igb_main.c:6170, `default:=E2=80=A6

out of scope

> - [High] This problem wasn't introduced by this patch, but
>   ixgbe_xmit_frame_ring() has the same ordering bug this series fixes in=
=E2=80=A6

fixed

> - [Medium] This problem wasn't introduced by this patch, but on the
>   igb_tx_map() failure path, cleanup_tx_tstamp in igb_xmit_frame_ring()=
=E2=80=A6
> - [Medium] This problem wasn't introduced by this patch, but the
>   cleanup_tx_tstamp path in igb_xmit_frame_ring() calls=E2=80=A6

out of scope

No plans for immediate followups, anyone/everyone feel free.


