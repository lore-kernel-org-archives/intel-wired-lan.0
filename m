Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6ED606A321
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=8CUse2JU;
	dkim=pass (2048-bit key, unprotected) header.d=isweg.de header.i=@isweg.de header.a=rsa-sha256 header.s=2021i header.b=OgmgkZGS
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD6FB407CA;
	Mon, 19 Oct 2026 22:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-ijNT7rcP3u; Mon, 19 Oct 2026 22:56:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A9BC1407C8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450575;
	b=FKWAx9v58XInXKRMa577yxjdggTYt8srRnvPDob+ZNv0EjQ5nZFvqA3Yu3ZxlcBl4grY
	 B0qdIy6fcOes9/Yr1n+4vqZAZ0HW5fdXpt8k6QvuZ6uf8kAyicstFHx3OJxJnzwey4dRV
	 vEcpvtE451VUHaB4+Oy0JB0c6TIKh9dY2l5Gm5Y5a0wjZW510DI8zg14+dcXZVSANssZZ
	 /1V6goB9ULprWeY4KLX6MgGkuScU7LjnPPyBaHKCUg1l49GpF4BTCyVKebgPKegG+JSHQ
	 Ob21y0zDRaBQuekZT4xg5mkZX5Nc7cMv34PeLlBeqAJMIgC4CnPmi4u+ud9yg0pBlmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450575;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:
	 X-Originating-IP:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DQ5Zun/35P3cktP35L81EljoKn1BORxWPZAaGc2ZLGo=;
	b=E0wrO8kftoau/QPOS+I0RLtLhl8VlS8r4/h+Z00kQ0ULr0LZ04udYWK2gMHUrsCJxYOe
	 Qemz/uhgywMiRbUEjv59AR43S3DgLNGVATXp8oyC7W8ddML5B30eKJOrEBu5Ollt7f167
	 N2C+73o0gqxBa5EQwIbzp7Qp0htoXSkeEWZzTUnLAt9FIevJ9OcLJbQ3rfRvePgBaY3Fd
	 5wnYtWkwUXpjQkDO3jfugjc0AM51oFZm2nIJltgiF8Nae0a/Zz7f9yyRRpDmNxAW0DIRe
	 0cRpMk2zjFnjZmNyYLdO7jzDf/JzaCqX8LeDMNcvoxSrKTvRLfRMSCYKsnylHCav57A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450575;
	bh=DQ5Zun/35P3cktP35L81EljoKn1BORxWPZAaGc2ZLGo=;
	h=Date:From:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8CUse2JUy4aDWKwa1yI9Fv4C7trNKE9SyuCBQxAtWd8aTMS5fwUZIcB9VV9ZQoyWl
	 II1z+q0qVaji0UrvKFFbDUeaC4VbqIu3+v0MMPyPcJ5PEetfDJ5DdWeirY/Cwa9vpY
	 Crpar6c8X3H1Ou/octIznowDMeAxnBEkmb37f+pACwlLIjysEKs08GaJaXyB9ZLLYt
	 3yXOwl4p4tGOzUGuMG1sWxwX1E3N3CqJN9QBhppNOv4p/j2S38QdGFQWc1Q/OMgtls
	 TRZk2Q7GOq5p1S1e045ZPa4YsSv1yCMUO2ydTaI2ADtbZvOz102aP9rqSwgbSPaZeO
	 xcudxpuP/7AFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9BC1407C8;
	Mon, 19 Oct 2026 22:56:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CEB05263
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C082C40080
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 10:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmMHE51ZQEvI for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 10:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D526240079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a03:4000:6:e043::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792407430;
 b=Vz4D/oIgn8aoDESCITaR1M544BQX6sXh5BVoHBv9TKhbMi4KNcuWM9xDoGv8U5FWmOIH
 y80yG2+m4P/2d9sXbPJRILujYjTobra8ADz9r57iJewNpEcFBH1ObVYRpSxPmGzG6AVVc
 6EdfA4Qxheo6Tkqo33vHpcn44lPOKNXpvBFvVVQ11CYq1Vokt8I7gj2Y1Z5NmqGAU4pKJ
 5smh7QbGx1XPTdB0zC/itWBP29y7B+vji6bLMkck5/cz3rWpmNkjTa9rglD487TzLMc+P
 I/OhVkmhGBinmk5mT3BQoPKDwx9D937rsZByDZw7rDijNWryxj4Ppjh7AhTCEk2a/5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792407430;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:MIME-Version:Date:
 Content-Type:Content-Transfer-Encoding:From:Message-ID:TLS-Required:
 Subject:To:X-Originating-IP;
 bh=DQ5Zun/35P3cktP35L81EljoKn1BORxWPZAaGc2ZLGo=;
 b=DQ8e1j7EtK3VwaLBk5sh5ybX/Ou4QWtwGFNrZSVLdZviGTCSkwSXcfQ906JRlfx4vhmD
 bWXBka0XiXtyuSfQj5eaA1etCRI2xnMrsr7YOzy4mWJRztGZ6CPO8p6wLBDtsGFk/XfXZ
 CFz7KkHtXAUdAjMgp6yCPDIIWLx4bBi9Hkbbj9XBGt3fa9XZcmGiD5sv9nzDHorlWhfg3
 ZhIapVsWptzqPUM4sVnDtw8YUhcD+xUUGldSUVo6DzASbPU++JnXFfgBVJqegp5jKQx+y
 weeprs+SNRf22lMMquGRTvsDlulFvUd9CCTI869bei03ossT8wXQud4dRQ70eRRcVMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=isweg.de;
 dkim=pass header.d=isweg.de header.i=@isweg.de header.a=rsa-sha256
 header.s=2021i header.b=OgmgkZGS; 
 arc=none smtp.remote-ip="2a03:4000:6:e043::1"
X-Greylist: delayed 516 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 19 Oct 2026 10:57:09 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=isweg.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=isweg.de header.i=@isweg.de header.a=rsa-sha256
 header.s=2021i header.b=OgmgkZGS
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a03:4000:6:e043::1;
 helo=viki.sutter-it.de; envelope-from=timo@isweg.de; receiver=<UNKNOWN> 
Received: from viki.sutter-it.de (viki.sutter-it.de [IPv6:2a03:4000:6:e043::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D526240079
 for <intel-wired-lan@osuosl.org>; Mon, 19 Oct 2026 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=isweg.de; s=2021i;
 t=1792406908; bh=RhmRaHC8r7YLsJv2rmFGEI7XcHwanmJlwi0M0WcB7zE=;
 h=Date:From:Subject:To:From;
 b=OgmgkZGSYHjsBwO6GlPK50r8s/nkjTExp74VPCk7XnUk2tgYBXGqjxY01an+8ZY0K
 vfCw91Z8iXlH0KveWPFu4hulpQ8bVr5vHPrSWnVcHvyjSRYcOGCgJMaihtYaI36P0H
 dsFIh8BgBkVqizBWEniqZpHOxZOYSjsMrLwtwnez9ns5DKjsMNOSjAN+MjZOLQeygi
 f3rm+eA8wJWLDOfQfieHOoyhybMM1GVuUuefVPk7veHAwl3MwGp0+TDPL1Mx9XB+58
 Z7BYRlbMgrZSy4F8KKRVVogEnpodFDQVjRzLNDx+y1994OzdLvhWk1XCiP/M7g69j0
 WzfOcfHItrqSw==
Received: from mail.isweg.de (viki.sutter-it.de [IPv6:2a03:4000:6:e043::1])
 (Authenticated sender: timo)
 by viki.sutter-it.de (Postfix) with ESMTPSA id AA4D87F262;
 Mon, 19 Oct 2026 12:48:28 +0200 (CEST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 10:48:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: timo@isweg.de
Message-ID: <362f7fd1a54a726b57976c983561ec34d612a6f9@isweg.de>
TLS-Required: No
Subject: [BUG] ice: VSI open fails (-EIO, "Failure Adding VLAN 0") after S3
 resume on E810-C-Q2
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
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
