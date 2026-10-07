Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EB6CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 15:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5514360BCB;
	Thu,  8 Oct 2026 15:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_s1Mo23luft; Thu,  8 Oct 2026 15:27:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C759960BC6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473251;
	b=ZdZUmDuB5jk2ZRsotjOXCVd4M1qCdmD28+tu/DRSSXS12q3MZbrAZddk/Tt5/DdMwY0D
	 RdbQjZa+DG9CQyTPafu2muIEVfD9hDOqIRDyR+vmCJvX7ygUI/ntN0T3Zu7gbfkBabH5L
	 2H4uF6aPsDk9zctVud+amQ3NlmbTctxKA8LEX4qPwMGeAJNv1L739eIzfFTiVmh89UADi
	 NJsi/8BzR0oIwVo29lefbJxiKmH7YL2zKMR2y0q2WUWwFyNO6ViBAng+4FHU7QoM33OxK
	 FgIzFQQ33QszJssJwMCDKVKLL5BfwTuPskaU6v4eMBPnaJcWUfS+XFUcwBM6Ezj5Wgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791473251;
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
	bh=DbLtENrG5I00kMX4i+UCiZIr5Qm/AkQbhE28uvMASeM=;
	b=Ye8H42/S7OkQEMVhFN4kzUK7ts4bHIHfk1vz2gMLWJ1Co1XRkGTk+FuKEXPy/yGTImzd
	 kpTqBWRnDY2M5PNmEUdE/T2rbQb454kC6hFfefxT7vXLKz2HCU6mpVfxykTfmv5tbKdAV
	 hh8lWrFTP2dy0h07QlHSLBBHtWB7F+a3T56arlFddzrLhVVy/lzKJfen6nHYdglVNhvMU
	 fPGEnl1kgBZ9jQbSist+uTcytnBQ29RaznafgByacI6YoE+ugXcnAhAn8R1LqEvknTd7h
	 Q1ajDppeZ1Tmi0IlNvxRuQ/w/hT+nhFHxZk0cfDM667X70ZI4kB/CuopTDl/SVP7xsw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791473251;
	bh=DbLtENrG5I00kMX4i+UCiZIr5Qm/AkQbhE28uvMASeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nTiGVrU0ySc2IqWIr6o7EgPkTQrlHbfd+s1Zk53+suJRkXqHuYFObyI6SlEdNc+eh
	 +WOvPzIigmMyDmuoWLU3Fcoxt2LssD9jJa9hgAux90jpIikosA7aDZN3t/T2gIWq2z
	 DtoB7SzfDtvWYyi3EYP7y+esHV8rgxyKgtUMk0uA2TVeKWT5LDKQFx0TK8N9R9/5bu
	 3+PnrnlNqRIOt9OwhhuYAwWVTkY+3BVTmUXLjV+Y8j7RUntJuooQLtzRzhoAIFHUvj
	 ZrvgCDP4UeXi1rj/C/etwMXY2Wv0F6v1oRcKNs+a/Eb/yEQvHg09HItWrKgn65kXzy
	 fu8b0Orxu/vaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C759960BC6;
	Thu,  8 Oct 2026 15:27:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E2C232F
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B86740721
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ynMDdhZM3UTy for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 18:16:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B881040512
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::831"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791397012;
 b=jXJ5r/mCmMoRAGF7+t2AztND2CvuQGtqzcD8AqOT4D0XPsn5eSnPjsGBlLGf/rowpbx2
 g1Ks39Hcr+KGalz75+fuwm9ZtXoIMkZj/de8RMMPiSp6+QS87NTaKVzGRn/id4D22loTF
 RlsZrSRA7Nn0OUJrhfD5ozeThKHZc7lFnh8YWZ+BjmAuYKGlbm4T/pyUihMh6xMccDu3h
 7MkGKnZZI58yXPxLAA7Mx0tSa/s7/VvOvDv/NvQia1RVLxBIaUFJfVhyjfPprLn71glDQ
 WvwQuvd+9LxBd9eAEcA4z+bZW/iX7u4TNHWHW37r2DkoDMa0zelFvxbzn427BZatLxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791397012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=DbLtENrG5I00kMX4i+UCiZIr5Qm/AkQbhE28uvMASeM=;
 b=IMxVG/qmw+jJGBDbb82caeTuLTPzLEYQTb2Xg323kVGXYWGLvUVQScu87qHTWGxvwt1v
 ZsnL6A//oASyYbuOgTwr1LMJ6efGTnpUf8cJPpFdAQ3Mtm6/PeBuDRQnqvXT5rCbJJs8Q
 jJY1S7EUuXKk1UL0lUbJVHNr3jEU3Y/h0a6FUzdZMBi4PMQ/ERgoH/7uAHCkrTYQB2fHi
 4TGRpyzHGDklw6O8puBvk5IedaXy9+GA+iHb/mYMY6Qx0qDSoRTOh6QnRd9bapQ3kCtWg
 fPcyxHF7RiMkMJmLfAlsUfbHNKLxROWHoYn/oCGA3e+qDmOViHz0Btb5KfEmBEsIwVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=toxicpanda.com; 
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=VmiWebe4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::831"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=VmiWebe4
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B881040512
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 18:16:51 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-535853983f0so3816171cf.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791397010; x=1792001810; darn=lists.osuosl.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DbLtENrG5I00kMX4i+UCiZIr5Qm/AkQbhE28uvMASeM=;
 b=VmiWebe4Vab1OvSunPIpiYYZPkWtOMVei4eQowIa3oqYraMYwd7AaWFfmUcZmA7utV
 U5RYpX29zH8A3c/a0VOMFmeROY3H3Ikn6kmWJoVZ0oV2EfcB3XnrRDk6TcNTIDPtj3ND
 UVZoRqF0vi7Sp74uN0fI8Y4HBoqy6eI/Il2koPPAe7FTxKtZVYv7VJj3GL4OLewRZYFf
 Ak+HPb97W4ZZ19yIqAfoXmvS/HkFwq0bCxP2cq/K2ZVBkBqVUtkoCgX11fJinaRsYqQs
 OkEApzW6UYLPL1wF4LTGpWvC1bXgB4udDteVKMg245EQb/BoVv+UEhWqtUMbx0YrYnX9
 8rQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791397010; x=1792001810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbLtENrG5I00kMX4i+UCiZIr5Qm/AkQbhE28uvMASeM=;
 b=tDcHiRYZ8RZYAXPwcIg+0R9EOUiws7ijVRYs9nGa5qZPMg7ikaGf45mIw22YkGdhfD
 n0RpOLny3F7P0/3QpkLP56B6i7544bLQxr+Rhdyh1GfG7cUjJL4bNOypuaKX0kUfNiJQ
 pzAe35BbNGCo6rnS3GyycqekJRncStzbnnejcGtBQJiLtq4e6ruxPwXz2y0LhlNOCK/f
 uDdSIr8XAvuIXprzHQdI7kQ0dCUqsLaz8McMTLSJcqQP2hE57NL5t8TqASh7Zm9gOOzZ
 yPViENpIw7+31rVaNrB+mKXSwh5cLdd4ZAMXDF+pVRIwDVF1S+RwevxlZ5wjelWbetIs
 Fe8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2F8+ajf6maTPUek2nxk4MDTo3bSw/EY2IRQvihR3deuRCbjsXjR+yfQ/U+0cU+JXLUjuSXjLyEv0SjdLgsIo=@lists.osuosl.org
X-Gm-Message-State: AFuF++m+Re1oL8B3MKxBqyANqUQFEx3oGDPnaNp/2pCssbqLclACTbdS
 kjqYvVGnZDMjSmxkayyIK1wkktvJNzUGjo6iG7+tl1BJe9E3Xyk0ZnoJhHF3QmYK2kI=
X-Gm-Gg: AYBFou2KX6EuX5pRGR26w5pEP6MUsKurvlypD8/VT5wI0x87J9UwcwAkCf2x5F5UuP8
 jHo9ooAdS6WHdOTQEHGTfuMiJ5HBHzXvJ9eLqCqXRI3OvsyztL9gK1q9j6FrK1Zh/CAWUn3KzSn
 s8UTrnffI21OseQbJB3vRO7S7GlXU8mYVAozK6czXcfyb0cmDUivxQUzHqbi0a9euTaIlLIc9Jx
 xUrtBb4dwErC2NbHEH7yXW3Jcgnx5BYSZ0NTX3nu+67C2PQUxF3mpJz6V19NNdT4vwCuj75y/UN
 xx+qBU5cCJ1jycuOfDoYzylvdZmxFxP45WWFSRf5X82X1h1VeltokYpV1BjlCubfr1G68IbiFXt
 Ytflp+R5P3gwbdP6u287sE/S+bioApcs+Z8q7PTE/OMqfhu1hdMCD+2l+z6iHhfJTOOBUC3TE0N
 x5NGKs3VTVHBm7WQ+0X/Rdzux12bXOg8n6SX99GkIKKlJNuBgmO6gI8YBkohvxKCIB/OaMXA1nb
 l3PH670iyagcFwXZ2dZ0j20tw==
X-Received: by 2002:a05:622a:60b:b0:533:94fc:1e69 with SMTP id
 d75a77b69052e-535755237d0mr54333081cf.21.1791397010017; 
 Wed, 07 Oct 2026 11:16:50 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.242])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5357214830fsm26034571cf.19.2026.10.07.11.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 11:16:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 18:16:22 +0000
Subject: [PATCH net-next 9/9] net: skbuff: don't reset truesize in
 skb_condense() if the pull fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-pskb-pull-tail-drivers-v1-9-9512b0fb977b@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1791396985; l=1285;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aE3S/MO9vLOemBhMvEWEtBv4CYrulZjUcAw8T5FEx9E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAKmlD/cXgBiooOoWC6A+H7tw5dWzG4gHatAYnnjbF9tFpPNqC/1rDXMvdLjveUvTCKNu/kJ24U
 cYCfNc2tlrQI=
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
index 43ebe61c7fc4..70df607da05e 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7118,7 +7118,8 @@ void skb_condense(struct sk_buff *skb)
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

