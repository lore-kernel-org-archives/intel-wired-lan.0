Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8B606A334
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5bQiHQWG;
	dkim=pass (2048-bit key, unprotected) header.d=shuye.dev header.i=@shuye.dev header.a=rsa-sha256 header.s=sig1 header.b=iHc7JFDz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E7EF60790;
	Fri, 20 Nov 2026 16:33:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dsMCB7spDPlh; Fri, 20 Nov 2026 16:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6A9C260629
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795192387;
	b=JfTBb204cc8Dmus2z1KJY04jh8iaiHJUIMkLKcBeRg1Ql+sRjopsQFTBlEAlU38ize39
	 Sgqpj1YfeXFNOE9uTIEFmizAWmlVWaFcfCPIrHg7r4Z57ei8Nfl4kv56cxuUlwwcPXqq4
	 hHWnxLEMOm65ZnWbREYb1RQ7w+lm9LPxroCdFd+xtM1xwbaZ92xg+gkAH5LeyuVfEC14J
	 1heoKfSFgTDI//UL/lqm5voHmg0u5ul5d0YRQqAReun+q/ESsVbspwrQgdsTGzzKrpMh1
	 V3u+a4PXMi2V+eQjW99mnltfKOGmI4rrrw3Nd/hApuFo9HG/59pDW3V0ivk9XHpdKTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795192387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:X-ICL-RepId:Dkim-Signature:mail-alias-created-date:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Info-Out:X-JNJ:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3nJFyXbIWx/MRH904ZczxefA6Hie3BnVb96ab2XxJ0g=;
	b=Ub6aU0/Ig68FyvMzQF8qNFm33ib10dM2Zdx0dOycmSCn/0yEK/wft2Uqj8bEYnth5Tjt
	 YAXCiIJ7mM/cuQQlh7XV+rdLADmctwbnJhoFV7RjyLHUnpbema65ZZ0go2smHzK5+8NZa
	 jdY402BGNAhohtDl6QZCnhjQL3Xe87//vJl/Gpsdac3RD8wjIxcXTh81V1D2h01S/gwhE
	 dC/jsI4NteGyJtD0zFWQRkzfvB4G227IAR2hGVQAvGxnekAQ5o51KGAfM73u/ARMW+Frg
	 FRi1B33Salj6UKGfes8zAbtuynOTJWcpq9lFECmRNaRivTBdytFhKjI/beoNpZOhnrA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795192387;
	bh=3nJFyXbIWx/MRH904ZczxefA6Hie3BnVb96ab2XxJ0g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5bQiHQWG+9dLL3KWCIFQaECtOxH6OKGaSc8RHmwOOBDlOPIZxD57xZSDDYFZi6QiP
	 WveM1tFy3hCUnWBqnT4A33icEfTWxzChRZJq/iVzEVLHGFuMdNCjQa0YGADoVQUXhm
	 9e7iQqqinhMz9OZiPeXFObrkNXfqGXvM3aY7Vc8ZvAaL/VuJ577qJR/8dTJW8PPqlG
	 t49ejdwtM+UmmZbLbnV5kd3pPFZuXIIwxnde99nrbVqAEiXE2TYHG/2tgFxwPvGkjX
	 PYAJln75qREmsFVGInvGe1ZlXGDDvjwdxKNZTaKPGbW4eMjOrmVBITcjWTwjBxiBTP
	 WgnRZJwwrvxDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A9C260629;
	Fri, 20 Nov 2026 16:33:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BDD9879D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 02:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB42140DEF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 02:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HxqjvS5eX6Jk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 02:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D72E140DEB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a01:b747:3000:202::d"
X-Greylist: delayed 1073 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 20 Nov 2026 02:12:50 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=shuye.dev
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=shuye.dev header.i=@shuye.dev header.a=rsa-sha256
 header.s=sig1 header.b=iHc7JFDz
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:b747:3000:202::d; helo=outbound.mr.icloud.com;
 envelope-from=hello@shuye.dev; receiver=<UNKNOWN> 
Received: from outbound.mr.icloud.com (mr-2003a-snip6-3.eps.apple.com
 [IPv6:2a01:b747:3000:202::d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D72E140DEB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 02:12:50 +0000 (UTC)
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-2 (Postfix) with ESMTPS id
 1989F1800244; Fri, 20 Nov 2026 01:54:52 +0000 (UTC)
X-ICL-RepId: 01a1f6a9-e9dd-7848-8fac-c9304d982ede
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shuye.dev; s=sig1;
 t=1795139696; x=1826675696; bh=3nJFyXbIWx/MRH904ZczxefA6Hie3BnVb96ab2XxJ0g=;
 h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:x-icloud-hme;
 b=iHc7JFDz5oLF2OsthbKzZft7BLNi+KCZqswCIDF7IHYllDLb0LXqAa75Ew09mfLoV0Z/nkKN+KYwtRniu1qHRfU8oyvQ3Zi02HJ2uY76W/KLDuNhbBR+sYij7aenT/tdNPWvO9EBEw25ZwI+XwklfKTpf1h/F0pNUQNfLzimUQLohqQUwKUHHzpebm4yEgs+ZdV4PpR0a4YmgVL7K8OMjfVb5K8mfRYm11kie8Tqtk5INX+JjvNoQQ84ZuW4FWjR9EUXrqdYiH7Jb5Urkgz740ZTw+W7UgsvsKqPegGWguIzIC3QWCJML+JFIAvaWOv8pNMz4t6guZvdcI/a/cPGaA==
mail-alias-created-date: 1658105457252
Received: from [192.168.1.237] (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-2 (Postfix) with ESMTPSA id
 F09611801FA4; Fri, 20 Nov 2026 01:54:51 +0000 (UTC)
Message-ID: <c4801ff7-7ff6-457e-b0a5-c2e633d35c59@shuye.dev>
Date: Thu, 19 Nov 2026 17:54:50 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ye Shu <hello@shuye.dev>
Subject: Re: [PATCH] e1000e: add Dell Pro 5 Micro P5M1260 to disable K1 list
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261119001818.513503-1-acelan.kao@canonical.com>
Content-Language: en-US
In-Reply-To: <20261119001818.513503-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jbCAZH3vfCWXGgbCSZPZ2sPzq8vDHWeS
X-Proofpoint-ORIG-GUID: jbCAZH3vfCWXGgbCSZPZ2sPzq8vDHWeS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAwNyBTYWx0ZWRfX4XfM9aHe0pPZ
 Bp5wfaJ/TPln9eAHtewduefqFrReBXw8om4+5+IfeKFMEZBnQSxwHm/3Pz7ljLfxg3qSYnJIZiK
 8jD9rqScaSN1yDl04O274rCnNv80HMb+qfyuZx9lvrhcSg0BOiGtL3iVlFRKjC4U+Sc5BG6QQb0
 a8egKeL4Lk+n/FXjcwK0+5YvjTIq99m04MlnPYxuVFnJuUbRaasvvwpKc3tZLxYMPFrSTwLZ9xm
 K4bbHg9p8jSM6ZelRf6/Nj908FR0DsyOFVHJM+P38cuYbjyfBSHcwSFs5jVl2qDszjBLQxE+MFU
 qpTxvnRvEbPp34/kKTM2J8kMQXz8WEE7TCwwI+yjyN2lxkkVtRBO3T6bGNTapE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAwNyBTYWx0ZWRfXy2+SmrgO6jwn
 Y3ZkLdZrT6+OPAoApIy+SzoRt28ayc9l6FglV42FmTM9dN6rHnjixwZUvlobuTLvEYvjne+qzNi
 HP6qb53xfgnGCwPrUd9HpuBPcz/+PmQ=
X-Authority-Info-Out: v=2.4 cv=fISsTpae c=1 sm=1 tr=0 ts=6affa86e
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AZoGnDOZhPiq548KR6q9:22 a=6pjilUagrR-x8BKHJBT4:22
 a=_HOHq80dBbJJRk_yJP8A:9 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABpKVf7VYpJFRYNM4Inx1hXJ26BM7s7NjMFejxFGsnpGru/1oChIUijPP5g/Kcz8
 FRIb6pMnYREpzQujFLkSqZ45NESBRr8SEjWH5wOTiVBuTHRgQQ5Li/sywoOZOvQRfU34uB
 QusfTqcmY4JNQ13ckq3zVGvxBPimYgmp1BylzA27fgeFw0g2rIR1hFMm7G9SUX6Er6hn5t
 /wcjReEY0uKff+pwEEMlhfghyHlpDUgqNmURtFxCeg3LKXfpW5Z4hxs3OmVDiEEW/XSmrI
 +lyyQWFwhDFW36KF3IICeyjoR+RGK9mVc9wRZh48vvlCEuhYdn4mT/lCCDJ65w2sevSylG
 cZT3tR1XzB/ItiJheMV4wE01YAi/ihR92wqvu2bbG7ZYQXYmqfqVQgpvqS+sfdl1MJ6KpE
 UD/u8wiotqqcxlSgI99da79WBIV1ndQmxMylbXSsQQCuZLp/Jrh87WJzOb1ewrkQgZF88V
 0pyY+B4zdooBUO/PwLfKxC6ZTikhyjiA7RNoi11nniVtY1yWMsuZ2/MvMPX9k+t6s4gthj
 B9K7ujTzU4wDulxPiZH0o7cy4VKkKvsir6NQAaupqd/BeB+lYu+YLpLiARiJiuzhjf/Lo/
 bgvCNkQCyznkUnp7MyvPgHhR51TuybztP0rKdW0HygtpwG0QRaHb2pVE8r8vD+D0QKvxbo
 7G3N1DhhkjQpr4zCSYeRHDVeC3h+MpThkjr4l8fK02p/wvMsNY6bdvwNoU9l6gaZwk0kMp
 8UB9/hS9KRT7JB1Q6tPKQuWpv6J9g9RmnAIhnK6sfNZzr+m/BIZaLpVNDikETMxHsAYhyV
 C6Beyn/oYH38Zmrxzh80NDslLJzX652lKK40CPyEON77rSEugLmxYEs+ZxAXhxE2t04dgT
 ITEEiSftpufMcV1tTyrzfg36LiAJW1i0UdHG4TSGW1KNsEBcXpYIhttuBRLt5RO0nvTQPZ
 kgbiaK0IrKUApMqmNrhjEpJqZj+O23X07XY9flYhi0EfAHcmxXbBPX+6wGiUTV8gw5vpdD
 nn+Pqdpm9KuYmqH/P9yPxS5zM+kc/nfZOTZrzE34Avh+ye7qqf0no/8j0G/d79SnGM1QkZ
 FoedGGatTP6TUdj7sYMo8wxdwv7WiD2Kzk89TSyJi1c8YJ3KoSuoo14DYijHjugu+znY8k
 qS7szBDeY9s/tYN2RM9MhhJwjKAOgS+cDRnmETCOtYRxXUay25L6qFVPXBVC7oUYb5Y2yV
 snR83+cLc5O6Zrko0tKvcRPFznFIdNkF61Fiyg38XnfZMAW2xvHr2gOv8kYyZbJfb0g7JE
 C3scbTAo6G3kHrjBr6Wrk9pApWDxbx8Uz7a6NZ2RKlE02wsbIK8M95sDZCsZeB2WGGC/4P
 FHFaG9QHjEOMjjn5s9GERniAV/YLRYMRe5KPftTkSFjIuzEdZQ==
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chia-Lin and others,

On 11/18/26 4:18 PM, Chia-Lin Kao (AceLan) wrote:
> K1 was re-enabled on MTL and later platforms by
> commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake").
> Since then, the Dell Pro 5 Micro P5M1260 (Panther Lake, I219
> [8086:57b3]) no longer enters S0ix during s2idle. 

I have independently reproduced a similar S0ix issue on a different
machine, an HP ZBook 8 G2i 14 (also Panther Lake, with Intel I219 NIC
[8086:57b3] using the e1000e driver).

Machine tested:
- Model: HP ZBook 8 G2i 14
- DMI system vendor: HP
- DMI product name: HP ZBook 8 G2i 14 inch Mobile Workstation PC
- DMI base board product name: 8ED9
- NIC: Intel I219-LM [8086:57b3], subsystem Hewlett-Packard Company
  Device [103c:8ed9], driver e1000e
- Distribution: Fedora 45
- Kernel: 7.3.4-300.fc45.x86_64
- BIOS: Y70 Ver. 01.01.07

With K1 enabled by default (disable-k1: off), S0ix entry is
intermittent. Some suspend go into S0ix while others do not, even with
CPU reaching Package C10.

> Every suspend ends with:
> 
>    intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!! (S0ix cnt=0)

Failed suspend produces the same message:
   intel_pmc_core INT33A1:00: CPU did not enter SLP_S0!!!

> The PMC low power mode status dump shows the GbE IP is never power
> gated (GBE_PGD0_PG_STS, GBE_D3_STS and GBE_VNN_REQ_STS all 0), while
> the CPU itself reaches C10.

The PMC dump shows the following:
   CPU_C10_REQ_STS     1
   GBE_PGD0_PG_STS     0
   GBE_D3_STS          1
   GBE_VNN_REQ_STS     0

> Disabling K1 at runtime restores S0ix on the same unit, kernel and
> BIOS:
> 
>    # ethtool --set-priv-flags enp0s31f6 disable-k1 on

Disabling K1 using the same command appears to resolve the problem. I
performed the following A/B/A test within a single boot, using 120
second rtcwake -m mem cycles and measuring slp_s0_residency_usec before
and after each cycle:

disable-k1 on:   6/6 successful (~116-119 s in S0ix)
disable-k1 off:  1/4 successful (118, 0, 0, 0 s in S0ix)
disable-k1 on:   4/4 successful (~115-119 s in S0ix)

Since this issue also reproduces on a different machine with the same
PCI device ID for NIC, would you prefer adding another HP-specific DMI
entry to disable_k1_list, or do you think that disabling K1 for all NICs
with PCI ID [8086:57b3] would be more appropriate?

I'm happy to submit a separate disable_k1_list patch or test any
proposed changes.

Thank you!
Ye
