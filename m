Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78390F3D605
	for <intel-wired-lan@archiver.kernel.org>; Sun, 29 Mar 2026 16:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF76240B77;
	Sun, 29 Mar 2026 16:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2sdLkwJFqMjD; Sun, 29 Mar 2026 16:02:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC62C40B71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774800158;
	bh=wsYFc3Tx9EISvC1vyUkGB5FPr7lo2/T7m98WS8sicfw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K8M7vq1ikOJLd8NK2KefR3P+/RZ0tvGyY8+UPFHmO3lqHQlTzZzCZOyeIKYsiTf+I
	 ylU/i2RQul3VaUPXuTjB8dd8HwqIf8iiBSIymLcAhMk8zgFj3m9NFXlfFchJ+CXK9Q
	 +/j3VFVkOC2s2QVYwyLbtKRFHoQb28TSzkoo/SmZ3tMYs9I88avRT9ZjGV3JKA2OaI
	 UJJa2erM8Q8ioCnc7tU698vb5iUcMOgX7SsX46KXOLhQ83i+4E31EbPXLBGudlaswA
	 9czPc6hPoKoQljHq5GHwLCDtRU0q568y6PO/OTSHAyHlm4FeoXx6xgDpgnnIch1Kmi
	 CT3Ik/wVW1r/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC62C40B71;
	Sun, 29 Mar 2026 16:02:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E78E2EB
 for <intel-wired-lan@lists.osuosl.org>; Sun, 29 Mar 2026 16:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4059F40B71
 for <intel-wired-lan@lists.osuosl.org>; Sun, 29 Mar 2026 16:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4lmhTBnBdzaA for <intel-wired-lan@lists.osuosl.org>;
 Sun, 29 Mar 2026 16:02:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=83.149.199.84;
 helo=mail.ispras.ru; envelope-from=pchelkin@ispras.ru; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BC01D40B6A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BC01D40B6A
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC01D40B6A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 29 Mar 2026 16:02:34 +0000 (UTC)
Received: from localhost (unknown [79.139.247.223])
 by mail.ispras.ru (Postfix) with ESMTPSA id 25EE6406C750;
 Sun, 29 Mar 2026 16:02:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 25EE6406C750
Date: Sun, 29 Mar 2026 19:02:31 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Agalakov Daniil <ade@amicon.ru>, lvc-project@linuxtesting.org,
 Roman Razov <rrv@amicon.ru>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Daniil Iskhakov <dish@amicon.ru>, 
 "David S. Miller" <davem@davemloft.net>
Message-ID: <20260329181905-cf917b74fe3e24dd60228601-pchelkin@ispras>
References: <20260318120512.687149-1-ade@amicon.ru>
 <20260318120512.687149-3-ade@amicon.ru>
 <5128e54e-4164-4cb1-8ae1-e58d6a40c005@intel.com>
 <20260325180127-711d8e8fbff840853081f11e-pchelkin@ispras>
 <3a0f74f0-7031-43e3-8268-473badd9f1fe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3a0f74f0-7031-43e3-8268-473badd9f1fe@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ispras.ru; s=default; t=1774800151;
 bh=wsYFc3Tx9EISvC1vyUkGB5FPr7lo2/T7m98WS8sicfw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XMTrtt7hMEZ8CzZI90QoUDs3OLWEoOmS6/3M6V6qtyg+rEx8B6Kp/tTa4X4VVdJJc
 sqbovAZxM8nFZuihgPu41DKntdu4zJv81wz/cTuk7Kc7I9th7kje1oZAT7ypCbmQqz
 Im/2VlOgs69XGfX8y9obf6+6O7vLibYppE45UOW4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=ispras.ru
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256
 header.s=default header.b=XMTrtt7h
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

On Wed, 25. Mar 16:01, Jacob Keller wrote:
> On 3/25/2026 8:19 AM, Fedor Pchelkin wrote:
> > Hi,
> > 
> > On Tue, 24. Mar 16:26, Tony Nguyen wrote:
> >> On 3/18/2026 5:05 AM, Agalakov Daniil wrote:
> >>> [Why]
> >>> In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
> >>> words. However, only the boundary words (the first and the last) are
> >>> populated from the EEPROM if the write request is not word-aligned.
> >>> The words in the middle of the buffer remain uninitialized because they
> >>> are intended to be completely overwritten by the new data via memcpy().
> >>>
> >>> The previous implementation had a loop that performed le16_to_cpus()
> >>> on the entire buffer. This resulted in endianness conversion being
> >>> performed on uninitialized memory for all interior words.
> >>>
> >>> Fix this by converting the endianness only for the boundary words
> >>> immediately after they are successfully read from the EEPROM.
> >>>
> >>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>>
> >>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>
> >> While this is definitely better, I'm not sure there's a bug here since it's
> >> being immediately overwritten. Seems like this patch would be better going
> >> to *-next as an improvement.
> > 
> > It's worth stating in the commit message that the uninitialized memory is
> > touched with le16_to_cpus() in the loop only on BE systems.  Little-endian
> > ones are not affected - le16_to_cpus() is a no-op there.
> > 
> > Anyway, for the BE case, touching and manipulating uninit memory bytes is
> > still in general considered a bug, even if this memory is overwritten a
> > few lines after that.  I guess if KMSAN supported big-endian architectures,
> > it would hit this, and that wouldn't be a false-positive.
> > 
> > I'm not aware of the details on how you treat the bugs in these drivers
> > for BE-systems: maybe they aren't prioritized and then would occasionnaly
> > go as -next material.  But, again, this situation looks like a real bug
> > worth fixing on BE-systems.
> > 
> 
> Typically the bar for a fixes and a net change is that it requires some
> user visible behavioral impact. That's where the hesitance on our end
> comes from: how does this cause a user-visible bug?
> 
> If there are truly user-visible impact on BE system for touching and
> manipulating the uninitialized memory, then it makes sense to go to net
> for me. I guess "KASAN/UBSAN complains you touched uninitialized memory"
> would be such a bug.

My first thought was that reading and writing uninitialized memory is just
undefined behavior in C.  It's hard to say what some compiler might invent
here.

The current situation is not trivial though because there is a chunk of
uninit memory allocated with kmalloc() to which we have a valid pointer,
and we are swapping the order of uninitialized bytes inside this chunk,
i.e. reading/writing uninitialized memory.  Basically it should just go
down to swapping garbage values without any suspicious compiler
optimizations - I don't think the compiler is aware that kmalloc() returns
uninit memory.


KMSAN actually supports one big-endian arch - that's s390 (the only arch
except x86 that KMSAN supports).  I've tried quickly to trigger the splat
out of curiosity, but booting the KMSAN-enabled kernel with s390 QEMU TCG
looks like taking forever so unfortunately no specific results here.

KASAN/UBSAN don't catch error patterns of this type.

> 
> Alternatively: is there a risk of some side channel method to capture
> that uninitialized data and leak kernel memory? I don't recall enough to
> know whether that would be an issue here...
> 
> I don't personally have an objection to going through net (besides
> fixing the commit hash for the Fixes: tag on the patch that was wrong)
> since its an obvious fix.

Thanks for the feedback.  I see Daniil has already sent some newer
versions targeting -next.  The problem in question is rather obscure about
severity of its consequences but spending some time on investigating this
now I'm more inclined to think there should be no opportunity for UB here
and it's okay to process the patch like Tony suggested..
