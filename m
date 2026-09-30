Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E79CA5FC4
	for <intel-wired-lan@archiver.kernel.org>; Wed, 30 Sep 2026 21:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B11381218;
	Wed, 30 Sep 2026 21:01:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uQUenCsy_NTf; Wed, 30 Sep 2026 21:01:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0BA5781212
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790802067;
	b=INTTGoMSYgClRAf5tYB+hloom9Rdtgk3n2u4+HImMbXBqt4lYNn+A2DBv+3datw+v7hI
	 vWSoHLQEd/bN0dnbHvD07dOv2f/M0oHAr+vurUP9/koZpaDAx+2uFyEo0EmTiI+NFTDdA
	 aRonlzw5m/Vv3/J0SAqLKAVU6txw8ETaPzUUxHA8Pe2t01CPX2Xfu5x75bp4UdekAH/XM
	 1+rPlS+kMYNzLEYIjw5GP834yRrFL5T0gueEuPuK/PujJE5wY3XktK9TCcWLNSzyZeA45
	 vfxUz0FBWT6i7RDvvyrq9M/WQscTa48xYZ51HMFt3Msq06AxlRHbrAB4WOZEXhKVUow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790802067;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=StediAXhZsd0+dDV17cqJ8iabgq10UbTEp0fAp69Bl8=;
	b=EAcbZYGf5fNdQjHFJeyqS6W/IduW1qYTotcouOEsB6CV/3Sm0Riek6dTkV29vbJKNLhW
	 z6Jtmm6rlhxC7HuQ1UYv93GzUCQcfarKvx1fHGql2Ykl/dSjeCg3nSQievY5g/xkJj861
	 k8UUjOcaGJE8J9GJ8zY09u7exowmfErG/HeUTn8eyZw3djccjCi4qZtrhQtduY1sFsh8F
	 C13NK8hLacqgSMWHLcPqtLThuhkN1qA40Pb57/yxcv2a9CZJilIHtmOCy7+vgtnvWT6gE
	 rCMM6ZWQP9se7VETvUXYHiL0AiSiZ+Jaf8FwFlwgiL1UdWDO+8KXOrbGnVQCfcXxQfg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790802067;
	bh=StediAXhZsd0+dDV17cqJ8iabgq10UbTEp0fAp69Bl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K0lVqGNGSR/WQcf65gcN+ZtsLZtsHobCou4v8AQ7v1dUyEd/wJuzdPLM3AuOg91Ia
	 kv/knYuHNx6JNnt69SrbCr3G2oQoSjake9T/5D2a3YwOBtNyJlGz/h2VhOatop6wWk
	 Ip+HOwGUcL3qZZoYm1OfChyP7z25wH1ElBBahJ6F0/GYRipjA0mvyXnNkEA8j/qG5L
	 wyzabtF7WP16IEzLLansnHu4ZUJj8mmnInKX+loJ84JDCqWdNh1s6Hd0zZJ3PmnIvR
	 /oi98rhD68f68s2OKd6EYw1ffx4vsNYFOME2n7suvYmPVyoxoYT9tGZ6TfLh6pr6vp
	 Qc4bOduV5rXvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BA5781212;
	Wed, 30 Sep 2026 21:01:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A45E1A6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 21:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7029B60BA5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 21:01:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3YHOca5AjdXY for <intel-wired-lan@lists.osuosl.org>;
 Wed, 30 Sep 2026 21:01:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E507660897
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790802065;
 b=RRdAHg86gAloImKyu+JFVmxA8KIcEOZGeKlrTpUu5iSUlkCadlZa9xeQQsj6sz6+M4v7
 U987KGfCJ0m0W4Nm2Pt2ODcDxnFEN7uAXhUCVWkBJSA3KfS9mk88JkstEEjn6zBDunase
 fmCB1n4mzimofuyPe5jcoud5OW35TG76Y2wV3ZWhYy6Lp2M2JIbjLHt086menPcVmV3Q2
 QHe+Zp0AG8rV4aPPvFbrDKFJUB38j501kO5R9pCQkYUxn6AlLAaAzyJVY9od3LfoObIMD
 0Uff1keITQUHcT3QiFbJqUnxaUDrMk9dxMdtbiwJ5Dki/DGRwohTNEiwDuSzBuM3tog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790802065;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=StediAXhZsd0+dDV17cqJ8iabgq10UbTEp0fAp69Bl8=;
 b=gwmpFooEaFVRAMFrOTrH4qreXAdrVNNNDPRnY2WI5jxhkD0Qh+6+yeZvD8Lx55dqmm0R
 z1mczs180dSoAZo0v+JGLeU2yzgwz7jZefeB/rJPEXI1qlwU7Gy2vjKQ+2qjay2NoH+5r
 Jx8aQQWDBle0li5diVWisAE6TULL/vu6SjJmGxVVyj3m/co6OCXBY7SHIv/SojC16DL/6
 iaUWkltX2j74loOF6Kv5GHzs9pmFp+ZJ1j2IpX+0dN1vD0845YoDT4GQYKGR6erIE/h7K
 C45y8I/7771ZHU7d1y3WFk0R94+J3rR6/CQKTXKBvcehEVV0FVmO9hL/2i2ZXpHL7VA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=koKw7EEA; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=koKw7EEA
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E507660897
 for <intel-wired-lan@lists.osuosl.org>; Wed, 30 Sep 2026 21:01:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B5E541A3B;
 Wed, 30 Sep 2026 21:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC741F000FF;
 Wed, 30 Sep 2026 21:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790802063;
 bh=StediAXhZsd0+dDV17cqJ8iabgq10UbTEp0fAp69Bl8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=koKw7EEA8SgqTVJpyccx+p2wc2h3J0foiTPJPsTGP8L/Qn2fvevD+ERTtDdk5flaZ
 mK76G2GOhJjx74b9RFjbA8y3tDg7EWJSar6tZ5tWw2spMr+Kz3VMF3tBqY1Hn6UQi9
 aU57DI2Ph9X5VTRpESUmRqnylG4DwVyE9LfdcNSv5kDwLFlnucaZyFNkyo2PMFdGT2
 8z3+WvxtgDlCgKcQqFiJAqRuGaztUxDwR1+st76TSEzNC/9TlXt4uJbDjchAQTVUlP
 L1TLn88arH0ciVApKQ5RqXv6vNpW1Nn6s7tDpSUZ/eDFrREwB+eYwc624JglyqSFwm
 rLQa3qtcth93g==
Date: Wed, 30 Sep 2026 14:01:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Michal Schmidt
 <mschmidt@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <edumazet@google.com>, <horms@kernel.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>
Subject: Re: [PATCH net v5 0/6] ice: fix stats array overflow via proper
 realloc
Message-ID: <20260930140102.05c4b4bd@kernel.org>
In-Reply-To: <e917c70b-a0db-4c5d-8fa0-219ee77b49ea@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
 <e917c70b-a0db-4c5d-8fa0-219ee77b49ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 30 Sep 2026 13:55:51 +0200 Przemek Kitszel wrote:
> I've replied to all not pre-existing issues. My ask is to merge as-is.

Ack, justifications seem reasonable enough.
FWIW I'll take this via net-next because we promised Linus a smaller PR,
and the errors here don't seem likely to hit in normal use.
