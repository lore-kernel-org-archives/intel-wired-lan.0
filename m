Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4587CA6017
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7857C60727;
	Thu,  8 Oct 2026 21:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVZYdbpeyKkS; Thu,  8 Oct 2026 21:03:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 84C6F60808
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493402;
	b=fufvZxIY/g9ff3/d1mZ+W+lVLWBW/WXusg8eRrhy1wmZRtm7DXCMpTgPU1f9rx+TuXig
	 pHhdYVmmHFNY+DnONFRHtUV/1QkYL5roXQynUfCL9ujwcefkdoiwotI0G26K8eOY0dEI7
	 1BaotwvPu8kpaD9U12MUSEhDBdBbGOs3LrEiIh8WDFtLDWEWdNJmnQLTq5t5U2roXCJ7y
	 lP2uuNOMQhEgtOf5sG5d/bRfhqB7knrTWb4bkzRMZpfmetXw/souU5wAURHqBQ4BnWRPe
	 sELl8jmnFL5bubqYKgAEneG9xVHQO9Me/oJoIL5jLWqVjvVPyIrIyL0xmAGbuX/ixQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=veWMGuSVswTQSpRQuCY1UJnPdK7Vk9Kj0h3fikv2+bk=;
	b=ohQ4jss1wU0sYYw/t7ElNg8ifzmhU7wRMtwrtTa4DiBNsEbqMeaWoTuGGE1VsPmrYHPC
	 D3L7WaAc0UNQ2vodpADd/g4czDXHvxf/ZNheJB/xpemgIMvK8XOwH+wR/++iuDy6MnHxc
	 UfL7hlBWDsd0JvYNJMov5m/UAgyM1YlRFcHI/9XQn/Z/ta28yXfEedDFbYZJ/nQGPC5XR
	 /uyhm+kIJ8nnngmsSTWrXyujCiQZkyqArbJpICk0h5FrgxEeO7U5NyEsLCDkHT4prSc17
	 Ulu5IgJFYHTtdD7nyQoCSC6XVe4NyF7ut5vpYkGmkDG1NYkK2AWAa3WdWD70F5icIkw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=iiWrfWYz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493402;
	bh=veWMGuSVswTQSpRQuCY1UJnPdK7Vk9Kj0h3fikv2+bk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5AwuX6pAFWDbdDGD0dZF2UkMEi60xu+u9nmd1aBDdYUk9UtxnaXBXvZATLCl/YZvt
	 xox4Vi2Fi93ELbs5ChkdeZ1rmJFYD7JQhLepb5lhoHGDEv+NzLBXqa+a0B3QWyGmPX
	 uFFXMVvGJgbgAMC2Llny8ECkTU7uVBetjK+9tVGY3TJLjRXZKJEAIots9J/NP/Vmwt
	 pECK1O05nuwdOvPoWg08AWK00a0QzKWio2Tbv/2jq9wGZryL2PWv9K+tTqvaSQ0DcS
	 aZGfLzKK+jwTbqb2a3jY6u1Prl1bV/0SIM4sQHQ8sSEmbfYTQxGA/QJYGz8eqMWvMy
	 j+p2IGMuJZevg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84C6F60808;
	Thu,  8 Oct 2026 21:03:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 042A22E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE5CC60808
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9zEWUmAd_me for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 69F7E60727
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493399;
 b=qKOWEIZS+8/QZT4RCRBMXzo1Q0TDLswkpjUQ+jynL7Mx7G+Tg+7F/Du53FiVBCFNPcH5
 TzQNe500E1o4AI+9pQL9Z8xSKW206X/RM9hr2F+vU4fRYBNXtfSeuNQlxUowBmpwXVhcY
 HjiuCDb9Enjl5ikdaSyq7NHmxAvB2bXovG9Ac3t7hQX8YCTqfBstJ3Hs2+a63rOVInLhM
 4G+RI72FYeNrzswQupKNhZrip65fzsKYVVW/OKn6g/AKwhQBdyAXO81vBy6Ef5dROVvb9
 Bh4fWhCDoIT8pJLy4HA9/dDMMs2aEMloBAlM8cyH34wfmzlKwA9akBO5+nXSyPB33sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=veWMGuSVswTQSpRQuCY1UJnPdK7Vk9Kj0h3fikv2+bk=;
 b=rb4mcyiEf6nVfdspDr1DI4DGQaD6iw2rdoVHShfu1Tkawp5y9fzTb/OKEhYfVqqOv68B
 a5FHpVDQkZGCLjvh1x/i9S04oJxXFAvedpEcOvkvN+gWvTXE7wnErT3DG9nYw8/cc2u5n
 ontOy8R0U2FfkEGt7gAcd0TMLjQln29+N8YqGWn/ZxdOh6ZFeWhkPjJS6VuwOhBR2KHRA
 6Z30bm2EZ4x+Ga3bFv7TyWy91E8LxeChORck3cRXWPb6LDD71HoLxSeU6kF6QhrYrvBpg
 PDrp2Srrs3Oc8Ag9Xaog7harb/XAYdkNLZthWktEeM9UwZvGlP0KtUGNLy/d92WRuIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=iiWrfWYz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::834"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::834; helo=mail-qt1-x834.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=iiWrfWYz
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 69F7E60727
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:18 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-53440816851so61717051cf.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493397; x=1792098197; darn=lists.osuosl.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=veWMGuSVswTQSpRQuCY1UJnPdK7Vk9Kj0h3fikv2+bk=;
 b=iiWrfWYzuYr79HOatqqS46HJUHW18NRB/2IgwZzDdAMnoXOE8hMcRTJ2yv123bwC1i
 HKGONp9eJFaqZG2AVQEJCiwH+a9dLwgYVvCxqg07xTNxqYVg6SA9PbfXz9JttRVRbwDX
 K6H8B15rbWQTQr6RbJCWK4SuS7BNgtjt6+cFpBE4PWRJ7GYsYvjG8RyGaK8NXKPO2H1M
 8eqoRYKSwrPC2BtUl8JwBVHdiIbN/1ee70+97bI1A4ZnLCBuJgHZDrTKMrSAoVteWK6N
 jli1dcchjhV4fyo3lE7RBw/By0wyiiMrZoBcl7WBWwpvpIth2LY8TWCOdkNOrYbXHjRr
 V5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493397; x=1792098197;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=veWMGuSVswTQSpRQuCY1UJnPdK7Vk9Kj0h3fikv2+bk=;
 b=00WbksAG9iEszOQNvl9RXwnOl+lH7pLHvr3IGu9xfhVzW69BEWpxRYm8dB1asXmStA
 RPU3a1rBus/C8591vFyjImdoK61JxsDakpzPmWR7SIO2ttzzvd1gL26F8NMkNVHxKZr6
 IlmBrHYf5JY7OiYhvvPXTOPRwVDs5pVir2epUU4ju3qqCtnu1hyAt4+B1Mflm7PFRBLX
 Gw5gkguCa6oSgQcSRRWqLsVTIFwpfwFSRo/hm70fJ4HnbfXQUh6xB03+3qrlZDKpQWl5
 aaZOvxbPEW9GrFgxKUcG/9ujYWhcqudGCsNhJYDw/w62CSlDwMXM/OxgPU+y4gk7DnHa
 c9rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+eg8bGC3x/de+9ditK3ExOr7UaRb/AgRmTfXWyUrvb13A4LQRDTg+n0viJCfvZRYVDUoOwLzL6KR5qEgxows=@lists.osuosl.org
X-Gm-Message-State: AFuF++kgcTGzF0D+I8wdZuvgYM6kxEI36T035YAlCSs8gGIm5KQd6ULL
 RUd+mIZbbgXXCCZ0btfJPMTs+ZMAdaKpzba2375xTubbSYZHbScY6INVXdgp4LvSHfA=
X-Gm-Gg: AYBFou18mgFvJWNAtN30s0HIDQwpgfDHh8I87Ce/BWIs9m4MYgrGiIl9FSeTWwkxhHJ
 tzZ969a80eN2yL8C7foc9wqNHTxysivnW+LoLMvLXENrIXAKCAR+EhmRoeJ/erSLhnjsiKvaOsk
 X6APMlg94SaBvca1fOvZt009OjwdREbwh9DFCNDbsJBI+qNTBpvgpDxr+JE7P4Y9fNZ5MnbtRJB
 2bpTA3jzuvKevPG/aJvvbQ2iEONWyXxGU8b9tG7vQxcAU22Dhy+nihRXZxK0lpbDYvK5PYcBj0a
 6/qWbOhuHrXWV+5Um/6E3W+j9jURfPsrZigOlwYzvQQEbNxqaKm3RP6ThV0PSU5VT2MHh/HhMSK
 w+fgrFSVtKaxTL2sIVH8It7NBk7tMOMDkgeWn7oJryaWlrUsdkEz8jsQ1iY102/60zkzNjh58Jy
 R+S/O8mNpsuzzvBKLyEu+hsBwK1pfGK4IrZmfiR7axLp2aun2rursCa1ymCCpprLnVOOjP/Hx16
 D12w2WLtwSyrI0=
X-Received: by 2002:a05:622a:1f1b:b0:535:70b3:aa38 with SMTP id
 d75a77b69052e-5357573e670mr108763961cf.74.1791493396306; 
 Thu, 08 Oct 2026 14:03:16 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7dd1a0sm3101431cf.27.2026.10.08.14.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH net-next v2 00/10] net: stop calling __pskb_pull_tail()
 from drivers
Date: Thu, 08 Oct 2026 21:02:47 +0000
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPkEyGoC/32OwW6DMBBEfyXac7exLQqip/5HlYPXrMMmxFi2g
 4gi/j1Ae6x6nNmdmfeEzEk4w+fhCYknyTKGVZi3A7jehjOjdKsGo0ytlaqRKoz5Shjvw4DFyoB
 dkolTRu8rT6atK9YW1nxM7GXeu78hcMHAc4HTzyXf6cKubNXbL9nMSMkG12/WEI9UHXfz77Et0
 0suY3rs6JPeV34pm38oJ40K2w9tSHlqm4a+yjiLizZ09t2NNzgty/IC68Wn+BcBAAA=
X-Change-ID: 20261006-b4-pskb-pull-tail-drivers-ff4fb2964e1a
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493384; l=4998;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=uEkT7bvpoCXxFRYilwrMqw4m/avYlKD/tw+E4y7qkfI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCXCcPzYE6MckGlWvZs5GlcBhgvsQUwMKctcIvHVU60iM6MoRF4p5/Zxb/dlkHyUCxdBM8d4+e7
 75wiNZDfujgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA
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

v1: https://lore.kernel.org/all/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com/

v1->v2:
- New 1/10: skb_drop_empty_frags(). xen-netfront, netxen and qlcnic
  relied on __pskb_pull_tail() releasing zero-length frags even when
  there's nothing to pull, which pskb_may_pull() doesn't do (Sashiko).
- xen-netfront, netxen, qlcnic: call skb_drop_empty_frags() after
  pskb_may_pull().
- skb_drop_empty_frags() checked with a boot-time test under KASAN and
  kmemleak, on cloned and uncloned skbs.

--- Original email (v1) ---

__pskb_pull_tail() is the slow path behind pskb_may_pull() and
__skb_linearize(), and drivers shouldn't be calling it directly.  It
takes the number of bytes to pull relative to the current head and does
no bounds checking on it.  Ask for more than the skb holds and it BUG()s
in skb_copy_bits().  Ask for a negative amount, which is what a caller
computing "len - skb_headlen(skb)" gets once the head is already long
enough, and skb_copy_bits() is handed a length of nearly 4GB to copy
into the head.  Under KASAN that shows up as an out-of-bounds read of
size 4294967288, after which __pskb_pull_tail() returns success with the
skb's head and paged lengths no longer matching its frags.

It also returns NULL on failure with nothing making the caller look at
it.  Eight network drivers call it directly and four of them don't
check.  All four are RX paths where a failed pull is followed by
eth_type_trans() or skb_pull(), which BUG() in __skb_pull() once the
head is shorter than what they pull.  As far as I can tell none of the
four can fail today, since the skb is fresh, isn't shared and has room
in the head, but that only holds because of how each driver happens to
allocate.

pskb_may_pull() and __skb_linearize() take the length the head should
end up with, check it against skb->len and fail cleanly, which is what
every one of these callers wants.  Convert all eight drivers to them,
check the result, and drop the packet on failure.

The last patch makes skb_condense() check its pull as well.  It can't
fail there today, but it would undercount truesize if it ever did.

The callers left in aoe and xen-netfront are fixed separately, through
the block and net trees:

  https://lore.kernel.org/r/20261007-b4-aoe-short-packets-v1-1-db5155f7bb9c@toxicpanda.com
  https://lore.kernel.org/r/20261007-b4-xen-netfront-short-head-v1-1-12d7113a7e4e@toxicpanda.com

Once those are in I'd like to stop exporting __pskb_pull_tail() so new
drivers can't pick it up.

Testing: every touched file builds with W=1 on x86_64 allmodconfig
(ftmac100 on i386, it's 32-bit only).  e1000e under QEMU, which hits
the converted TSO workaround on every TSO packet, passes TCP traffic
between two emulated 82574Ls, and with failslab failing 5% of atomic
allocations the failed pulls drop the packet and nothing falls over.
The same setup with jumbo frames and copybreak off makes
skb_condense() pull frag data into the head tens of thousands of times
a run.  xen-netfront ran as a Xen HVM guest under QEMU's KVM Xen
emulation, with the backend changed to spread frames over 18 and 19 RX
slots, which takes the converted pull in xennet_fill_frags() and its
overflow path.  The other drivers are compile tested only.

Thanks,
Josef

---
Changes in v2:
- Link to v1: https://patch.msgid.link/20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com

---
Josef Bacik (10):
      net: skbuff: add skb_drop_empty_frags()
      net: ftmac100: check for failure when pulling in the RX header
      net/mlx5e: check for failure when pulling the Ethernet header after XDP
      net: niu: check for failure when pulling in the RX header
      xen/netfront: check for failure when pulling in xennet_fill_frags()
      e1000: use pskb_may_pull() in the 82544 TSO workaround
      e1000e: use pskb_may_pull() in the 82571/2/3 TSO workaround
      netxen: use pskb_may_pull() to pull excess TX frags into the head
      qlcnic: use pskb_may_pull() to pull excess TX frags into the head
      net: skbuff: don't reset truesize in skb_condense() if the pull fails

 drivers/net/ethernet/faraday/ftmac100.c            | 10 ++++-
 drivers/net/ethernet/intel/e1000/e1000_main.c      |  5 +--
 drivers/net/ethernet/intel/e1000e/netdev.c         |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |  9 +++--
 .../net/ethernet/qlogic/netxen/netxen_nic_main.c   |  3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  3 +-
 drivers/net/ethernet/sun/niu.c                     |  6 ++-
 drivers/net/xen-netfront.c                         | 26 +++++++------
 include/linux/skbuff.h                             |  1 +
 net/core/skbuff.c                                  | 43 +++++++++++++++++++++-
 10 files changed, 84 insertions(+), 26 deletions(-)
---
base-commit: a5e7d8e446af9803e37a3b6a4d416fb41178348f
change-id: 20261006-b4-pskb-pull-tail-drivers-ff4fb2964e1a

