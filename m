Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8F6CA6016
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2578940911;
	Thu,  8 Oct 2026 21:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W1JjP7hcGP39; Thu,  8 Oct 2026 21:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6FA8F40917
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493403;
	b=S4sIiTdRIdD5Pbm+l6GeurQdIAG3NnWjGj2iPCufmPNz3nXONQpCTHm2LQqI2sjv8B7s
	 86GyzUXfAU1u95GJxAY+YYT+b0RvDdDGYq8rXeoGfE0u2CN7gwzTOrgc45sYgnpOeHxCI
	 SpzqzBD+64+skHZhpgrPOWarkpXnveKiZW8ZyorYDFwflik3NoCD3WZHoYdfHQQTvnkY6
	 JDT0NHJkhjwnkTHF+S6C2bOZazGi52Dubl6HR/NeODEGJ/9L6Jx4zjZPZI1QQfLS23AWQ
	 c1kNRLQfX6IjTgMWwLxnx66RE4re7B9ghLXiKhxvnEaWuSCmQmNT8vXLdSi7rgZkrqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493403;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cJq2iGR6XjS9tOGb5y7ebTTlkIKkVZtFa6s12jsD6jo=;
	b=dBeqoo0zzN0LxSz4nFclwZ6Xw9EEKGPX4Vuo0w8MGRfrghU9K1oyGEmHPXUa8tzax/xH
	 SzJ3QvdSnWogdwFAUH7k+hFATtkvNMqqbdXut0ttxT8x1CG/kT/9/o3a+MCVzNI8w8PRt
	 sZSsIr2QxlptbgKFoVaY3+2xLbx2XOi7wB52CMQRHFrCMf22RN/OyIMkDG2lPvkgedp7m
	 KF2ac7/X9u+Srsu+jOLDLA+O1wwskFz2ZscwtulIXxOOnMME19AZq9rnw6NCH/OYfTdzF
	 IXZKC1OLGUKk6UV+XpiEomNi/7kQhaLDSI+6mhC/epelXO51bnA+gJlE847scsEcW6w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493403;
	bh=cJq2iGR6XjS9tOGb5y7ebTTlkIKkVZtFa6s12jsD6jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=295CF9rS6orvfQE/lbERCtR393wKB5fb2cewkL6o/9l3xXDoaGtW/byoupioe0ZKD
	 3YNVk66UhiWdA3jCYYq7mObqFNoKNsywHJbx8lHrZCVEZopyRSnVE22wxYYU/g6NEJ
	 fzHOfIUV2utI3A0xbhL4MomGfmaUMKJeS29pnsaKXLVOQ0w+Hfo/NQHvIemG7DnEWG
	 ZNHfjkod+bOAJlmCsSBVDyWDMnmriGN/cFHUZDWPZTbPJE9AgrXbdV0VyG+9m4yNYO
	 +ujczsTU9NJKRFPI1bi01YaBVUNrnG8snC//z+V/ZMt7DkOXSoOgxv/jIB1OzUj7rm
	 JLCv/ro4yVO5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6FA8F40917;
	Thu,  8 Oct 2026 21:03:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5512E356
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AF3F60808
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7mdpoiZjrIdp for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5039960727
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493401;
 b=NeZlzbtCS7MHOuFDDka8IovapScvowGfJP39hvvLKOy6rUVy4igxATKdpmjhzl62Gn37
 kbzg5fTjt56JKQaaVIBtBotXUIgiLXCY9/ZTGEvf5Igb9nwCngzft5fLEuWgBz8GH5GPC
 Y8QR2gpFoy1/cnnAYeZF6husW/HqDqJ2DPb0GgFoLxkOxWJhjiyaPpOEqj7/waVtBipC9
 OkFh7F5FOocJ2+JIJukXGedXjv4HWY+tDhaJsdEbisdVnMKz/+5si+F7EKz3kFy1J91x3
 XI4TYD/eS1pRYCv4l+qEVIou2HZxFu9kxpisGghHonEe6OHiS2RoWfN3lvhpgh1VQ3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493401;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=cJq2iGR6XjS9tOGb5y7ebTTlkIKkVZtFa6s12jsD6jo=;
 b=ZsIl+2QockpVMcn1HDj0c6gskjf4/wJxuCPtaXfdko3AH1Xg5ro3kULWINesRQdb9Nqh
 dDh8sa6+49pEHy4VdjoMBKuCNnwCEa1udAqHKcSahQUSCR1vgMnZL8ThG9LsUJzpKThi0
 xBvyjHtDjtHK+80pBu1DnM+uMVI/3uQv/6+nQ3w/x7EuJaYgeYMPyRzAFcEeygqg9vtSj
 14c5IHUjvkMslhhgPJ4DDZ+GXMDyzswuHoApLhpnPNXGjruouX8p/KYVim0B9SMGJrwsS
 WmLNa97NtpyEg1Wc0O66Le3YxtiByP4whHc9toM0M6UwYc2uvhSTUNhWLQx+WwuXasg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=YMOucgDj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f33; helo=mail-qv1-xf33.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=YMOucgDj
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5039960727
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:20 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-9178510f3bdso42601836d6.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493400; x=1792098200; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cJq2iGR6XjS9tOGb5y7ebTTlkIKkVZtFa6s12jsD6jo=;
 b=YMOucgDjDQEJPQVDSOmvTALgfykSs7ZQt+9nuLCTP70LiIz+Zgnuqnmu908aAie8vu
 eVtN9NWZ1Z1B4u3Q0u0PtDS5qClweryhOneGmo+3R1kEOGphYXOandTe5JlpjjVrON9v
 wZxEPCLkrMVH8+rgrJYiIdS/7GWmdLTZ1482dUxEDqM7fi9Sh84zzkQ4MPTpDKy3RX74
 akKioGfirNfpMoosBCDT2B1cUVUFQzt5QeakgrPWefxGD03x4rdmDYxJnyzcgUZQ/2DA
 7TQLw3Qa9CSR7SPsffG1gtAVWbKSuhZG5tgMWjUsBFxbxwT4lGjXBSk6DcH87HQgp+9o
 3iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493400; x=1792098200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cJq2iGR6XjS9tOGb5y7ebTTlkIKkVZtFa6s12jsD6jo=;
 b=xCfyvyVKPbIxS2sB80iFLJGdboRz2WCpSkSYVoY29K17wBP2OpN/aP2SOOCKLYs8gy
 6yGI/1Cqbcqwr14eN0VhY7X4iHgkNaiACT6FSgx4oNrSy4aIiWRuArGkEPX5MuwIYRDa
 KT9sAgRV0w9NkHmv/uDV/IOOZH4pa93lnDqpdOQFnklon3p5ViD64wLGYjcgrn5iNeP8
 9TzK1wh3cL8U6Ueaj5nTo+HrPBapTk4LzZ2GcdjD2yKl5vKRQ9Gz706uI87fO6c8vmNl
 eixbfAaWdwLi9psloWlQjCpd35K3YNfZFGZvNpBmvZFy9o07CguoxFrKXJUTF+xgF17/
 cZRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2qr6rM5m2CjZPtxbUSwNtOFoIgiO1+1dOsWrtzIZVbY9YE8D4DA8+DyNIeZANc61ZU7R5fV94Khl8FaMcFNw=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJ0JZPplPmyLQgOgLdUULEtNYq512ZiNGnvtteeJgN5SXGHcLJe
 3b/qtPDv1AM82TIJRP9bfPhyO8VdsGium+dQq1TOKmit/d4XJVLXd4kEUrahBqxgCIU=
X-Gm-Gg: AYBFou0Td362w12Tyxh+9dWYmjIv4YVi3PGkabgWBp6l1NtCHK0Jj6NS5+e9GF/1r6x
 4CwRpx41I5zFhO1EF5yQaIPeiE5xV51RCwcqgMYXOGW2Spqs1LQFPQMxZz9rNMPS77pnwLvWP1I
 L818A+Yptj3CjLFCemE/oR9xGpmRRoxCgLij3G2Jks1YbY1He6uBrGhIo8rsfsi+KpLd7F+hXEU
 YDQoW5w3c3PzWQYxCKZS4RM+Crcn/hIUwXBcuYMktUDcd3Ql+3y01yJRV5tLIBBydb0Yowg9m1h
 3Q73zi9X+ozFEIlzoM9CyGbiftdxoCDm94GUOpY09Q2PrUXRA+TGBfJma4Z3/uofqz5lto5I3yN
 vCzObFvKcXstEntNyKXeRXIH5FQcXcPVjh/R1L3qLR7rGzXbWtrMvfdb1CKfUexaO8LYLpi2ye1
 jD2qR3PuMKYHXGGSZ7miBnWs7AfvGTxD/NidL56eQtlpTgtQnwt9ETbWl1Pws9eOVtETPUz6Zcj
 i1r1ALqaXZGzBk=
X-Received: by 2002:a05:6214:8506:10b0:91b:51ea:8f3e with SMTP id
 6a1803df08f44-91b51ea9005mr10470996d6.49.1791493399667; 
 Thu, 08 Oct 2026 14:03:19 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b55120027sm41246d6.49.2026.10.08.14.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:48 +0000
Subject: [PATCH net-next v2 01/10] net: skbuff: add skb_drop_empty_frags()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-1-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493384; l=3047;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eNF9AfY31ifKJcp/wEnDWb5NxkFPFrVkSamyLYsUttM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOI8lG/wdh6wd8yc4i7FHBwvmuyCaLtAuFDjmIGDKRvpDQpmhSkJsjkYyP5E/1+czZMvAKz61ka
 mmydLfI/gLQo=
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

__pskb_pull_tail() releases every zero-length page frag as it walks the
frags array, even when it's asked to pull nothing.  Some drivers depend
on that.  xen-netfront calls it with a zero count on purpose to make
room when a backend fills the frags with empty slots, see commit
d81c5054a5d1 ("xen/netfront: tolerate frags with no data").  netxen and
qlcnic get the same effect when the frags they pull to fit a TX
descriptor happen to be empty.

pskb_may_pull() returns before getting there when the head already
holds the requested length, so these drivers can't simply switch to
it.  Add skb_drop_empty_frags() to do just that part, unsharing the skb
first if it's cloned like __pskb_pull_tail() does.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27ec1e38c828..c1295f6baf6d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2840,6 +2840,7 @@ static inline void *skb_pull_inline(struct sk_buff *skb, unsigned int len)
 void *skb_pull_data(struct sk_buff *skb, size_t len);
 
 void *__pskb_pull_tail(struct sk_buff *skb, int delta);
+int skb_drop_empty_frags(struct sk_buff *skb, gfp_t gfp);
 
 static __always_inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ebe61c7fc4..f798118df112 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3004,6 +3004,46 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 }
 EXPORT_SYMBOL(__pskb_pull_tail);
 
+/**
+ *	skb_drop_empty_frags - release the zero-length page frags of an skb
+ *	@skb: buffer to clean up
+ *	@gfp: allocation priority, used if @skb has to be unshared
+ *
+ *	Releases every page frag of @skb that holds no data and closes up
+ *	the frags array, so the remaining frags keep their order.  The
+ *	frag_list is left alone.  A cloned @skb is unshared first, since
+ *	the frags array is shared between clones.
+ *
+ *	Returns 0 on success, or -ENOMEM if @skb had to be unshared and
+ *	that failed, in which case @skb is unchanged.
+ */
+int skb_drop_empty_frags(struct sk_buff *skb, gfp_t gfp)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	int i, k;
+
+	for (i = 0; i < shinfo->nr_frags; i++)
+		if (!skb_frag_size(&shinfo->frags[i]))
+			break;
+	if (i == shinfo->nr_frags)
+		return 0;
+
+	if (skb_unclone(skb, gfp))
+		return -ENOMEM;
+
+	shinfo = skb_shinfo(skb);
+	for (i = 0, k = 0; i < shinfo->nr_frags; i++) {
+		if (!skb_frag_size(&shinfo->frags[i])) {
+			skb_frag_unref(skb, i);
+			continue;
+		}
+		shinfo->frags[k++] = shinfo->frags[i];
+	}
+	shinfo->nr_frags = k;
+	return 0;
+}
+EXPORT_SYMBOL(skb_drop_empty_frags);
+
 /**
  *	skb_copy_bits - copy bits from skb to kernel buffer
  *	@skb: source skb

-- 
2.55.0

