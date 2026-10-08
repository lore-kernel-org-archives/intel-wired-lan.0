Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DCBCA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5FEE60878;
	Thu,  8 Oct 2026 18:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m0idHGCNynpq; Thu,  8 Oct 2026 18:17:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 04CF56087E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483428;
	b=MD5s3wkR+ok6Da5euhyYtM/DyXZ6XkBrHffVSNguepzETDPxs8p3c+YWROrtS88/plnT
	 svuJ5CoXxHpuCLjIfIx0RP9PoRgNlDXmoOvRy/ZYu//GyNZZapqeTkP6Xxd5OS+DFXA7o
	 2kMR9xBeZwvwljvZiQpEvPnjFlAnysFutkTC2F/Leck4b9LFwHBZ7OpHVIP/iOnmhB3GX
	 3JJ2GlQXDZeJgk924hgZebVVXh8nd9868TDdjgyEK/nms9nD9VZRbQsqSfA1hxZvwgJMH
	 swAz71jktl0p9cdHuXLvdSwC9pDRaeE3Ca4Olj1u74Mi3h+xoDy/hQq4k64pKZqW3Nw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=H9LOvnDoD+35fywn4kLsddt8yt5WqBAHe8H9SFqVS/s=;
	b=aCwmy1NjdEcrJQ89BzI9/d+TcU5p0mEEUEF211Gx4WVh/DQU89V4dS0Z8BD9xaq3v1HD
	 au2AwkfR+MgwLsVJsQsX+UHlehHYnl2Qquq1fR6cDb8XQg0qeWtqQ7XihyYQ4voSbZzgP
	 Inaoo1VyNRGTxQURal3klFz/nvovlCSTR8xHVl/V3JZ9DPLjvjaf9zSRM1lYrjYPwtaS3
	 B3jBSxHwfLVCcU/8yPz5eA+mq3bhoA1hIw2ftMFhzIB8kpgZ/sh8rdDeci8FeLumPJkB/
	 V3oAPcbew8i6Wyu9x1iR5d3VCwILUjJGVqjWn9zbmP0tVfaaNZFkA1zPdunONnQ6Lpw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483428;
	bh=H9LOvnDoD+35fywn4kLsddt8yt5WqBAHe8H9SFqVS/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wCCkxdSBB9fECFo/r4HX4UJBG0c8Xz96lmMYuNrtg+FsiGAxNVR1TYzU7EdLpxUl2
	 XQndulF0pPy1K527P9zwDdfxexlzwvclGyJq+8233+CGIOFhu5XvN5uWypqZlGUVKM
	 MzTEkSwSvO3565PhyjxnxyacG5404KVj0IDjbTcdPmOIsQ3ysAs6kTsdwRJa5Hxka2
	 ISWA3e2I/ir7GRAfaDJ3majJVfY2Vh93JVU1jgl68GxEDI5EP/xkHYQHUmJqrlQ4S0
	 1IhZAev+3TV/uJWZfp3kmsbPYuci5TdIRmC7G//xsV4UwlGWegu5S9hkLvoxSYHEK+
	 qywgNV0b9N+Kg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04CF56087E;
	Thu,  8 Oct 2026 18:17:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 643DD524
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38AD7408F8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mc_M6tgORWzS for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5EEA2408F2
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483422;
 b=qywDr80GYlKjO9inWzA+TVCfVCY25Vo9bXXkAcKzfswx7fGqS6AyseFY5FQtAcVRxJuO
 u7+qxc53VJOU47aY/S/cKwV/WeNDX27xPekHFMvcsXU3xz6OZdzgsW1DGyocE/yX8mj5s
 w3PCMlC+XojRUmxq3LyeElDokS45BUbW57h27DQ9L7KFahApW9I5yXLzPC8/JhsLhFGoo
 BLZyjj56bFbP/Oy4Ee/bVY/s1ebsw9yYTt570J1OCN6JpBTy4NcWfesXHxkBE+26KalQE
 iw1BFL0JLAH6Dv6bUQuF/L83OSlOghsOQa/1q/ur1YbhMiVvVWsozZThTufHpmEREcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483422;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=H9LOvnDoD+35fywn4kLsddt8yt5WqBAHe8H9SFqVS/s=;
 b=AJqTVTU1DYvC6dpkbE4e8gsiVLTyWKsoDZlWOv81nfvHyLooAe9pdATOucbPakCYrIn0
 kyWEzWlKf6H117s+lKWZBnYCl7D0UCmLPoDpt1b0JS667/0pP4BKR96l/BIW8iRxU2Uv1
 R014kywcI2yBNFOXEnnslXCml3Lzbow5ZMqBebo3IxY2qvk1Zz/9l5TL05tBGztLFFkyI
 LDyQJt8YCoHcDL46o7tWEfWYRVv5IYqF17+9UYa0m8RzPGPiw/ZhbEZ7H+MLbMlucGL5F
 7MN6jvLSOh84QLKytpDLvDfLDf/2oNtOXkQ4iMMV/AkeX7jikcjxB7Y190NQu/N6rAQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=clasa4H8; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=clasa4H8
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5EEA2408F2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0087C60239;
 Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A031F00893;
 Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483420;
 bh=H9LOvnDoD+35fywn4kLsddt8yt5WqBAHe8H9SFqVS/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=clasa4H8PrfW7RX1l95x66aQYoRHG98wx9pcuFLwIKnqhoK6nglhuVu4Ty6haAZtH
 1y61Hlb9o4KSJ05924i5qeMbpmn8w5XaJCTB4Re/xYy2ZwNm7fAxGPOfO83Lw9L2lI
 lVLiaqDpoOU7xvwGUIXLCXrU2xSxHKAZjVVHoS28MO9qglE1FZQJDm7hKkuT0cm05q
 KeH5kb1HFejkxA/kNuaFEgs/98a9fEKzBNrxdjbzjaCe8lp21ZvKjoqYGlDVRT3y6M
 ZLlmyfs14V8peu71luTsoDpm0Kojs8gtJWIqkreqtwtqMyY9pgKmXPxvXiOf08ynFb
 REQ2Cb2WXQazg==
Message-ID: <sashiko-outbox-164449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 9/9] net: skbuff: don't reset truesize in
 skb_condense() if the pull fails
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-9-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-9-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:17:00 +0000
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

> skb_condense() pulls all of the frag data into the head and then sets
> truesize to cover just the head, but it ignores the return value of
> __pskb_pull_tail().  If the pull failed, the frags would still be
> attached and truesize would undercount them.
>=20
> It can't fail today.  The caller has checked that the head has room,
> that the skb isn't cloned and that the frags are readable, and pulling
> all of data_len eats every frag_list skb whole, so nothing is
> allocated.  Check the result anyway and leave the skb alone on
> failure, so this stays correct if any of that changes.  Use
> __skb_linearize(), which is what this pull is.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D9

