Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CDF606A32C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=RNFEf58F;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WnuySN2q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 41CA140AA4;
	Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TigK0YHEt0mk; Fri, 30 Oct 2026 04:54:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C0FC40A68
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336044;
	b=PVDnGdJDJsqqKnJLkPg7X/hfNH1dUc8pu0/VfBGDcU0mr+zCpNwKrXKpLrKh25i1TYvF
	 +Wv1dEbr76DqM5txzTT+zq9Y6BXKvR5DjD1/X4wAf7O9MBlDCa73ak2plceniv8pgDESr
	 +F6IpgZ6hyD530U76XIQHifC5ZFHbeMKMZTLCFXJinSPYkkBT58y2sP9AQEL94D7cw1lq
	 qsrAc00y2X+T/FKuEqshoygZ/xyZascUaDsJpOPf2SMBMltOjWPz+ot0wUAdOnxfX3okp
	 Ug+37RMg781eE7eHek5aOPnjYQVyn+m88CBpDiDVF9gxWJ/g17Scn+sBY5OOrberSww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336044;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=M2lzqkeLdt2NTPhtbCzlSYHPAELmvEyLktsEo5jEYPQ=;
	b=luZCx+oT6jmGWxlttGOKCVv+jjwewVsk7jrrS4Sas7MeaTvQAbXhi3V35y7nGBsC0uqB
	 8B1Hl9S9fPwgRPndIHcmqz7y/33pf6dCfJN59r0sr2/W20TvKboPVE6YF4pVSvPCVGDLY
	 e2aqEH08IbRN1y22R9dbGSG9ynKFjo6cC7jhQmuviXYVLTGg1hjCSeRisgTSgvZ46NNcV
	 MyxxFmZqynkxbjeNjc5EJP1TunK2yTZA25CFUusrx8aMDHJBEghPORsCwCUbvo46H4gG1
	 9E8K+Nzwqaiv07x4jDEzAzT6H3pn/yLdy9q/xZ4+wwYVTVcc9Yl9l7ihFShpjgZTcxw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336044;
	bh=M2lzqkeLdt2NTPhtbCzlSYHPAELmvEyLktsEo5jEYPQ=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RNFEf58F275CcNiBCTs/RDJcKdXwcui/+O4rmx4BHRX4aPJGj6VEN5MB8OCJB/yFY
	 dDDoHN4YKoEalYaz+Ogx55MuYnMTlb3Hblg3UayqoVLWHEkoUKV3XgSSPx2HGxSASx
	 AmnJolW+EH444S07FwhGSEqbX+bIqTHs0QzaJaFWdUvZDmbeRWHBaEir3py2Jqv65O
	 ClSMqxgkewyD8CFaviC0CPQ24TH6xfi8rQHawfAZuOd1z4JqJYe9YqbSmPkcLwkxJ1
	 YeKbZ3YYUSb8Ek9KKP4OHwNJeaG6QzSZXs+E0fMZwNFau5MRVCZ8ExlLI2v+q0+IgG
	 Snk41oCaC75sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C0FC40A68;
	Fri, 30 Oct 2026 04:54:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04D73D43
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EADB880DCE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvx_B5xtfJlc for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1570D80E13
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336041;
 b=fhjAE3oYgcgexqKolLURuyZuYa67sVqn+wBL0u2TzQHlUgThCeVIB6JBu7wDJwKFvh8p
 iiIW9Efbwr1w7Gkc/dYCuo2CGpOIL3IIc+8sjCsGEaocVGiqlSweCohUfS8i9YyfTajCt
 gPT4QqbOQ2KqS5zWxpvtFOYYrmE6SMkI0d2lQpUPVfsHJHfog7fpz2oXSQCpn7RYjVFme
 xl8KG//ymQFrZM5w6TPINuVOPAZKizqbZxciwEowuEDRkJmdCatdfjPN6c4keYRIFr20X
 3iplRf70H3ojMLtmm6rgU0HyUHt0AjvKnL8INgDo0MOXxfMP0OWYU8XcNyObWfbeUuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336041;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=M2lzqkeLdt2NTPhtbCzlSYHPAELmvEyLktsEo5jEYPQ=;
 b=jfSj8tc/MLvQIRquMMLbLX/bGL5/vGAvq57sDq8Z6iDlc+KTLcZ1GxKkzySq61yXmcLe
 AoYxY9QbNIo18W+3FG1tJicaEbOYDK4m9Zl9WHROp6YNn9KJaUxcsnOXjmxMq3ESQIr/I
 wRdoB0jb/mIMkG27Icy32IANM8xfnwkS6mgwGLI8VS9556uoOXUske3P56l+pVvo7uLsQ
 cOCEmznQTp6DdKB2eT3m7o4SeJDjqu2HRH1Jk16ZAuDODUIxxG2btdtZGiZ/6Opy7JMVN
 10codJjYVwYrcbvKX9/IS/9WbU/X74dXz2iw9REX/R8TFsuBk32ANqexNiTQv7pZGVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WnuySN2q; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=WnuySN2q
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1570D80E13
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4069043AEA;
 Fri, 30 Oct 2026 04:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0156E1F000C1;
 Fri, 30 Oct 2026 04:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336040;
 bh=M2lzqkeLdt2NTPhtbCzlSYHPAELmvEyLktsEo5jEYPQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=WnuySN2qvhjloJ3k1aGE9M9qu2P6deAGvcJeBxpzREJbOQHY/NETV9UcXdPuYB2x2
 JwhX2onAqfzqeVR4v1VubOdeYgQ3Hw9bAuVCH0Ib32W3FcaG+bwr755hFcUjti6j+P
 K77fvTdJaaTvaxVFDnYmidFu3pnqqygvszF1sMA6nbRIrkq1P4/e+w3wMcs3hPzbVC
 LGYSpJuCmB1MRxBHADpTHpOX6lVR1y0iq+ZXsId1OA2kiLNqcSOmOttibouMapsGpQ
 ywuLN4Ua84krFv9uROMKM9lC2zmT7ACgyGr+gDbbz9yAzCIGeCl7csJKKdGzvBLmvz
 jH+ltJpsyYphg==
Message-ID: <sashiko-outbox-190392@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 4/8] ixgbe: increase SECRX_RDY polling
 frequency in ixgbe_disable_rx_buff_generic
To: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20260508031226.3601800-5-aleksandr.loktionov@intel.com>
References: <20260508031226.3601800-5-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:53:59 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbounded or excessively long hardware polling timeout due to usin=
g `usleep_range` with a fixed iteration count.
--

commit 8a91d1965e0f71698f5b5eb20f1c8e612eb2947a
Author: Maciej Rabeda <maciej.rabeda@intel.com>

ixgbe: increase SECRX_RDY polling frequency in ixgbe_disable_rx_buff_generic

This commit replaces a 40-iteration busy-wait loop with a 4000-iteration
sleeping loop in ixgbe_disable_rx_buff_generic() to reduce stalls when
the security block is quickly ready.

> The worst-case is now ~80 ms (4000 * 20
> us) plus scheduler latency, which is acceptable since SECRX_RDY
> failing to assert is a non-fatal informational condition (the function
> just logs a debug message).

Is this worst-case calculation accurate?

Because usleep_range() yields the CPU, scheduler latency and timer resoluti=
on
limits apply per iteration, rather than once for the entire loop. On a busy
system or one without high-resolution timers, usleep_range(10, 20) might
sleep for 1 to 10 ms per iteration.

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/ne=
t/ethernet/intel/ixgbe/ixgbe_common.c
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
> @@ -2683,7 +2683,7 @@ int prot_autoc_write_generic(struct ixgbe_hw *hw, u=
32 reg_val, bool locked)
>  **/
>  int ixgbe_disable_rx_buff_generic(struct ixgbe_hw *hw)
>  {
> -#define IXGBE_MAX_SECRX_POLL 40
> +#define IXGBE_MAX_SECRX_POLL 4000
>  	int i;
>  	int secrxreg;
> =20
> @@ -2695,8 +2695,7 @@ int ixgbe_disable_rx_buff_generic(struct ixgbe_hw *=
hw)
>  		if (secrxreg & IXGBE_SECRXSTAT_SECRX_RDY)
>  			break;
>  		else
> -			/* Use interrupt-safe sleep just in case */
> -			udelay(1000);
> +			usleep_range(10, 20);
>  	}

Could this loop stall for 4 to 40 seconds if the hardware is unresponsive
and the SECRX_RDY bit fails to assert?

With 4000 iterations, a 1 to 10 ms delay per iteration would result in a
multi-second stall. Since this function is used during device initialization
and reset paths, this could freeze network interface configuration and
potentially trigger khungtaskd panics if the RTNL lock is held.

Would it be safer to use an absolute time check, such as readx_poll_timeout=
()
or ktime_get(), to enforce a maximum timeout instead of multiplying the loop
count by the requested sleep duration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508031226.3601=
800-1-aleksandr.loktionov@intel.com?part=3D4
