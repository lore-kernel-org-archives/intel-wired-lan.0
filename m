Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702E8CA601A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 21:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 401EC4087F;
	Thu,  8 Oct 2026 21:03:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6D0Cp22-4mCL; Thu,  8 Oct 2026 21:03:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A363340911
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791493427;
	b=KEBtDQ6hGMQ3qxiPulUAP6r+cv0en63km5L4ypb9yAxItJjahRXPL5jAZ/k4MBtOAEw2
	 wzZAr+C0vNBX1Z+4k177Mol/LvgqyGdaILV5Ld3ESFnfFJiTn5V2efUspSevMhqBniEkc
	 xPDKykEtcbbQhxAqX9bgv8fVbkHHH9WsdyaPn3SnBi1aAbYSBRN9N8VQ4DN71ivUIpEyS
	 rv0KcbFFi+R+GuZkkX7fn7zXzjqV+o2x7Irh1cVVeNjeWhVe5yM/7h0HYu+TlQELwIC9K
	 QzoOjpRvvTe5KT3QYI06uuFMWQWKjPojUM1pEvLmtCVUNehOmuXup9wVfmzbeRE1Z8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791493427;
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
	bh=D0uSM/A3oRPIUcCVkMNaXKAYlboH4f+zE5JovH6Ln9w=;
	b=rzPg5d/bmcrNlDHC6bqzZwwh38BIQBUCmQX03RIMjoceZfttJ8aCpuyoIgTS6sC1IyNQ
	 ryJIyGRdeKRSTrdagSdgtUMILR5tgRhu0WFs1B8VdZqJKi+oatFsoBbBOhXid9PPTR2TL
	 7CBkUrHfWi9NUkBucbW+Ql5hS2IaMhZWl6ZmqTQ6C17tziwTMwAw1aTLlV/JT3Uxt25BG
	 L9uyL6B4TNJztjVdMiemI4bkZhDLz2e4K0wj7CzEnvXAD9xParAe+Vw8nCEMNK1uHFdEJ
	 r+X3kfJKfPPgeyz3OgH9uvBcfJF7gW/NA4bCiOh9cr5dMdtTJgxYST9jvIKp/+f+mdQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791493427;
	bh=D0uSM/A3oRPIUcCVkMNaXKAYlboH4f+zE5JovH6Ln9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4DlOvr4SY/6GtyfShI8CKNsUVm1UC3nsMW2AYw40w9QsBt4wNMegXo7l3UTcngoel
	 qb3bJ7iBoct3uVDMfMnpniNHGzu8VVDjVhvmiXLzQ6kTxkqZgXY5SARICa8BzNLTdG
	 st2sKGWp2xamlp3ijl7IolD3tn858+nRDjQnOlW9Sd1BjYR57pBjZH7SJc8Cn1kK9+
	 elJFxrch1phU0l12mDPHbTac/ia/6WpCmsosZ+4J4JzLrNvr43Y8bc1eJl5qZ+VYU+
	 8ynkJC3QXomiC/vOOsGQExk1YWKKWzxr1QR+IywZBEh2CWVSjbtPQA+fSJlWoRnE+Y
	 jkjjnp+PGCwDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A363340911;
	Thu,  8 Oct 2026 21:03:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F9AC356
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7604B60892
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mVTHq7VyqyGw for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 21:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ADC660808
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791493425;
 b=iK4Y/WEfPlrSerjH27K5T07oIKGrA+aBd2F1IBEPJbDd2YyyI7YNahwfFsAD0DtBOgmm
 Qo74nb1hVHf1xyEDfgQwn2khAu+owCRfvdHmVRbvXo6yYMKQHRgtYxHyjmuqFbAEbv+CE
 4JX7/5dW43CBMfVLCZaZDHIS4mylulbb3p+3UVJF3uB8dSZNkF2V0tj7gfQjNokGfizEB
 tcGtuJhW+Z17Nu7Exvd3XuH5zpRvCZStSjr9zjxSGWNfB6IvpU2yPwnMbRMpTXseZaKYz
 PzoGhLp9QsibGli/AXymh550088J1iYrm+SNkUohN+pBWRyhZpHnBsL/tTU46D2Uxcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791493425;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=D0uSM/A3oRPIUcCVkMNaXKAYlboH4f+zE5JovH6Ln9w=;
 b=nz6MjGhBdbyuf+t9/P/iYxI/k/3bJXxVS1JMEyZfFslhBa2LjRwiMcIB7fqL+FSgH5B4
 +fuoJ8hS/QzjydkQHVC4FejCsB6tT0RpJpLB8HHzHHFlk79tZsgPYrDEkhKf9DRiBtNdu
 qdaZVDB7Db+ANBjcN3yTsQlXM1Ilcl3tnzBkhZ54VOgYEuNVUwS717aBd8aBAMBsPyPm5
 kKWYhws+Q57uxM/3TO3T2a62glZ4SRu7feEwP5iKvDwLQctb00WZ9ApPRi7MfghHyIm00
 aIUu1/0Bfx7nmGHQjozEqe/fGn+NXRTH9FiqAu0yY+Wo8QqrjH7tIGnO4VOwizkLuSQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=TZ0KJ2O1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=TZ0KJ2O1
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ADC660808
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 21:03:45 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-9199927cb42so17444306d6.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791493424; x=1792098224; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D0uSM/A3oRPIUcCVkMNaXKAYlboH4f+zE5JovH6Ln9w=;
 b=TZ0KJ2O1LWwWAZivHu+uFAPeXNjL6JCAvdMhJ16ADYynRygQlfa8r5i9RU+yHQfJJP
 ms504r6DFCku7PXQ/yZZfSO1QAoaMc0Bf0Z/5+XZEpXM2A/MGAvn+PqH1qvJFSm2mqGI
 kZsAB3hB2mk5O0hIWdp67iku3h7xHT/Gyv4PlQJKk/KBbSQC/Qs8XuaoOL/OEDdWBrDm
 Hf5saOqlAGf2ESXTzaFcmjWFmjp7MnxtSS7KKBSFN3BfMByiqMDpDL14pH8JFsKEjmOc
 LmL98VjphbxdN8WvtCAesyofP0SC3e2zI8FpKFdkD4HUT3kCYWNMJXlRiVWs49fAsPMT
 TVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493424; x=1792098224;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D0uSM/A3oRPIUcCVkMNaXKAYlboH4f+zE5JovH6Ln9w=;
 b=u+sZpt09u9JwOltl7PqJ33jFIq64P7usqBq1a3rePB0EkMelTUHRDIE0WuqYfTeDEo
 i/Qw2bYrNq8Ud7TlSNMJQ/8lNn1R7IMYpU5HCeQ+999PJeu7zERrhQ8ppqSuD+eX80qM
 JRZO/icFcVP4ghnEeyDzj+KY0EALL+is12ihN+yAhrXmC+JxqFkTyKB3y/zBhyNIeNCR
 jcWKV5gXxcO9ROq0xxgBOg7G8LcYqolllPPicGQaAPAbWaEMq3Yn/BSZGHQEuQv75QHL
 0NOGWv6b4NfpEmQDH+rCZ0n+FEw9iN6mWoRSEIpN5efuqWSVI1srzO5jqsI25l5OKdbw
 /3nw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGWa4p0uimu4pIgSfCgo8Nl9OTtY9iOKErxijZdWOh7DI6j9zexBNHd4F05vKPv8VIUMa7+7Qv8tLncOYJF7o=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJBaHXeTLurMl40oYtrTyLTY3tTBIwkW6XbglIKpB4QjKukd5tP
 0vv85EOMHyiY0EAoOr9W8ZYnKyzllMLzKka3Vd2jto6+OlRxcLkxGEDf+b9rhYFBO9c=
X-Gm-Gg: AYBFou04ri56dWN19lnXwQlkHMZt3mGWiurU1BdEN/v43f34UukIkzah7BBJv6xvnr9
 1wFSUiYhsXJ571zGshm++qYIi1sR3P1F2cjpQ6YbkQ5LQBZebuc7QGJq+RqadVlANgRW98OCjxR
 9eQezYvD/757fFukHk3ZFMqZitKlrjhSxA/KvGrmFJl4gG/9kVtkvzsay60jtn2QDlBPoBXbO8o
 oPfuAzJk9NNmz/FtOGMr5hlYJ4p3Ps04Aiu5cyAaWml1xNtlo0zkaQgUQi6dknS2kfYemum2sRy
 rKGiA+XeIVIE0cgRmheE3vxHssdN0jHp76i8YmNktcsnjoW4PG3mSfwlGBDk9pTzh4vNS5BpMHq
 4e62DK09Mu/aqqO1vAOPPxE1JMkHDJhq0boxmDhGzez6LghwjWWdxz1W0tuqUmClJeD2ya7c9hu
 ybWpTS35KwgPnxGqX7/4peWZpVVBNdO6MIsaYZE2uYs3/BYZXxVfDuPt8f+UEcB/74phDnsfxtw
 6ybVHuVLRZZEAE=
X-Received: by 2002:a05:6214:ca3:b0:919:952d:7ff9 with SMTP id
 6a1803df08f44-919978f7ebamr126853616d6.57.1791493423774; 
 Thu, 08 Oct 2026 14:03:43 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b550d394bsm79796d6.41.2026.10.08.14.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:03:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:57 +0000
Subject: [PATCH net-next v2 10/10] net: skbuff: don't reset truesize in
 skb_condense() if the pull fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-10-8f2bd9bee138@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493385; l=1285;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=G4GQSS/z86H6HrzRjtGCGkhfNcr1ZqkSUEOCEKTi8N4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QD7QXznJXVwY4tvhlA2g/ntlgNB9z4EYJ24pFBre8ehTYCPfcNpsZClmKSf0INhwTvOUpctCjRC
 vzNH0Zo1blA8=
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

skb_condense() pulls all of the frag data into the head and then sets
truesize to cover just the head, but it ignores the return value of
__pskb_pull_tail().  If the pull failed, the frags would still be
attached and truesize would undercount them.

It can't fail today.  The caller has checked that the head has room,
that the skb isn't cloned and that the frags are readable, and pulling
all of data_len eats every frag_list skb whole, so nothing is
allocated.  Check the result anyway and leave the skb alone on
failure, so this stays correct if any of that changes.  Use
__skb_linearize(), which is what this pull is.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index f798118df112..556d37981f0f 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7158,7 +7158,8 @@ void skb_condense(struct sk_buff *skb)
 			return;
 
 		/* Nice, we can free page frag(s) right now */
-		__pskb_pull_tail(skb, skb->data_len);
+		if (__skb_linearize(skb))
+			return;
 	}
 	/* At this point, skb->truesize might be over estimated,
 	 * because skb had a fragment, and fragments do not tell

-- 
2.55.0

