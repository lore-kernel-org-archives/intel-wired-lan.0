Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5195E9D3E6
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Feb 2026 14:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8120E60D62;
	Wed,  4 Feb 2026 14:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7na0AxH6DQwS; Wed,  4 Feb 2026 14:30:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E05D60A55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770215407;
	bh=AsQa8W6KnKJ7vVh4W36ji+1sTPnT2pkn89GFbzErC2o=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zDkBxeFA9IUYEv3ZeZX6YWhl4+s5HxUbpR4NPxxWh2IgqDTLCt83tFbk0BqK/lKYC
	 1q12SGiIaaJnsAO0AOIaClzPJnXuGqvcgVR+MhaSOtrNH1vSaRfDIgp84jKITUM4KX
	 q17vwer3geqzllc7pGrRLwZI2ei4V4M+x3+NkanaacCQaMYJ4f0L9r+xdA0UyAKlLQ
	 JX8Z/HpvvKND0hPv0NOZRM8Hn/tMdfcHM740FZj5n0Eq3YP/k26E//Md2gM4dthZTy
	 UTGq5lNzkRSWCWX12eKsOFhGGTjD3s4/U1fi7I2nNhM3/TpJ3uODlHhGTpcIkb8wZl
	 t3WuDRAo89PVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E05D60A55;
	Wed,  4 Feb 2026 14:30:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74F1BF4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 14:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6236F60BD9
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 14:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLwICvA-DNaP for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Feb 2026 14:30:04 +0000 (UTC)
X-Greylist: delayed 2282 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 04 Feb 2026 14:30:04 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7041B60C30
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7041B60C30
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:242:246e::2;
 helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net;
 receiver=<UNKNOWN> 
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7041B60C30
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 14:30:04 +0000 (UTC)
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.2) (envelope-from <johannes@sipsolutions.net>)
 id 1vndIR-0000000EPxD-1SEs; Wed, 04 Feb 2026 14:51:55 +0100
Message-ID: <f3ef31b332a5f28a20054d5e55e6024421f14dd1.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-wireless@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Stanislav
 Yakovlev <stas.yakovlev@gmail.com>
Date: Wed, 04 Feb 2026 14:51:54 +0100
In-Reply-To: <CADkSEUhXO-01yaNUawo58MQ=xOC5bCDHWCFrCwe6TX2D+WVR=w@mail.gmail.com>
References: <CADkSEUhXO-01yaNUawo58MQ=xOC5bCDHWCFrCwe6TX2D+WVR=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=AsQa8W6KnKJ7vVh4W36ji+1sTPnT2pkn89GFbzErC2o=; 
 t=1770215404; x=1771425004; b=c7ElgIRUuYAK0BFa3HrcBTVI7vmw/FgkmVog76bhl5BVZET
 d2j3cCw99mpyPMg/1oZE6wDFIRDTvYkwOfioNXHkjydOgZg4cGfcVs0qcA2qyQVwg2EDKna1he9wc
 sgkv58Fz+DFCC/mt3/u7l6Wmd9VlR+C9VQTbp858n44W6B0dWORsSt88ILz/959kHIPRymHsAzJsB
 gSHPzkv9XbmtYe7NsnKs4kQPQyVn0/9pE+sXcQNxMNsfRiAWE9NulLlTrJdyVe9L1WMmOisbjxvH1
 q1gOcF2wToEq5c5NZfgaTk4a8sWIc8+daszEu1jIhJOFn1RkJxNS5Z1HkvXSYEQg==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=sipsolutions.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=sipsolutions.net header.i=@sipsolutions.net
 header.a=rsa-sha256 header.s=mail header.b=c7ElgIRU
Subject: Re: [Intel-wired-lan] PCI ID conflict between ipw2x00 and i40e
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

On Wed, 2026-02-04 at 02:15 -0800, Ethan Nelson-Moore wrote:
> I have written a script to find device IDs that are claimed by
> multiple drivers in the kernel. It has found that the PCI ID 8086:104f
> is supported by both drivers/net/wireless/intel/ipw2x00 and
> drivers/net/ethernet/intel/i40e. I assume the i40e one is correct,
> since that's what the ID is assigned to in the pci.ids database. Can
> anyone at Intel confirm this?

FWIW, I wouldn't be surprised if both are correct, and we just forgot
about an almost 30 year (I think) old device ID assignment ... I'll try
to figure out who even does these assignments etc., I don't know right
now. Let's see if I can figure out anything for the ancient WiFi IDs,
but I'm not very hopeful.

If we knew the subdevice IDs we could perhaps match on that, or add some
code to have ipw2x00 reject PCIe devices, and i40e reject PCI devices,
or something like that ...

johannes
