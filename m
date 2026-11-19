Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55358606A330
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fEW8lBks;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i8rot8Zj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FF6F80F2F;
	Thu, 19 Nov 2026 01:44:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7LTDEMDj6AL; Thu, 19 Nov 2026 01:44:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9E293810AD
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795052697;
	b=qjxRsTRbS69MaB2v0QsQGL6xqHRnySbM2uUi4Uj9kj70HS6YsPZQhXy15+E4XHNaS4hG
	 4MXUHXnl3XOk/DGB8bxrLVVP1AIqwV0goJSVzRh64izWGszIFt1cOaEqDS9Tbjr5+lYe8
	 fdExVLnz10ifn/xajexaZB3MgpEIwkj3bnr63b8i2GNl7xeAwGNafkYpg7c48CwekOae4
	 XjJgQiY6gQIHly/SB/52Co57OXIWjsY3WiE35BWY6ZfM6V9TR8vA6EA+fb6HAbmx2gL1F
	 btIE/u4hTFPQcoivU94lgPGmBke93vx9nToNdhxuSlz35cI7/z+Gep/DaeuGRdwYMIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795052697;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v4lW71hqhZbV5kfSIsvoYuUxtKOMyzQ4eCZONwiwYEQ=;
	b=pVhcY5qdSNgCkzkrZQcPmCsdkWZkeUQR1vqFD2qFS2VHDMHD7T+9QyBfkJkhYM0ms+ui
	 w1UvIj9EZsorDEUrJYVSC5hjHsWgQWcwaWKQEM24ynVfJbOLQ7uV3Rw3XYCdy3qsScHyX
	 B9UFdtKAiKne3F7wyNZPDE8Sfv1FGkkp33kjt3RJCFjC6SyGIv+T/TcRj+hrw+0rDGA4H
	 SaabMalJqZHNwXTyMlJXfKGGK+M8Wf/4ifvJkpaaDgkwXOfLoaP6sI6Ip7XUJIWDaQDwk
	 /Ysrt2vsGKu/aaAiE8BeiS9yWbDni5pmlpbdXmakef8VMmoKIC8Twn+rId+79fYxNfA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795052697;
	bh=v4lW71hqhZbV5kfSIsvoYuUxtKOMyzQ4eCZONwiwYEQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fEW8lBksNquY1fKTBfERql8z95ukXmgxZaKStndrMvwJyL6krEs2dJXbXrs+RKup3
	 DH0LUKRu47+/MFousP/6XYZe9LDhXckda4h4hpAxQSz6NiRYxLJN4/TmZpMgezO4eH
	 vcaOrq5dGMKP9ktL4uszIVerGItcN5eh2PAP+I+lUQ686Dmedn3Oe7izHZ675S1guO
	 rx+h+d9D2ZEbBY9i6dMKALOyEwp7Zp3Kg141F1YHLRCdnRzRM99RgCqFZ0I+ydiC+D
	 pzjrhX1P+UaxSeL9dw4jvQzhdcfnnDA9iuprcV2iSa5Of8tUu7KyN7p9Z8kWjJx25I
	 WGASED01b7GTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E293810AD;
	Thu, 19 Nov 2026 01:44:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8178C15D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 01:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67ECD400C8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 01:44:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRJiUY6WtoZJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 01:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A5D04400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::72f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com;
 envelope-from=lcy8047@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=i8rot8Zj
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A5D04400AE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 01:44:52 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-94960131b30so193287085a.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 17:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795052691; x=1795657491; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v4lW71hqhZbV5kfSIsvoYuUxtKOMyzQ4eCZONwiwYEQ=;
 b=i8rot8ZjEHCjN4vGi+WXEiVnE7KTNa60M4jB00jrL8VTEAH0TT8AQObdUhpIVWRq1u
 bLs0+/UubpzfNR5W0kxg/qgz+FpwI/Waa2bLhQX8hDuz8wlMtX4+8m3In2+6yvVCFDIP
 KcJj14lPahdt1w+ou77LM5yabrK/xurCXCwS/ggCEQ6/eIj07UyFa0XC+qumteEEPxuY
 OSqNIG+wmx+jY3vbh7XGUOZ+3cX1Ec81qk0G8vZMQxoNce2wkuU1e4/752vyrmpCvX3E
 5Ie75MvHcsg4W2t9qlQQwaIWlGu0bhrLg37+Y67CGiDyLiaWOgIqW9dvwzCDPBHG5lIp
 b/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795052691; x=1795657491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v4lW71hqhZbV5kfSIsvoYuUxtKOMyzQ4eCZONwiwYEQ=;
 b=gev/57XPpDYkcwlPhlcBMWg38X7tmSs/TU9jv2awBsDRBeNxh6f8lQr1DVuHgJt+8m
 qLRmCrGWXVjiumbre/cAHBiSUutAS3JFDSItNc/fuB4M3sF97OiwLZNWN1ld6NpwGIC8
 ubJwLYzqkvnDyq3DJDQqB5PXWayKLcu1uBFYIyWo0EcCf1kr6TyUIl2kRldzppdggCnb
 GCkbOieNlaJz2UOCwitJPVej/hyO5M1K8nGEnAWqkcc7T/A01ND8lUBxlADG386ZsUe8
 4mqgBbTRjO+EbbKRnAuPI8PDHAN7jnnUB8uY8h5gZTV5TEF3KB7cA0F0msMBLs6sTqQE
 QpEg==
X-Forwarded-Encrypted: i=1;
 AL+hErG4faDgs12y505v8gDXvX7x2xQ8d66MhaKA2kN2CDkiys2RwL3T5JVhlFDb/2R6/iTYVNkRG94UAfA5HvLsq/g=@lists.osuosl.org
X-Gm-Message-State: APuU4Z/1moijXdSF0SrwMYx3GXVNmIl+9o1BUob2RAVqsulw6+OQrDPD
 ngKlzePwCvrnpW+hy8YKWehYv0tzV4QB3mSB3HPacrsysNG41pV21+EC
X-Gm-Gg: AYBFou0Y2q58+NRP9ehAmjuUt8FJvE3t1KvCJaValC4cSRT1gUHlrbBipgUfmrYHY7R
 kgF9D4DOZ4a+QMK7dftU5kKSkrZ0ZGPbZtRt1mwkchoU1Krd4nfzLyqeN+Vzh7gIdoIgw66TrFN
 P6d/4zbKCmVYUq5MbiBC9ReZqoCHpquUbRl6XS8CzWwrBLjwlunnYF0aEWe+wGQWeS2oxgES8tH
 oFtA6ZqJqjmOz5UuWeeFMgfIY5fkuq0BCa+UCmysva6IADczp2pwgFZr4SH0+S6GL6VqIz6t/WW
 TIdNpbJzLoyyLiqmJBMkGjB6gN4u3XuscDPvm/utH5ZGJd7ie8RgMrD+nTmBFd7YqFlmG0ozh1S
 JVI0ycA/WZ9rbvfzBD56PwAHJ8GsUgbZqB4oUZcWySIs5vn0dF9gUVP0rWFbFORzKRZelAlkxuv
 x8slSNB0tsBlmkYmeDGa9lsO9ArRUayKgoA0P5tym4zHBrRr63KjaXrj5KYfdfOYQ+jNiL8hAOx
 6MffYKGkoufw6nWUcXpczUKbcvfrYVYYxOAw+GcIg6Ax/iTuz/IWo6QpUw10b3SHnYxzYSd2zUB
 8MY43bB1gQhdU7IlxG5ELtnvofGWvFA9hcGtXZsbF6UKxH8yhv/etJSqJ7j96TDdsap1QMKt63Y
 =
X-Received: by 2002:a05:620a:258b:b0:93f:3565:813 with SMTP id
 af79cd13be357-949994af05cmr800463785a.9.1795052690762; 
 Wed, 18 Nov 2026 17:44:50 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b743a8bsm320302485a.17.2026.11.18.17.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 17:44:50 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH iwl-net] ice: protect VF lifetime during LLDP configuration
Date: Wed, 18 Nov 2026 20:44:46 -0500
Message-ID: <20261119014446.577784-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ice_free_vfs() can free a VF or its VSI while ice_cfg_sw_rx_lldp()
is configuring LLDP. Taking table_lock here would reverse the lock
order because ethtool already holds RTNL and ice_free_vfs() takes
RTNL under table_lock.

Look up each VF by ID to hold a reference. Hold the VF's cfg_lock
while configuring its VSI to prevent ice_free_vfs() from releasing
the VSI during configuration.

Fixes: 2296345416b0 ("ice: receive LLDP on trusted VFs")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus PCI_IOV, ICE, DCB and
W=1.

Taking cfg_lock under RTNL follows the order set by commit ae82ccd68774
("ice: attach and detach VF representors outside of vf->cfg_lock") in
dev-queue.

 drivers/net/ethernet/intel/ice/ice_lib.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 773a656ba92e..4068a1aac8e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2207,7 +2207,6 @@ void ice_cfg_sw_rx_lldp(struct ice_pf *pf, bool enable)
 {
 	struct ice_vsi *vsi;
 	struct ice_vf *vf;
-	unsigned int bkt;
 
 	vsi = ice_get_main_vsi(pf);
 	ice_vsi_cfg_sw_lldp(vsi, false, enable);
@@ -2215,14 +2214,18 @@ void ice_cfg_sw_rx_lldp(struct ice_pf *pf, bool enable)
 	if (!test_bit(ICE_FLAG_SRIOV_ENA, pf->flags))
 		return;
 
-	ice_for_each_vf(pf, bkt, vf) {
-		vsi = ice_get_vf_vsi(vf);
-
-		if (WARN_ON(!vsi))
+	for (u16 vf_id = 0; vf_id < pf->vfs.num_supported; vf_id++) {
+		vf = ice_get_vf_by_id(pf, vf_id);
+		if (!vf)
 			continue;
 
-		if (ice_vf_is_lldp_ena(vf))
+		mutex_lock(&vf->cfg_lock);
+		vsi = ice_get_vf_vsi(vf);
+		if (vsi && ice_vf_is_lldp_ena(vf))
 			ice_vsi_cfg_sw_lldp(vsi, false, enable);
+		mutex_unlock(&vf->cfg_lock);
+
+		ice_put_vf(vf);
 	}
 }
 

base-commit: c2c187fd5fa667cedb0b946f5f7a5099fb8e8402
-- 
2.43.0

