Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8CD606A31D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=nCYWtYjg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HE3K1pkj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CB304055E;
	Wed, 28 Oct 2026 08:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sPZneUSw0sDY; Wed, 28 Oct 2026 08:55:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DBFF440514
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793177714;
	b=eNEP4pGpqOdDcUx2PCmjQW+g9v98OcImuh3/XB586tgynTfgY4sdGLa69IX+DoSf2oAV
	 tCw4V+BF647IYu99LNSupvteGnSzlVJJ9urfuT3J7V92y5CIVGcGFjcmnrqx5hLKMyMir
	 iMrIMkHBtxnFPg01OB2jiSnaitYn02AZnQC9w5316jKWjyiUx28KFY/4yS1iy9zRN9fMZ
	 pUf/Rru8CD6dnFGPX5XvzYiAQ3J+Ok0aWCbwt63i3/09sD4XNMNU5hcytaIoF2tBpoKO2
	 a2cJzFaLRf2tZslFATrZnYZx9vX+D1BDBWGPCM0ugtdyXsdStyHPSqZlLzGdCQWIDgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793177714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Br/L6M7BV6KUjLMbIXP83jhCUutmdK7rlCiaE96Bmu2FQQJgUvL9TS8EDXUURO4YY7og
	 a/txusSk+JsMMzKZf49LOV1hBF+VZ4eO841J/jzyrxH08XGCLuqM4vFuecv/YTjsY0OWT
	 ecFy5nqe7pU+LN44f48jEgiSOX1zrhVxb8AJl61Qn6GFCkgI/Hq0EK0OKPBHAKLTsRpMe
	 svq543pTxWoQTtT4/qg32p6042k7rA+P83nszsspcPjR/uHpvVKfWSWu/ETr0+kxyko6Q
	 2yeeEUpOOzV9mC7/iHlgKFedTl6z0/ov11mOeHsR0Amt5Zrv3slT/43LGI0ge515aSg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793177714;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCYWtYjgqBTM+P819k7JXsFalR66NZ4zTraHsGQiDrnQx2mCA98rY0at7HgXpakZ8
	 T4QsbQsPZr2gDqWuJA8wHiY6VXIdTLBi7W47s4SY6VT6Qxig4sOz+ENCYIiI1WoRMj
	 Y8NJvVRy9ePBcW91rjcn168vhSDQyn6lmEnxd2+L2q9OFjQRblSTon0E8QjtZ65NKg
	 OWRE9whROq7BtNmrY26E0r42eW/rco7XlB7Htn4rbG1ULSQZHbGGT1wpJ3epOHJiA/
	 ASzvDEmzae3WiUUIbszyENVTacfAazPR6c1oJPFuWWpNm9vC5GtjMBkyYP4DFg5V5h
	 yqfEdAV2aY7ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBFF440514;
	Wed, 28 Oct 2026 08:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CECF4D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 724A760658
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:55:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d3oxRX28r9tV for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 08:55:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C593E605EC
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793177712;
 b=LwtCqCphXiaxpb0gZqspq+fhlw7V9JRqwrbEzqvjMAR7xzVmfGgmN7buQvjdqnT5blEB
 brTwt8PnO7SKRnVnoN0ZvQoXNGyvOO9JlET1eNMr3Af6pdsy00JbxyWicGieQIVmon5ee
 Vh8GQMZZIORh8lxJ2TBcnczqSV76bLfQ10YW8661QEHZWxAvLyUjybeNhxY/ntW3N5Guj
 NKCIQO8PAsHVllELY9npkJcTmNeIP5uCplKn/+NloA1s0DBD6LdMsbB9KaZR5REGh4L55
 U4MhE6Tw/3UpKnhxKBZBMOjl8VWYD/eQaczRhFWnbHdK3gHv2q7LuxSUzgfnJdJVNyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793177712;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Auto-Submitted:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 b=RkH9QR6XP+7ehU+2itXh/EYEz9pF2h2KSS4HadzDGv4l0HnRDaSFHYcoBbxc1A00C8Wm
 We+4GkMVyVg5pBdd1lYgfE4oRmkF4SuiyOVPbkEEWx9oqLpKpicHk0I7MEN67UgLdMq6Z
 YyUG1EzM0rgpsYp/0oOFMLRHDrJXnxRRBk9OJKdvMWHmYvcJ1HIjnHqnj0hrvMIBcfP7U
 Qny5TQsF/uJgIAzflWHjl+NO5E9ymlJxbz1k8F8lZCCzBJCfWuLXaPsHnxB5nyCPRS4D5
 0ZOSGD2nHLyRZmntexVyRZyXur+2Pda9I+/TkAEtZk7/OlMDIRj1Y6qMtpEuF8lO+Iw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HE3K1pkj; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sinfo@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=HE3K1pkj
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C593E605EC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:55:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A622C402F0;
 Wed, 28 Oct 2026 08:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E201F01825;
 Wed, 28 Oct 2026 08:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793177711;
 bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HE3K1pkj3Z42tmbio0PdwxCuFtxWKXKFq6+hv/73PqTedoUxj5vvZK5Ja072YlzVy
 8dHbaql57NxaWxphm2fSt6rMtpwCHIKKhhWDd4XcApDfUMDZPTrEi2E0We2l0mALuR
 oe5YVejCYo89WCV71xOmPaNmjmccMkzb/XMb/Ura7NU1MAy1Dnhk2F6qqOZyyjX51z
 fgm+ESVhHWsBCdrWv2Q8EgBtPjTsG0tiPD2jkRk//0Ee36uO78erFxwlKLOwYgLGF3
 XAT0thqLmjZjJWC4ckTAwKn3ZxJXCVJDi/7WR+RiY+k1QddnvgNn+Xo2UKUzx0surl
 2cU7omvmcXeAA==
From: netdev-bot+sinfo@kernel.org
To: Paul Moses <p@1g4.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maciej.fijalkowski@intel.com, andre.guedes@intel.com, jithu.joseph@intel.com, 
 vedang.patel@intel.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] igc: return XSK frame copies on XDP_TX failure
Date: Wed, 28 Oct 2026 08:55:10 +0000
Message-ID: <179317771001.3327.2393142414431005660@kernel.org>
In-Reply-To: <20261028084919.3059158-1-p@1g4.org>
References: <20261028084919.3059158-1-p@1g4.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
