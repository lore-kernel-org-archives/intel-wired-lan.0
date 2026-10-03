Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43627CA5FF0
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Oct 2026 15:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDA43406CF;
	Mon,  5 Oct 2026 15:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3geFgrVA4blo; Mon,  5 Oct 2026 15:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 72E74406CE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791214000;
	b=RXfYiILudB2V0ms71cLmpYpmKjnozY35N8+LDhlc2YAlKi7XVTEfL4TFmzG8FMU3hvMu
	 V+dtC3z4X1UeRaK/oi6LgOw+cUW/spqS1YDxmjtZWcWA/w+oKIfayNtzFzXDIbktrSCVE
	 Cy2jgDT2tGCAzR0wvSKiR0e5/Y76qM4nrV6V/zRfsWIfVrGhAFjL2y36IvuvfFsi3Zbt0
	 SJpFN4hhgsZJ4HZOfmctPJjm11sW4g4YZI42kOSNmFRyjze9XpW6ghcAQ+owDnlr6/r+i
	 2sI0yOyf7raXFhnp233mVE/j24ld0JgB3Fh131saR1JWX/P2oOJRDy+ptuKaFAlm3Ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791214000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:X-Rspamd-Bar:X-Rspamd-Report:X-Rspamd-Score:
	 DKIM-Signature:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bwrVY5v28PGK1OZtcruzewUpzwm+gzaeGO4vTrGfTfA=;
	b=CLOBAdUOwZL+tIjfoZhWNaWZrxpGl5u7fz2jn9VzxTyREhqLS+dTm2yHoDvPrGSH8Woo
	 78mVDUq2QEiVVDsvlFCVUcTHP8FPiVQj8e0Qimlrs5JGjjPppHLge0uXMRuPC9ad7Fk6K
	 8MRc7vzgv6PDxDEWu5+qFAqPVhR7l7jTyovMXjMAxg1v4EFiLzoQZslx0/t0A6XfeI2U2
	 ADvTVsQ3pgExcI12VhSsewVUZVCHmLz0ec10VXkEu2oAh7ujz2SUlQOG0yX2MoIXeAbO6
	 y5Q11G8DCYn8sZ7ioLLYILvt6Ms6ZIv5OtwFsDCt+fxLxx84ys6bwoC9Az0wLAOGNxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=grothesque.org;
	dkim=pass header.d=grothesque.org header.i=@grothesque.org header.a=rsa-sha256 header.s=uberspace header.b=vX741BGg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791214000;
	bh=bwrVY5v28PGK1OZtcruzewUpzwm+gzaeGO4vTrGfTfA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZCfp6UjOmTleHdTultAcSyXdr7p70Z2KCv+il9G5iBNuw2PIITwA3VaZieCQVLF/b
	 oOl6uX5j0Elxe7D143trL9zWLccFv+XyvZxB5A3XnteUnilIj7Lm0R/SSKplJx1I/M
	 lCWqZeJaTIjaWNFN/pd6Qs4eHKkWQwbpU3FJgRiKAxAoFhAbBFDDgoROJGWe0KJDM8
	 SO7nmgN1DTYWul8i7i3EupZJlvwhUJGWbY6Sl3n44159wX//9y2TpusNDDNJ7tdFdo
	 yO9NmiShNDG/stpHAUcr9zgL3lytuD2PpdYv4k1u9QKjGsIaP4fl739O5eRH8OQ5Nn
	 twcQC8e4QEV6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72E74406CE;
	Mon,  5 Oct 2026 15:26:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CD49C1D2
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 15:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9FD440748
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 15:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ccygpBXUmLFR for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 15:05:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 793AC4073B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.26.156.114
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791039904;
 b=FEgm6+1gcZJTOm0l0aYz5RSSOgkQzDsMxOw/Oxb7O179imNdJ4eGRbNZBeakEcP0BryW
 hxUvdBGsXN77GTBpUNFXyK+4bZ/dYn3/dKlRjRS0q4mpJco1Esm42bRQWYQZvHQRjII28
 rebVDHDExUExIoAs2SphZ/bJjQ30KdY9AixcevVC8EX1EWTywLWHJcXLYYCTOLAm7jAw6
 F5dSIL74Ia52AyZhbU9SqJBbmpexNES5xQc+A1H3kpArrAhOhxdVH2SDIS6pSbyH5+a89
 0eg4ZUY4xcLIq9UihcG6hHVc0Qeh565VR0K8zORMPADukss0+c+Rxi8pT8GOl18F42A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791039904;
 h=X-Greylist:Received-SPF:Received:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:MIME-Version:Content-Type:X-Rspamd-Bar:
 X-Rspamd-Report:X-Rspamd-Score:DKIM-Signature;
 bh=bwrVY5v28PGK1OZtcruzewUpzwm+gzaeGO4vTrGfTfA=;
 b=az6hJCHWVIKLvP+GWwPVrLAoxyQWNHI7NBIFOK6UvWqtrSUj6Q4m2NW4Xn+u5ji2eHyB
 +oHrLUDkz0rSujOMHhViJEfGR/8iTIaETCod3ZDI8Rc3T/eNzTFA7vIibkxsx0LBfTczj
 iWlzNaF+UkLUoe4e+umHgyT7jwHKf8dVN5+uO1asxr15+zP8Gtu7PPDhEAKNOreIVB9dy
 j8TE70lrLSf3WWRE/5LpLgoF+Ooo94DqolffQT1EHD4w9fiuPl6z6uznroy1Y9lQs3uOQ
 VfM6fhfCelM8Hd1QOc7GwNAlCLOTgY6RC3dWwGgJ98D2AZm2ac5Nv2g+WuxlL3jNpTg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=grothesque.org; 
 dkim=pass header.d=grothesque.org header.i=@grothesque.org header.a=rsa-sha256
 header.s=uberspace header.b=vX741BGg; 
 arc=none smtp.remote-ip=185.26.156.114
X-Greylist: delayed 472 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 03 Oct 2026 15:05:03 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=grothesque.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=grothesque.org header.i=@grothesque.org
 header.a=rsa-sha256 header.s=uberspace header.b=vX741BGg
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.26.156.114;
 helo=mailgate02.uberspace.is; envelope-from=christoph@grothesque.org;
 receiver=<UNKNOWN> 
Received: from mailgate02.uberspace.is (mailgate02.uberspace.is
 [185.26.156.114])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 793AC4073B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 15:05:01 +0000 (UTC)
Received: from dia.uberspace.de (dia.uberspace.de [185.26.156.221])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id ECB02180C1E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 16:57:02 +0200 (CEST)
Received: (qmail 8386 invoked by uid 989); 3 Oct 2026 14:57:02 -0000
Authentication-Results: dia.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unknown) (::1)
 by dia.uberspace.de (Haraka/3.1.1) with ESMTPSA;
 Sat, 03 Oct 2026 16:57:01 +0200
From: Christoph Groth <christoph@grothesque.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: e1000e: I219-V RX CRC errors on ThinkPad P14s Gen6 Intel; disabling
 K1 restores throughput
Date: Sat, 03 Oct 2026 16:56:26 +0200
Message-ID: <87v77ial45.fsf@grothesque.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Bar: ---
X-Rspamd-Report: SIGNED_PGP(-2) MIME_GOOD(-0.2) BAYES_HAM(-1.246969)
X-Rspamd-Score: -3.446969
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=grothesque.org; s=uberspace; h=from:to:cc:subject:date;
 bh=4lW/BssFmNITl/QT8rVYhFtSHEp3mpgUMAyeNv+oPt0=;
 b=vX741BGgH//yFAHdBwp/7itX42TSowBi0OSO6OfoQvC6GUQrZn4GOtbt3sQ96FPZd/dzebKrbN
 VK5R9jVUEFnVH8tYVkJ7aAO7HN4kXTVnxzA3s3zAUVV45lmGqpC5zPELLmDXFaRZ7SmJwYzJl0ow
 FBOH6C2bDjjo3E2C810JIP9CZb6G3R99wYznLn/8VwHoIt2Ymg6EDatzFB79L4MZEoDnSxomzO7L
 CiS2P9muTs+oC6UedS9yB0ZXk2G3Dsuy51YysaBQLNbQtrYUYf4AvxTFqCFzChE7PYejLr5eZav9
 fkHGDruB3/UORwOfq5OYD2XaJP0Hj1gkKiHP1ECGnbbwN304nZu7kg3iTVmg4VMG0tHBfH3uchQ8
 ruH0NS0GSJy0kXM9P2wX6s4E0FJygxKJraFI8Ni2ST8S0g8xCq9ddUrCV/DJpAdv3BxycnGWUXE4
 r/lCO7SLwIT1Ej9sUFA6RfJKgqOYV+fcm5CoEIM3PWl7Y/YJkV0Vvb8LZfaIuU6ad5Eh0w5SZI+p
 tgx/TiGluP+djaE/FzzESkB5U4B3DIaEFz8Uptad0jlFB+qi08ZWUPfum4Sin1spOR1ie9PRvYOk
 AE3ntzLDN5BCd5wP9Rqynp5wekwBo9vWf+wWKQOt4kw7Y3GIQhvA6s3Kw3ODRMPbuSWPZTrdVaRO
 o=
X-Mailman-Approved-At: Mon, 05 Oct 2026 15:25:30 +0000
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I noticed that wired Ethernet throughput from WAN is much lower than
expected on my new ThinkPad P14s Gen6 Intel.  The culprit seems to be
CRC errors.  This is with current firmware.  I updated everything one or
two weeks ago.

Executing =E2=80=98ethtool --set-priv-flags enp0s31f6 disable-k1 on=E2=80=
=99 works
around the problem.  There could be a relation to commit 578294b8b60d
that re-enabled K1 by default.

See below for a shell session demonstrating the problem by downloading
data for 30 seconds.  With K1 enabled, the transfer generated 125 CRC
errors while receiving 156 MiB; with K1 disabled, the error counter
remained unchanged while receiving 2547 MiB (i.e. a 16-fold faster
download).  The following has been recorded using a freshly booted
current Debian testing live system.

I=E2=80=99ve been observing the same problem with different recent kernel
versions, different network cables, routers, and networks.  I also had
the opportunity to reproduce the problem with a second identical
computer.

Cheers
Christoph

=2D---------------------------------------------------------------

root@debian:~# uname -a
Linux debian 7.2.6+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 7.2.6-1 (2026-=
09-16) x86_64 GNU/Linux
root@debian:~# ethtool --show-priv-flags enp0s31f6
Private flags for enp0s31f6:
s0ix-enabled: on
disable-k1  : off
root@debian:~# ip -s -s link show dev enp0s31f6
2: enp0s31f6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UP mode DEFAULT group default qlen 1000
    link/ether [hidden] brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
         26981     189      0       0       0      72
    RX errors:  length    crc   frame    fifo overrun
                     0      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
         10442      89      0       0       0       0
    TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       2
    altname enx[hidden]
root@debian:~# curl --max-time 30 -o /dev/null http://test-debit.free.fr/10=
485760.rnd
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Curr=
ent
                                 Dload  Upload  Total   Spent   Left   Speed
  1 10.00G   1 153.9M   0      0  5.28M      0   32:18   00:29   31:49  5.5=
8M
curl: (28) Operation timed out after 30000 milliseconds with 163226929 out =
of 10737418240 bytes received
root@debian:~# ip -s -s link show dev enp0s31f6
2: enp0s31f6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UP mode DEFAULT group default qlen 1000
    link/ether [hidden] brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
     171179576  112998    250       0       0      96
    RX errors:  length    crc   frame    fifo overrun
                     0    125       0       0       0
    TX:  bytes packets errors dropped carrier collsns
       1102954   15430      0       0       0       0
    TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       2
    altname enx[hidden]
root@debian:~# ethtool --set-priv-flags enp0s31f6 disable-k1 on
root@debian:~# ethtool --show-priv-flags enp0s31f6
Private flags for enp0s31f6:
s0ix-enabled: on
disable-k1  : on
root@debian:~# curl --max-time 30 -o /dev/null http://test-debit.free.fr/10=
485760.rnd
  % Total    % Received % Xferd  Average Speed  Time    Time    Time   Curr=
ent
                                 Dload  Upload  Total   Spent   Left   Speed
 23 10.00G  23  2.38G   0      0 84.23M      0   02:01   00:29   01:32 104.=
7M
curl: (28) Operation timed out after 30000 milliseconds with 2670737217 out=
 of 10737418240 bytes received
root@debian:~# ip -s -s link show dev enp0s31f6
2: enp0s31f6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel sta=
te UP mode DEFAULT group default qlen 1000
    link/ether [hidden] brd ff:ff:ff:ff:ff:ff
    RX:  bytes packets errors dropped  missed   mcast
    2972820757 1958686    250       0       0     122
    RX errors:  length    crc   frame    fifo overrun
                     0    125       0       0       0
    TX:  bytes packets errors dropped carrier collsns
      13144890  187359      0       0       0       0
    TX errors: aborted   fifo  window heartbt transns
                     0      0       0       0       4
    altname enx[hidden]

=2D---------------------------------------------------------------

Information from /sys/class/dmi/id/:
sys_vendor: LENOVO
product_name: 21QTS28200
product_version: ThinkPad P14s Gen 6
board_name: 21QTS28200
bios_vendor: LENOVO
bios_version: R2WET44W (1.26 )
bios_date: 06/30/2026

Information about the Ethernet adapter:
# lspci -nnvv -s 00:1f.6
00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (=
24) I219-V [8086:57a1]
	Subsystem: Lenovo Device [17aa:512b]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin D routed to IRQ 128
	IOMMU group: 17
	Region 0: Memory at af780000 (32-bit, non-prefetchable) [size=3D128K]
	Capabilities: [c8] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3col=
d+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [d0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
		Address: 00000000fee00318  Data: 0000
	Kernel driver in use: e1000e
	Kernel modules: e1000e

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCgA3FiEEP6x58QAOdlLG0jena2rszJGp28QFAmrBF5oZHGNocmlzdG9w
aEBncm90aGVzcXVlLm9yZwAKCRBrauzMkanbxNEsD/9fPmeCISF8DOUMRIwhP1/x
AqCi8Pes2Lxhv9KAoqiyKOc7spP2KbUzSsZ/StPPiknlKc7w1sxnWGycm01OnBFw
WIoK5hQ2bmpJrwXaqHbzbbzha2G+nQUokz+HOZdNtUaSo17mi+4v8NSSHysjrCr2
R4oAy6xu/dVG+7TYZzXnqTOiAuPZJ91hSJUOY8r/CJ5+5+2qnxq2B3B0uNABvVgv
tqNhOdHtPOQn3Bmfrk5pQS8l2Sz6tcyHeR0P3AAfsTpthCQKakuMqvGQHdjLkJHh
sEhOIxIYlNnpLWtsiaYp8choUZKETVXEUc6zK4ZdmzTWU2FYlG590ypiiZDZTsyX
u41f/ZIcQ9azo3a4+nwElKSYJBTtRCwC8QhOojzu9pmIZbcmzjsxO7ijhJdUbYFQ
IFktfQWNyP3QSVnKhuSqy0al6D+do/dHwDj49cDedcExV4erzudrwMvFM6ypKoAo
HJRZIntbQKGP1Q4mp5pkEyTs9aJ6kXn95dDAX7WSKPYdmCS760n6YnI+clAD4wMP
y0AeEOChL7yDaxDs9d3zlewQzDxEWp0N4y7od6cLxh4qkNbiqouy/J+Vf2i1Yt3T
0kc0FqgSAc+04VZUgLTG1iYEb1WkS+9q/fuuieK5EBR06yRnuOdFO782HqWxbpN+
BaP/qHE/r3Xjzupuo+p9BQ==
=XVWp
-----END PGP SIGNATURE-----
--=-=-=--
