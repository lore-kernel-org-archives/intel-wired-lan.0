Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA453C531F5
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 14:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A76B0409B2;
	Thu, 23 Jul 2026 14:06:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QuJVum4Ad4-I; Thu, 23 Jul 2026 14:05:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AB2C40956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784815558;
	bh=OAGB+hnDVwiPeefwu8aOxBU9oUq2vbyk1XBqwM5436A=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bDE4v4r1iSsmtNkNI/Ke4MQYLVaJVk5Cikw7YU+XtcOUv8C+Atf2TayubBpKhMsVb
	 46c9u9Y7tgKwFBCRKuZmzLVgTAQ2ISSI17vwrcvphvecdMq+rbYMrcozCVtWPv6H6u
	 U1mQNsNFSnDPAICLCj2nZe7i0igfryfp03aCpe24ZzuaG9ix9yQhsaG/kpW53TDOwB
	 jQRuX6CkXzoMBRbIed8I9eJ3X1ZkrT8e9kV2sP1JpB47o0y5D0RnPg14L71tH+mqN7
	 exhFnNCEcoRPU811TOq+FXsAu9YDpLTGcjP2/p0fPZAKTGFZOZO3p9DV3fZR87l3pA
	 gOK6kYi10WgAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6AB2C40956;
	Thu, 23 Jul 2026 14:05:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01F6B2E5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7DFA80E07
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hD4vpjlVEZzn for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 14:05:56 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D2C4F80E3F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D2C4F80E3F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D2C4F80E3F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:55 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-nKPn4WjzNCy-rlKHs32bzQ-1; Thu, 23 Jul 2026 10:05:53 -0400
X-MC-Unique: nKPn4WjzNCy-rlKHs32bzQ-1
X-Mimecast-MFC-AGG-ID: nKPn4WjzNCy-rlKHs32bzQ_1784815552
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4926fa2cb17so4464835e9.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815552; x=1785420352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OAGB+hnDVwiPeefwu8aOxBU9oUq2vbyk1XBqwM5436A=;
 b=b35Fyjp2eR6nHpoielKsY+UEkYEQnHyfS2FtIwYJ/3b1FTrp8q5StYvG5n/cY6ps2i
 dE+aoGPQgxQ7ildO7e1UG3KkjP0uY2l75ySYS4aN9FG42Ia710Fa9AYmnzliRiihNbK/
 q4zb0J8H3iZtHvKEqMBOubPNJUKbLKYKfwpLLWGiIllAm0FbSa2g8SfKVdh2keKOyHRm
 LIBN/eLWQvpAIqBazuih9fSxv+aMdD24T4wL5JgkX9NuMcMuAL3EJigyfTtI+D5fEVDr
 tinCfsocrfOf4AhPXT9Vxf7UCCUN9WSYH2U/1uOZ4Fs8IOVHoGmXXEoJMWJhH7CQATtK
 UA9Q==
X-Gm-Message-State: AOJu0YwSVaVoXJtvYTr6nBanNtt+Me0lxoXVs0U2lO62gR07lKp5hnJM
 DAz6OKun+kNSOp2HRye1jIsQaMs29y7EIrwrocrffPdY4WAXVlWv6NSP/ljU5MZf6qdYBCGp1r4
 iIjZwEdxv/Cg99bXtYS6nJRSk2ExF8YoGCn0gUyVBFH1qy741ZUPZG3yjcDtHm//IQefQCbLBYU
 VJ8wZequ/HUC/qTTUGUTPrrSv5N26j/sXuJuvIU/rBbJbXg0yZUFMXOw==
X-Gm-Gg: AR+sD105ARQtsc2OZxb5hSza6zCeDT6sEw0dUEqmmU7ajUemXA3KiCTI9jtkLIMXIlG
 M1lyuvUFVbU2XFrTqMm1N3Ho//ojlcP4d4x0B3932Sx5Vcf5SGP5FPOVExyvK76sWCqvfs1046v
 Mxm7VUlOoOJAqmsXtx5EuRZ++KMu8/3ZiNLmBYilsMZ4WSk+0+2Lep9wYoEVVGW0FCgfR5tZi/G
 hzWD8mM/mDkkeqes7udnUg6XR0W8QeSMtHikvt9pBQuYPnKAYOiabAIUk4tafzmWwQPR3jtjZFP
 voiD7WHJvmYAsR8VMWw63eHv1P8E+WbmZCrk7R8h77jFlk3TRWoBfWZC2pkME/wxxTfFOjTuCIR
 YdMKSpqHKwgTWOA==
X-Received: by 2002:a05:600c:630e:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49574589f9cmr28903005e9.6.1784815551726; 
 Thu, 23 Jul 2026 07:05:51 -0700 (PDT)
X-Received: by 2002:a05:600c:630e:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49574589f9cmr28902145e9.6.1784815551125; 
 Thu, 23 Jul 2026 07:05:51 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:05:50 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Date: Thu, 23 Jul 2026 17:04:17 +0300
Message-ID: <20260723140510.184819-4-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723140510.184819-1-mheib@redhat.com>
References: <20260723140510.184819-1-mheib@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7xTLoT0kMtXIA07FSXGSLB2x0Ickq93mwWzaBJZZ9w0_1784815552
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1784815554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAGB+hnDVwiPeefwu8aOxBU9oUq2vbyk1XBqwM5436A=;
 b=YtDqRXPjre9LHHEfsD2K3xJMXZry0fjZftcHbeOF1yaQdC/0UAquwRv1tAqyP0hp+tanT6
 tXzbRKXzBJNCdmgOVtvluFYjbPDIJFeoGOANVND8BUShB1dL9LN8A+ZQc3a1nsOaeVwSQ+
 UywaG+T5+24fUI53AP53JgUVT9f2vAI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YtDqRXPj
Subject: [Intel-wired-lan] [PATCH iwl-next v4 3/3] i40e: trigger PF reset
 when re-enabling ATR via ethtool
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Mohammad Heib <mheib@redhat.com>

Toggling flow-director-atr via ethtool private flags does not trigger a
ring reset. If ATR was disabled while fd_ena was cleared in the TX queue
HW context (e.g. after a ring reset with both ATR and ntuple off),
re-enabling ATR causes i40e_atr() to inject FDIR descriptors into a
queue where fd_ena is still 0.

Trigger a PF reset when ATR is re-enabled so that fd_ena is re-evaluated
based on the current flag state.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 6d2b076049f7..bb37f8cc4643 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5301,6 +5301,13 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
 		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
+	/* Re-enabling ATR requires a reset to update fd_ena in the
+	 * TX queue HW context.
+	 */
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags))
+		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
+
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
 	 */
-- 
2.53.0

