Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BC2D31A06
	for <intel-wired-lan@archiver.kernel.org>; Wed, 14 Jan 2026 02:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63925616CF;
	Wed, 14 Jan 2026 02:24:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZLY7V15ybtQ; Wed, 14 Jan 2026 02:24:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9EC2C616DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768357446;
	bh=wJh7ZUFqa4fl+Y1O82cpynXKL+hZQAjunDXmzid0HFk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JWNwGd9P75ZYvp+KoNxEXCayJGMnb16wS/UObVAUWf4z4Rv4sbsfbZvRMAlVAfcKi
	 Tw9UP4tWFGavaYNJtLduv4q8SLLxSgLH82pf1s0aJIaz19+XN2ue+/DSzKEiBP87nY
	 /2pwjTI9M2jkXj2lHPiE8q8e+fmS+Vch4QYaASbO6PLNZvpGAi52qaDmxHsPi/PUnq
	 eXez8Fq1HG31NMPJ8+mAP+Y6+CLr6ePbgJJFuiOcXcKjCOFKA4UPD2yIsrIQaKhL4T
	 JPP8s+jeM8oYyVigToF2JxFxUr/OaDj4kW9eAiGR0RNwc5pUoGQv7ySkK3YkuvgmFW
	 KZqxGLf+YWWlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EC2C616DB;
	Wed, 14 Jan 2026 02:24:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8E771C3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jan 2026 02:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDB19616CF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jan 2026 02:24:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZ4GXXxrEK1K for <intel-wired-lan@lists.osuosl.org>;
 Wed, 14 Jan 2026 02:24:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2C98C616C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C98C616C4
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C98C616C4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Jan 2026 02:24:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 686F960052;
 Wed, 14 Jan 2026 02:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56E8C116C6;
 Wed, 14 Jan 2026 02:24:01 +0000 (UTC)
Date: Tue, 13 Jan 2026 18:24:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Wenger Jeremie (EDU)" <jeremie.wenger@edu.ge.ch>,
 intel-wired-lan@lists.osuosl.org
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>
Message-ID: <20260113182400.723e34a1@kernel.org>
In-Reply-To: <01412a4684684995ac35b4d6dba75853@edu.ge.ch>
References: <c8bd43a3053047dba7999102920d37c9@edu.ge.ch>
 <01412a4684684995ac35b4d6dba75853@edu.ge.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1768357442;
 bh=EInKEyER/0G089jyq3knL1VkRB5cwyxxObwgPXmL5No=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TfSXZpoN99f/bDBTdixQ/EUyg8MQQ3TFU5ZifGXAVYFGHmmAPefoSSM6ijbQj3qE8
 kOQpvycOcIp00mz69Bbut8ectlIM1eSPO1eft9HpKwCXQLtLXlh30yOWP+lSWy3TIN
 SFVvmP0ci9407DYFJNzN92lBLev2cBbJqWQMcR/Od5cWuODmF6Du4Av7ZAP9KeVObg
 Vtfhqk7YRpOBY5bqAHax0UFZLgCrE0yrA/r0/llljry8gv6JZxIXEwQTCil5+XD1Ts
 kmxMqooVt4vDnvYk9SuStCqd2I+snqNPYjOhKPw3US80rxshvrv4FRbtvrNJSOQsQf
 KXSoaX1Juae4A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TfSXZpoN
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e: RX stops after link
 down/up on Intel 8086:550a since v6.12.43 (fixed by suspend/resume)
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Thanks for the report, I'm adding the relevant people to CC now.
Please try to consult the MAINTAINERS file next time 'cause networking
is a bit too big for the right people to always notice reports.

My best guess below..

On Fri, 9 Jan 2026 09:40:34 +0000 Wenger Jeremie (EDU) wrote:
> Hello,
>=20
> I would like to report a regression in the e1000e driver affecting an Int=
el=C2=A0integrated Ethernet controller.
>=20
> Hardware:
> Intel Ethernet controller  [8086:550a]
> Driver: e1000e
>=20
> Summary:
> - RX stops working after an Ethernet link down/up (unplug/replug cable).
> - TX still works. A system suspend/resume reliably restores RX.
>=20
> Regression range:
> - Working: v6.12.22
> - Broken: v6.12.43 .. v6.18.3 (tested on Debian 12 backports, Debian 13,=
=C2=A0Debian sid). v6.18.3 is the most recent kernel tested so far, so the=
=C2=A0regression is likely still present in newer kernels.

Judging by the range seems like it has to be efaaf344bc2917cb
Would you be able to try building a kernel with that commit reverted?

> Symptoms:
> - Link is detected (1Gbps, full duplex).
> - DHCP DISCOVER frames are transmitted (confirmed via external packet cap=
ture).
> - No packets are received (no DHCP OFFER, RX appears dead).
> - Booting with the cable plugged works.
> - The issue is triggered only after unplugging and replugging the cable.
> - A suspend/resume cycle restores RX immediately.
> - Using a USB Ethernet adapter (r8152) on the same network works correctl=
y.
> =20
> Reproduction steps:
> - Boot with Ethernet cable plugged.
> - Verify network connectivity works.
> - Unplug the Ethernet cable.
> - Plug the Ethernet cable back in.
> - Observe that RX no longer works (no DHCP OFFER).
> - Suspend/resume the system =E2=86=92 RX works again.
> =20
> This suggests that the PHY or RX path is not correctly reinitialized on=
=C2=A0link up after a link down event, while the resume path performs a mor=
e=C2=A0complete reset.
>=20
> I can provide additional logs, ethtool statistics, or test patches if nee=
ded.
>=20
>=20
> Best regards,
>=20
> J=C3=A9r=C3=A9mie Wenger
