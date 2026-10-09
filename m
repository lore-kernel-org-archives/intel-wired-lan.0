Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47B6CA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FE568149E;
	Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S6F_NWKl2lNt; Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF52B8146E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579844;
	b=oxlrERDCCQo416MA5RvC/mT/zriJ/FnsFvLwr94iroL7GBEIhDNzU1pxIn0iXwtM6PKd
	 EO5fLxEB8FFHOTfWS9UIJD7wXBhOxrHEqe6xSXq5b/cfys9jHeGHDzZ3/f10mqUdNVl8s
	 gEQx3Ldg/Orscps48HsMkOoqjX77gS7b+g+h6WjqKlxUQN1LsNTdpeuRVxduUBHqAXS3w
	 aFFQ7ZoWRbVbw/kAwUg5FKK66vBsdzlwQo+pTdydF/EfrpX1a/y9AgLZ/QP/ecMEMKR1O
	 pV+31YzGbr6Gj1dNCNVCUpJ64NaKjXEJq2gAyas2WBs4e7GdsNTJjSdRP/TOn8JvUCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=p2RK6eivKmR6gMNd1r8Uomrm3bxdwVOSF0pQiYhu/y4=;
	b=MJDWg+eUfeFbTHO2hIL4T+xoJIOydXETAJabP+pp1K9WbqDHME4NUqYtCJ5pubiCewfv
	 kcOC0leXGJvZgLaX+Rlo+6DreY1ylxrhz/bDaHgduXGcy/98tBdoy96KAH9fGddxJD34c
	 6D4YUB6HEfcOj3Hr3vNNSR8flwxLpiW0vbzNmsPprORcBrIXRww71t+uccm4EOFlyWfux
	 0gvADt/+wHMBmghecUoGqS+Tuqk5f0+gZqKnKYDL8jZftz3XzYvrbUuGd4iN0JT2DgzOc
	 T6Mr+CIsGittSsmSe8uPtZ7SEl3TQ//FgKi6zKJqX71yJhDKyFjsXX+IBudH/NvOZyw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579844;
	bh=p2RK6eivKmR6gMNd1r8Uomrm3bxdwVOSF0pQiYhu/y4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=rIRTCeFqmR4C6lU7ewh1zMWTRJRDkFKM7fZxMXcPHVK/mznhVCNL3LBoli4tyiUD5
	 vlP95unMAje4+TS5QltIs2kufk0U5e5DzR5iWi5M6qKKINXoiINEs5XyHsaRnOBI/k
	 WZT+D0GhSLMtT7oFZIMd/0ZW0hOBDQ6m/o+MnEv7tMYzn8wmGv3X4S/277LjxzrVWj
	 urNkN++ApUEIZp5M1UsZSBFtuP48kMRn8Q8SyCw9+XzpSVAERvWDngtiKWMcNqmT3c
	 pgQg2sJapE6yzRDAMERJiPvl6LteUpEF/jklTTKEQTzbT35QS3RRTqPZACNH6C9rWF
	 Ps5C0Pr3u55RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF52B8146E;
	Fri,  9 Oct 2026 21:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80FF31DE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7327B606F8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gpzIHhe5rOYg for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BBF866067C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579840;
 b=gMrO/P60jQtWGclmpKDWI+fyxqFlh8q47nf9+wi/qVHADM9l1uYwgJn/5DMRfXHplQ6w
 y1xvFWxhrUqV3jEYMcbBOqFTKqzD//a/PT6NLBb6knyhIMKVCBLUHA5MINnO2gWajhLyp
 kMDRHz+hAvk1PpyHecgz8Si1i515q+9a4pL1TXvbQgqh6kuaQn3wTfFSgElLmlIQccKdv
 4eymTQgIGDip7UYpEEqon4ftGJb+ekXEFHsQcVe/Hs0j3DEAwZulx6NccLvuATwsWv40t
 5EYoA5tziPqUB8DvyYPasyVfPHwXr3fT7H+S04pLfpRpzK1B7ziJL7x3V8/1cWErBDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579840;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=p2RK6eivKmR6gMNd1r8Uomrm3bxdwVOSF0pQiYhu/y4=;
 b=pTL+/RxidCv7wmQSuGb1x0Fl7/E2dB7yegTRV6b8TUaosW3sp1VFchWf9RIj8XSU3Get
 mEK4CTqfH6OVu8h9egh8ywojAMhRd7aG5VUSEdpbCQrQ7CGiLC9Jk/xqmuxr+JDQ0ImyV
 LteAmro1qJkXaiojMd9U1BblR1DP45/K9aJYl4TZ8fpCzzwiNzkG/UBnVjwdXuvnd2piy
 IKAXR1uzQyCZtEe+7VX3weB4LRbYwhf3xyjSVH2v3CoIMsPmewpwq3V95SAU9QVC7PNjH
 EQDDn464OQhtM/80/MQmhBm51YraVW7mvSI03mtinYeIQTu4nVAKdeDgO3IIY8cRmwg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gRWlBil+; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=gRWlBil+
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBF866067C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A1EC60DC9;
 Fri,  9 Oct 2026 21:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ADA1F00893;
 Fri,  9 Oct 2026 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579839;
 bh=p2RK6eivKmR6gMNd1r8Uomrm3bxdwVOSF0pQiYhu/y4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gRWlBil+dMa71myUCS9SWRF/QT4BuMpLVE3doIQvaLTPTs7hkSsyBXehts/2CENTB
 X9xQ7/n3opb6pse7raIR+LbzNqRNVm2r9xdTlZX83xOk8MxkDVXu4ZR6zGgEHDqXOi
 ywPEY9NOqHr2lSZFjNvD0k0i/Ixpub8KJa3irxJrgzvhCmqSi9O/H14BReLTEAbhDN
 xN0T07I2+XzIz9tplmPsBYFpp1fdA9y8fzpjbDPB/RPV90yEkJndSUE2PSPnxuOARJ
 F/gVGI3WSJXG3VY+R6vc45FHN+vpITEuVwElarTaMjwxDYu/7C9w3yujXOPjmbNTy5
 yt4YWPj1je3EA==
Message-ID: <sashiko-outbox-166071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 06/10] e1000: use pskb_may_pull() in the
 82544 TSO workaround
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-6-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-6-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:03:58 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

> e1000_xmit_frame() uses __pskb_pull_tail() to pull up to 4 bytes of
> payload into the head for the 82544 TSO workaround.  It already checks
> the result.  Switch to pskb_may_pull(), which takes the length the head
> should end up with and checks it against the skb, so this driver no
> longer calls __pskb_pull_tail() directly.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D6

