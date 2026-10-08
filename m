Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20699CA6007
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 13:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C52B8811F8;
	Thu,  8 Oct 2026 13:19:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Hk7OO_XS2mu; Thu,  8 Oct 2026 13:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC75681212
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791465545;
	b=o2yD7zc5I+vEs4pInZfr1ajE/z9IvkevK+1kM3+1TZyMHTEYGhToe8anmBn1uo5+GJWN
	 pEERh/g3WeI75B+atbyzRIszzEZjw+gNH5zU5FUp4zf21WATZM4mBYHDdShyPnHNtPcps
	 nVrSZRahVn9vZSwFSfaW4f0pOGWNvXKSipXFDsO+qzC0UX2+PfacaAmPxwx7Joc9ZXvo8
	 kRt3OCsw+eVVZWg4zKt4TuyoqF0HiLVhq5LV3T3ZoaXZRzoPslvdSOMAS2QpFjMGwO2T6
	 woQuKF1AlzERVzO5voPvMM4onNLK48yaCkvNcParbgvdtxaAtkNBzufhU6ch8mADnFA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791465545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
	b=oKOTEjkYCLn78w6LC1SAD7K7VOLuoXDL+rtZYJ5PdRVU1BxxfTyKjTqbxangSLt9sr4d
	 dw1lfG1jiNnptF9Q/+S6PNpR95J+XQRnSbaQNtyWqGqZn/8h8D2rBCWN+KCWVzHTljg5I
	 RQTGYv2zuT4nxJYGhYXrBrDqcU/9YCDnAbxD9eBBzU09OosukbE16+r3+1OSyMWFm50rg
	 XLUrWRmYOwbetsh5tjqAX8QNJBf8UbN1N0haBfOq0tpTLTEud1YELCbg7GEOha/y4/TOJ
	 RVoaW1nsZRJpaF6+MKTSwzL6nyRiBci8d0cvJw8U0iNRrU7lOcSWAEBkqwJV8UWljKw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791465545;
	bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w+BV7J/jDP+/15XGWJmWWAs714xxOLcGyZwulO53w6aDCmBetEXnj94VQXk7L+Xc8
	 0bf5ZCW9WAWGuE2YMt2jTCIPUpnfXcxDGZnbdirzFlK3HWKDt/kuZUM+Dy6W5FK5/D
	 iPWBs/ToBskHKT1WFnkDdhQZEgc+eF/Sw7O9s++hAQ2FhgEkxqHSHC5YtaoCzr5gIZ
	 g9a7pDssmOTTwfkmSb3WjZCdS2Nb+JYHN2XCLJ490weBHQHyo9wsYJ/i63GGqGpIhJ
	 Ww9vRiR+gkgB5ygDqA/M2FNipC1z/5Z4+pQwbXjznsGHDA8pi8KFW50I6gB0uulw3n
	 Psr5sIr1YuaaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC75681212;
	Thu,  8 Oct 2026 13:19:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A15C934E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9302560B57
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kLQ0Jyp5Omiy for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 13:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 53D4360B14
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791465542;
 b=N0HgLeRsEXWGcTQKs+NlfZFJdKB8h84tXeaZIsZ2PAB7G4LucwB2TRon2+6oglJkYkqn
 zXjWIbvnLzppHtK5Vex+nY7uK1Jae0kigDC+a6gc1RZTWdYFVSHfBE/5ScApAdy368jBx
 84UmtJSUtMX4uiKszUGndEtxWcSXOxUKktHhsiSQM+IO+0Cr3a99V9sQqedG1MKEWROZt
 Vcey0Na9pnkQJLDIyqnKSqXtabTVJPSZC6MO7WTUob5xpWt2DfNSgD74/EjW+z4q4/fb9
 DMR8+6o2q7k3vsLvvhmJUV8Yl17vgXUGwfMW1WDEsLTz5sJhNt2Gfemay0T63vP2aaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791465542;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
 b=fXv/KPw14lh3iP6fxoAh1DkbgENm5rUb8KyhelGHQXA3K+uedLsNrqDOW772bGwy8vS7
 yrSlyQFwiB0AUmgIfx9s6CdXcZ7Xyhqo3OaJqnjn8KTjnkgWOPEia+x2NaGVzW9N8ZU8L
 otc4OwJ4HckMgK1f0gIqYP/fc6DB+YlqAoAD26E8We98e7UhpfmMxPRi2OnXuW43/Hdv9
 7+IbCTmIHutoiWnVozpqfqGkiPwq8+H7tiFADH2R+4LOD6VKbmjAi7gLncb3PZkEBlRQh
 L8wtB2ODdS3SxJUSxtPEgBtA4xr32WzicF7X8IpvNzxOcC+WoOGvVxu3s0iYBWAOmeg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=D0ylAFd7; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D0ylAFd7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53D4360B14
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
 b=D0ylAFd7s5+szFmBdHAMhBIc5rawRkeD5xj65+inJUmyfuK5KnfQWG2/tj4Jfynu+tJSXq
 bs1sDFvuA3ydppnfixlUVag5PnUoTkI//jCeTH8K7RsKq5+1SJdxHMTB0gMhOwmIxAKHh6
 sQ0SPCb95Syo++x+eqa5DPLDf9iXlDU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-wje1udKZNtKFkdkXvgvBrA-1; Thu, 8 Oct 2026 13:18:57 +0000
X-MC-Unique: wje1udKZNtKFkdkXvgvBrA-1
X-Mimecast-MFC-AGG-ID: wje1udKZNtKFkdkXvgvBrA_1791465536
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a0761224e1so48865665e9.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 06:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465536; x=1792070336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5eVeHT40IQAJyolAKLqgRdv75qe5omjt28pu1NKPFQE=;
 b=B1wuNost655J/kTYWItwoCMrVfBtacIqYfd+ogvZ96C7V16XXquFkWmT6BOS9QBDl0
 D+FLu2LMPvpw2XzDcnl5f3vbQlJqa4gBlRiU0lkMRm7hfqpVaDcJYa7VSne2PhlRgQjE
 V0l0GQB7dXDXbWuBmq1npNC1/yTYmxl8DpJAJimH+/sxAo8qUZeGOZnTw+ycplI1nPd6
 JYHOweBxgwD3GcfKPuNdjghfux4fVuSMaiyOMEUqAguRohEq5jmS2IdjpkX6ZuqyU8bk
 GnXTb0T0wxrclu0OpBhtO3//3+OKHwXq0mnoYDcm+yGChW3b/qPwhcMtiFtg+hqbaenl
 3ycg==
X-Gm-Message-State: AFuF++ne9x3dlrMyOL0gC9n/IvO0XQsPadk+xgpC8+wimoIP9eUuxSzp
 Lnloymj5h8ZFf1djEdCjMJvnMrqzcxICNBplbXxBinu6iDdS0P/KB0ZfRd2tCTO99yx35FO0mrt
 fBbAXvOiTtZQicoXZtBfmo81PHghgCmoj7HqSh0qWl3i6ZYnav593J4UrU8Tx5ICyyO4OEtT/ER
 2rmJkKv5HPfjzLCxeRm100L2DXiASnMLBzRXU6wdP8hfzGD4o2BJvanQ==
X-Gm-Gg: AYBFou1Z40opfhWV4HvMb4ydQhUeBspiFcFrGi8mRSJL/zCYK+pD4WwrvsbbCEZUpGe
 7pbxD2rDBuUz9V4AwmzdNVjqZFiw7E7O65eAEQn06LaBykhZ37x4bu12Hb4gqrSbA9GczuAc1vj
 o33cZKnD9JYhCd1TfQuCRniTCVQbZjmHDvfjY+AKEWrMbYhI5u0SQj+rehkG3jFUk7AUmPJz3tK
 XNOpzxpWHA6qiEigz1lZAcl9h3ofoTve6lIdmTciKE4XIuW9jQooZJJcndtQoJ5vlzYKHqXETj7
 c0sCjnvRrAgFy/suqEt4HUEduf8gJwiGZ1eBrXLFX6/h2FKvrRQHdCGTn+ftbKBnGtyLPr/yNq6
 1WE5pL5qLU92d9zYMhbug+hIpp3FQebwj
X-Received: by 2002:a05:600c:c4a6:b0:4a1:7856:f4b0 with SMTP id
 5b1f17b1804b1-4a180671a42mr99650545e9.30.1791465535662; 
 Thu, 08 Oct 2026 06:18:55 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a6:b0:4a1:7856:f4b0 with SMTP id
 5b1f17b1804b1-4a180671a42mr99649895e9.30.1791465535142; 
 Thu, 08 Oct 2026 06:18:55 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843e3356sm62947465e9.14.2026.10.08.06.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:18:54 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v5 1/2] i40e: move ATR sample rate from ring to PF
 level
Date: Thu,  8 Oct 2026 16:18:23 +0300
Message-ID: <20261008131824.248508-2-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008131824.248508-1-mheib@redhat.com>
References: <20261008131824.248508-1-mheib@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uyvdLnNAS7QblEeK9SXdHEyyYHQI8Xxpgk2PPAX1TxE_1791465536
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Mohammad Heib <mheib@redhat.com>

The ATR sample rate is currently stored per-ring and initialized when each
TX ring is configured. Since the sample rate is a global policy that
applies uniformly across all rings, it makes more sense to store it at
the PF level.

Move atr_sample_rate from struct i40e_ring to struct i40e_pf and initialize
it once during i40e_sw_init(). Update i40e_atr() to reference the PF-level
field. Change atr_count from u8 to u32 to match the sample rate type.

This also changes a user-visible behavior: previously, re-enabling ATR via
"ethtool --set-priv-flags ethX flow-director-atr on" did not resume
sampling until an ifdown/ifup or PF reset, because the per-ring sample
rate was latched at ring configuration time. With the PF-level rate always
initialized, the flag takes effect immediately.

Trigger a PF reset when re-enabling ATR so that fd_ena is re-evaluated
in the TX queue HW context.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 +++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  9 +++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  3 +--
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index a9d79bbd3ea7..528ef329a647 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -486,6 +486,7 @@ struct i40e_pf {
 	u16 rss_size_max;          /* HW defined max RSS queues */
 	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
 	u16 num_alloc_vsi;         /* num VSIs this driver supports */
+	u32 atr_sample_rate;
 	bool wol_en;
 
 	struct hlist_head fdir_filter_list;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0ae50d7f3465..9b1ecb2c4edc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5300,6 +5300,16 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
 		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
+	/* Re-enabling ATR requires a reset to reprogram fd_ena in the
+	 * TX queue HW context. Skip when FD_SB (ntuple) is already
+	 * enabled, since i40e_configure_tx_ring() sets fd_ena when
+	 * either FD flag is active.
+	 */
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags) &&
+	    !test_bit(I40E_FLAG_FD_SB_ENA, new_flags))
+		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
+
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
 	 */
@@ -5431,7 +5441,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 				case LIBIE_AQ_RC_EEXIST:
 					dev_warn(&pf->pdev->dev,
 						 "FW LLDP agent is already running\n");
-					reset_needed = 0;
+					reset_needed &= ~I40E_PF_RESET_AND_REBUILD_FLAG;
 					break;
 				case LIBIE_AQ_RC_EPERM:
 					dev_warn(&pf->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 109ba6b20f8e..d83116596eda 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3459,12 +3459,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 		ring->xsk_pool = i40e_xsk_pool(ring);
 
 	/* some ATR related tx ring init */
-	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
-		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		ring->atr_count = 0;
-	} else {
-		ring->atr_sample_rate = 0;
-	}
+	ring->atr_count = 0;
 
 	/* configure XPS */
 	i40e_config_xps_tx_ring(ring);
@@ -12754,6 +12749,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2032465c9b7c..acb47a9fd86f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2887,6 +2887,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int hlen;
 	u32 flex_ptype, dtype_cmd;
+	u32 sample_rate;
 	int l4_proto;
 	u16 i;
 
@@ -2898,7 +2899,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		return;
 
 	/* if sampling is disabled do nothing */
-	if (!tx_ring->atr_sample_rate)
+	sample_rate = READ_ONCE(pf->atr_sample_rate);
+	if (!sample_rate)
 		return;
 
 	/* Currently only IPv4/IPv6 with TCP is supported */
@@ -2950,7 +2952,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!th->fin &&
 	    !th->syn &&
 	    !th->rst &&
-	    (tx_ring->atr_count < tx_ring->atr_sample_rate))
+	    (tx_ring->atr_count < sample_rate))
 		return;
 
 	tx_ring->atr_count = 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index bb741ff3e5f2..be587f804e7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -372,8 +372,7 @@ struct i40e_ring {
 	u16 next_to_clean;
 	u16 xdp_tx_active;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
+	u32 atr_count;
 
 	bool ring_active;		/* is ring online or not */
 	bool arm_wb;		/* do something to arm write back */
-- 
2.56.0

