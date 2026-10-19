Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D2606A323
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=2Ezxp8ZY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79F468100F;
	Mon, 19 Oct 2026 22:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JL8N_mXkYPbk; Mon, 19 Oct 2026 22:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9523A81028
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450576;
	b=f4jtVbMFD40I+ODE8mTQTq/9nEuWF23H5Xc+ikf+x6dsi3/UAzAL5mffTWYe+DUA94ZA
	 XoQU6m2Z8q1TJ6KloMP5SRFiMYW8NLZBwSEIzzm+Uo/nEMps636MqMV5CqwW27rfvg9xK
	 pMMojNFi2ggaj+e6orLd+vhZ4iIROu4obYCUBJY5lDmywZLNOCrJ5A2I228JsvjO1HBbC
	 2sU1VKlW05jycMJfELDtTn2cnnPSjv/7jMcX/QreD1nVW3d6ypLLFbncUX8CTjLZ9XMEN
	 5GqPsuWLf4gjX7nCqQAUyTjbO8qJ34MBElAq91XnZWWUW2k7dTrgTBKs6ra6/r+7iLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:MIME-Version:Date:Content-Type:Content-Transfer-Encoding:
	 From:Message-ID:TLS-Required:Subject:To:X-Originating-IP:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=99uzCEoBsFmFYbzhgh1Nxy/Yb+YsgaZMorIz8cCZkb4=;
	b=m4jfcKnn0dEz0DflR6VZa8sRcjk5pXeOMDt24F1BoHhlhg81IqNg+tDhlaTLpTOe/dpL
	 0RUmCVKQick2JOJuO+ptlpySDEN9Z5NFts5FfW14AOQkZIX4N99BTWa0FTzmVRNtyC9Fi
	 ST1BAeQRFgHw4CQmy9gCNIMj0c6aYCLEtLmVHDi5AIASYT0esFdU1eg+lXTtYrVnO4G2f
	 b8jWlFyQpNz9ryYa4xNDScdarbaOdCHaSU7noLIyXVFAi7rtX67K8B9jXxx/ejbFZAOBV
	 XdlyDrOcYDlH4yJV0AckWWzfVJ1yjh2taN8E0Xwf83kmZ8pfNos9A6Pdm2BlVzLofzA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=none header.from=adverblaster.de;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450576;
	bh=99uzCEoBsFmFYbzhgh1Nxy/Yb+YsgaZMorIz8cCZkb4=;
	h=Date:From:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2Ezxp8ZY3Ts/n5jZWk9ZlYRjFBxQ/YYOHGJPQ4pQmiRjxrzGILgqfT0lbnRoLfoX3
	 9Sm3gT9jzAAmGeVGFRiIJ2GlnsEv2hS1LrrRZqoXeuNoSem7XbocYCKEjlBywHnFqn
	 RV6KfMk5+t1SNKOPYtP8I/E/gb/CoHGZb08FP8UVdi/OaKeP/dntyKOeHR0YKeHG8Y
	 4cqXWZ/jhzBpn1mH1CR8awpSbf0xiwd8+8oabYWYS8mbtUh0NiPBnQdBw7XH0K2cyX
	 617+X47c08dWXSfPQc1Pa2V88a9V4TPTeK1ZNa6e3/GPOBynHCVs9HQfGTetbhNFa6
	 EG0GKZopl4w3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9523A81028;
	Mon, 19 Oct 2026 22:56:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6C4E1DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:02:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C851380F28
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 11:02:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5d_35L5rvuDi for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 11:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1094080A88
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=188.68.53.159
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407729;
 b=IWlmFGFrc9rFO1VzF0pozgdwmmpQ82OfpVMEImrBOQKJydejtGNKnNvWmciDSj37xMMV
 6lZoxgvUVp7uOterMpJbKAJBwXh1/lVeh+1H1n2IXDEYxCH/fk3JpWVrnzf+E0n64Qdl1
 C6P1EDUYaryJAka9cNsC1wrFUB1qrkIoYtx9CXsS5UyGRWVnPXJpMlGvNYObpwOAsu0Rx
 pf2FCXZdyitI6JWg+koRjufSm0Ymxwq0H8HpiujTaE7NesW8eADvzcL4F6Uvmew0zsfID
 Z16GR0fTs1T6BX9ww1su3JW8NOCBtvIiJAnNHPCtRgGKO6cim9LHJgKUWdqSuDb9m2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407729;
 h=X-Greylist:Received-SPF:Received:MIME-Version:Date:Content-Type:
 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:
 X-Originating-IP;
 bh=99uzCEoBsFmFYbzhgh1Nxy/Yb+YsgaZMorIz8cCZkb4=;
 b=dvf4WhWCqSkyv9KXQR7yN2gjJVf3jsuuJGfMeCdC8F9x/YnjeHc/0yuaIAFwZwzEPjDV
 BvKFmV571gHbD5Ft4/VjvB7d1tPOAHPHJ9H48vRXPgjDqKoAe52pipSa/eJsOZpqJ/rZj
 8UHBKU5bMmYvBHX+9r4Fokue/TtIycN49zznllIADZZhaLDantXYe+jrpGdfHE605iU34
 of6BIkMaVs9HhOVjBiE6xDSOrclwnEZTtzQrapGv7HOVVCq3j3vTBkb9e/wGn2UcFHlV5
 srE8HGawkoCzL2AHKRbsokGkVF+6etZqyJ536d0mN/Hn5wX/rDwtIMx/sgWPvc6aB7A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=adverblaster.de;
 arc=none smtp.remote-ip=188.68.53.159
X-Greylist: delayed 524 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 19 Oct 2026 11:02:09 UTC
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=adverblaster.de
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.68.53.159;
 helo=viki.sutter-it.de; envelope-from=info@adverblaster.de;
 receiver=<UNKNOWN> 
Received: from viki.sutter-it.de (viki.sutter-it.de [188.68.53.159])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1094080A88
 for <intel-wired-lan@osuosl.org>; Mon, 19 Oct 2026 11:02:08 +0000 (UTC)
Received: from mail.isweg.de (viki.sutter-it.de [IPv6:2a03:4000:6:e043::1])
 (Authenticated sender: timo)
 by viki.sutter-it.de (Postfix) with ESMTPSA id 57ED37F76B;
 Mon, 19 Oct 2026 12:53:22 +0200 (CEST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 10:53:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: info@adverblaster.de
Message-ID: <54ed8ffd0c802970d94b92c3de2ddd8e08d2e587@adverblaster.de>
TLS-Required: No
Subject: [BUG] ice: VSI open fails (-EIO, "Failure Adding VLAN 0") after S3
 resume on E810-C-Q2 (resend)
To: intel-wired-lan@osuosl.org
X-Mailman-Approved-At: Mon, 19 Oct 2026 22:56:11 +0000
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
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

after resuming from S3 (deep) suspend, both ports of my E810-C-Q2
are unusable: the VSI rebuild succeeds, but opening the VSI fails
because adding the VLAN 0 filter returns -EIO. Unloading and
reloading ice + irdma restores the card every time. The issue
reproduces reliably on every suspend/resume cycle.

Hardware / software
-------------------
NIC:      Intel E810-C-Q2 [8086:1592], subsystem [8086:0002], rev 02
          PBA K91258-011, 2x 100G QSFP28, RoCEv2 (irdma) in use
Board:    ASUS Pro WS WRX80E-SAGE SE WIFI II, BIOS 1702 (08/22/2025)
          AMD Threadripper (WRX80)
Kernel:   7.2.11-1-cachyos (in-tree ice and irdma)
NVM:      5.10 (0x80022601), fw.mgmt 8.1.1, netlist 4.4.2000-3.29.0,
          OROM 1.4113.0
          Also reproduced with NVM 4.90 (0x80020ef2, fw.mgmt 7.9.1)
DDP:      ICE OS Default Package 1.3.43.0
Sleep:    mem_sleep =3D deep (S3)
Config:   MTU 9000, DCB enabled, FW LLDP disabled (DCBx/LLDP in SW mode)

Steps to reproduce
------------------
1. Boot, link comes up at 100G, RDMA port ACTIVE
2. systemctl suspend
3. Resume

Expected: both ports operational after resume
Actual:   "Failed to open VSI", no traffic possible

Kernel log (resume)
-------------------
PM: suspend entry (deep)
ice 0000:61:00.0: PTP reset successful
ice 0000:61:00.0: VSI rebuilt. VSI index 0, type ICE_VSI_PF
ice 0000:61:00.0: VSI rebuilt. VSI index 1, type ICE_VSI_CTRL
ice 0000:61:00.1: PTP reset successful
ice 0000:61:00.1: VSI rebuilt. VSI index 0, type ICE_VSI_PF
ice 0000:61:00.1: VSI rebuilt. VSI index 1, type ICE_VSI_CTRL
PM: suspend exit
ice 0000:61:00.0: Failure Adding VLAN 0 on VSI 6, status -5
ice 0000:61:00.0 enp97s0f0np0: Failed to open VSI 0x0006 on switch 0x0001
ice 0000:61:00.1: Failure Adding VLAN 0 on VSI 8, status -5
ice 0000:61:00.1 enp97s0f1np1: Failed to open VSI 0x0008 on switch 0x0000

When unloading the driver afterwards:
ice 0000:61:00.1: Failed to remove Rx LLDP rule on VSI 8 error: -5
ice 0000:61:00.0: Failed to remove Rx LLDP rule on VSI 6 error: -5

Observation
-----------
During the NVM update to 5.10, the firmware was activated via EMP
reset while the driver was loaded. That rebuild succeeded, and the
log shows the DDP package being downloaded again:

ice 0000:61:00.0: The DDP package was successfully loaded: ICE OS
Default Package version 1.3.43.0
...
ice 0000:61:00.0: VSI rebuilt. VSI index 0, type ICE_VSI_PF

The rebuild after resume shows no DDP download at all, and then
the switch filter commands fail. My guess is that the device loses
power in S3, the DDP package is lost, and the resume path does not
reload it. I have not verified this in the code, so please treat it
as a hint only.

Possibly related: at every boot the kernel logs
pci_bus 0000:60: Some PCI device resources are unassigned, try
booting with pci=3Drealloc
(the NIC is at 0000:61:00.x). In addition, every boot shows
"Failed to add generic LLDP Rx filter on VSI x error: -5, falling
back to specialized AQ control" on both ports.

Workaround
----------
modprobe -r irdma; modprobe -r ice; modprobe ice; modprobe irdma

I am happy to test patches, provide full logs, or reproduce on a
mainline kernel if that helps.

Thanks,
Timo

P.S. Sorry for the noise: my first mail on this topic was sent by
mistake due to a misconfiguration in my mail client. Please
disregard it and use this one instead.
