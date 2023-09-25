Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D5ACD54BE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 Sep 2023 19:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FBAB416F9;
	Mon, 25 Sep 2023 19:50:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FBAB416F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1695671400;
	bh=RsY3EDM1/fsUmhyNFrpBl28TqdkcJW1uH61o+bkP/I0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dvd9rasRzRgx9ZMCfNEhv6ppncqM5vZhBYyhHOpD2Q84O8C0kLc1kLvZFycnvds6m
	 KDin7YJSz1bS8ARtSCLvi58oUfPufQXGcg06p5mR1HUDbR73nJ9CKo9ayJDyNKM/b8
	 sn5YWkFdLfguPNnd88LFLNMlmwxRanuMGjMHdyk8N/zT8zY+JcnPxYolIxOxBeEGFq
	 ks0dxw4zE9gc4KosIvYtcgNQaAWFfuzsHebYcoMLQWnFnnHVZMCcaKzbOxXvPeSytg
	 ZxitXtS3RR6BTQTn3c1HWkOygz9CPQ0WRK2D1HIDCmpqYtgdA0HLVMj8RpjoDNlUXu
	 4DzwlzowswXzQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2J0CgfZRdY0a; Mon, 25 Sep 2023 19:49:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6050B416E5;
	Mon, 25 Sep 2023 19:49:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6050B416E5
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 3E95E1BF334
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Sep 2023 19:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 12704416E5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Sep 2023 19:49:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12704416E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L8ut3-1qLC9H for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 Sep 2023 19:49:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EFC640352
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 Sep 2023 19:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EFC640352
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qkraV-007U0J-NV; Mon, 25 Sep 2023 21:49:47 +0200
Date: Mon, 25 Sep 2023 21:49:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasad Koya <prasad@arista.com>
Message-ID: <8b73a251-c00d-4de7-b520-7e43478846f5@lunn.ch>
References: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
 <40c11058-5065-41f0-bf09-2784b291c41b@intel.com>
 <04bc5392-24da-49dc-a240-27e8c69c7e06@lunn.ch>
 <CAKh1g55zm4jcwB34Qch=yAdLwLyPcQD0NbgZtUeS=shiRkd_vw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKh1g55zm4jcwB34Qch=yAdLwLyPcQD0NbgZtUeS=shiRkd_vw@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=lunn.ch; 
 s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
 Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
 In-Reply-To:References; bh=ipzR39TmhmqHzS02fSh+VFhLnrwo7FeJ03ytLCA7Hdw=; b=ys
 meiksB71VUOPmP6qMhMhXRN6jSxTnYe3M5xENzDedkETd7YkAA2ZP/6ySlA7siHr2utNiD82QJis2
 YpG38C2Fgh1pGVy5kB7d9/z1U7l11ki1Btj0Cmjmi9R6lOzirrrXyo6rWuwMR4FDxHJ+VAitoShgA
 yFlsU6bw0hH+13k=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch
 header.a=rsa-sha256 header.s=20171124 header.b=ysmeiksB
Subject: Re: [Intel-wired-lan] [PATCH] [iwl-net] Revert "igc: set TP bit in
 'supported' and 'advertising' fields of ethtool_link_ksettings"
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: "Neftin, Sasha" <sasha.neftin@intel.com>, edumazet@google.com,
 netdev@vger.kernel.org, jesse.brandeburg@intel.com, "Ruinskiy,
 Dima" <dima.ruinskiy@intel.com>, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, "lifshits,
 Vitaly" <vitaly.lifshits@intel.com>, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> However, to reset the link with new 'advertising' bits, code takes this p=
ath:
> =

> [ =A0255.073847] =A0igc_setup_copper_link+0x73c/0x750
> [ =A0255.073851] =A0igc_setup_link+0x4a/0x170
> [ =A0255.073852] =A0igc_init_hw_base+0x98/0x100
> [ =A0255.073855] =A0igc_reset+0x69/0xe0
> [ =A0255.073857] =A0igc_down+0x22b/0x230
> [ =A0255.073859] =A0igc_ethtool_set_link_ksettings+0x25f/0x270
> [ =A0255.073863] =A0ethtool_set_link_ksettings+0xa9/0x140
> [ =A0255.073866] =A0dev_ethtool+0x1236/0x2570
> =

> igc_setup_copper_link() calls=A0igc_copper_link_autoneg().=A0
> igc_copper_link_autoneg()=A0changes phy->autoneg_advertised
> =

> =A0 =A0 phy->autoneg_advertised &=3D phy->autoneg_mask;
> =

> and autoneg_mask is=A0IGC_ALL_SPEED_DUPLEX_2500 which is 0xaf:
> =

> /* 1Gbps and 2.5Gbps half duplex is not supported, nor spec-compliant. */
> #define ADVERTISE_10_HALF =A0 =A0 =A0 0x0001
> #define ADVERTISE_10_FULL =A0 =A0 =A0 0x0002
> #define ADVERTISE_100_HALF =A0 =A0 =A00x0004
> #define ADVERTISE_100_FULL =A0 =A0 =A00x0008
> #define ADVERTISE_1000_HALF =A0 =A0 0x0010 /* Not used, just FYI */
> #define ADVERTISE_1000_FULL =A0 =A0 0x0020
> #define ADVERTISE_2500_HALF =A0 =A0 0x0040 /* Not used, just FYI */
> #define ADVERTISE_2500_FULL =A0 =A0 0x0080
> =

> #define IGC_ALL_SPEED_DUPLEX_2500 ( \
> =A0 =A0 ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
> =A0 =A0 ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
> =

> so 0x20c8 & 0xaf becomes 0x88 ie., the TP bit (bit 7
> of=A0ethtool_link_mode_bit_indices) in 0x20c8 got interpreted as
> ADVERTISE_2500_FULL. so after igc_reset(),=A0hw->phy.autoneg_advertised i=
s 0x88.
> Post that, 'ethtool <interface>' reports 2500Mbps can also be advertised.=
=A0

So you seem to understand the real problem here. It would be better to
keep the patch, which does in fact look sensible, and fix the real
problem, the mixup between TP and ADVERTISE_2500_FULL in the igb
code.

	 Andrew
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
