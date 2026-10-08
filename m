Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBC9CA6014
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 18:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C8F4813B5;
	Thu,  8 Oct 2026 18:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tx2bguDtoh_P; Thu,  8 Oct 2026 18:17:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EA15813BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791483426;
	b=ryfqs0tg4J0nq2oj0H2RF3CAvEx34IrN5pY+pEPMJqiHYtx2+fEO97bmanb6ilX+Unyb
	 4jsze8EVFC8mSD2pNviNpxmNDcIB/KRGCaMgkQ/zz0te4GpNSJKsHIB/OKHMvOCgOBH1K
	 JIwo2sXDK0gzlGkvy2KOez1EH3P30ST2nA5Gi39zVoTOl2rM+RREAy+O+J3l+VgXz7BL+
	 ioGatKb+YgfBaowjDmmUiQ8s76DQu4YAJnB32Cqu6QRanVdkEPW4hasMrNT3YhYP986Gk
	 4ZvyfRt+GxyuSLN2pw0ewGDxWHvDH6yDuYAP51J8cwIx6plmBxRrYhPRwdnw1KGtsYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791483426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=+YKRW4tmPv8f2DylTjG51YtABlKuN36zuKEQ8ZwJcog=;
	b=ZzymFpYGeavJNI7sdluFONd2jMf+S5c2vJRmUHuxod6JmM3CFw284w1tQSr+c2kUTtx2
	 PfvaAcNXSc2BppGfYxzRcuVvv/qVo8UZf/FlZHu0u/C/Mp7t9/jsxCApJDl5X4vqk9IS+
	 CGM5ngYLV1JuMzhah572siJVXBI/jtRUUFRBxA2BqeWqdIZTTSEUVxlRf5mkHuEBYIkQy
	 mgAyIXxKXZsv9qMmW+mG1ycPK7/b0yWf/Jlb7VCAV8PVtNWeXWC3RCfStaPP2K+nXWfPO
	 muK7l9dxO4I2FoNKSJ+WvFiGI7ltL1A13H9tDdRGUi9B+rhpHBKK3qKMXSZ1DbEzqwg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791483426;
	bh=+YKRW4tmPv8f2DylTjG51YtABlKuN36zuKEQ8ZwJcog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=9bMyCBtmIpNQWV8XDAIs1iIIqHVcNWGx7VV3iaviYJEP5hKp9rM2IeCc+MPiiaeLG
	 0dPQsQf7RwHawm2877W/FYnRAaexpCJ5HYBECY0FetLnAbu2Nt3FMf/qfVcsfP6zLd
	 yGcsiBrZ0abdAINvJvSuDNsrgthAEzhC40Bayhz1NqUpTRH4QHWPoKcm0urS/v71TD
	 Q4errO5Oy8sCj0ibLMZHFf/O9PSUub6MjSqK9XSTuHyrOetTnffZBAhBlQPQtI3lxG
	 Gj2lH2WULltx5EgNzsEaEa1LYZZ5rRd+ogbxMMgArjbN/gTGGziFYmbDrN5vN/Ql0F
	 Odg2hp/Hcw5vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EA15813BD;
	Thu,  8 Oct 2026 18:17:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A40392B2
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A21D408F7
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yhN6_69N2th7 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AD22F408E3
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791483421;
 b=OifV8Wd8KeQhVnylJT3/Pz7m1qBjkKvW8hyy7Bwgzy8eqWGGZcEsA2Pg4NgMOGUrcrVz
 F3E7Cbe/7vO2Inx3nwSsiyR9CdUjmnQrIylsb0rFgirAeHGjcqe0G0KG2woSWmAFcXTFt
 6GHPqdkFUOPWO3z/4HmarUJJf2ySZjg18Z8vfhhTQ6Gi7A5m/IexHzoiP7g1cxREqSXjo
 1Fbbffl3WG0h+p9T8O5jcIjxeKbsuOTuMW3ye2cYaywSjrcE5/rnkef8t0yEUuvTj744u
 5mGq1rmAPNjjuS6jvalaRX0/PkiQBGSozc8J31lP+oRFA3ivFqcC/IdBUMrMj14M7wQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791483421;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=+YKRW4tmPv8f2DylTjG51YtABlKuN36zuKEQ8ZwJcog=;
 b=YTKEzTC+cuFofwX0liLmhyfG3ENQWYYWAhH2GS/W/xelO1YPDXnpjdYkXNHc2xpDfl41
 lIlYxxSvTOUDSC5Z3ihNlImCki6ncAioinwMk07iRdeKC+G3ahoPtYYal8dLks0YuhEJE
 r9D9WEYiWCtGW/5H/cDPWWNT3HIcPUc3/aFVAxsfMFQ9ITdJrW0S8qHSOpzcsozW25vTj
 M/tiBfeBMKJbazr37KMPvZranc+ndwmwCYRdcEyzZFCGvjUM48PuKHiPAMSavjNny76ee
 ud523xhi5SR/zdvPNoMRZPoppNaNUonKfwYgpITWUFMKNmgjoQTVhkcvguZR7NM7U/Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cvRfmqp9; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cvRfmqp9
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD22F408E3
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 18:17:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4DA8060514;
 Thu,  8 Oct 2026 18:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7441F000FF;
 Thu,  8 Oct 2026 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791483420;
 bh=+YKRW4tmPv8f2DylTjG51YtABlKuN36zuKEQ8ZwJcog=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cvRfmqp9nlYJkuXFvMJyE3D0x+cIiRmtu9x963+m4SAtAhY9DUabkzjKsQ9onaSMo
 HYrUSOOWpYq9nGuHkts3PFpDiPYJIvbojkn2WW6Cg+rY/sp7Rw7YP+ke5T7WXGq/Eb
 U4Fq77tKb35nzR1V60Szcu3LgFhpYSevxXdiLDI7XfOCXy0qPgjg6cVVtX7JEF+2xG
 CFtmwiSvrt/mcS/GiXErU/xhuyt4dFcutAq86k59u7Qi1r9YrZWCSQut1S/B48noTm
 4E3Dq3OYGTDCVk7NzdBJtWZyysIMnndlVHru3hfdveF7uMaNebvNHH3olIERRUPzEE
 2z//w2vuBUYvg==
Message-ID: <sashiko-outbox-164448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 8/9] qlcnic: use pskb_may_pull() to pull excess
 TX frags into the head
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-8-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
 <20261007-b4-pskb-pull-tail-drivers-v1-8-9512b0fb977b@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 18:16:59 +0000
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
- [Medium] net: qlcnic: 0-length TX fragments bypass hardware descriptor li=
mit
--

commit 8b8cbbac7b14c094feb17203e37bd51a63c158cf
Author: Josef Bacik <josef@toxicpanda.com>

qlcnic: use pskb_may_pull() to pull excess TX frags into the head

This commit replaces __pskb_pull_tail() with pskb_may_pull() in
qlcnic_xmit_frame() to pull excess TX fragments into the skb head.

> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net=
/ethernet/qlogic/qlcnic/qlcnic_io.c
> index 761ef3bc8193a..4a81d499e51c0 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
> @@ -682,7 +682,7 @@ netdev_tx_t qlcnic_xmit_frame(struct sk_buff *skb, st=
ruct net_device *netdev)
>  		for (i =3D 0; i < (frag_count - QLCNIC_MAX_FRAGS_PER_TX); i++)
>  			delta +=3D skb_frag_size(&skb_shinfo(skb)->frags[i]);
> =20
> -		if (!__pskb_pull_tail(skb, delta))
> +		if (!pskb_may_pull(skb, skb_headlen(skb) + delta))

[Severity: Medium]
Does this change bypass the hardware descriptor limit if the excess fragmen=
ts
are 0-length?

When delta is 0 (due to 0-length fragments), pskb_may_pull() returns true
immediately because the requested length is already in the head. This skips
the internal call to __pskb_pull_tail().

The old code safely removed 0-length fragments by unconditionally calling
__pskb_pull_tail(skb, 0), which processes and unrefs them. Because the new
code exits early without removing these fragments, frag_count is not reduce=
d.

Could this result in a packet exceeding the QLCNIC_MAX_FRAGS_PER_TX (14)
fragment limit being mapped and sent to the hardware, potentially causing
the NIC to hang or behave unpredictably?

>  			goto drop_packet;
> =20
>  		frag_count =3D 1 + skb_shinfo(skb)->nr_frags;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-pskb-pu=
ll-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com?part=3D8
