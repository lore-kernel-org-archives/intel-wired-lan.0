Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0FDCA6012
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2A3A81393;
	Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2KGzqzAKDcCG; Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F35A4813A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483421;
	b=atRtLzhx/NuVyVwbHNcCIdBrfgCiKMjX28J2ds4qTxa8mPQbGVkWLZXzn/piwt//A770
	 jTQv3myMdaJKbpgWMT5XFwsR8Dsds4ZIsZUeT3KasG60gVNPwcTTg6UZJvKqZ0vAF5Ev7
	 8m9CZ+VK4esQnzmwDxTYnenbytKcKkt/2Y/jyKvlU4SX9bGr8mAbVPR1E/QwvHU037B5Q
	 2p7HSPsDCNqs0RgxZbLy8xcz5LC3vvaAchFqvNhhXnNjXA/cmPY6H+pParVn111LofQvl
	 vwYE8cqLDhXXabNSYo4zp/lq57oIihk2DELizg44xTevCROlkA+sdTg95UpB4CG97nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483421;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=hQP0DDccae/wkhGSwQNqWKTmasq14MDjibKhebkKkUM=;
	b=taq8TtlHAfOWvjyBpt9Ix7ShjIuuzL7pYvqOy832CHJUIkd5ViEREEq3Udk4OBm5YoWJ
	 Q+38QOvQizP1A6ON65F0Zi5VjXMbtQgjXojRp0fsEfAokmjHp/6hq7g9DPWsHi8gpQVvK
	 /sQocHx2FMF0smmYBYfuR1MWsCwgTrYjhc3qQFho1WbQVG/Ceog50dFBfbfbfzHBB/LOg
	 16tP1G3Tub7Bl1X7S3Glhfdbyjcx98msaO3h+mD201vN4HxF76dtqr47DEkxr28JGRACJ
	 vNW/C/JGE0yYHo3iI479UlYqAy/qzB3EW2F6N793h+iss+fRLhWCG4N73zn+FgYy0qg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dJ6K0dFj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483421;
	bh=hQP0DDccae/wkhGSwQNqWKTmasq14MDjibKhebkKkUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=CUl3lUz2z5ZvTDwZ9auOZUFl+i30nXL6YveikE3ZFGCHpyEgwNOWFd+ciD0+mKAkn
	 sXBTvGo26muEltmPZNQ4UJ1YWu1EnduSlOe5XCkItsI+1vW2g94xIbsJi09tLYdxfQ
	 A3r9G3HCRTCoT/kjP+xuuQReB7RKEOUIvPHBXMoj4cNMXsVo1N49Vl2tKN6dA431Qc
	 HgvTGl2nuG/iXmP3xgBRYubjhjaNJeZnxVqxauHQKWP+6IcLlfPseZrlKXnZZ3V3cZ
	 ijP3EjEYBxCnf5BKmhUEMyQBJv4wtkYeUHa+rlxyPzDmNJzjcn4+N0VHh3YAVWL2KU
	 NOJQpJ6psKjDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F35A4813A6;
	Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEA612B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94EA7813A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h0gl_ZbS3IQc for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D9FE181393
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483419;
 b=Hg4oPd+fIKPteYHWKery4slAt4zNNI9HnOcfhKi5RgcA4aVVtOgjcqqSqq/aYvD8h3cb
 YmL97qO0+7PoCZ3WxNh34z/+QZHgeNisqjZ07MgnrzXpCdqZlG0BU8udTvVMygnQs8UQx
 Kp7aoQJa2rTzL09/0TMzUaMSPaXYarHj2noUFQcd1518EU0TT3Wv5bbEwL/vTPdxti7x+
 T6rU6aAuaYFypxI6G+XVo2hJIcLWxm+tX1iI5eKEyATzgTi0voMddGZYWpQNPxhTLn7wG
 WHwvlXO/z3tm05HBZ6nrJvPok7/LPhkF0AWU9srPWqyLWEfSFoM+z7OozNE2CSyxeAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483419;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=hQP0DDccae/wkhGSwQNqWKTmasq14MDjibKhebkKkUM=;
 b=B+07d5JAs90bzHlJmdti4/o+mXOPOTOD9JiEWz79MTWUp7jvR1sX4H6ODH1BkaflPs3n
 eFDT9+gdyRTwmBpkkt8OAdENNLVThILRzPhn2RmCnyyZ+7OO1VMdplTcA1IlMZKDE+mw1
 vRMHmavsrGBJxw4fSKwBQGsqdXNKJJquKJQOqRcVwM0Ct+eTRUqST/9SBeYobYCdfZy30
 JXyONrRLKLQshUIpS5qKXRZMnaPV5oGj8B3aCRYeLImPrybMf1iKfqM6WxixS1vSUjdVT
 KfN6PRa5BRYbleLaromynm5kzUaAdOMkqeZOMYOuNPIwAP86YJfN/kmYui25EMocHpA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dJ6K0dFj; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dJ6K0dFj
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9FE181393
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 494F543EEC;
 Thu,  8 Oct 2026 18:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC901F00898;
 Thu,  8 Oct 2026 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483417;
 bh=hQP0DDccae/wkhGSwQNqWKTmasq14MDjibKhebkKkUM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dJ6K0dFjn3WaxojiBy+8EDjhE5VXFNNDC/+B8NL3oiHQfsTGgT6ZQ9oiZjWTLQDKm
 N2a5Sfu4Js6WB4qtlgmlb7DNNFmjHCSFwvEP/SnDQ6LDNzBeU4z7fKHyUzL066/4IZ
 X4a4X5IiB5tCSj0zotRkl+byaR7sG4OtE3WBo0wv0M4rM4pKrqtLLjz/mBmJqr0zZK
 3kX2tn7ANaBxIiIjhTUVOJg6aEVlrOuKldxMuMuxnAc3Y4+yespKLkNS2vQTQGiW8P
 Go/mTBMpdzLkzmERQCct8o5tL3g+vbtL5LjBM6ZC9nA/ab8Vvd2WeaVL519Q1/A+kL
 kLfRkMUSOzRXg==
Message-ID: <sashiko-outbox-164444@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 6/9] e1000e: use pskb_may_pull() in the
 82571/2/3 TSO workaround
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-6-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-6-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:16:56 +0000
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
> payload into the head when the head holds only the TSO headers.  It
> already checks the result.  Switch to pskb_may_pull(), which takes the
> length the head should end up with and checks it against the skb, so
> this driver no longer calls __pskb_pull_tail() directly.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D6

