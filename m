Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEE8606A332
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=cllh7zKK;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WA+cH7dB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C512D40A50;
	Wed, 11 Nov 2026 09:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y56M9L5H6jF9; Wed, 11 Nov 2026 09:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D3E2408CD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794389457;
	b=E0gFgVaaSmam7jC6fPfh5fBEueRSOe+ULMjR5M/nTp+412CvIOCZmaa8J/qXSHgfwy7k
	 81m9bQ24dOwtb8UM1mFOqZQ7U9vG8EQBIkokwVs+xgAeqOLl0qzp3jItzqWWocr+TEq2m
	 qIupOPf7pzjMlTZBsNfbLhHzadAY7L9ZmRuZeIOkMk48sqmZ0eH8S+j8bIAT6BMQG4N3r
	 8r3BZl5QcvtcEdD2qMR6u9Kipjircf88LKwLONNXM9Tnq4DMklG/nudH8lnAjZEPZqyUp
	 jPoAp7oHW3HP8txTuEuB+AucAiSo9TGUI0VaaimodVr4A0A/TsWBRf4ItD3gnwNzXNg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794389457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
	b=Sel0P9x82k3W/T9hO/Udoh/QlJQDqU2PBi2oejilRd4LkkHjEf+zFOuBNqbrL8VWDONx
	 4i88YIjhvJycLSveAa10VUCoHE6sBUEcDJ9ThVYOq7d5b5SgGNgmPgdD0BsKqUGFNtv4R
	 amsZyWpDoI5JB2EJqHXrOHYceTzhvbxLYym5iLPS3q2z2UHWm8Y+6VWkf8I+/Mslpt38q
	 m5Qp5bljzWT4dQDn9RIicl7KxU6YyH1kyIHXrsY8ChStbqX+aDYJ8qLiS/hmnjtgLt4Bk
	 CVtBHlAdy9ZQZWJHH10EfjPQC/WXR5moTL5akB8AqL1wyMNMar82DKJfoWhX4kvmcbg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794389457;
	bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cllh7zKKgBlwhNuw6rxuLyYLzF//9QD9NIxAxf9Ph0LF4bKct3DbO759Q5SK0n5mo
	 k5da4khyTgzURwQtbXCsSa20/J+k6uEYpITgHVpTRJfIEObLBSmdCWPw5CCtaADpX9
	 Bsg+cK3e1K7lTrULOjAK25m9bhF1trhpve3yos1N5kukFIhhr3m2z7WjA9Ul9wfynJ
	 uh+mNT9e4ylcd0Ppyvku4+vyKD9wWJrns+npe7k+Z7kEF/mMzosPQhjeBOZcZCqkwX
	 2QIVzqHKgZkaai+1vo4GCoDVy5cgTbLIZMZcA4/PfDfp/RtyA71dpkgGQJS/CtsZOa
	 oo39FOzp8lj1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D3E2408CD;
	Wed, 11 Nov 2026 09:30:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90FEA17CB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 76FCF6071E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id urkc4zE9MzYq for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 09:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60C80606ED
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=danividanivi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WA+cH7dB
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60C80606ED
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 09:30:53 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so27188865e9.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 01:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794389452; x=1794994252; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
 b=WA+cH7dB7zXPSZIpOVo3HRuZR9IcjH1lFOtoQynv/a4iIJNfPS6eCtaUn2whylyRlS
 ehiamrDeokKVioE+GD6r7gf473jlvBomeiIQ6L3Iml7cWKZjvB+DHG7Wl8prQMGAvg7a
 YiAg3euvN36+kGR5AH5miGA7PMzrVTkja4/BoxHARfW+4bRZNf3Kj1cnQhrcexakA/70
 cApzzubIvUb/vZ5rF2NlVcO16ZzuGQEczBuTlEjQ6rVJKJu2PYdpaIC07A1E4Og+twR4
 WaLmhhytdg+9Am8J/fPLEMc4R2NP9DnChqqplObpNvGL8CTvePtXrkhEYjFXCsKOi1Oa
 9V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794389452; x=1794994252;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ohdbjek4hr8Jhs6bONF/iNmbouRA5J+FWduvFT7IpeM=;
 b=2seV3Mkj7fZWlBv/5NFt1NtxzXldFTBA3wCDkfHESojjsIMQh3u4ULf5LEUpFrnRaN
 /fdqec94ogzpJmWw5dVVQ/tYPsykrbY//+yDJFEtAIAs30Yoffxv0C0XNr/FxHm3bMAI
 cWn8MkCqBpcw76Ip1qsyt+G2+wIwLldwlqrpAsKeomlG1iudzWQQbz3VUMyIdB34IjKc
 0oDPV5W3n7TTnnHCg6MwKcFaPwRxZgCq15fs+vH5DTfli6Oh8/s5D0XrORfHScOTKh4n
 dnx3b0DOiOYQ5wvM6On8LigdIiMRiOB+reiQQDDEQhnLMD4oPc0jetjFegHnCOPOPdPV
 mHgw==
X-Gm-Message-State: APuU4Z+MvWMtihz+zXO+cWkMBTY87busGSeVO9yHJi0c9dNuXySKZ3Y3
 XIeOwq5W0YXhJG/yE+vFKZulJReoww63BtHayKms+pBkYi1Ul3wszkeTCFd6b9fc3Kc=
X-Gm-Gg: AYBFou0HZ/tgm4bnC/V2RXEp2Y7gUnGSMVpSgi1a38ABrhVwBMNAlbuLxii5Jea0iEo
 nfIbi0Ju6LiSbAEUo8mAF+uTyHXlwXlMmVBkcu83sJKphLndOwtWObhn1y3GqVrCUxAWc2tLZlC
 6/mm3nFCeTs46aFluU64ktAR+D86BJX5DUBa0w0ZBfl9YFJey9ZgUy64NYseHso/UAZvmyy/Zrr
 WkwWLvj/E6rlNElgjQ36vkQsT79ABSxUFoIusk7UEQ4ARjzR+Gqx1RYiSA/0o19RqbN5FPmNLmW
 kntPNcjrrJsLb3iODGIN0D4qQm+d9gN/GO/Afi+2O8t0FXef05vrwCdt34faLWtaUI9FrZCzXAZ
 us3RK/lezODOv5IKrWLzTIURfr6XZea7LXxB9NbOz5u4w3D12f3S1XfREuxiccD3f1UzNmjPSCV
 9byp2ctqX4hsA/53ekNuwi0j7As+vS7bzShl1BJBNnHanJ6OqSqV4guAW7UC7dgBwloqw66u2Q6
 kaPuOnkUcy8/DciEG9HYuDb8D6JgJksWudnvR2mjaLVR4zI+iAKgGA9WvXxjV0AIBR3qptwpRDL
 XCrSsyNMr3lwjFIJrO8DhVHCFt6K5g+9S1JnAvc9CVc81i1VbEW+va/Q5nGzBuqZ5GFaqwzXVFE
 b7Qi6KEEMmiRADtpl9rrqfLBVzX/DRNlzq4OaPfP1bERu/MVgLUH+RaJUWe6XYxSVu4ZOXdHqEH
 mqG1lGnSHebNI=
X-Received: by 2002:a05:6000:220e:b0:48d:ff0b:9b52 with SMTP id
 ffacd0b85a97d-499c72712d2mr3050951f8f.19.1794389451603; 
 Wed, 11 Nov 2026 01:30:51 -0800 (PST)
Received: from AHERLNXVDANI01.lgs-net.com ([193.8.40.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb14asm9175839f8f.34.2026.11.11.01.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:30:51 -0800 (PST)
From: =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 dima.ruinskiy@intel.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Daniel=20Via=C3=B1o?= <danividanivi@gmail.com>
Subject: [PATCH iwl-net v2 2/2] igc: treat I226-LMvP as an I226 device
Date: Wed, 11 Nov 2026 10:30:35 +0100
Message-ID: <20261111093035.513635-3-danividanivi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111093035.513635-1-danividanivi@gmail.com>
References: <20261111093035.513635-1-danividanivi@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The I226-LMvP device ID (0x5503) was added by commit 8f20571db527
("igc: Add new device ID"), but when commit b8897dc54e3b ("igc: remove
I226 Qbv BaseTime restriction") introduced igc_is_device_id_i226(), it
was left out. As a result I226-LMvP is currently treated as neither an
I225 nor an I226 part.

Add IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). This changes the
behaviour for I226-LMvP in the following places, all of which now
match the other I226 parts:

 - igc_probe() and igc_io_slot_reset() disable ASPM L1.2, as done for
   I226 since commit 0325143b59c6 ("igc: disable L1.2 PCI-E link
   substate to avoid performance issue").
 - igc_tsn_enable_offload() and igc_tsn_disable_offload() set and
   restore the I226-specific RETX (Qbv full) thresholds.
 - igc_tsn_enable_offload() handles the FutScdDis bit and the base
   time as on I226.

Intel confirmed that the I226 TSN functionality introduced by commit
b8897dc54e3b also applies to I226-LMvP.

Fixes: b8897dc54e3b ("igc: remove I226 Qbv BaseTime restriction")
Link: https://lore.kernel.org/all/5d45a583-198c-467d-afbe-8f19398e82f3@intel.com/
Signed-off-by: Daniel Viaño <danividanivi@gmail.com>
---
 drivers/net/ethernet/intel/igc/igc_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
index ab9120a31..6865fef40 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.c
+++ b/drivers/net/ethernet/intel/igc/igc_base.c
@@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
 	case IGC_DEV_ID_I226_V:
 	case IGC_DEV_ID_I226_K:
 	case IGC_DEV_ID_I226_IT:
+	case IGC_DEV_ID_I226_LMVP:
 		return true;
 	default:
 		return false;
-- 
2.53.0

