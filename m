Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A406CA5FA7
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39A9980F4F;
	Mon, 28 Sep 2026 15:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 82h8dw19xacr; Mon, 28 Sep 2026 15:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 68F6D80E5E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608418;
	b=BzVe7KsJSfQcxRokHeOBC09mWtkc1wawvKDLj/FA9ErikrCJiKbdugZcxj43qArJQVAL
	 sJE5lz+CezxmiVzujMgq5eNrO1E6Tf3XDmMufXtxF386uIvuv54oKJ57mcQ1E2Qimennz
	 fHhSUi9ka3G/eUlhpWTte77W077mz4sqCwigUafaVg+EDlpKqafsWzuGpUng2My8iADbR
	 84pfADdihrWEuesD4sZcj0ixwzTnI6tkxO9TiN9SXfYysLQuZdvr+EfIDXUNZ7RM5GZb2
	 KA44X/gsD8m2Xic8mM9d+0CS9zAuYF3h2+xc0i7ltR+bgjqIr1n6607FeILl3gWgMxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0Nq+R4e0Gpg6AZgDlzqSYdzoZZv1eDetTkzkwCKLwXU=;
	b=GTPHNMH2tF2qehk8WIIUKLlGiPvd8HdveUhUji1FDVcBRqLxLJrLEdw9K1Y81bo9E+e3
	 TUcIoNMD5+tVXPSQRfkJkm0VV9vkT7yZlZLRGQIBN8dusfleTf4c3qGzr2Qrlqudsiq7s
	 Bnd1q5cfiAMJxGNTK5VtQirYYsWXztbMvsXaCa31Zdhi9dDKhE2qtb0YtH0Jmwft1pw25
	 hPUN7HP2ox8tbpBywnvdvaeoHiofZcwUAbM4Mcqfp+C+7i3Z2tystXd4ZjKme3vnXQpB2
	 mC6aIAQiR/6O/5s07Y9+2RRWwEVlgkbKRIHncyzZusbr6J4bebVm+sqYGLWfL6xlQOA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608418;
	bh=0Nq+R4e0Gpg6AZgDlzqSYdzoZZv1eDetTkzkwCKLwXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DeOb/tw/T/77uV0Hr3ROuuFeIfY8K3dxvuMuT7dbUR9V9Wbvf3ttDjsto8jFs9hh5
	 4OlufPoj5PyOLxGqFd1elOGpm00PLrOd5BZqf9iEJKr1So7MLFkeKUlJIIom+pw78j
	 l8XOMJqzDbV2AmcBVMcvT7VM9yU2PUK/DEhhjr/2TbiEny2OlmHHDytWKKq5cGCkad
	 DpRPExpHMOR/RsDL8D2KAtpbo5amnz5GuSgcvbevmf/rvO/Eki62mLGvPVQq6dTGen
	 F4drOrI/wAuuCHBeBVGxr/lemrQqZRm9oJMXDFU0vOAPHpLBckKhOfXwybAxs2LllN
	 Zsh6hYII4CnaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68F6D80E5E;
	Mon, 28 Sep 2026 15:13:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09C67335
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E479860653
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSQBRhVKZ-QW for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 18:23:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EF9EC6062C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790447023;
 b=eSAHer5wS0yADE/ZzC83kGg3wTmIz+EGpWCpyhzKaG4axQNWaqMtWU/KKFiDxt5dNBML
 Xg5KD5t6upye9+C764HkG2EIu39gm3An85ooocxi3cNVww3q5MKJrjrbPkYbO608HMA4s
 Y9FWG66Bgu/DwiJ+5k0Vz//UJ8Ym1WY+cXUz7mv+45Fp8mZhov7MSvRgrFqn3HwGVJA0y
 J83QW0m+MB2b4R72+tBoXV3qMkgGMzHi1+OWAjtkvAuFhKlhDdz0ae/33AkC2eKoqCF3r
 REuhI2DnlG8sEEkwensWC1lx9n9yDIAaPKVDSfRdvjtQcUVW4HYwKxVxDuLTJIisUbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790447023;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=0Nq+R4e0Gpg6AZgDlzqSYdzoZZv1eDetTkzkwCKLwXU=;
 b=LYeF/mWX244B/loa3hBf+XpsSII7KhpW62AWUeYnfu6ZZIXSo1dyy/0K9o6gGZg4lPH2
 RyMpVCR+za+xtdoNWKHsEZCf5w6KGuqFrHG7GFW2AhusO4T3HailrQx/sz83IExBYavyA
 h1db0ynF9VklgyR/EX4Wd1BpX6Eg6sZrYAjCXBHn2fOyXmIp8vfm93bufrtVL2YdaTHXQ
 qo2+vLzCzgDgnaSWD7xbpMbB8weYCJXfbwi8S69nPddT+AZjw574fwYiNlgEN1Cl2QwNx
 zIhGExxMzP9br7KOYwA6gxmmhXOHZt16DATYx+y7SGHDSzFKtzL2yCbqf8QD5291g9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=nebusec.ai; 
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=YKcHmo0g; 
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com;
 envelope-from=weir@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=YKcHmo0g
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com
 [IPv6:2607:f8b0:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EF9EC6062C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:42 +0000 (UTC)
Received: by mail-qv2-x10.google.com with SMTP id
 6a1803df08f44-910704e63a9so7733546d6.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1790447022; x=1791051822; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Nq+R4e0Gpg6AZgDlzqSYdzoZZv1eDetTkzkwCKLwXU=;
 b=YKcHmo0gJsS2u8N9N1h8e7frCWz7lHV2HETKBcO/ZguK8w4gOnNetqvQIOQbOlr6Ap
 iAQYqI2NOktgDgGaFlPLBL+KJ/qPrPCdmbu5s9mtY5IAjmQJS4hMaQJEv2frK3A/lPAz
 epUNqHAnvLOiM64eTnHCVRxSl8bQRRq7BaGxKMpVHq+tbfiz+sxgjdsbpWvRJBKhPJNd
 NUhdChr71Xx/JaQ3kNManBwkdgpN5Ps4hQXNGPBT7nsTI0ugEQXkZJ6Y6E7WB3SnnqDW
 P2n7ChZUmrYzNhG9611SVUK6CnIw5lIWb28bfR8W4fM7oiDl3LOU3U0lbdvmwzRtbJeJ
 9qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447022; x=1791051822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Nq+R4e0Gpg6AZgDlzqSYdzoZZv1eDetTkzkwCKLwXU=;
 b=s5RfTkhC7+kEjLsabRzEBE6EbGNOxozyR1LSTKn2vX8LGMw8ffP8Kp1hKN0kwElydX
 ejHS3CTp/IMZF1Jdwfs2jz0CMhBV3ZTlLvW6CC5DzdAAw5NXdyAboG0D4EOX3o3hAYm8
 yJxeUOd6ChTJ+1hdk1iXobhLjjQ3IU/f7uwjL+9r1T8zMWxh64rnPTCcqNr+dmtLHam9
 4blxfkHubuBffI2za2e8nsSduDBcHir2tZiD8xzZowY636sRpJfNRiZdb4kRBAxMg0kM
 EPxFrYUF4airS/K4dP1XCf0pGulVX19Tobqde1EHD1aTTDIcE4awlVyYd2sTG/J4rAQW
 l0mw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkR0ithG+0awJy0yzdgnoQiJLZdm2owZtQhaaBUItspI50YBp4bSsztQLK/sCpMtVJWfJcLDOpvl/XR/wRhrA=@lists.osuosl.org
X-Gm-Message-State: AFuF++mpNDitP13HBjq71dIoUOZSvL7hJUbEgASBd6zjyMR/065AOYSl
 hr5iaN5VByUwOfcjGNE2Wfl/gZuOV0NFHDPAivYN1Z7hIbsbpOAzVgBTFxMUQhhONjE6
X-Gm-Gg: AYBFou1Qq82zKU+E4fl5SpKb/Y5v4W4EpBTtUD8VMIOBXYcdz23IScbuVz6j31WpkHQ
 E4k8MvbBTiKWr/bQw0HHotKimrosBEA8f3dO6AYawEg8ErGTdR4MbXG7lllA+4ZtQT2ZMu8zOyb
 984l1eJxIpIr7hPkGz0N6/yX76S9cTAcik4vybTEfw1Hsc/WFGerdwVZ9IsVcL5/aY4EqzbMiGH
 97ZcxRSIJ6/LO7BYKPGHKicZZGvysEili4frAbLBwAfGQMMNoWA1xgaJfuMpjlkJHjleb50wY/7
 wAegeyNSiI0Q9gPKHrTyHCWnnGQpgvXSbw4ppdaY/Fi/hPUY9xJF/kp4KlkLYzQNuICXB0Pp2xp
 EjUPcaoIaw9PyIg5YlCfTzjqVJZRJ4H7KR8NNOAR3fhN3OoKLvJKOw6sVcxfSa9+UgajS9CsPLR
 NlsqLsFgOSaDbn+0DuBI/DH14hlkMY5dphlH4t9n7aoPymjUDqdzvZrDg4EOEDh+HmlkKYtrdga
 4UtNdg=
X-Received: by 2002:a05:6214:e89:b0:90c:a989:a68a with SMTP id
 6a1803df08f44-9142f8bee20mr108894156d6.11.1790447021515; 
 Sat, 26 Sep 2026 11:23:41 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([202.8.105.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430ec87e3sm43970006d6.47.2026.09.26.11.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:23:40 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 lucien.xin@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, sln@onemain.com,
 fw@strlen.de, petalzu987@gmail.com, weir@nebusec.ai
Subject: [PATCH net v1 2/2] i40e: validate TCP header before ATR access
Date: Sun, 27 Sep 2026 02:23:09 +0800
Message-ID: <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790082243.git.petalzu987@gmail.com>
References: <cover.1790082243.git.petalzu987@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:34 +0000
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

From: Zixuan Chai <petalzu987@gmail.com>

i40e_atr() uses ipv6_find_hdr() to locate the TCP header. A successful
protocol match does not verify that the complete TCP header is present in
the skb, so dereferencing the result can access data beyond the packet.

Check that the complete TCP header is available before inspecting it.

Fixes: fd0a05ce74ef ("i40e: transmit, receive, and NAPI")
Cc: stable@vger.kernel.org
Reported-by: Florian Westphal <fw@strlen.de>
Closes: https://lore.kernel.org/netfilter-devel/aq1HaYS96SNn7HJY@strlen.de/
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index ef5e657816f0..cdac279b8aed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2911,6 +2911,9 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 
 	if (l4_proto != IPPROTO_TCP)
 		return;
+	if (unlikely(skb_tail_pointer(skb) < hdr.network + hlen +
+			     sizeof(struct tcphdr)))
+		return;
 
 	th = (struct tcphdr *)(hdr.network + hlen);
 
-- 
2.34.1
