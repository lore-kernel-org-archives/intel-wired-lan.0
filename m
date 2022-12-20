Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAD7C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Dec 2022 16:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1971660769;
	Tue, 20 Dec 2022 16:01:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1971660769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1671552105;
	bh=aNazwSk8TYE8ORqWjZF+or/FHT5xS7ioOSQUlKYpzYo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=q6WaQYg/pOPIBIcoDorw+6jaZ5O0VwkxHiBo6w2xRQEQs8SBSzRRtXdXfDHYRAftK
	 1tT4ImdJwnMbLIM4K5rmUNGKdD5tPNbMqEt5iPIJlVorKhSGUkFCZECgldgX1mRZTS
	 gV3CojjPKsKFbgsVgexb58XBm3zqyOyuYkv8o2JWigAB8WZwvBPhk23RFmFWMtk5rA
	 h/C1ZqQGjrjqqYyk57Fu/iNMRjJ3ItI0gFfV7Gyr7IbRMlL+OphEdhrmK009eJyllR
	 b3hHUTELfyOPlS5Q0bCGbMAkB05IxeT5G3fhLQmoGoFoamK6hk7NrSPwjPKW0Kc9tl
	 jrfifhaFCa5Zw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mkls27kmAwtT; Tue, 20 Dec 2022 16:01:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E247607C9;
	Tue, 20 Dec 2022 16:01:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E247607C9
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 7FDB01BF325
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Dec 2022 06:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66B2B80D2A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Dec 2022 06:34:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66B2B80D2A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xni9hM59b42E for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Dec 2022 06:34:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 104B780CC8
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net
 [178.154.239.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 104B780CC8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Dec 2022 06:34:25 +0000 (UTC)
Received: from myt5-8800bd68420f.qloud-c.yandex.net
 (myt5-8800bd68420f.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:4615:0:640:8800:bd68])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id AA85C605E7;
 Tue, 20 Dec 2022 09:32:58 +0300 (MSK)
Received: from d-tatianin-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:a418::1:2])
 by myt5-8800bd68420f.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 mWekiF1Qua61-Os7KMsdQ; Tue, 20 Dec 2022 09:32:57 +0300
X-Yandex-Fwd: 1
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 20 Dec 2022 09:32:46 +0300
Message-Id: <20221220063246.1593327-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 20 Dec 2022 16:01:37 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yandex-team.ru; s=default; 
 t=1671517977; bh=fZ55fK+rBHxzLQTQDzeHsEkqnYvLJhSwxRsEbq74Ca4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=POTAmd49lFo/yCA7Kr6hv/ZWDI4yh385HgNAVUrAjRCTyCWkIB386e/0LKuYgqMO9
 Dh9mLJIrnKfA8D/RWb9sIZ08DGxHgvOs4esWwZl3JjAa6WcEZe5D3JzHJbymZAf46f
 v4QQJ4eUUJSh8wDVTEM2smuMSloeIFw0KSqofO58=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru
 header.a=rsa-sha256 header.s=default header.b=POTAmd49
X-Mailman-Original-Authentication-Results: myt5-8800bd68420f.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [Intel-wired-lan] [PATCH v2] iavf/iavf_main: actually log ->src
 mask when talking about it
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
Cc: intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This fixes a copy-paste issue where dev_err would log the dst mask even
though it is clearly talking about src.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.

Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c4e451ef7942..adc02adef83a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3850,7 +3850,7 @@ static int iavf_parse_cls_flower(struct iavf_adapter *adapter,
 				field_flags |= IAVF_CLOUD_FIELD_IIP;
 			} else {
 				dev_err(&adapter->pdev->dev, "Bad ip src mask 0x%08x\n",
-					be32_to_cpu(match.mask->dst));
+					be32_to_cpu(match.mask->src));
 				return -EINVAL;
 			}
 		}
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
