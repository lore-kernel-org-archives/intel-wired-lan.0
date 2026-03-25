Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A58109C02F
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Mar 2026 15:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2464C6059C;
	Wed, 25 Mar 2026 15:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuZbkAwAa74L; Wed, 25 Mar 2026 15:33:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B63DA60AFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774452811;
	bh=CgGVEdDotrUxFWiSjF8zmnyJCQXPhbkhrROl5zrGJNE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KPpRbZNcw9uXlUlltyOpvOOuY4VnwxGULsISL1dlSwuWJ+Oa0wX5GzbQcRcueAKb/
	 EEbXc/qmey6BSLXaIgfM7BnY60cnwDq2pD7WC8AMokLyZd3en8NyIcsdu9pXHkSxIS
	 zhHKaHEkTkx+3bO24PDHj/683NDgEdDb8OqvOy3ACQQRizE7yRVd2IHB+R7O2vFALe
	 XI8PyopMB8V/IqKoYAO0RwhQpPWpMfxkWJSDFRLczwN7m/0pChhEpMWZ7206pKOB3h
	 bsrGRlmUBAKBkEM8t2Dgd4a3hQ03UEIO2zxGkTEv6yLItpPuNpXvF8SRdZEyjrP+3d
	 D+oDc8pIHfUyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B63DA60AFE;
	Wed, 25 Mar 2026 15:33:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 592E7353
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E5EA4009E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5aeg1LKRrLB for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Mar 2026 15:29:14 +0000 (UTC)
X-Greylist: delayed 563 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 25 Mar 2026 15:29:13 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6101840081
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6101840081
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.149.199.84;
 helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=<UNKNOWN> 
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6101840081
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Mar 2026 15:29:13 +0000 (UTC)
Received: from localhost (unknown [79.139.245.7])
 by mail.ispras.ru (Postfix) with ESMTPSA id 0A6A4413A4D1;
 Wed, 25 Mar 2026 15:19:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 0A6A4413A4D1
Date: Wed, 25 Mar 2026 18:19:46 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Agalakov Daniil <ade@amicon.ru>, lvc-project@linuxtesting.org, 
 Roman Razov <rrv@amicon.ru>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Daniil Iskhakov <dish@amicon.ru>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20260325180127-711d8e8fbff840853081f11e-pchelkin@ispras>
References: <20260318120512.687149-1-ade@amicon.ru>
 <20260318120512.687149-3-ade@amicon.ru>
 <5128e54e-4164-4cb1-8ae1-e58d6a40c005@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5128e54e-4164-4cb1-8ae1-e58d6a40c005@intel.com>
X-Mailman-Approved-At: Wed, 25 Mar 2026 15:33:30 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ispras.ru; s=default; t=1774451987;
 bh=CgGVEdDotrUxFWiSjF8zmnyJCQXPhbkhrROl5zrGJNE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FABBEw/37TiAtd+C2rszl59lq2kNQvjmeRtRirvxCr+ARggo14pCI2v/SAGWBj72r
 3gf3sFpnQ1aM1xs/SBJS9HQH4BZwv753opCIKSbOSgzD6XOJdhW52sVPevE9ow2MDj
 5/bi8ITcQS68lg1n0mUTy2SGVA86x2GFMcrOqk0Q=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=ispras.ru
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256
 header.s=default header.b=FABBEw/3
Subject: Re: [Intel-wired-lan] [PATCH net 2/3] e1000: fix endianness
 conversion of uninitialized words
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

Hi,

On Tue, 24. Mar 16:26, Tony Nguyen wrote:
> On 3/18/2026 5:05 AM, Agalakov Daniil wrote:
> > [Why]
> > In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
> > words. However, only the boundary words (the first and the last) are
> > populated from the EEPROM if the write request is not word-aligned.
> > The words in the middle of the buffer remain uninitialized because they
> > are intended to be completely overwritten by the new data via memcpy().
> > 
> > The previous implementation had a loop that performed le16_to_cpus()
> > on the entire buffer. This resulted in endianness conversion being
> > performed on uninitialized memory for all interior words.
> > 
> > Fix this by converting the endianness only for the boundary words
> > immediately after they are successfully read from the EEPROM.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> 
> While this is definitely better, I'm not sure there's a bug here since it's
> being immediately overwritten. Seems like this patch would be better going
> to *-next as an improvement.

It's worth stating in the commit message that the uninitialized memory is
touched with le16_to_cpus() in the loop only on BE systems.  Little-endian
ones are not affected - le16_to_cpus() is a no-op there.

Anyway, for the BE case, touching and manipulating uninit memory bytes is
still in general considered a bug, even if this memory is overwritten a
few lines after that.  I guess if KMSAN supported big-endian architectures,
it would hit this, and that wouldn't be a false-positive.

I'm not aware of the details on how you treat the bugs in these drivers
for BE-systems: maybe they aren't prioritized and then would occasionnaly
go as -next material.  But, again, this situation looks like a real bug
worth fixing on BE-systems.
