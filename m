Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93971C79FAE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 585EC80BD1;
	Tue,  8 Sep 2026 15:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fJD2vevocIE; Tue,  8 Sep 2026 15:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7977380C27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880443;
	b=nUSVgC1qoJ63H6VpmqYQNSpUPYvZbw4KYTTeBXoSbKB+oUNtyS0HCxsQHDAb0hCknsDG
	 7IC9iZGcb//ilKN1C9lae8UoAqhGNNYtLiQB7SpWDimWAXKGRAJgBEZD0kJ3pfvTl14IT
	 R4iHnYu9FWDe/Sp0jbknIDMU4pF5HlXalhUYLwojhJ8CtQml+7WgFoRdkzHh+9wnHP8j8
	 kTHvN+XvwsuWqhWCAheVclYmKQc8x2lh0sEeFTBQbSCAAxYtdhBggYgXJPlXogj4TkpDp
	 mIYcz3nHMAB+AlO0F7e1Y4ehx4d158PTnyClqR4CB18ubn2bEdULt6Lu+KaGCdmU6+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kTIH4rp729nLZ+mp+FLaZ9eDX+y2kMWtUzXLWEWBJHs=;
	b=R4IWrnX4vbbjLuuQ/Bzb7B2QVTRFpdWUk/gTz9SLuY/Oa5+rJqNIFNPcVGA+I9vRpE1C
	 LSRuHgJwz+uHPzyej9Ifjh2qv04nWQkyx76QmbMQhfVW/KAXG5PsIAQtuf8ThCv49LKjO
	 BcEG/+f548s6hxIHmwIMH2NqSqaaUt/HsuiDIuZjMhWh5DaX+hKtWms72D0VbJhmj1AJP
	 NAxxCwnHkakGe/C1NN75U49IZyKwmEvAvQBSaA6Od/BkJ4Qz+MuOKmowWu+2erjIMqzUt
	 jYXCnGs0E5OyTGAfflijglSpLZtHxbMKeWuC+9Vw5Zvx1bGE8zOXEM/fGneXqGaoMww==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lLWcElnV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880443;
	bh=kTIH4rp729nLZ+mp+FLaZ9eDX+y2kMWtUzXLWEWBJHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uvlPGj0dDFBoT6o3+nbe0M/zfZibLcw7sPU2kTCk6dfPARVEpQJgBDUxuigSi41nh
	 vtjGOnNSNVYWrJBXFC1n0MUAvCdARljWFkYGFsWv8IY5aObzu8jRVeBB1k629F0e6n
	 CImTM5Kpx0WzzD66s9XugwoVoLmP2KId8KCD1sRqmUj2W17CbIJMIapHf0NeNuub19
	 zDWJabquWuVnAfi8NeWAdqq+PC4wI2UwqlNFfvbL1/qEQ7MSZGjRSKeqTDS4FNPL7b
	 QZdNfCYaNX6PBpfzgOfu7qxW+aD37drOKCB/vfu4N7xWBqqkkJ+pTiz9dPx0TyJKn9
	 VZdebTDCB0NPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7977380C27;
	Tue,  8 Sep 2026 15:14:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A0D75AEB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 925F280C5C
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yx4SdfHgE-Hw for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 09:55:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3D4580C47
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788774916;
 b=TRYRU7Nez7JyxgZ/KoExGvJQb0zSEnf1PWiFZXh3EctsKURS2/llA9VLTyJS4U3Dxh9L
 eScCTNPu64xTwJhNnTSK8mprt7RnJjtx6ekTJub5nPdKxvYs6TSELPBNmxaeXd0Z67NJe
 y96wpes/9VNrlUO5sGJv5ERzXS1FjEnT8ipRNNtbn9tG679JlSoCbkEvdy8HNCYUIlTCq
 DywlayqQnkQf5o4aj0c/fYUU+3OAszFdvonhRatguL2zGpacF8kN1vKIAvEaZFqNzOx2f
 xg3NkNROsu6fzVLRDNYD4+1CBHnpKgdW02aKI10NtAHXkRQTmi+ojHpR5eNsdGD1Urg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788774916;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=kTIH4rp729nLZ+mp+FLaZ9eDX+y2kMWtUzXLWEWBJHs=;
 b=grWezyCWhKsFbrZFbkcZq1A9svGUZEv1UVWKsYctc4T2ljvTLfYrV/cihd6dd+p/fTtX
 5u1vaiXxGoNl9nV/vdUqiw5ZCQVujh0O3gDpCgMXElViregfLuAEkIkf7uSu+y2fVSQ2c
 gs4aSWcanKqGJvwOAFWVkjjdwK+daor/gWABEp+9sNKxUxkfSdwsxqhDeFc0uAQMwP9Dj
 c299r3Up57z39iYBeKLWj8OItVWNWVWQ+1HBWzhiE3VhRMvJKJhzNs4OOxmBazRSUWNrg
 lWzREWtJdZzbyfZs/zGwZt99FFIeJGcF/G9J88vKFj+FVUvAKLPaE4cr1ZNpxiPxQmg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lLWcElnV; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lLWcElnV
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3D4580C47
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:13 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cc1c3c90074so2767341a12.2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 02:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788774913; x=1789379713; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kTIH4rp729nLZ+mp+FLaZ9eDX+y2kMWtUzXLWEWBJHs=;
 b=lLWcElnVV4lT0crB5WWTaJ1zlCPW/4cTUNqkeqHOwOEdW7gPqKJoWTV6Ckrfu1SIis
 T9ZZleaWsOJ/Ylcl8kOxDuLCXcF0dSmh4TEg6i8iAZKTeTMvy6QfTWpsMtHx8qUJVQKC
 yZ5FWtaN//J0yR+D1UFxBKNj1H8PxfaofRkW5wxx77LDgCqSh98L6K2oLdNu3U2oaVdz
 UN935ZC3BZsBp2rZGmHJT1uAtEsP5HwXMBXjtREbJCQ2FcFUCCd814JvuJhxkPFxVG7Y
 mkbDS+JpREYUi4ijN/AnJ+DKPfdsbHyXQEksjg++I0hlnLE2C7W7WjmWAn1enN1unFDd
 7thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774913; x=1789379713;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kTIH4rp729nLZ+mp+FLaZ9eDX+y2kMWtUzXLWEWBJHs=;
 b=skuzCYU7k2sCK/Ji9tFaP9povAxHaLlk7hc4CJfzD3S+6GEWfW3jl3nKGK9z2n2lfe
 GaCdZ4Ig+CvWLgvlExa1+pczfHsX0T4mLhi04x3cprfUuZYcxxzwLDB9l3IcHRmAopgx
 rOZlkdT+rIPOtyAGLKCiUsFAM+vUVz7LE0nxM2EL7arqOfyZ1x5B6ACj6bVeHfAwLxIE
 Ygz43RCTXKd5BHxNUHTR/UW/WBIuApDmV8VAkmMugkB4ZWrhHyH42q3xVHCv7V89O/xs
 CsPN6E0XN0MbeyFAx0Wdi69IgeYfLi/+WoK2CxVNs3gUBePS7T727broj50tSEO76KgH
 Cw4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxchbDRZRVMdhQNH2cUQnX16dMJSzGT6LpK3cmvTlMhFQP1cPwgLJ3g1mMHIbYRNZ+KDg3qbCnaHYf5sI1PmaA=@lists.osuosl.org
X-Gm-Message-State: AFuF++mi46VqWOj9r68iFQZy39NE11CZQjauaep32Y6s3Kc+DLjRxEbF
 HUtQgqxb89LAxCOXTG/9qotYoCDu/DdOv7B/x0c6MTJBWRIb9MHztOuw
X-Gm-Gg: AYBFou2goYQ5VF8Bw6VcP9FBGIzlAbZGHYq50Dh5Ut32Y/EPKvlde9Nn8OPx3GSB7Ok
 Yb5xkLyrpQ/sbcy+9BcdYDLdtRnYQqLkwKrA1wOi3WkCSVgjWc3qCyYdW2oF4qt3+iPRH/+DnBv
 O9VtmNS42k0GtKCteh7dEiWEErKqY9sa/eskdW9hb7ioPSodjm1fZ/uDR/TDcj2CnEAFdSh6hI5
 OV4Oft8FkL8MqDOqr2bzfEbONBxkn+eKaUuPec4nbU/VCf7eTlMGpyu46ODhckXZ9RBmW3nUWUB
 Av8gEd/HmNe7fGBoC0W6VD3dX+JmGG1efjTTzoKATPIkDwbDqxb7gSJ4WvfJQSveCOpLELtv4aE
 DF3gxlk875TNhPl6MOqZy5BR5Pk1UKbjUjLGDKNCHgaVbYg5NunSCrGWtQAXwMP5NsuURVuBOc6
 BAPRyT0Kd8T+7lHwYIbIlND3Bm3yAJRsxz7H5LA3KfsMTy6O1ogcVZNc26y8eErzAYJiE6UGrWC
 Oeqcukr3Hw25Q==
X-Received: by 2002:a17:90b:5289:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39b261d0d83mr36070397a91.16.1788774913277; 
 Mon, 07 Sep 2026 02:55:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:55:12 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 4/4] Documentation/eth/intel: fix repeated words
 in comments
Date: Mon,  7 Sep 2026 15:24:46 +0530
Message-ID: <20260907095446.27290-5-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
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

Drop repeated words reported by checkpatch.pl. Only touches
documentation text.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to iwl-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/

 Documentation/networking/device_drivers/ethernet/intel/i40e.rst | 2 +-
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
index 53d9d5829d69..e01f0adda3f6 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/i40e.rst
@@ -692,7 +692,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
+hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
diff --git a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
index eb926c3bd4cd..5840569917f5 100644
--- a/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
+++ b/Documentation/networking/device_drivers/ethernet/intel/iavf.rst
@@ -171,7 +171,7 @@ queues: for each tc, <num queues>@<offset> (e.g. queues 16@0 16@16 assigns
 16 queues to tc0 at offset 0 and 16 queues to tc1 at offset 16. Max total
 number of queues for all tcs is 64 or number of cores, whichever is lower.)
 
-hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new new hardware
+hw 1 mode channel: ‘channel’ with ‘hw’ set to 1 is a new hardware
 offload mode in mqprio that makes full use of the mqprio options, the
 TCs, the queue configurations, and the QoS parameters.
 
