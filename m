Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2775CC77B71
	for <intel-wired-lan@archiver.kernel.org>; Sat, 15 Apr 2023 05:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD77760BC0;
	Sat, 15 Apr 2023 05:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD77760BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681537761;
	bh=qydjX6oJkSissLmkMnuSoIVyw5YNgEpTXdWzypZEefE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UICaOTTSkNw/jq2vbUzzb/1QVGZFcmZialZwuFDszzKz8LeiywmbBxH4L07E+Lwxv
	 jQXyr882CWY2s9Mdrenq9J/567T9OUzux2+4pnXVOAd3xTkr43CjHH6ydDi4d/ArTa
	 TV3jI8Nw8Nb1e7w5rZLrLCGYwAiip7NDgLcCjjvrIAwQToMqRz1+txtu936npV9a2I
	 807HZk+rsysRYGjuloQtv9P1h2eRTcHpk1TyRV+DGepEcAxodKXczuibxK0wwrqnDj
	 EkhGdzz6A5lMakmMdsOzr5MiYFM4q0JLeOuYlS2Ynj7hMbqlT0Robhio/p9+HJ78w8
	 6uJkFQO/zf0Tw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKMcHB8Aaj39; Sat, 15 Apr 2023 05:49:21 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id B401270016;
	Sat, 15 Apr 2023 05:49:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B401270016
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1777E1C3E9C
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Apr 2023 05:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0B0D416F4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Apr 2023 05:49:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F0B0D416F4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rptLAYs35hS5 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 15 Apr 2023 05:49:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B3B34410D3
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3B34410D3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 15 Apr 2023 05:49:14 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id qb20so50456947ejc.6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Apr 2023 22:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681537752; x=1684129752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OrHxjozj9Y97lEiYcNHU+1VJEkZJKfJvYo3LQaIdl54=;
 b=R+A17toH/37HhJxQW7lfst85X174Vtxul6Dfb1jTQlUxMH27jljViGYLO0I0N/gTRW
 hDA7/zqKNsK/QdjZeR0vUdLQNWrrOlKu1/u2uprFkRzkwAC6TVBPpYZerXZiH7t/eP8q
 inl75qZFpppOO/+ybVZVU0yPyjwswdl5MbACdo+VIALCh7TOb/wIABUbF/ylXOrdJ5Rd
 r0HtlcBoV0u6+KihJ/qzrQ8VNhKLsFsMD7B5KRM+tVuLufW78MPQaRgIfqcOjFMlILyE
 XHIkbqBiWlmyZR9Jh+BWihpXbfRTKJR3qT3jSWYPhp3sDUjH3LKcK3kTcXj9ZjuOGbAB
 O8zQ==
X-Gm-Message-State: AAQBX9dMSd0Vo7gxIqqZp/4a48k2Kj7QrufJxWBFOgiiNxyme3mZ9kZK
 02+op1PUz6ih/Htd4PxHKc6/y/icRSddG4VQwmv4WxhWsiDNmGQRAd2YRG6CsuPo1r54rW2FKRo
 18yIWzIaVK60ciZ7soHxzeucMW14bQbwzarl9QCxzpWpsdj7h5sqU/CP2qjpfGz6Gb8Nb/WqHPK
 x/mdA5l+rfz36VkA==
X-Google-Smtp-Source: AKy350Z9Nlpqh7TxlmaQw7ztKHaRdmGvphuxDHwV8dW9aG4Zh5OvVBqI+4//7gu2sR9Xu5moGNttUA==
X-Received: by 2002:a17:906:ce2e:b0:94b:869b:267 with SMTP id
 sd14-20020a170906ce2e00b0094b869b0267mr1275663ejb.28.1681537752625; 
 Fri, 14 Apr 2023 22:49:12 -0700 (PDT)
Received: from perf-sql133-029021.hosts.secretcdn.net
 ([2620:11a:c018:0:ea8:be91:8d1:f59b])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a170906038100b00947ccb6150bsm3294856eja.102.2023.04.14.22.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 22:49:12 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: intel-wired-lan@lists.osuosl.org
Date: Sat, 15 Apr 2023 05:48:54 +0000
Message-Id: <20230415054855.9293-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415054855.9293-1-jdamato@fastly.com>
References: <20230415054855.9293-1-jdamato@fastly.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastly.com; s=google; t=1681537752; x=1684129752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OrHxjozj9Y97lEiYcNHU+1VJEkZJKfJvYo3LQaIdl54=;
 b=Fb7MUrzERZTDIM2m1ox2M5Cpglh5HlkjRbFy8kqmMloPsqIrRUc6QqMEUlKseiY5hj
 qA64609fNkKBvosDOzAYFA26qcoCR7Yj87fOz/A4c3DCEOXi8tCiMW+WJ9vnb/6eIph+
 tPvI5X6tsFuPJ/S4NorWY60UcaWdbb4NdYiUA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com
 header.a=rsa-sha256 header.s=google header.b=Fb7MUrzE
Subject: [Intel-wired-lan] [PATCH net 1/2] ixgbe: Allow flow hash to be set
 via ethtool
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
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
 anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com, kuba@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

ixgbe currently returns `EINVAL` whenever the flowhash it set by ethtool
because the ethtool code in the kernel passes a non-zero value for hfunc
that ixgbe should allow.

When ethtool is called with `ETHTOOL_SRXFHINDIR`,
`ethtool_set_rxfh_indir` will call ixgbe's set_rxfh function
with `ETH_RSS_HASH_NO_CHANGE`. This value should be accepted.

When ethtool is called with `ETHTOOL_SRSSH`, `ethtool_set_rxfh` will
call ixgbe's set_rxfh function with `rxfh.hfunc`, which appears to be
hardcoded in ixgbe to always be `ETH_RSS_HASH_TOP`. This value should
also be accepted.

Before this patch:

$ sudo ethtool -L eth1 combined 10
$ sudo ethtool -X eth1 default
Cannot set RX flow hash configuration: Invalid argument

After this patch:

$ sudo ethtool -L eth1 combined 10
$ sudo ethtool -X eth1 default
$ sudo ethtool -x eth1
RX flow hash indirection table for eth1 with 10 RX ring(s):
    0:      0     1     2     3     4     5     6     7
    8:      8     9     0     1     2     3     4     5
   16:      6     7     8     9     0     1     2     3
   24:      4     5     6     7     8     9     0     1
   ...

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6cfc9dc16537..821dfd323fa9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3131,8 +3131,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 	int i;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 
-	if (hfunc)
-		return -EINVAL;
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
 
 	/* Fill out the redirection table */
 	if (indir) {
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
