Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FBFCA6015
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F32860808;
	Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApqhdLOpX4Ws; Thu,  8 Oct 2026 18:17:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E8BC460872
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483423;
	b=Jo3oDToEwZMmmhcUo1CB80y1ozXyneel43W5wbs5BDIVHi75cXTnH3xaDqF2Lbbq41ey
	 rQeQgESjrLVlsHnaj82WVr1/QY4buPcScg5l5ByFJ7fQTZ5nEgfmq+xmFlMbM9oSDsYVs
	 AXPW18sZMuiO8fLLdU1J9kGVWMeflhPNgujHd6gRP15MgkXBdGmqQBm9SBFEnet1ypCVv
	 ADh7litM9CypbFx+8wrogP7RY6RBXLp0babCJt+v0a9uun1uXVClqBAAwgP9im5iYdZzz
	 0yxce77tUx/gpOpsu9qdb4BG2bk0j6kaAVTyVUUkPiSaiXMtJlzR2ja8cTHuJw4vOug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483423;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=qAe15mq1BpzxwIcVhWzI0A40fMUDDC1KdVZ7WBl9XRY=;
	b=sX/TVCtj03uc0sic27+gx0uqJZxLYYjvdJmkKQOMq+NTdwK8tos68p4Ij/bQ2mdwygIw
	 qJoQAzWmxsDijoZBgdqU57Ra/tb3haZv6QAj4tQmfc/BbzV/xeXfnae91Q9ZNAJNMnkHa
	 jlz3KPB2WNXSB0O2l+MtEmR2gIGAm2fTumbBqMXysYGbGejqIg6wVVL8+m61svapW72sM
	 l3+xg2hqADZ0gNn9E3e396bacRt5qEn0J/xTBLD7pTjUF5BfDKR4AtaQc9XSnTbF1uWEd
	 keolJMTHemJpoEhMnxvNHQzbLa/KcO2gP1ZmsYJo1A4oC3D93AnnxKDLfJ3Z+19tUSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483423;
	bh=qAe15mq1BpzxwIcVhWzI0A40fMUDDC1KdVZ7WBl9XRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=34hatyP0UgGFSzKlXkJwfJhTpishBw28sIQy/inSaTTud+C7lCFhGRpkTXfSrRMmJ
	 yozohgh/eDsuKMH/EFKluRYoefmLy62BZZpR6p5lqxjfiNRf6mXBMPCRlN3yZq9jFv
	 naliZmBLE24lbjgs13hNP2VdOQMUJRAUTvhW/cdQo3E2k+5ZU5v0UFNJOPg5AtLrHn
	 VgNS6veRl7vTxzdcEn8a8N+26AJsjIXKqB19hOpknpfQMFYw4Epp1M38JE9WeUDo/d
	 QzKw4y8o5Te/z5XOV8PIb1kVGCVxwBCNF27sSrhsdLC3Yc0DTbKHga7TFO2FOetVdb
	 5xV0sHeZDOgxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8BC460872;
	Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 508322B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4257F401A0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vYIrwUjjxDCs for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D368403A6
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483419;
 b=Kz2UmtLmfaL3z/Xg2HfAH4heW5VEaKYnD9NBVz8AEnq3eICAcoc+ZOngd0uo+Y+VXnS6
 fmsbjOub2Sjel06zQiXYyecthTu3bQUUB1X+qPNZBRhMgKFY8BNutvN1eIckcfjj5ve+w
 8BO382t0fgQ8MwngSX+KXYL1czhkjvxy8UjouMGD9YGqNwFslSfaSMbVIVrNm1c9slJEK
 bLElNELeKtuC/nIRfm8RUr02sxe2vGZ5cxsyDOhYzNHMQSx5ffV5ECS7QjsindM6l5KSl
 RW08K6UG8P+nxCLarCWjPcY98FHNpMUBYfwzWmjc11w7rBz3up1LMcMKPZINZLxTeCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483419;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=qAe15mq1BpzxwIcVhWzI0A40fMUDDC1KdVZ7WBl9XRY=;
 b=ScjP7N4zAePzV2I79mzZRTqz3pfPKBNGvF8lMTE/z0NuAq+u29dBhlGfZlhdqWlEGRgL
 2FgAfubgqF7fGapdk3ZycSSHICJfmZMxvCZ42uALA8/h4cSocRCcqoSQ8fhfHFkgzL6jg
 lP4W2BEmIgvJXLAoAeJBaOwGYurN76C4h6lJmVqexx+ZYrfi1UxCjRr3MCDHfYzlhZwYX
 VIRWwTT/l9ttFRGGZX8y+1nd5BWcHwH/kt7VwckcK8XVz7KugVUUi5E+i5oyEFgFz2WBB
 HA2dvTuqBC62l250hJYn3FgXfah7s/N+wviBgcUj0R2RwtmqQC4z0S/NUf8UP+pPbHQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ToG+OGah; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ToG+OGah
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D368403A6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:16:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B0BE942E9C;
 Thu,  8 Oct 2026 18:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F021F00893;
 Thu,  8 Oct 2026 18:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483418;
 bh=qAe15mq1BpzxwIcVhWzI0A40fMUDDC1KdVZ7WBl9XRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ToG+OGah2ToHux6TxOw6XacdvmU2BN/8AQlUB6/RfVE2xS90n772zKbtG7OvfqD9B
 qeYFdwkCsRNWdc529yE5YOmjM4/JXcjDqgRoYDY7cg+XM5Cz3pQ+brjqwKeE5i0wFd
 ZZlwLIVJ2ekuf402jXH2OVHP1sz1w4Cp6ql8refU1TRAqPW6j9ypYlR8oMW/ID4Yv7
 PlXxg89A53IsyzDCs4RirUloLxfar9T5ag9dq58hco90CivJ6i7ObS3FgnRoOoyR/D
 ICzMe5Qtwg8jSPb6bK+yV8JNskbN8NbxFRGhIDocSvVGoJPv4bh5shGAvNxnvpo00Y
 eBoAMCCsefhaA==
Message-ID: <sashiko-outbox-164446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/9] net/mlx5e: check for failure when pulling
 the Ethernet header after XDP
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: linux-rdma@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-2-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:16:58 +0000
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

> When an XDP program leaves less than ETH_HLEN in the linear part of a
> multi-buffer packet, mlx5e_skb_from_cqe_mpwrq_nonlinear() pulls the rest
> of the Ethernet header in from the frags with __pskb_pull_tail() and
> ignores the return value.  If that pull fails, eth_type_trans() later
> finds less than ETH_HLEN in the head and BUG()s in __skb_pull().
>=20
> Use pskb_may_pull() instead and drop the packet if it fails.  Pulling
> min(ETH_HLEN, skb->len) keeps today's behaviour for a frame shorter
> than an Ethernet header.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D2

