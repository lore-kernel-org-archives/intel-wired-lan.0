Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D9BC001DB
	for <intel-wired-lan@archiver.kernel.org>; Mon,  7 Aug 2023 09:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1A6A4056A;
	Mon,  7 Aug 2023 09:15:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1A6A4056A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691399704;
	bh=CHM3sEkEOJPrmgQKS59bTJfx23g9gYqnTfsfHpT3+pw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=1NXr2s2pP+twZhjaY6+6ovSKEKNfyB4bAx7JTvTuuBeZNt9F/nnKiPHsg9neks5rm
	 zgWcVYUnGq/gUsu7tfe9BIXTldnjDYPXg63beW/6pHg31QKSl5c0vwhoiIH8Cw5IDN
	 TFe9CGwqHn3uIdsA5m2t4N5pHav0JwPpZT9UzqdT77mL4TCAx6allRQ47PLVoPJoXg
	 RZMFV+s5XKAn4FlF0YW8KppTQuGa5J2tYSd7vhgyyPxY2TiGViYAEvFuo+Wqu0gEjK
	 YEPwyXSB0Z1KUnmK1n7Xg/hoFqQKvWjB2o1LiVErfNuvMGlln8FQulVy5ifBOU5VQe
	 iwFEC4CQwFaIA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TQAexUgjbCxK; Mon,  7 Aug 2023 09:15:04 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id ABF064036E;
	Mon,  7 Aug 2023 09:15:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABF064036E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 3BCF41BF969
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 09:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9092C81492
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 09:14:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9092C81492
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pl6uQ56jKR_m for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Aug 2023 09:14:45 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net
 [129.150.39.64])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05ACE80C1B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Aug 2023 09:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05ACE80C1B
Received: from localhost.localdomain (unknown [115.206.160.170])
 by mail-app2 (Coremail) with SMTP id by_KCgCXDxvXtdBkKGQpCw--.25311S4;
 Mon, 07 Aug 2023 17:14:00 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, saeedm@nvidia.com,
 leon@kernel.org, simon.horman@corigine.com, louis.peens@corigine.com,
 yinjun.zhang@corigine.com, huanhuan.wang@corigine.com, tglx@linutronix.de,
 na.wang@corigine.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com
Date: Mon,  7 Aug 2023 17:13:47 +0800
Message-Id: <20230807091347.3804523-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCXDxvXtdBkKGQpCw--.25311S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw1DXF1xXw4xWrW3Gw17Wrg_yoWrGFyDpa
 1UJa4xZ3yvqr15Xan7Ja18ZF9Yqay7t398uF4Sya1rZw1vvFyDCr4DKF9I9ryUArWUGF13
 tr4UAF13Aas8X3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
 JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
 0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
 17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
 73UjIFyTuYvjfUeF4EDUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Subject: [Intel-wired-lan] [PATCH net-next v2] rtnetlink: remove redundant
 checks for nlattr IFLA_BRIDGE_MODE
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
Cc: Lin Ma <linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
IFLA_BRIDGE_MODE length") added the nla_len check in rtnl_bridge_setlink,
which is the only caller for ndo_bridge_setlink handlers defined in
low-level driver codes. Hence, this patch cleanups the redundant checks in
each ndo_bridge_setlink handler function.

Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
V1->V2: delete the link to last commit as it already in tree

 drivers/net/ethernet/broadcom/bnxt/bnxt.c           | 3 ---
 drivers/net/ethernet/emulex/benet/be_main.c         | 3 ---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c       | 3 ---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c   | 3 ---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 3 ---
 5 files changed, 15 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e5b54e6025be..9e098c1cf1ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13101,9 +13101,6 @@ static int bnxt_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		if (nla_type(attr) != IFLA_BRIDGE_MODE)
 			continue;
 
-		if (nla_len(attr) < sizeof(mode))
-			return -EINVAL;
-
 		mode = nla_get_u16(attr);
 		if (mode == bp->br_mode)
 			break;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 18c2fc880d09..e8abc43a7061 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -4985,9 +4985,6 @@ static int be_ndo_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		if (nla_type(attr) != IFLA_BRIDGE_MODE)
 			continue;
 
-		if (nla_len(attr) < sizeof(mode))
-			return -EINVAL;
-
 		mode = nla_get_u16(attr);
 		if (BE3_chip(adapter) && mode == BRIDGE_MODE_VEPA)
 			return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 1726297f2e0d..d1381b1b3f3a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10042,9 +10042,6 @@ static int ixgbe_ndo_bridge_setlink(struct net_device *dev,
 		if (nla_type(attr) != IFLA_BRIDGE_MODE)
 			continue;
 
-		if (nla_len(attr) < sizeof(mode))
-			return -EINVAL;
-
 		mode = nla_get_u16(attr);
 		status = ixgbe_configure_bridge_mode(adapter, mode);
 		if (status)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index defb1efccb78..b2df8e517a85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4883,9 +4883,6 @@ static int mlx5e_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		if (nla_type(attr) != IFLA_BRIDGE_MODE)
 			continue;
 
-		if (nla_len(attr) < sizeof(mode))
-			return -EINVAL;
-
 		mode = nla_get_u16(attr);
 		if (mode > BRIDGE_MODE_VEPA)
 			return -EINVAL;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 6b1fb5708434..85f36ec2f986 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2068,9 +2068,6 @@ static int nfp_net_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		if (nla_type(attr) != IFLA_BRIDGE_MODE)
 			continue;
 
-		if (nla_len(attr) < sizeof(mode))
-			return -EINVAL;
-
 		new_ctrl = nn->dp.ctrl;
 		mode = nla_get_u16(attr);
 		if (mode == BRIDGE_MODE_VEPA)
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
