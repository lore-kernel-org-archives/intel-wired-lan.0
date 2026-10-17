Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDBB606A319
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=sY6+puSt;
	dkim=pass (2048-bit key, unprotected) header.d=mser.at header.i=@mser.at header.a=rsa-sha256 header.s=kas202607210106 header.b=oMsTZbY4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59FCB407C6;
	Mon, 19 Oct 2026 22:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4tmwgXIUQGK; Mon, 19 Oct 2026 22:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F3E92407AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792450573;
	b=tKPuwryxm+c6+3QcpszQIdMQQK8WkpMTWLHiTB+KCqUd0bymNc/JVKmWvPueIA+BpGyZ
	 gsPMVslgw4VikaQJ9XJkKd4j0ClZ6O1UzuDR0wUFKAV1/Ha6nwLIvVBj/tdTjeSHJWT00
	 w+gEgWjxcpEq6c1ryoK4e5ie3vMEOQrqVHy+Q0N46etBwm0D7gXa67BP0SnYBBkP9Z0Cs
	 EduhMlY8PE/jICSWae1qjmNduA5ERczKCR2djFXkvRBk5sN+wDcKqc0j6b35vRV3/PEYX
	 6HN9/KQeZPMqqYAbw7ZSb0VMJaC2PQLybTqHMs2BSeo+ky+yJiyIKIp/cbEl6x1zz6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792450573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-KAS-Sym:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-Spamd-Bar:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=CGhY1j5WWDRuIQj1Il7dEANey+L6PXZwc9JnpFqRboE=;
	b=htNouDM4N309K4yCWEryvbY56F/UqD1lIlbfwDIbn1RncJxZTGbDt5nyHj/upYgvaBgp
	 BNI2WyVRg9ZbSliVSuXdAsjQoa06mUOFi+z8in9R6Lpwbdz9jb8akYxTEQnxrHpU/Mzh8
	 7lrdhpDerNrh6nkV99yE5DXXMtelqAwG0E5PktP0g0eJIpFuUAs0JZsHIMPdTwAL7CNHd
	 Vb7co+FMmEcnO1Uu322IDU3YeyD4NJhO4c8Sj9qMRmDBNXTyJo+7iVzAwTYGBj/bOM5rj
	 tgA2saQhdtl7ZJmdi5PAvWfFv42J9EB160l4QaHEYAbkoO4jhFyib0R/xnjn+DBDwQQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mser.at;
	dkim=pass header.d=mser.at header.i=@mser.at header.a=rsa-sha256 header.s=kas202607210106 header.b=oMsTZbY4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792450573;
	bh=CGhY1j5WWDRuIQj1Il7dEANey+L6PXZwc9JnpFqRboE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sY6+puSt+LlDQDYdjgQcGQTgmxaHxlrOd6DiDazu3w75Ac/90A+uJhreTv5zaNylF
	 F2F75umSa+P/01+oo/unja8GUxKK5a3XcDmoKJlb39vmNbPIkAQhg8Znmr7b2wDYZr
	 y+EUBtZ7n5PQb/jlATnDqmoC62mlK9K9Lm9Vk5blVedfdIJeH/d9f5QuHZjlqJliX9
	 SdKRJm2BKJyfQX6869ZkfntO3iK36M5IqzO6lEHvW3mB5usPekxMHtkB9C4ceH/cc0
	 nJQ45mhltlaZJNgYr7fHnzQ+e6W1XhV9gakI5bBQvwsS2I6TBpj9t9EfpMWEWcXCY6
	 /XgIZ0c1cu00Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3E92407AD;
	Mon, 19 Oct 2026 22:56:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2759B105
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 10:22:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D8CB409B4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 10:22:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WJZWFd8MsYEo for <intel-wired-lan@lists.osuosl.org>;
 Sat, 17 Oct 2026 10:22:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BEC41409B3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.13.131.59
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792232570;
 b=TBVrhBpEEzfXEuZUHS9a9JMusOfV/gRF36WHsshAcOAX24mMTYt9+JlQkSo1hxwGjanw
 DwoT1duCqy03snyQSa9HLzzadKFCJunoDtbgQYAJtBnWn1q/3HXmpjsTSyxVGBipG+OBU
 jFnUYkXsI7xBBT48BIXkJi5oy8fQg/Ee/MDLY+CmXYq2LhG8JYsCktb9fqUvX2iFqUMgV
 lVdOJwUEVBQF75mGqN7v+2wGTiAPAxhTsNp4iaBuVqNnqfnyolLtwkV2+h3xkGzEEMHej
 z4uk1MGQlyRP0gjg3A1GvTo5ejte4CgwIB2Z50LoiVteHf8MI2AKAF7aRLtfQrYI5qA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792232570;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-KAS-Sym:Received:From:To:Cc:
 Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:
 MIME-Version:X-Spamd-Bar;
 bh=CGhY1j5WWDRuIQj1Il7dEANey+L6PXZwc9JnpFqRboE=;
 b=aTE2RRa/0WWjjZgNYK/iFEgoB1gdsi7h2E2nZDZynwMREIs3F5Yo9LVLOijnGm6rRQVu
 qc0t/TvyaVFa+Es9JtQ8cPCjzNDq3wm+t51EiHIJCixnE2qUPv+S5+RvI0DmTwReHW3t6
 mb5W5DThjHSeFVeWyj7utEmz7mchlN326fFTioMC0o2RzDBYSb++ktOULkb51a8Ozcid9
 Kpny3jVti41hg4UbgSImvKasd/in3l+Ob621InB1fnLQ93eTyfxVfVMA9hWK3Yfxw3ap1
 5n6MRDLfIi9kFzOlrKlv9jxlPp8UCMFfmyDucmRW2C59ECQcutxDpizlbAx5OsNf6OQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mser.at;
 dkim=pass header.d=mser.at header.i=@mser.at header.a=rsa-sha256
 header.s=kas202607210106 header.b=oMsTZbY4; 
 arc=none smtp.remote-ip=85.13.131.59
X-Greylist: delayed 424 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 17 Oct 2026 10:22:48 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mser.at
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mser.at header.i=@mser.at header.a=rsa-sha256
 header.s=kas202607210106 header.b=oMsTZbY4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.13.131.59;
 helo=dd30414.kasserver.com; envelope-from=dev@mser.at; receiver=<UNKNOWN> 
Received: from dd30414.kasserver.com (dd30414.kasserver.com [85.13.131.59])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BEC41409B3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 17 Oct 2026 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mser.at;
 s=kas202607210106; t=1792232140;
 bh=CGhY1j5WWDRuIQj1Il7dEANey+L6PXZwc9JnpFqRboE=;
 h=From:To:Cc:Subject:Date:From;
 b=oMsTZbY4SL7Xi8DAu7d/aYpI04VzQeovBO2rxmS5R/uHmY9aW/SZPNQpQT9mgw0QC
 ALCieFKw+h0uil7LISnJhn/9alBJl6BlJ4omtxuBlW9m4LStW5E/GtefAmmW2EjtH1
 zky83O+NEaQwu3hXTrme2rzfEXQkQM2vRN/rzn21HbGRzNE0+46hC7+F8KpOb7NubH
 Sd1apTyuna3Ae8wBZdtjx3szk+0HYvgn5nuwi1ZWPp08TnCtOQMYOo5Cq0GrLd/oA5
 jOweDd3qS0o2yaqw6+HXhmqc92GkadEK2DbywCIG4345wQE+JpBtGYBhAyoahxpnpK
 qMx9zS6WlqDjA==
X-KAS-Sym: v3:f51bdf72230551df:KL96b82JnBvxBVxJ3ViTV0fFYexrc9umwBgZIAwwdJqGj
 3xyZaY9+eM4tTRkccUcGnXxh4f+qznOGrs/Adhj6Aj5XC4gXBW820R191HABSXM9NidEeN8E3+n
 gVxLZ6gtfo/1dFR0VfKpdLCOfcFhokqbmlZPFzn6XWTcXK41SjHCIfHFeV02ONZgDDYJPoQvjrZ
 Ax7xtyt3COMA8LZNdDJ9/CNad2eImpPJJmsCuhu8nn0/3wWEOeMyl90Sfg5s4XEdh2Tq49GkLv8
 qRUXBFZuMCYaQ6ovFpVzGB3eb4BCZCltS4fZnmZdUWOkM2dVCx0GLrkITY9aNf6ZWhR7ALYw==:
 nh7ikQqpUbBvYN27iR3kwS86UFVfHADlVzoJ6g4o98k+QEQpBybMAf0mqk3ohV2KHr27595+D1m
 pixJjhcsnAW7jR/eQG2g1yOiSvgHjEhsSm5mTwi6eJc8+CSe357SZSBY/HC9DnyGKSyvwJ9iTaF
 G1oRxldyRUtH1C/bXmhGjkmS+isfg5yyYI2Q5ovORX2IC0pZrIv5H0R2d72YDeK29D7WZdlxEzp
 HuphS4qfGKQ9XBemxozNiFwECAwH1qhMa+HJfB2GNz0QTdDn0+aikSD6lSSgCrH0CFfnFC7Ftw8
 OLmG0xvvM8y/pS4Hx99dcM6+/m6wLh3hpoclx+8mkl7eudJFucquVXzhuiNmpUdJlANmS+NKGme
 Tq7G1CHMW/zbC2BYa4JFYKHY/SgxSPfRrsowjV2s/KdLsfSHS5XBZ+vLJe2zb1j1TZd+2cNfCqo
 1C+xftq/iI7EHlpXmxggHcevXP7a9X1yH0oHr9f1UaEyhfwC0f77NJSQ0g1jFfqKbjuBO4lvilA
 UtV0nBXrTajJlV/Pbwuub+gdDB50y/ttU1kiemsoCYPlG0=
Received: from report.eml (178.113.74.246.wireless.dyn.drei.com
 [178.113.74.246])
 by dd30414.kasserver.com (Postfix) with ESMTPSA id 232617F047C7;
 Sat, 17 Oct 2026 12:15:40 +0200 (CEST)
From: Michael Serajnik <dev@mser.at>
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: igc: I226-V does not wake from S5,
 PHPM D3 link-disable bits never cleared
Date: Sat, 17 Oct 2026 12:14:45 +0200
Message-ID: <179223208565.28107.1987245697366860479@mser.at>
Content-Type: text/plain; charset="us-ascii"; format="fixed"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Bar: -
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

Wake-on-LAN from soft-off (S5) does not work with the I226-V on my
board under Linux. As far as I can tell, the cause is that igc never
clears the D3 link-disable bits in PHPM, which the NVM sets.

Hardware and software:
- Board: ASUS ROG STRIX B850-I GAMING WIFI, BIOS 1063 (AMD B850)
- NIC: Intel I226-V [8086:125c] rev 06, subsystem 1043:8867,
  at 0000:0a:00.0 behind an AMD 600 series chipset downstream port
- NVM: 2023:889d
- Kernel: 7.2.9 (Fedora-based Bazzite kernel); the code paths below
  are unchanged in current mainline

What I see:
- `ethtool eno1` shows "Supports Wake-on: pumbg" and "Wake-on: g".
- BIOS: ErP disabled, Power On By PCI-E enabled.
- /proc/acpi/wakeup has the NIC and every port on its path enabled.
- After `systemctl poweroff`, the port LEDs go dark, the switch sees
  no link, and a magic packet from the same subnet does not wake the
  machine.

Register read:
With igc unbound (strict devmem refuses the mmap while it is bound),
I read BAR0 + 0xE14 (IGC_I225_PHPM):

  PHPM = 0x00045298
  DIS_1000_D3 (0x0008), DIS_100_D3 (0x0200), DIS_2500_D3 (0x1000)
  are all set (mask 0x1208).

As a sanity check, RAL0 (0x5400) read 0x62e7fcbc, which matches the
MAC address bc:fc:e7:62:d6:2f.

These bits come from the NIC's NVM, not from the board firmware, and
FreeBSD bug 282140 (below) reports the same link-disable bits on other
hardware, so I do not expect a BIOS update to change this. [1]

With all three speeds disabled in D3, the PHY has no link while the
device is in D3, so the magic packet never reaches the MAC, however
WUFC is programmed. In mainline igc, `__igc_shutdown()` sets WUC,
WUFC and CTRL.ADVD3WUC and calls `igc_power_up_link()`, but nothing
in the driver clears these PHPM bits, and igc defines neither the
bits nor a D3 LPLU operation.

FreeBSD's igc(4) has the same problem: FreeBSD bug 282140 describes
the same NVM default (PHPM 0x00045398, same 0x1208 bits) and a
proposed fix that clears the D3 link-disable bits on the wake-arming
path and restores them when the PHY is powered down.

Could igc clear these bits when Wake-on-LAN is armed? I have not written
or tested a fix.

An agent (Claude Opus 5.5) helped me analyze this problem and write this
report. I ran the commands and checks on the machine myself and read up
on the background, so I can follow the analysis.

Thanks,
Michael Serajnik

[1] I have not updated the BIOS yet because of reports of dying Ryzen 7
    9800X3D CPUs (the CPU in this machine) with various BIOS versions,
    and none of the newer versions' release notes mention anything
    Ethernet-related.
