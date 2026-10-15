Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E9CC6B3A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 07:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A92BB8109F;
	Thu, 15 Oct 2026 07:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HEa4jHSoUiDH; Thu, 15 Oct 2026 07:56:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D6276810A1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792051012;
	b=L8YExJq7bOtmvsoaVE8HTQA20tAIM7rrXDvAS6H4G3SzHNxhkH7vSAdCrbb0HMLz3Kfs
	 MAaISTyYqfUUK4OC+AQVaywvUCPRXe6tZKLXh5UykNDBdD0eLtt/T6qlpxPNOxeD2r8Ll
	 tz+XBCjM8FsMJLtdpxRf2zlAbLPZD81lhY53eOxNY2/fQDHSbbEYkC2W7hEH3mNXkP9Oj
	 tWo1HwbxWt1Xa2y4p+zicloAwMfTNLvGxGl+7o1aWvpdB0EfjBy5kqZWtc3n+oIWLq5jh
	 XxBphDEiIx3XMwDfI+jWphzJVsZNosGoD4B5EOR/SPvJPvNu2f6vBVW0zE1Q5jD9sTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792051012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=6vMCrrpixPqM1N2cFgOpKi14AhtedTWIOBF40enE8GI=;
	b=AtGen5I+AWq4LpxPF/Cpgw594SgWFx0GSpWiMwCvh62Tkvdd0m6o2b/xpvCGOLvgNJLn
	 YqTRVEm6pinPt4ro82GmTiuB5Brz4tjEzaqHzG11w6hU1E16BGn63nghi4z2ivWjMEtcf
	 tIxgFMUmdYpPqFZvaPv+JojGV4Us9E//Cl3CeqSIniIBZFbJXVjcO+mV2vDKtFqDZ5ts/
	 MVsZGCwP9omOO+jWprh1L9EKWO+pRVfuL/sKYm/JvJ59hhcjtSF7x4ALZzuDpnmjt2bK6
	 Ir+NE17YNqt/81BIKdCllU1UqF9CzODWJiw96HzRW1TnJ14Z9zRGGdWCx9ICKubnPWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792051012;
	bh=6vMCrrpixPqM1N2cFgOpKi14AhtedTWIOBF40enE8GI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Ty3JkKM/xBV3X4M7jCqMG+SyLmaW3wMcD0MhU3niFeRhhzdSR4WX090iNAdpTvTS/
	 ItVvqMeeGVimftFxHkYLVX1z+N3llivuWCYs4KnaM6RxkqiweqvuDMdW1pXyThrL7A
	 eXsgoXjiDeMqQQhc7K6pqr4XREa51h57D6M6yZEPwjKKuH9O4as5AtQEnqAeYE+mKO
	 lvpcID9OpE+Tyx1XmHuGpOV3ssL0hO86tasPcTIM+wAClK3jag9KgmUFQ7/IidZrJ4
	 10rjGlHCS2Yv16lAA+u/vdQgpetAnZenXA/Vq4f4meNv+gpwffaqRO5nlmXeIGYN8j
	 d/PnCgWBTAfog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6276810A1;
	Thu, 15 Oct 2026 07:56:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 699681DE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5047E4009C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jiuw5V5LBIrJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 07:56:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 83D9640053
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792051010;
 b=kmyS0CeRP4KkOR4WusbZCq4SBx1NTbMgGtr4EAu/ADwqPPUhnM/yDWMhtIWbXdwTyhtC
 pcrLzDvThElMa4BcZ6We5jInaDqFYkBJWXCrwg1YCIno6ybtURlpzONVuBbXxEk9eZq9t
 MGfLdKXgJA1bdCxDOxrKmvbMDVd0tbNKGdYhjY1eGdWffHgKEyJVJ1+UfpZpfaJDeFwcl
 Q7k4B+xkFzlsfHd2aiUVMnDXqROqdm41xuClpah9N4FjdJ5aAjjk4DHHI1InAQLWf+tNE
 yriubc5eNu2vxgF8U4750qmMRfqo552XmXzfVlhWinBzrOJzrEbPYukLgg/5ftLkrKA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792051010;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=6vMCrrpixPqM1N2cFgOpKi14AhtedTWIOBF40enE8GI=;
 b=qb0JeuApyKUwoyQQiO2TEFr6Oqn1HV/lDHeDVe4MV+V0MpRvOfhNSrYWFH/gMuHNEcFK
 csttfseBZLDMZjmfUzP6lgb9mhpujxDvvqYNaCLv2qmIHzDk2/h89392sGBmW7/lHPXNZ
 blYVSIl+vKcdi+Et0wEUrB6MYN7AJeTi5YbpjW5V9PjZfQFBEGlDJSZXmoDYZ+4jpz2Bt
 4V6ugjETgO6o9t+9sE4c/GHtM5WqQ+VD+a1Agfs80gHS4SHQXvNwiAzyPkMVNL0Dtixk2
 VMEZLgyV8fDWGTSKmfsMZr+lsN3YdCSm27Qp5ZIrcKdBrb9KJg+GOQLTJ1d5+HgdIUw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CL6Nko0o; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=CL6Nko0o
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 83D9640053
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 07:56:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88E746022C;
 Thu, 15 Oct 2026 07:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5D61F000C5;
 Thu, 15 Oct 2026 07:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792051008;
 bh=6vMCrrpixPqM1N2cFgOpKi14AhtedTWIOBF40enE8GI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CL6Nko0oB/6QP1dfKEwV8coOKK0iDF/u/C2tzMijfOYpCKn4NnBlMov8PMxh+Fb4P
 OICssyqja4xpRD2RoJxqwiEZj3qQ3R3myHuyTNCThsYG0wupe0MjL3DBguLBZsclGb
 EVZwtY50lDcNfm9RdmulIpKYrGFD47QElbRAzeG3eWUxrG7ucNypECHOue7LSL1HLz
 QuwXzGibCGZSRD/FFkSqzJuZTmXtXbbNHaHECB7mAfuZsQ72tRtM8ShxthOk9MgmuI
 Xro4870Dq/m0bhjOZs5aRICmUOhFXghk8O7qPiYmpxtSoNKDxYCYmbhhaDKu4xj7Eo
 Amiq5ASQkCBSw==
Message-ID: <sashiko-outbox-172439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH nf v8 1/3] netfilter: nf_dup: preserve guard across
 NFQUEUE reinjection
To: "Zihan Xi" <zihanx@nebusec.ai>, virtualization@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
 <1eca65f844ea4eaefa9ea4a852f1db27aacc10b9.1792048855.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:56:47 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] netfilter: nf_queue synchronous bypass triggers false DEBUG_NET_WA=
RN_ONCE
--

commit 6ab1ebe7cd71aef0c99fc87d28ca2657ffc20779
Author: Zihan Xi <zihanx@nebusec.ai>

netfilter: nf_dup: preserve guard across NFQUEUE reinjection
   =20
This commit saves the task-local in_nf_duplicate guard into struct
nf_queue_entry when queuing a packet and restores it during reinjection. It
also adds a warning in nf_reinject() to ensure it is not called with the
guard already set.

> diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_qu=
eue.c
> index 477fc632657f4..1ec9c1fbae843 100644
> --- a/net/netfilter/nfnetlink_queue.c
> +++ b/net/netfilter/nfnetlink_queue.c
[ ... ]
> @@ -369,17 +370,24 @@ static void nf_reinject(struct nf_queue_entry *entr=
y, unsigned int verdict)
>  	unsigned int i;
>  	int err;
>  	u8 pf;
> +	bool old_in_nf_duplicate;
> +
> +	DEBUG_NET_WARN_ONCE(current->in_nf_duplicate,
> +			    "%s called with duplication guard set", __func__);

[Severity: High]
Does this warning falsely trigger when a packet is synchronously reinjected
during queue bypass?

When an NFQUEUE rule is configured with queue-bypass (fail-open), packets
are synchronously reinjected if the netlink queue is full. This synchronous
reinjection path (nfqnl_enqueue_packet() -> nfqnl_reinject() ->
nf_reinject()) executes in the same task context as the original hook
traversal.

If the packet was originally duplicated via xt_TEE or nft_dup,
current->in_nf_duplicate will already be true.

Because this can be triggered by remote traffic intentionally filling a
bypass-enabled queue with duplicated packets, could this introduce a remote=
ly
triggerable regression on systems with panic_on_warn enabled?

> +	local_bh_disable();
> +	old_in_nf_duplicate =3D current->in_nf_duplicate;
> =20
>  	net =3D entry->state.net;
>  	pf =3D entry->state.pf;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792048855.gi=
t.zihanx@nebusec.ai?part=3D1
