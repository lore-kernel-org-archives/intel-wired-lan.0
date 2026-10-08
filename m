Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B18CA6018
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4138340933;
	Thu,  8 Oct 2026 21:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WDm232hbM2U; Thu,  8 Oct 2026 21:03:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DCD640921
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493414;
	b=H02Zh4Y2IaF/50aYnzJcVtljM5oieJK0XNdEc6waT2uXIF0lkcZkB3GjOFjMbAPRIxDm
	 Q4Nlm/U3PXEJxzuiAaQAvV5ocDKWydN3gY107ju475poFKMOdPSwd5wcfFQCYPeNJlHu0
	 QR8NkOYCYIUy7pQo/ZuIsEuln/dF03gFxUnBGfUw8XFsle995Djn6SbbXiF6IdiRA3XlX
	 XSqKsrlmra96SvUa3wu+UtPQVqLm60ZH9zJBlJVP1r525heOEVMXDc8ak8pFrKCyFUcMm
	 8pjOyme2Rck5h2Vx56KnXWrxos7hKfcRQ0RMtbm8WdwYGcySoJy4IO9qI1653mGAJXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493414;
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
	bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
	b=fl821aa3RHCJTx1+O7/C1CXDqaVEE73h7AcJ4toXnQoyhIIjd8oSlAkoDw/zG8NWZf2E
	 noxLe1xqIhDjqriTMvgQ6A64LtCQFaxmKLLN+qt1DKmagJWLbF6ZfSYmF3upOnsvwY2Gi
	 4lyc5bVdWcD4tdXWTQFtwit9oPxG0D45v0HQOTZkdCrF9IwzaORjOZX0TqST7hOAEXwyh
	 FSP/xeBNXp3uKJ2y61+flQUbmLho3WxgmoKfcuAG2Vrf/Gf0EyXWmmVpodHdYd59ZyL/3
	 KtDyXl4ixl8yTNMNg/Z2+16KieT/5nYCpVuYVCwpWzOr+gkC/i6+NLw5rTWloh8ltyw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=S9QU6ytp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493414;
	bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bxy1VgfBFI9lNWFC6hClyX1FIRCLxEAo3BVnA96mu4pQLPm7r5o+KXOvnqSt3/w/+
	 2/qT3ZfMLrRiyLWXTKA9MTimRsWwjeHZElzf7XjEyc3FCOT8SiWhpRNiETOZxniV/Y
	 A8VRAyh/hzyDiH8I3bRkZHm/j6AmF4PxOlqIPMlNy94ZCde8HXzQS+vO7C8BfVgjhY
	 hwSHoyQDfhklgEYc7i8BanTuYXZLC0oeLsnIJeO5pGnmrbovfxTVtXOoHBznfAhD3y
	 gSTC+piBoKUXvwG2gTjVgSsUhfEv0lqgwO5nmgFK7hsmVzx/DlPCF6gnD9dlTgtebA
	 GS8f9D6B1ZnuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DCD640921;
	Thu,  8 Oct 2026 21:03:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 17CE82E0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09CDA4092A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o2ViYKnF45dc for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39C0E40911
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493412;
 b=JDdyyG0VXy8u3jyqg0TViQEo9vVfoKx1dpKFhnuP6gPzqXDJEoPknxCy0HtucBo01gVP
 eJls0MZl0oH00P3zBvUwwHeLHJRyyX/7cA3oQXABZ4ybgHdkl8uL1Jwl722hOou4+Glx7
 SA5LfOkiDsVJXq69KaaZNH/r9Kdk0GFZ6gcnltqT3lARGm8nLz0QKBnjeyNPYG6LXTpLq
 rQxDpQ6uLJvy5Yz9Xd1JrqxQH8EKqakz9J4qwiiayGEZ3wl2C79N/2T9gw47gxbSlcNhf
 x+OsDPqghe4g6u29Bb+zKjyxuIcvtBDrQGcsP9krrCXEsrwkLPWDjaKXhl9DWnXcHEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493412;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
 b=NbqLnc9W9ZCglf5CGqhu0fdvoVD68CmDxj9o5koItAUjLjR/vRrjlCJ1SO/hBxDSRoBv
 iIbhdT8gi0Ru5vzR+HS8543HLp2gfJfKkBWnp93wD71ArHeJ6B9KUZXQCNxNsViYQ5vUy
 INpuzaccul0cB1Az2zWWdJW43slWCe020fwwvyNSdLZQATcr+bQJW8hRwB37QuaYfT9+r
 w3qox47JXFgk8/1LBoJCeo0P1nDxKnKLOq+dmuFn1daB/jvf09BgpwnxlPMQB0kWXd2tP
 Ecp4mCzg/shecxbqHg67LC0VmY711gixFgsFmnW9U+1f0yEE0AifcT2n5Jp+4AtWZcA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=S9QU6ytp; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82d; helo=mail-qt1-x82d.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=S9QU6ytp
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39C0E40911
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:31 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-530e75d1ba1so32390871cf.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493410; x=1792098210; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
 b=S9QU6ytpFqhY72MB8oUOSe7MiU6DFm99z8w/PmFo9YZpSjmDko2H7dWpu2ZbH6XWeK
 EkPlDr87oXSkzZoz2TVJAdm1uHssXb5vAR/hIslsH+cXcRfV0lL6MvO6iL2OiiS6DOTb
 KSkTHPoTVQKI9n3j326mlqXvRvrO/UOy9MRLO2vRzzA0oogQE8qWbnyMm1s2qAQ8AKez
 k6wSOm28Ul//AAiYKhPvxGtRdqtvC5DPS7x1TpJ+U1FFvxVRg+qPbNXvTD8wY1IaNTuG
 UYDbRz1Wt5zmg6yLSsuNYuxAKVVi4qQd+T9s8zoPhMXUWHa4LHSY2mxCOoES2GVewljH
 3qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493410; x=1792098210;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=blrnvRK83a0BrC00ZsKjSLnGbEsSK17m6K1yrBXm/SE=;
 b=ron+RjFY6IQn0tSp5zndbjqOVJm62aOu1F8ALfpjzTtDrDmKfBFg/zmdLXtAi0ru8W
 7NSiEJ0RJKchyWjbLcRiOlZL/2O0nuGEhKzvop15TFbQP2UHYsNMtdKm+GRnNrwD213g
 b1hrGY3pVG9J6kDuNu1d+qG7xSaB3z5S61dQccTWlk/NOBvd12qXNdpJH59PpV1RUhME
 R4rX57tZoi1JTve+Pnm54+BZMDoVFhTgnnAJ1qPg148wkmtSZR/DLXvMgANURji9v9s4
 CeqzOqmLwAU+dQe9Jp7TddBweNo+o0tHTmDzWa1QXSJYdeVvkrpBdRsjyy9q+IhhDymc
 TdXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxKGsHHbfE5dxcJ4LF/5Uhx5F6kZ2asEg7x2PFK2x56rSoM31MCvbNPzC6rg93tDHoecSfKzwF6tki6NAvsiw=@lists.osuosl.org
X-Gm-Message-State: AFuF++kV+XZvgqF/SVGc1fgvQmlU+S0ARNU1JZHEJDZK0gwgV/YbdWWr
 zBiPxtVIwnNkumeZ+2bC/pNam8h3e8siBh6ccKwaIIZo0WuKjnRLdfwpFEFBb5ofDHA=
X-Gm-Gg: AYBFou1MmRXuiFU2mkcC1n+k9XUMXAyz6xGzEE47ZhHO6V3RlkTSUb8o5re/Gj+fqna
 II8Pj6RJ6dtliyFtig8lfHHTZfKbg69bOAELBXsBui4MpW9IujoyXfzCz+kV8Ev+a1b4t1tnz88
 7YN8OSXfhWCC5a+RBpswtJCtURCYudCyPwXmUO2Fzjcoy88tWrSUG+IUKelRuYYtG4KnZRI/ece
 gDBLBbafoBHd4N5Mfl45jomRgmMj9hqnUQu3OadIUfZXpoYzZtLRF7gO9CloJ1XWAIJRE9Fw8Xo
 rVos/RIlPymomOhtT55bFkL/1KGe5H+Hu5wxSzbVMVDJM/TcBtKzSczRMzHE6aHoOOp0zYy/5/O
 bMFXp3Pk7u1uRcAqPZMo1tVvYUS/T9vOLvtdZY1XBSTbIMQ4041MdIfsTZrIQuxVsl9ZA15AT2E
 UBh6p7cvxhmg7fSI8R/9gIpXbuZeYvMezlmpWKWfDmJSkXxx6RClojohzosPa9swEFhlGvEvCqG
 RDxmIqJLSdHfBc=
X-Received: by 2002:a05:620a:1d03:b0:93e:9809:dbff with SMTP id
 af79cd13be357-93e9b8ecbf4mr1178890585a.82.1791493410404; 
 Thu, 08 Oct 2026 14:03:30 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb99074f7sm22172785a.46.2026.10.08.14.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:51 +0000
Subject: [PATCH net-next v2 04/10] net: niu: check for failure when pulling
 in the RX header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-4-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1236;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=3f5WzTjnDsDOAnT0hR8gZXIWFT9KoT8c/AVMjDx6NOM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHTAZLO2IxS2OmXjiwrMC0xtj/kaDkW3OSxxKLc7dWB8wtA0dY5E/Ye18IDZRljWIONenVbHWP+
 B0r4Rpj6pmA0=
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

niu_process_rx_pkt() uses __pskb_pull_tail() to pull the hardware RX
header and the Ethernet header into the skb head, and ignores the
return value.  If that pull failed, the skb_pull() of the RX header
right after it would BUG() in __skb_pull().

It doesn't fail today because the skb is freshly allocated, isn't
shared and has room in the head.  Use pskb_may_pull() anyway and drop
the packet if it fails, rather than depending on that.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/sun/niu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index c74a97fe5464..d1c0e868004d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -3488,7 +3488,11 @@ static int niu_process_rx_pkt(struct napi_struct *napi, struct niu *np,
 
 	len += sizeof(*rh);
 	len = min_t(int, len, sizeof(*rh) + VLAN_ETH_HLEN);
-	__pskb_pull_tail(skb, len);
+	if (unlikely(!pskb_may_pull(skb, len))) {
+		rp->rx_dropped++;
+		kfree_skb(skb);
+		return num_rcr;
+	}
 
 	rh = (struct rx_pkt_hdr1 *) skb->data;
 	if (np->dev->features & NETIF_F_RXHASH)

-- 
2.55.0

