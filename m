Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A2606A333
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5KW1VWxV;
	dkim=pass (2048-bit key, unprotected) header.d=clicseo-com.20260707.gappssmtp.com header.i=@clicseo-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eh0CSHqi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 35C4280281;
	Fri, 20 Nov 2026 16:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4K2nTENCs-m7; Fri, 20 Nov 2026 16:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 509E8816F9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192388;
	b=EIlwgzK0q4WvzQ0WlQT8m0uuc5ttVL+4iTz4JCjf0UL+bvx+2l/34vcdCir0Oma/ET8R
	 MELhHf7sBQNj2HE++J/wTT8vpo+7uav71A6sQPX4VY6jkgPBGZmDTl243sEFthwP9krjB
	 2O7tHGbxRD8jQ3wLnQQJUiyX3cL4PSNSivUxg+3DQoe4eEIzBwUzEDczicHoJs5gydsZx
	 +vRz3Y5uHcbHQZPFXuqC4lZ7dUjOSg6R5FPpXDCG3wTjvpoTfdNFzpKecBLZdJeMoEkJ5
	 z0eYF8WX2vZAJInM/SWmje56aAoGO/PNgcAoD3lE8DPYix7gEmoVXV6h4fWqVCTWAVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
	b=shjIAOsZpUMksdVbfn52bUFZqUUjaASCYOhjVekYnxfJFjYzSNf+2hSSdVKYWdWYL9c+
	 jeNPwQiaQdmeTpq7jZlDYLIUW6iR3aysADRlvJwRTENUBKapQJ5ebR3wrV7SeRUUaCmqs
	 lXU1NYY6Bj/DfBNd/iepvXIHMQfGPSHvCVvSvGB2Vq0Fco0RZZFkyWU+4xpPjVAmg0a/Q
	 iQ9XQR/uZgub7rc+9+6HY/2i/w2L/jJlSoVSN52ZzVPwtdzUbPwTZA2M+dTBkalaBonqv
	 OwKqAvybemmTc2TCTfhMcGMR5Crz/rQh5+pFGnS4a/wpwnDvDEoKUdArrdHGczBRg1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795192388;
	bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5KW1VWxVC17vYNsMocKaL3Vhz1lwfFz0EZ9e9cp0hzZZY5Llml9lxA4xV+EhAdRl2
	 OA0eRCIBPeHr5pT3Iu8IzWEl9M//gvd0tuOjLLWRQfskjwLrZpYxMFmFfiqPqZxMUd
	 ukoKr2wi5MXAF6cwKb/ZEd7+m2Ybc29ZyoaQWtLde67K5rSLYIXD3mg0pq7xCJ+gRg
	 2xegL8nA/gx4Rpt3lG5CgwrYBpSFQNKsOvu9CpfS/y964CXkITo3Hegr31HlEdvIbd
	 MdyiF4UzVeWrujpg4ksQG20nJTk85aR/IgjWm6WsP1eHvhHgyh+Z2tv3SLRfcEHQoU
	 hNcdaKCMa6Scw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 509E8816F9;
	Fri, 20 Nov 2026 16:33:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AEA8F169
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 10:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A05A440A25
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 10:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_EHPLOMRpLR for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 10:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2463C4016D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b131"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=gabriel@clicseo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=clicseo.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=clicseo-com.20260707.gappssmtp.com
 header.i=@clicseo-com.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=eh0CSHqi
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2463C4016D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 10:33:42 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67dabd38cdfso1039777d50.2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 02:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=clicseo-com.20260707.gappssmtp.com; s=20260707; t=1795170821; x=1795775621;
 darn=lists.osuosl.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
 b=eh0CSHqiVBG4vyvp7jOIBgznV3tXCCueRPVaa6U0jHZyUIOKNEKEaWE1JbLjHnLBCS
 idglgTkf+i85/uwhMIYkejXxTFqOHDUTTuBCQk+pJ4DyBcPU3Mgfw49fSF0pjTFjFZmK
 9/iVTpen2aYPJx9Y/ASv00pN8DasJgBLr1GZXR2SExn6b27b0imyguhu9zBFX5Kb8kFP
 bMXecyFA5HlGrYQ2N4D5XAdnPDtOuthVcrZrcvkirxVGFMoa+M9H8NJj3QCV9UcRGuiR
 3XOKKV7ia/mA8SbChNcPA9DejxVk4ex5e0tb1/Yh9Mo/htk7MyrmrLRfSM+9R2POXcpC
 wzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795170821; x=1795775621;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WTrFO7DU8RvVQbAImxppUK3wi8vLJGpJ6ax41KF861g=;
 b=jr6Ete5fWoD7taTFSTRd7n62awqsUro52pq1MjQL0qp/u/xfMjA5VUH3zGOaeuoQP9
 KySAyoT/I3/n3zxzO2/ThIfk3HiTOIi8hl+vk/cNkaVKu9muht6oCvAH9xE6H7CuO068
 40bm/c2dunN2HqZVxVCaVRq1+AqfmLniNbiXzenxrW8STdKLirdao8hLHR/5QSDmDaMS
 FgW449u7IXUWcsG7E1+UETstF3B+ABsM3DrnydqoNXJCkXjgOh6oWW3AxISsOHr3dmYD
 uy9/7s8gVWE1nXYVkQjNbLnsQEbrnjrMraQem35+mNcyqlsBu+4MFesoozDH69j4LBLl
 KtYw==
X-Gm-Message-State: APuU4Z9PyA5hMOmRIAnwnn68FEqxKNFSoLr8dFadrCwwgpBEy0DHnSio
 ZmuKgSnBfafnssvmmQJXsXq8NWIGhtTLiGMTAPxW71FUBnUS8INphLM3hEM/OHz1NmTxx1AHMrE
 e0peXsqQwgZcuy7K5EceFI6lDuHICh+WItDMvXOV33LEZKsByl3QHeYud8w==
X-Gm-Gg: AZFdTZdDnd3lfLU5brSaQQvwUqLNmLwFELudPrhK4hgdO9kA0rFI/ZW2edpqqwzfbqn
 ofae595YHJKsPBJ5TTwxXerzvnLyajzXcMlVVwgWxqdy2RC1MTYRPqPOKohxr/qndHNNrQ7/21G
 tK211huo4oSET1PkgSMYlpEcp+vY7AYbRsU4ZrmBdhaCjo3tepbo3zSiNJI3n+OgZxdgH3+c1fb
 mfEwbR7yxDKQdbvTU918AsaURNg4jd8IKb9RYPj+vzdJCSstNeG7lGw7/GS6qISFNdh3EmYpeC1
 lhyDRjy0lgf9IQOre023SSshJR/DhO8XQoIXNmV08ziEJRa53cRvNNK7qAa0Q68M1LFXfbB1zRk
 +wG6nspn3QQMgG6YANe4vOLg9A9++ieuK3Wi4iregGUJ9jFwaX8L7LL4aCaBxnFXiubv8t9EFtV
 MOpazMgsf3D93CQKW6rRdVrOVT1WlGPUyspGdMXINrFesz+a5PMpphfOjaVFs+3BPOwXaqeM8=
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id
 956f58d0204a3-67df4410b69mr1252882d50.55.1795170821618; Fri, 20 Nov 2026
 02:33:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Gabriel Giner <gabriel@clicseo.com>
Date: Fri, 20 Nov 2026 11:33:30 +0100
X-Gm-Features: AclHuK-Z7D-2DkhRgFmpnmz9P3ePO_BbhRJI67sPtSk5ZcRRRKH6AlQJm-rND9U
Message-ID: <CAKfe=PoLDuKxiQDpVB8qcuu0+1ijQvPnOb7fVzHNc2t3oiO3AQ@mail.gmail.com>
Subject: e1000e: I219 (8086:550b) on Meteor Lake ThinkPad powers the system
 back on after S5
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:33:05 +0000
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On a Lenovo ThinkPad T14 Gen 5 (21MM, Core Ultra 5 125U, Meteor Lake,
BIOS N47ET30W 1.19), kernel 6.18.63, the system powers itself back on
2-3 seconds after a clean poweroff. It happens on battery, with no
Ethernet cable and nothing else plugged in.

The system stays off if e1000e is not bound to the onboard I219
(00:1f.6, 8086:550b) at poweroff:

- "modprobe -r e1000e && systemctl poweroff" stays off
- "Ethernet LAN" disabled in BIOS Security > I/O Port Access stays off
- with e1000e bound it powers back on every time

Ruled out:

- WoL (systemd .link with WakeOnLan=off, confirmed applied; the
  device's power/wakeup is "disabled")
- every power/wakeup flag under /sys/bus/{pci,usb,thunderbolt}
- every /proc/acpi/wakeup entry (LID, SLPB, AWAC included)
- Thunderbolt, USB, WLAN, WWAN and Bluetooth disabled in the BIOS
- powering off through EFI ResetSystem instead of ACPI S5

The state survives a warm reboot: after "systemctl reboot", a poweroff
from the boot loader (systemd-boot), before any kernel is loaded, also
bounces back on. After a cold start the same boot loader poweroff
stays off. Hibernate (S4) stays off.

00:1f.6 has power/control=auto and is runtime-suspended (no link)
while the system is up, so at shutdown it is runtime-resumed and then
goes through e1000_shutdown(). As far as I can tell from the source,
unloading the module does the same resume and PHY power-down, yet the
system then stays off. I have not narrowed it further than that.

The same symptom is reported by others on the T14 Gen 5, P14s Gen 5
and T16 Gen 3, without a cause so far:

https://bugs.launchpad.net/bugs/2162837
https://bugs.launchpad.net/bugs/2138359

There is also an RFC patch that tries to work around it in the ACPI
poweroff path ("[PATCH RFC v3] ACPI: PM: Use EFI power off on Lenovo
ThinkPad T14 Gen 5", linux-acpi, 2026-09-02). That approach did not
help on my machine.

As a workaround I unload e1000e from a systemd unit ordered right
before systemd-poweroff.service.

I can test patches or collect more data.

lspci -vvnn -s 00:1f.6:

00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet
Connection (18) I219-LM [8086:550b] (rev 20)
Subsystem: Lenovo Device [17aa:2327]
Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Interrupts: pin E disabled, MSI(X) routed to IRQ 193
IOMMU group: 15
Region 0: Memory at ab700000 (32-bit, non-prefetchable) [disabled] [size=128K]
Capabilities: [c8] Power Management version 3
Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=1 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee00b38  Data: 0000
Kernel driver in use: e1000e
Kernel modules: e1000e

ethtool -i enp0s31f6:

driver: e1000e
version: 6.18.63
firmware-version: 1.1-4
expansion-rom-version:
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

Thanks,
Gabriel
