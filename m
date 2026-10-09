Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6989CA9EC3
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 733A840931;
	Fri,  9 Oct 2026 21:04:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oDeBwlc8tbdz; Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B123A40934
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579845;
	b=FK+7I5umwYAH8s5yyWmiWlLBhP8mY/c+/1ft7soHQ3t+ITRaCop0vqN/AraX7A0CZIn3
	 QvT6e53VDP9OUuxdMbIrcjhZqkTYG1xnmi4Hf1ioRbCgGKWRZbAzA8ve+xoPAyBMGc/Zp
	 e30gspbcXEIeorgb8tDPml5iwA5kxi437i9iN9d7/rrQdhRVDSrYSaWX10EPq1FNzwwG1
	 KW9HeKQX+5u0PSAFcKx5WHG3Q1NTLkzK8fieGmnHfwP7XhHwJZez3Bb9NKLPcjMP2CqT+
	 MV1oYdjxhrxWZPqBxepC6DtD94cen9wACSomkJlXEat3ObbOPIzqXt4RxlpgvHcqnXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579845;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=qqgeUYi4ymJUKtqneVIXrdLGfAJW72MYSp85bsFbDeY=;
	b=EKiUtKzk4gUAo6o1Zk5g8TKX3w/wIZ6xG0zOlDIqFSdjxBw7cMWGy+pp8Oxwpzsw6D1p
	 3bf7FubNViYiLzHnlY0uUMQLwiP++vcoWznkFee38Fxt/QfWNgwGE6rjA8+ZtFssX8pc2
	 7Gg43s3HB9QEYdBWDcqefzuWey20fmkQpL9ZXlLAuPOPwSUl5/6xHBzjD6gCHOHoRjsVd
	 wOlIuXo1eVYrFcA3yefMEhTvOz4I0BnR1V/4eWYn55T7OD/l2wtlCvo3/xDg+oW8j56HZ
	 gfVGqIMqEk0cEpNUgtWwmSQsJlWGtRvLydnjUPez2A7eBjRtWCHmGA4FDFs31E/aesg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579845;
	bh=qqgeUYi4ymJUKtqneVIXrdLGfAJW72MYSp85bsFbDeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=LW8UZMHRPAGf27JYmM1EvgzTZBiW63r++W5LwFii9Ec4Z4gDgU0JoWrQaXGGNOLac
	 2X7VqoXWkBHHrdCzAvZj0aXf2uSbDrp8SUWlJ+w0kSyA6UxX5bHMmILOmHCjmWHL42
	 znZPB4bKVCOYWWK5IMJhCMmGlA5bo7GuwKn4Y+O6/Wqjk9JRtHK7vY+vdUNA+CRrCD
	 KrzBwayDsPmH4j3r2QCBorVKpUAgeIYwI/XKFzMBOgiAE1UYuLRBuHiM48XX9lS+z7
	 GL6BXRHiNMWshAfabqvunEKHyFjf6RiA8oO55L+xjfhrVs0oWuN3Gq8zgspGeFgvTy
	 E15f8xb8JbI8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B123A40934;
	Fri,  9 Oct 2026 21:04:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 583AB75
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A87F40080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zai6y0g5bw6y for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9900940053
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579841;
 b=djuqReGLGncTo0Ue6Z+2K1Y3S8SLEcZfkbNf0LjQoI8H7nHJh3HXUOYdPzICVGfuEcW9
 /RJ/ILEwGsH91AQDLx656zXFQ1J5rS9sXHw379cKIus1cvaIo5AYkOMEuF2R4TA1TaQQm
 0DpdK1bmIWT2CQ0yF3j8+mY6jPA2j/IGH7NJhYobmQh9eAYjn+TjxPTWc/wmUUZio3SHz
 v9grqddL7ab1OhTFggYqe2xd/sz/uL4E4JCzU7zeQzEMZ0wIYT6i3bzIvYwjdEueyNrYw
 degZD4Pa6X2kUhkMaXX4ZyVsS2RRRPRUHOJigzV8L3hI/36yMmnHH/XEBVhvuXZoqkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579841;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=qqgeUYi4ymJUKtqneVIXrdLGfAJW72MYSp85bsFbDeY=;
 b=Nfs/nlvZ7XeZgXmrMWwYueTpFmEQR6FilotVQSfXdAFkJNtmYUgsVLf9cwJ3fiyNoF66
 T1YAv5IXVKMl7V0D5b5TIgfvpXmtDbOCahpzFdxuMnXrlWO4DQlfgc3jxatl1gCfvNY67
 Yt6PlSuRdQ49G86O7rKe3HOAFvLFK2kcpffuX6hvTVXublGKXdfmVfr5X01T8b0edTm7K
 15hHg4FegHhT6Dny95K7ugg5FLWJjvckhBl4zwjRHKE/eQwdaQgCsCVa+PiCztnRrX5NQ
 zHigJEBHSxQ69HopfoUEQbNh8CJmMzSYpDzMlVdmWCo+CBVaChr1KPGRTX+7opheEMg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UuWekzjW; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UuWekzjW
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9900940053
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10FC8402AA;
 Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B91F00893;
 Fri,  9 Oct 2026 21:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579840;
 bh=qqgeUYi4ymJUKtqneVIXrdLGfAJW72MYSp85bsFbDeY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UuWekzjWmZZefRrzdmMbZfGNWt3GYNcfVBsOgIOWwgqnQjx6gDWDW+ylFBDr4Xgd5
 f3kCj2wDbv/u8u0lvtALWitRL9ghhWKr7qCWZsjC8rxjfcXHqxzsbmPaSCcSIsAq3z
 J0m+luAhFDUq28tYPt7Rd8zz/8VzYrbo4tlRZ9ivf5XHpsfVnTSQmirTsDoTHBiQ97
 OLEECFPBEkbD8vo6B2sHPZh5dYUKHIB6nJ88oo8lb+oH92MXaDldiM/SI1VoVFJ2hB
 GLxe3/KIkyxOhxET7HIiOBwU+7RP/IKhWpuRSxJV1UtwZzd+Uj32Vl2tIvhzDUteVT
 I9yxhv1YucdtQ==
Message-ID: <sashiko-outbox-166073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 02/10] net: ftmac100: check for failure when
 pulling in the RX header
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-2-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-2-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:04:00 +0000
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

> ftmac100_rx_packet() uses __pskb_pull_tail() to pull either the
> Ethernet header or, for small frames, the whole frame into the skb
> head, and ignores the return value.  If that pull ever failed,
> eth_type_trans() would find less than ETH_HLEN in the head and BUG()
> in __skb_pull().
>=20
> It doesn't fail today because the skb is freshly allocated, isn't
> shared and has room in the head, but that's only true because of how
> this driver allocates.  Use pskb_may_pull() for the header and
> __skb_linearize() for small frames, which is what the two pulls are
> doing, and drop the frame if either fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D2

