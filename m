Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CF1C05027
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Feb 2023 16:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1D6D40A17;
	Wed,  1 Feb 2023 16:25:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1D6D40A17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1675268745;
	bh=yH+hU+8NfZEcaLo3kezOEHP4KcUbfklY4HKh3K736nk=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=YAHO0+uZaLcQqEFPf653m+gK8nhRtixhetfaLEQ6habKMyztqCl0SooOwp0WsYXPN
	 iHDgpI8A3gUS1GzGNzZIVGvuPTCJ+YaubP0ckOgEIpT3AOln5A/2XdsLvyTxs3PWP9
	 0If4kVMwZ8JzUrrXTsUKwXagELmHqICYG97R23YVbflcdxN3yqemwnCaVTQu47GD6j
	 OqP7CN4XDRnVVPHrwwyNyCrhjxWrMIwDi9KUjZbtEm5VnmfN32Eopv/9gEjvb4P3Ks
	 umvi35C6GskaeV9kybVPC9+pxNj06UV6et35rKKzeBRSb32QDj6TV+WXy7o55drHw3
	 LM0txvyE99JEQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dGpcDIueH7wg; Wed,  1 Feb 2023 16:25:43 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1511E40A42;
	Wed,  1 Feb 2023 16:25:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1511E40A42
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 33E7A1BF31A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 09:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D8FB40734
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 09:06:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D8FB40734
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FM6qKr_QsTgy for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Feb 2023 09:06:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 88A8040629
Received: from exchange.fintech.ru (e10edge.fintech.ru [195.54.195.159])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88A8040629
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Feb 2023 09:06:16 +0000 (UTC)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 1 Feb
 2023 12:06:13 +0300
Received: from KANASHIN1.fintech.ru (10.0.253.125) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 1 Feb 2023
 12:06:13 +0300
From: Natalia Petrova <n.petrova@fintech.ru>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 1 Feb 2023 12:06:10 +0300
Message-ID: <20230201090610.52782-1-n.petrova@fintech.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230125141328.8479-1-n.petrova@fintech.ru>
References: 
MIME-Version: 1.0
X-Originating-IP: [10.0.253.125]
X-ClientProxiedBy: Ex16-01.fintech.ru (10.0.10.18) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Mailman-Approved-At: Wed, 01 Feb 2023 16:25:41 +0000
Subject: [Intel-wired-lan] [PATCH v3] i40e: Add checking for null for
 nlmsg_find_attr()
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
Cc: lvc-project@linuxtesting.org, intel-wired-lan@lists.osuosl.org,
 Natalia Petrova <n.petrova@fintech.ru>, linux-kernel@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The result of nlmsg_find_attr() 'br_spec' is dereferenced in
nla_for_each_nested(), but it can take NULL value in nla_find() function,
which will result in an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 51616018dd1b ("i40e: Add support for getlink, setlink ndo ops")
Signed-off-by: Natalia Petrova <n.petrova@fintech.ru>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v3: Fixed mailing list.
v2: The remark about the error code by Simon Horman <simon.horman@corigine.com> 
was taken into account; return value -ENOENT was changed to -EINVAL.
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 53d0083e35da..4626d2a1af91 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13167,6 +13167,8 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
 	}
 
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
