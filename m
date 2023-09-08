Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC29EEB56A
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 Sep 2023 18:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EB19F40169;
	Fri,  8 Sep 2023 18:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB19F40169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694196971;
	bh=5sQNYz43kntAXJjyOusuNuX4XeStFc1fQHzgb9iqAJ4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dlzY8WWU9SPL0qe8STrdXQXw0peQb/xjv1R4XApsKh/4kZ59D4yGuej8S+daNtnHd
	 hSC6H2IdticneKFWtUWGbUHym/nf/LS8zxYTUTdjNlwc7jaxn5vhpSiyhFkoCcUJJO
	 SqMDSMdmHc19zqrx6/rY/m/VCnM3QjcONaZ1G+C8Z5c2IKQtT9s/yGqzy4qs0q7ktH
	 O9UUJc8c5/y3Vh697B7V+igvsrDp6+G0/0JQODaNYTL31Pc+o1P41Nntn98MXRM1SI
	 b/WefjMzCn46aOleC791Zi/Xy3egeUrPJj6Y4fmG9AXj8y/ErOX01ZfPXGdk5vDU6T
	 HidF0zfcxIpfQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2yUzvs2mLm_5; Fri,  8 Sep 2023 18:16:10 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 17D24401DD;
	Fri,  8 Sep 2023 18:16:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 17D24401DD
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CA7811BF3DA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Sep 2023 18:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A249A401DD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Sep 2023 18:16:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A249A401DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9aZxCP7usiUe for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 Sep 2023 18:16:08 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E5C7240169
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 Sep 2023 18:16:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5C7240169
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 7E608CE1C4F;
 Fri,  8 Sep 2023 18:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF49C193E8;
 Fri,  8 Sep 2023 18:16:03 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri,  8 Sep 2023 14:15:18 -0400
Message-Id: <20230908181555.3459640-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1694196965;
 bh=L24/99yFP2SD9mr7M0EzsatIqA9G0bITSVQ1rgNLgfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jlISw8rUJfwT2CyUu8cXCyG7tBQbSYEFundCyR0J7H53LR/2I3ETUDMWvxpk4cCRQ
 djzMGaFadsXsuJxpHtwm8AbsAmKD7t8DuvuqwQRpWeFLy4kL1nRt/ttiRJYjDsJdJk
 w65U54Qy3pVkP+8vHy5ua9G2XxjfQdTvf9lbzcopeRQM7y5PCwlq+3jhvyDd7QvO6R
 LWq5lnBmTLshjX4j7ssC0XczFCHCUjUOf7zBAdWGyiY/Qp7rfmL/PoUvxL+sgDYnFa
 w3QpPPxrKmh688l2xsbbwnAqgWtKOxrt4xZqRlKQO0rg95mq3Kdq0TmH1u3Y2/+FC8
 am/07GUYKT07Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=jlISw8rU
Subject: [Intel-wired-lan] [PATCH AUTOSEL 6.4 04/41] ice: Don't tx before
 switchdev is fully configured
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
Cc: Sasha Levin <sashal@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Simon Horman <simon.horman@corigine.com>, jesse.brandeburg@intel.com,
 edumazet@google.com, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Wojciech Drewek <wojciech.drewek@intel.com>

[ Upstream commit 7aa529a69e92b9aff585e569d5003f7c15d8d60b ]

There is possibility that ice_eswitch_port_start_xmit might be
called while some resources are still not allocated which might
cause NULL pointer dereference. Fix this by checking if switchdev
configuration was finished.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 03e5139849462..eab2481114ef3 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -361,6 +361,9 @@ ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	np = netdev_priv(netdev);
 	vsi = np->vsi;
 
+	if (!vsi || !ice_is_switchdev_running(vsi->back))
+		return NETDEV_TX_BUSY;
+
 	if (ice_is_reset_in_progress(vsi->back->state) ||
 	    test_bit(ICE_VF_DIS, vsi->back->state))
 		return NETDEV_TX_BUSY;
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
