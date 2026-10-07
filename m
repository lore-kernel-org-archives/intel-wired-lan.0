Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC6ACA600D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F76A60648;
	Thu,  8 Oct 2026 15:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LDOxSlBsUZR5; Thu,  8 Oct 2026 15:27:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EA6CA60BC2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473249;
	b=sZKTGfK9bG+VtLqAg3DN3mTRNxGRst4rokTk25HoiQdlO2q0DRcicDbRBbNXrQTxTgRI
	 uw//RTFuzctfY1J9wmJBiR3HB7CukysD6xLUiqRFCgSlPYzg9YnVU61DjmHxbj4Igip4g
	 pqlP7yD2XGQD/QWbnSE9THTr6ksdSY+3o69cn6gO6pR1bPz/zhRv5YEjkjqgdQ3vl8a/O
	 EHoIQri9368c19qyJEMmZVq6IoYHNcVK6HTxYhyIWc5pQi4wGJBqibq0SrYRlTbCCNsG3
	 vPcuh4CBdQk9ivfJQv6NFJ67cR42zTnd1WnP4JeNvv+hspnHqgUK8dV9SWra9WdkaDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
	b=Sm0Ns3Hy4kxXGgTPCY7K4ST2dFPBuj1T+fThuIO96My1UdYSe5MdflrUnfSZrWl5ZC3G
	 gd6OLkxqDz3OEXRG/4gR2A41thWfzM5vrZoeMw4BMkKW1iVR2t1LZOTx6w1WIVriyf/4T
	 u4+lf3vrGzBjpJ/IBQ12g/QsvndOZqjs8IcuTXkCSd/mVZCYjekr+TMmGKQjpdFK6K31H
	 VyqugYEOcV75ODJjfvuieeNCINt7HZpaUXmr0XdE8D7Sdh0r56ikp9JN/t8La3JeVrJfi
	 3gB5BQU9FXQPZ5HxQ+vLvWQsxgTLBJFz1p64YXsIeuaqMzcNWBldmUMFO21IvwhuO2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473249;
	bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UqDdB8dmoyyo9I5eC3Rzx53ckdACEopAZn6uyNrpSOXmHolHlaRXvx3JULqTw531L
	 DCJwtk0PZmFbZm41dy4QkxOVdA+KVC6JdPe59Ug9hnaPthDVujzyzpGB2DsB6WfBwk
	 sMqAit/gXoT1/pmib0ertMkqNtV4KxDDNDtZWg3fy6kfl3TY0UnHa4+SC3NOsWPLNT
	 xTcdPHHE46D9K05Nmq4qgqe30vcXP3P13XiwHTdmJYeS614ABir4sJSIDWgAqbG8Sh
	 /aeRtoBusQSOh4ImZUdIKZ5wTYGsyoWgpbOCTzOxRrMzP/DSPUPAgB5NU+N4fezDEL
	 LI+b/N4//W4JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA6CA60BC2;
	Thu,  8 Oct 2026 15:27:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3598332F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 276E840512
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yup7SXDYA5yH for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6690740721
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397006;
 b=b2EAJhYSJxoMfGSxucrv4ASB1TwYDx8j+0JXh51eJSY6gnGaRTfUOLKyQW9ZIx3yYCPA
 +jFLM1S2HJ4SALN+9bJScVgc7oKJIOFPQhB4eOjJNREGZMQKQPYWTzHOBjUtRmKk0Nmms
 DHomZ8Tp2JQsPTAD1ZFPaO7sJugSGz1ih3RkNmRDz9AJX/a6qQaEiE05Yj316ik9DNhpY
 tcIMyGoTHJnrMTwwt0gD1HUKZQz/hMqmiegHHxAQ9qdIy7qYXRDWsJwOW5On18/SMkfi4
 B6RagJU7uqmv+uPnKChQM4LAv6xe3MGQ6RzYG9FmweFnyZUR7KYNNkkaUUpIbsi+B9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397006;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
 b=J2+W0dbOCsLbaRkQ1+i8xwPBCpnEbTvYGMsf0FZkFgYfPfsrtPNspVWSiXLB/Pl+d1YI
 Co+ukW4sQb81mKg7ZIsy4tCvy+XeNLY82JaJAalJ9NodxaOJGAPM/XnX9MmcoJ76oN5nw
 RbReJp3JGAvPXuCY+4f1dnDUYd+dtAkxY9Gs6eha23Ly/om6t/CJc47S5DtPuiSXD3XlU
 hOCVf3X6KqR0ACMXC6T7PpTOdCLACVwKjKDZ5Cb7qyv0k/PlBiKFcZIsN/TY5fd24HbtZ
 H3HHkoDMy11ErzOGMzn5uZc9fk2Y27AQ7shchga5PLvDpNRMqV+C8egmQzKAc20EqwA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=mc10fCxv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f36; helo=mail-qv1-xf36.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=mc10fCxv
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6690740721
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:45 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-917a7c03eb8so36288986d6.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791397005; x=1792001805; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
 b=mc10fCxvCdagfUv5ZcjzJLF/E8YOT9wtBFpKf8Ax0mmwG2o2M3/sV+bVIA4nB7gs7V
 OchXvknhtnyy1CC55enbaVPUpDcMrSRH4jj3wcQmoG+KCEkFBAxJn5Wl3KAbunx2TmCe
 rvdEbeabUCRJ31ehqb2Hcz41OlyW3RPX7xruUbThYy4Ap0AxBrPvBLoBmwZyyolypJ5h
 RjYgq/EQs/PYFff+G1ITbOKC65yUIw/RdOF8KPBuc/u3AJOF/lUe7nGQ6lrIYVvoVr/1
 vUVKbhu0H62sFCMyNdOfHSUqFH9w3RRbmmLVux5sgQd/vzFeB2pBkJQpJvzD4TaHlLww
 IQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397005; x=1792001805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pgpiLoGoqA0xV5yWN2rO1XVw1oOPWsG2lgMDpzrz1ts=;
 b=vhIRA7DvhNa3jOky9qae7E9Shn/0WpvfhQBkIoDDkg8Px0jkLZQOdVEfJSlcMUssyQ
 hcnn5xPV0oZsKvpxxhog9dClbOvsK27DCcXdk3oKJhBOF9FM8Ejtf0ii/tmud5pVOMgj
 bpNPDYhXpd2LC6A8KMCeyatgSrV/WaGu+/7nybIp7JFBdNIGsE5QOq/Wl4iS5CK9GZnD
 R9ZtyEc9lDp4wUIqxGLRxX45I/ccRmqcwl5CggEn5sXa7tqXP/9tmjTf6yQJWmitC0kU
 IuawxQIRazIouvx7MjCuh9gGwCNTIpEOvR1YqrANEDGxt5gYuNvZ8o95hiPnR323r2DN
 44Jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2Nm69ftmR2P5ZPmIM3/anLZBCG1zHxY6JuJgAiL73Z2WDCFUk0DiVKS4LE76jX+yE/YDWcEtsyO/NkYUnVqA=@lists.osuosl.org
X-Gm-Message-State: AFuF++mwe5J0XWH5bZdzCOgXbTVkwsUV5rHSStBBG/GmY5t1svBlQLbh
 k4Tn+Pz4AoPZpHexwottQsCAoMZTLTbU2i2v60iJ9T4SpQW7g6YjOmv9ZtoZAOXpgtY=
X-Gm-Gg: AYBFou2f3wAz7cG1QtZhaL4w0UjRxXZnv+GCTh3frw8VxHrviQ/AU75jthtTGs9Mw5Q
 ZaE4k7J4C0nVZ9a32VJdZWpVpr+uceoDlYdyjj0/smAIRcIAjH76E6STUfbah1+QFksoQ2Ns81z
 ix9DqKtrxPMFI9BIXwYOHXRIsSj819gy23GGWK0eXCaN7pdrxLRDbjN27DPll/Cvct5CRFzlDFT
 Gk/YW+kSd2QIslejF0JFzeAbMPirFg6NruFkEuqKyqzGzrM6/WmriZ0f3whycHUOmUj/dpyte5a
 /wc9ERf9IgtM5PqdGBoIeZpSBD86+16RQsBb2QKvvR/6tW92Aq57FOjPOZN6dDAe2NGt2kV5H2b
 uIMZ/MbMympjQS9vbQZ5DtsxQFC6bUpwvJvcDi6BzSkB2ozhgempA++w21SSduOj/fQmCNXOV0M
 s70BD1LfZa1HSSW0SC1JWKUOF8GiMfMyhnRCrvsr+hOZh0P/BfiuXzcZFrEmbjNizW6D7fjZA75
 XY18T2JuLup7CM=
X-Received: by 2002:a05:6214:2408:b0:90f:5154:6a93 with SMTP id
 6a1803df08f44-919977eb9a4mr57210916d6.11.1791397004534; 
 Wed, 07 Oct 2026 11:16:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-919aa0ff38esm986706d6.26.2026.10.07.11.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:19 +0000
Subject: [PATCH net-next 6/9] e1000e: use pskb_may_pull() in the 82571/2/3
 TSO workaround
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-6-9512b0fb977b@toxicpanda.com>
References: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
In-Reply-To: <20261007-b4-pskb-pull-tail-drivers-v1-0-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1188;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=2XY23bjEEEbmilzyi/OT0dLNP6D+zOB3zspYb8/aVZ4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCZC1nd2AgIaYMzIFdyfEIqZLuxEhag0euZBWHhtKoqomivMvwvOvEoJ6R+5XulLE3AuLwN94C9
 RAHLj79e6mAY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA
X-Mailman-Approved-At: Thu, 08 Oct 2026 15:27:22 +0000
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

e1000_xmit_frame() uses __pskb_pull_tail() to pull up to 4 bytes of
payload into the head when the head holds only the TSO headers.  It
already checks the result.  Switch to pskb_may_pull(), which takes the
length the head should end up with and checks it against the skb, so
this driver no longer calls __pskb_pull_tail() directly.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..e216868e15cb 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5859,8 +5859,8 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 			unsigned int pull_size;
 
 			pull_size = min_t(unsigned int, 4, skb->data_len);
-			if (!__pskb_pull_tail(skb, pull_size)) {
-				e_err("__pskb_pull_tail failed.\n");
+			if (!pskb_may_pull(skb, len + pull_size)) {
+				e_err("pskb_may_pull failed.\n");
 				dev_kfree_skb_any(skb);
 				return NETDEV_TX_OK;
 			}

-- 
2.55.0

