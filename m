Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A25C433FE
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Oct 2022 09:25:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCF18830E2;
	Tue, 18 Oct 2022 09:25:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCF18830E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666085137;
	bh=+4BktBQKvXRh7Lit8Yg2LSw0G6GWVbq5lXZA/iyyU4E=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YHCYslCHRiDempjKo26+WdngDthwwOUNiokqCrbh2+zpv7ISVYmJ75BP1ZpSl9kA1
	 WEC+Yw1fJsjJ678oWNe4XMXSEP/Mb8hKK9IMUvQM4iByZdmWLAQHavQTG74znhOjvg
	 7zk4T2kA5bBo4Vi1A1s0McLAdnNBd3ujQvqidPf6fIeOGAzjrkLxys4nDsSyntlCuK
	 jn21TbE/wvRhWItB0Muc4rDHQyiiMnd08xlWUh0+aHgxYSrNeO1es6yP4A/flVnPi3
	 dmnbzOogpQrjNsKsZI/o4d9EUiq1UXbAr7y+CiGCdIuFVBrC/0U9woTbmikGARPK9w
	 T1Vzz7vx0Layw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6fSrZFlfDz31; Tue, 18 Oct 2022 09:25:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id B193D83133;
	Tue, 18 Oct 2022 09:25:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B193D83133
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B522A1BF983
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Oct 2022 09:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 902EF40917
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Oct 2022 09:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 902EF40917
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWywkVynJqem for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Oct 2022 09:25:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5264B402D0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5264B402D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Oct 2022 09:25:29 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 x31-20020a17090a38a200b0020d2afec803so13471807pjb.2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Oct 2022 02:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MUGpXXu/YLX6vB16EEikz0mUodhAtO8kh4qarh/vsQ=;
 b=1Gfq3got25iLf8csfCaKU65SXqVQwMNlj/9RW3vl2MMP2GQV3JMteA3b1TAQR/rBo7
 3dsk3xFCz4GUYm7IQo160XbP1AjTZvJ598wYhbOmV9hDwjnzkChXy8I7a9oAIwp5+eBg
 fBJ8Y54vIZoV/tyVHfHN6fpEndRKojhqLcjkZzi6hLc/J517yoqftU+CjMYNm9mV41Lm
 WJAJFeFtlTW5cNRVVep9+fw66/+KUibXV/a8f5gSbE8DEbOmzY/btgq5R7p5zR5CyIEy
 jjlIW2XHazaHfmkLfKaF/waJYQ0+Sm4hkJ4ElnUwDeAAKtZImCuQRciiLlcIxXBCYqVS
 zwAA==
X-Gm-Message-State: ACrzQf1eqpB9PvKZAAdxn9ZtWEuJeApF1KKl0l8Hv/ImsFmSlDtBtgA3
 PvZaV1cX4mmqr47YVplObcewUA==
X-Google-Smtp-Source: AMsMyM5fHoJkZ04COrIOtFCeb2dhusZr7vVpO96gDwpJ6y8MRdxE8qYSAnuq4a+oCbS8YJhDc9xMOw==
X-Received: by 2002:a17:90b:350d:b0:20d:5438:f594 with SMTP id
 ls13-20020a17090b350d00b0020d5438f594mr38870290pjb.216.1666085128750; 
 Tue, 18 Oct 2022 02:25:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 o125-20020a62cd83000000b00561c179e17dsm8694847pfg.76.2022.10.18.02.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Oct 2022 02:25:28 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Ruhl@www.outflux.net, Michael J <michael.j.ruhl@intel.com>
Date: Tue, 18 Oct 2022 02:25:24 -0700
Message-Id: <20221018092526.4035344-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018092340.never.556-kees@kernel.org>
References: <20221018092340.never.556-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; h=from:subject;
 bh=R8ylvO6BqWbNVREdX/u1o3d4rMnlPe7DgQcXRdLK/uk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjTnEFGT/npSNQmG6Pg/wQsD1SJfFxPxu2rbyaqXID
 oCQB78+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY05xBQAKCRCJcvTf3G3AJi7vD/
 96KK47LIncnqzTUMut5a5skw4vihz4xnknY7/ue9t+x9mLj8qHg68Bwhsj1s6Ei3FnMALk3w768VYs
 SWUJUKa88nfLmMsRyuuiv/GTuK+tV2alLC3zKeeLtuPkJZIpyoNJwHOvRCJK8iOk6/dHj5XBXtOOr1
 WEv8l8xFabrpKP3Pmf3DxpM4T3Fp/rmj8cCa8rnX6wvcH0nQwL5Jhtp7ZZ2wB9VuSRi1wg63+on06o
 HYBlb23VbUFT1uO4xKE0RlsmQlP/4y9JJmgScoRQkr1eQoIbL4uR4tX3ke8KTzviQUllgpIcN/HKHO
 3EDeF9pKlGLcenyNmM9RDXH0dW1bLrNiAJ5f6yaaVWLx8MAooB4nY6dVUi9WiF2DJuZuEQenqPtlB6
 StgzPvNXcrHnuhXvMO2GcNYO6VSfxhypAGYmHZKw6IQXOCzYF6yjVQW7Yji1kcmn1rk+aAC7rAetO5
 NkxrAUM6cASntDrRuZK7kTOeOTuoHu8xS0XJttoDEy9dSJlLHNkMw7xIvR5ydp2oUpVfsCDGqKzyWm
 fhbrVNLgZtECKGDo1+eaDPoDYIskAVsjWf5kTjfLVOd+UrVNXtm9Kj4lolcvXjs38jYkx0OPzUy7mE
 x2lTxueP8LPPu50EdJIIy8Xy1olop7KKBYCeVB9wDl0PgbIz8gffRV7gFaUQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MUGpXXu/YLX6vB16EEikz0mUodhAtO8kh4qarh/vsQ=;
 b=JtNmvf1ubSjiH1NO0qolmx2k/7lVy3Sznt8a8J8fM31erknTm2/E4tqjoxnBJwLEUi
 f3Ub/BNwRaIM6jgFHsYdDtJ86QHx2fNnwdn55tyNvD6wbcQXSG9/JRY/lQnc85sRdv8Z
 Ea4kYzXelL/Wlo0P6SmcA4mO/+bqaZgW1FYXE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=JtNmvf1u
Subject: [Intel-wired-lan] [PATCH v3 1/2] igb: Do not free q_vector unless
 new one was allocated
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Avoid potential use-after-free condition under memory pressure. If the
kzalloc() fails, q_vector will be freed but left in the original
adapter->q_vector[v_idx] array position.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index f8e32833226c..6256855d0f62 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1202,8 +1202,12 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	if (!q_vector) {
 		q_vector = kzalloc(size, GFP_KERNEL);
 	} else if (size > ksize(q_vector)) {
-		kfree_rcu(q_vector, rcu);
-		q_vector = kzalloc(size, GFP_KERNEL);
+		struct igb_q_vector *new_q_vector;
+
+		new_q_vector = kzalloc(size, GFP_KERNEL);
+		if (new_q_vector)
+			kfree_rcu(q_vector, rcu);
+		q_vector = new_q_vector;
 	} else {
 		memset(q_vector, 0, size);
 	}
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
