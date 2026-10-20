Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E00606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Oct 2026 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=KHU9elo7;
	dkim=pass (2048-bit key, unprotected) header.d=mser.at header.i=@mser.at header.a=rsa-sha256 header.s=kas202607210106 header.b=WGk9Kcnc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 814468100D;
	Tue, 20 Oct 2026 09:44:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id so5ugaTqh8wV; Tue, 20 Oct 2026 09:44:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8CF8380FF3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792489482;
	b=J884SUhExng3k9c0HUG4Dma6LEXA7vkeoSTIxOkZDFHv8IgGk7MHleAFl51K/rBvZb2e
	 EWUJXoSvAcIVU5Rd8k048KMwOvZDA8voAzeqcQ3RffVtRm6tHssgUQweS+yOjm4hXCtcf
	 9W69AJJQcafv8gH/Y1fbxptbejTwz8qYbwtXjZdqthgmkwatLlOCTTtKv3b9hdY8tovxg
	 CWsQKMXy25IE9N4e3UBotcDKVHoo7m0nFdw0w5kufpgK09EA9NQAYGIl4X8eCCcfYKgcr
	 DCGWE/+WBS+dxNq9h8jhd191HW0OWbwQVFBthPqib7XsSk9ybL4ZKoqLVbAbOcnbCZg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792489482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-KAS-Sym:Received:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Transfer-Encoding:MIME-Version:
	 Content-Type:X-Spamd-Bar:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3bmhvq3zuODEOi5cEK5mdUmQ0bOqJ5bt/6nAB9gWM40=;
	b=We0WNk55SJmkI578jI6lyv8+5FYxZmygHC9Nkn6m3pr1iwu+4Us1pfHpRzq7/zYDbV0K
	 rW92bPQbndBU+QWV8D2D9j4pBX5yjBecE088scOCfsebmrV5Xala2ns/GqoIHOSXU7zh/
	 Pzwzzj78j8wGbXCDJZAMKjyw/eGP7zvORHUlqeFW4HVunajXNTLwtZav8V4X0NtJ0Z3H1
	 MgKgCecQ7kMPcYmioEseC5Vt4d3bMDtAr8BOl60/Ruw9YR5tRViYzELBnG372iL2nhzSE
	 JIrE2yE1epr/zKdCEuHdi/GYPhlmge7LFq5ORq/IM4I1Ap3SbAwMTKZSPjIs38Qu2dg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792489482;
	bh=3bmhvq3zuODEOi5cEK5mdUmQ0bOqJ5bt/6nAB9gWM40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KHU9elo7EeHdJjoeqHQJd0eFisaK6/YfvtXp1XXgJ2HLujdl1jsqxlFlXCkomtmpW
	 zQqT4+zFadsUDCOoadfOGAC9H1svJ8m98yZTa9QNsc5jxlfwVpRJHtyz2/EhBQ8sJV
	 QdNzW47AIyuctHqk6T4Tis4tyeBAoyfTtrjJWqLtljD6xjyYOvrXTtYIDFCT8YMzxB
	 zDe7OFkHfYUNmSWMVxVggrwqlVHemq713+HBtCn7Upee2/g0n9uKCCRpD5EZ165B3P
	 Hp67iiaXr8M9Mayw6+AkrV0teBhHBVZyn1xpmX6xAtZff5MmWguS/DtQtvbY9HruRP
	 e8xgtRX3cqrNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CF8380FF3;
	Tue, 20 Oct 2026 09:44:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4FB723A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 09:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8DE8F4016F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 09:44:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QNqMD3xAOebe for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Oct 2026 09:44:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 22537400FC
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=85.13.131.59
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792489476;
 b=scPT4JnPUvdRXiAoDDsNJAkGnEj99/Btj/TMNT4ju7jShLDR3mGSc/wIIFZcprLMj4Ct
 Q8T2QTO3peF+WWTVgqGbxZK8Q+RFTp6/+MaqgIOUnpDMiyhyFKCe3p/2GLO6Uhl33lPqR
 NvygnVXnxe9m7cBnho0pphmWtUDS8jAMYnpHPDQ5nCwS79ZZ692RxPa5GEhsmzgYEJy+J
 pwknwyqXmbjmjFdfIi8EHivsRbrB+JLZx+44LqNBW5T58/lsIF16aA4+BUmtFdNvg4yk8
 EtLiBVE6o+Cvcj2Z5Y4QXj95yzguCoU1VlXdg/94TmP09cj73LJ6ksiS8GJo5rgAt5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792489476;
 h=Received-SPF:DKIM-Signature:X-KAS-Sym:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
 MIME-Version:Content-Type:X-Spamd-Bar;
 bh=3bmhvq3zuODEOi5cEK5mdUmQ0bOqJ5bt/6nAB9gWM40=;
 b=NhYObo75U4wlEi77j4PkoV08H3vAyVIRPJLM64euKEENUJxYEPvEBMw5m//4HgV+o+h5
 fBR+p7MSG8NORd1JbhysewMgspyzsuZGuvR9UZ3b5pwyTTCICMZD2y3qrWNgsLzmf2To5
 EgWhQ6/6JNCHlgS8PFxLP+UOkfoUuX3g9rPR1h99re1zQEDDdmObKWnURLoE42JnJm1X2
 WuUMuZ2iV+FGv7ppUgXpZAvK/6PZtmcA1is+j+GLvWQFU0r+vCBAQHVkc4zZzZ14ETXPs
 imvnZR0cx5sowsiLCHjNvehWyXY7pWmM85dCCcWXHMH6rS8BRVV3MCMdt511aJQjMEg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mser.at;
 dkim=pass header.d=mser.at header.i=@mser.at header.a=rsa-sha256
 header.s=kas202607210106 header.b=WGk9Kcnc; 
 arc=none smtp.remote-ip=85.13.131.59
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.13.131.59;
 helo=dd30414.kasserver.com; envelope-from=dev@mser.at; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mser.at
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mser.at header.i=@mser.at header.a=rsa-sha256
 header.s=kas202607210106 header.b=WGk9Kcnc
Received: from dd30414.kasserver.com (dd30414.kasserver.com [85.13.131.59])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22537400FC
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Oct 2026 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mser.at;
 s=kas202607210106; t=1792489470;
 bh=3bmhvq3zuODEOi5cEK5mdUmQ0bOqJ5bt/6nAB9gWM40=;
 h=From:To:Cc:Subject:Date:In-Reply-To:From;
 b=WGk9KcncuXE9JhYfRJZILv9hMj5KMTvYUfIq3sVZRRolk85NIPBqEWKvwZJOhCxcI
 eTyvzucfgOhbeg0uWTYS7Myd4e8WsjIjHLxMycywppifxLxiobubdLSb+CnXiLS1Io
 BjoUehooMUj1PA61tl3J/tOslgsow9upPM0X9u1R0SiIIYr6vraIyaP66DJIGlYS+u
 EDvLTABHpAKOELB0iUbSYrvOJlCO/PbnoCXAHVT5lbtJDcKKD/7kvdy7tTDJAsNHK+
 1+ebcvZ/gOsGM1cm9Sg5IJhz1noy1GRcf522BB2bKsYHzVI5G5OtwBOZnlFlHzcXf6
 ic+FOgOBdGdwg==
X-KAS-Sym: v3:f51bdf72230551df:mPSmZyQeUU0hJ48cRNQO5WGMsDcTp+Gkxgw+MI5OoCBem
 P6WJ6UYsjuIfF9+V+PveSBmh11gxrS8WF0mkn0tqtj9K8h+Nf/DfOsu052Zo2q/22d0e6N/+cDZ
 JJyteODSDeneN9OMHCVWVRAmxkVF04QFIuY7qFaxsHobvUCVkvgM7sG75b/ZzbdeAool5VTxldO
 KDgV/ylY8R4WsZhTepVcYjGCl9eHaTAgI1jWQXFaynzA+fbW8GXj1F5/7uYnfLl1SA/TzkKJYx8
 r4fwQj04N0ux19yrJjgX/PtV+GNpD+NfdlDK4HoIfx6sFYnE2fBKu3Sqc5sbgXlAj33Z8hRA==:
 Jo6itHlrlMQ+M64S2A8WL+7l3j3DrwE++rng/IGS2DBSj3qeDrSFnvqfjWq48OIodXzKCYL1cWi
 A+J/9avnkLmKfFk99uigi8m4tjtBR6CwtOUY/ehTot7DdR8zSnDsOM+KyITxP8Kgkk3LWX+3CAA
 O9MNh8y3pkjiM0IzxzVNOs5M+R1LvnLqn5YAVETdoXJPwTd5io5AdBlnIMhxXL13alU8Y5OBHlU
 mxu5pMDQrTApsf6V6wQ1HPp5iWe6Sjedib9eRxUy0U4A1vwWm31lezqqco2u3fofheysBOSSksY
 z3lCb3Jyd758vd6ZTlkIKDvZqEWgZ3QQWbP9nZiYEsVX1U8muK6v94kb30Qll7xAT1BkXcRBwRL
 cZ5fJNsr2dbYf2oPi8QjtjDf9QMAq9FHHSbKQXO5ZBHueZ9KsG7TLqm0H1dC6tv8GemlzvWxMpn
 H3jFlhTFlq+lZJyheGoHUmApIJnCru+40X7qJNXkk0peb7s0o0qosBMOmDHjx2jp+rpRdgfrhf3
 HxPvhJa2dmteviagDh88W+2Wq0ZVrKVg6Rj6h8m2NP+kQ==
Received: from mser.at (178.113.74.246.wireless.dyn.drei.com [178.113.74.246])
 by dd30414.kasserver.com (Postfix) with ESMTPSA id 279BC7F04AFE;
 Tue, 20 Oct 2026 11:44:30 +0200 (CEST)
From: Michael Serajnik <dev@mser.at>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Subject: Re: igc: I226-V does not wake from S5,
 PHPM D3 link-disable bits never cleared
Date: Tue, 20 Oct 2026 11:40:57 +0200
Message-ID: <179248925768.53035.1880576110074374844@mser.at>
In-Reply-To: <1562f299-bb3e-4fe6-81d9-e11f67606737@intel.com>
References: <179223208565.28107.1987245697366860479@mser.at>
 <1562f299-bb3e-4fe6-81d9-e11f67606737@intel.com>
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="fixed"
X-Spamd-Bar: ----
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

Hi Dima,

Thanks for looking into this.

On 20/10/2026 09:55, Ruinskiy, Dima wrote:
> I think I can fix it in the driver, but to double-check that the problem
> is indeed this, and not something else in the wake-from-shutdown path,
> could you try to reproduce with a different link partner (switch or
> back-to-back) that is known to support 10Mbps link speed?

I can't easily swap the link partner. The PC is connected directly to an
ASUS RT-AX88U Pro router, on its 2.5G LAN port, and I have no other
switch to put in between. The cables are clamped down tightly along the
furniture with no slack to reach another port, so trying a different
port would mean moving the furniture and re-running the cables. Since
this is mostly an annoyance and does not break anything, I would rather
not do that at this point. It is also unclear whether it would help:
ASUS labels the 2.5G port "2.5G/1G LAN" and lists the four other LAN
ports as gigabit, without saying whether any of them supports 10 or
100 Mbps.

Instead, I restricted the I226-V's advertisement while the system was
running and waited 30 seconds each time:

  ethtool -s eno1 advertise 0x003   (10baseT only)
    no link (Speed: Unknown!, Link detected: no)

  ethtool -s eno1 advertise 0x00c   (100baseT only)
    "NIC Link is Up 100 Mbps Full Duplex" after about 3 seconds,
    stable for the whole 30 seconds

After restoring the default advertisement (0x80000000002f), the link came
back at 2500 Mbps Full Duplex both times. So this port supports 100 Mbps
but not 10 Mbps, which matches your explanation.

I also need to correct my report: I cited FreeBSD bug 282140 as the same
problem. Looking at it again, FreeBSD fixed a different bug there (the
wake filters were never armed), and the PHPM change was dropped after
the reporter's switch turned out to support 10 Mbps. So the bits are the
same, but FreeBSD kept the 10 Mbps behavior.

> In recent years, an increasing number of switches stopped supporting
> 10Mbps, so we have been receiving reports of similar problems from time
> to time.

I think this is still worth addressing in the driver, if possible. As
you said, more and more network hardware no longer supports 10 Mbps, and
with such hardware Wake-on-LAN fails even when it would link at
100 Mbps. If I understand the issue correctly, keeping 100 Mbps
available in D3 as well would make it work with this router, and likely
with others like it.

Thanks,
Michael
