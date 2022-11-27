Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EF9C433FE
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Nov 2022 16:32:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 633E6409DD;
	Mon, 28 Nov 2022 16:32:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 633E6409DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1669653144;
	bh=OW6gXRYHcIcoqNiz3oDEiw11K98JsK3FerCMeXlZxVU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Kw58+u+nrqOcxbU1r0e5vVUu6HDBCgUI5c4wkxSGW1fUhTYNcgfACdNajmdZmrfSt
	 ODBhivHNgu06wQZlABccS2piqAxhf1AFC1PJoPxeiW+cu45+m9sERL/WgBqInYmjnc
	 UwC+ovZPmnDGLSZcAk1I9SDlZ7CeEbQmDyQ2hwy5DcNb1bQIlb4sVv5yHM+9yaxKge
	 6Kzq9vI++cH7rmA/ykSIVxTgBtYkSDQtbyO4e7G40BbMVEdrBQkYxfZviRYuQxHOeM
	 94rb7o4AhK8Xa+o+oGMmpKj3ZER+/VF5LwBCmY0/LwEnqfPlInyNEZdqlrm/xu2id6
	 f9evSGIG81alQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QiaRC9pNp56w; Mon, 28 Nov 2022 16:32:23 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA85B409FC;
	Mon, 28 Nov 2022 16:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA85B409FC
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id B6E931BF470
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Nov 2022 08:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 91D4060E34
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Nov 2022 08:17:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91D4060E34
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zxi_0TWcJHBs for <intel-wired-lan@lists.osuosl.org>;
 Sun, 27 Nov 2022 08:17:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDB1360D52
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDB1360D52
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Nov 2022 08:17:11 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 o5-20020a17090a678500b00218cd5a21c9so7620651pjj.4
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Nov 2022 00:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wa4XaW+1zFy7m2UqkW+jljIO+eXfIIcKkAfn67qndy0=;
 b=Sf9+rNSnaULwaaFwplSE+5UeOaMxz4yuJrvCru5gc+m2E9fyU62jRNHuCObN3qDNAN
 7POS+EhbcYnUvJ7V6itjtttCm14gwXQYvrNBKt/gpX7z91cRUXvGYg6yCeuB0nXWDclZ
 ubT/p1AMxGPaSrptR3t1SHZUEsQKXg/WuY/8b6BfmdTk/KHewKnRXc62kv03Sygn7Re+
 D3Qojn5L2m6EaHqKrHLJqxS3IvY2QtLFE4iNzsCizM/0yP1ATyhvWIXB1JNxHwdx+J7w
 dSawPToUCNw76pbBeAWqcwPd3FxI0BnJ/XrIIXO8lojcT+RMawh7ffdvmfLuvtN5xIda
 JLxQ==
X-Gm-Message-State: ANoB5pn4ibPUpCigE6MiAv1ON3zhttcin4VdzPuJvWcc/jQWcdfolkYC
 GrB+9mov7YAO3K95+q6UQFQ=
X-Google-Smtp-Source: AA0mqf4rvxZSLx94xt8O0hrAYSsnP59wsDAZFSxDBKEQ/j+L4D0HtYyX3yRdaNZhIgGbImFJPSQqeg==
X-Received: by 2002:a17:903:251:b0:189:78d9:fe3c with SMTP id
 j17-20020a170903025100b0018978d9fe3cmr5123764plh.101.1669537031297; 
 Sun, 27 Nov 2022 00:17:11 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp.
 [124.33.176.97]) by smtp.gmail.com with ESMTPSA id
 a3-20020aa794a3000000b00572c12a1e91sm5799915pfl.48.2022.11.27.00.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Nov 2022 00:17:11 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Date: Sun, 27 Nov 2022 17:16:04 +0900
Message-Id: <20221127081604.5242-6-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221127081604.5242-1-mailhol.vincent@wanadoo.fr>
References: <20221122154934.13937-1-mailhol.vincent@wanadoo.fr>
 <20221127081604.5242-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 28 Nov 2022 16:31:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wa4XaW+1zFy7m2UqkW+jljIO+eXfIIcKkAfn67qndy0=;
 b=gJ901gCKJQ/u/46XSpx0gsFigjhjTIx2OCUIqZb1puMm0hUpCJDoAKMAPYXqchSe7Z
 ztSHzcluSUWvjmcnWlVqaUrEeQe+yU8FZaNIkx821qFXVZkQLkzPtl0l7z4hdtyrnQP6
 Jc9CJVhx3FRDEJIC3Ll7BCw3oK9/f1SHcq2mHryaZIgPtK6Ekw5JuSnSKUd2J2VV+WW+
 axUt7HoyeaX4MHUz9Rnj5nSezf2VP5hlKZ7pqPqkeknbllCEr1tHOlUJdU0yzLzDHK12
 y0xxEvZL5zG78lBDSvgpaE1mMckYgBkexx+4SDgnkJS7huVaEwd5HcASnMddw/oEohtN
 w++A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=gJ901gCK
Subject: [Intel-wired-lan] [PATCH net-next v2 5/5] net: devlink: make the
 devlink_ops::info_get() callback optional
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
Cc: Andrew Lunn <andrew@lunn.ch>, Simon Horman <simon.horman@corigine.com>,
 Kurt Kanzenbach <kurt@linutronix.de>, Eric Dumazet <edumazet@google.com>,
 Jerin Jacob <jerinj@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, drivers@pensando.io,
 Linu Cherian <lcherian@marvell.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 Shalom Toledo <shalomt@mellanox.com>, Srujana Challa <schalla@marvell.com>,
 Shannon Nelson <snelson@pensando.io>, intel-wired-lan@lists.osuosl.org,
 Vadim Fedorenko <vadfed@fb.com>, Paolo Abeni <pabeni@redhat.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Sunil Goutham <sgoutham@marvell.com>,
 Ariel Elior <aelior@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>, Arnaud Ebalard <arno@natisbad.org>,
 Michael Chan <michael.chan@broadcom.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Petr Machata <petrm@nvidia.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Dimitris Michailidis <dmichail@fungible.com>,
 Manish Chopra <manishc@marvell.com>, Boris Brezillon <bbrezillon@kernel.org>,
 oss-drivers@corigine.com, Vadim Pasternak <vadimp@mellanox.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Taras Chornyi <tchornyi@marvell.com>, hariprasad <hkelam@marvell.com>,
 linux-crypto@vger.kernel.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Geetha sowjanya <gakula@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Some drivers only reported the driver name in their
devlink_ops::info_get() callback. Now that the core provides this
information, the callback became empty. For such drivers, just
removing the callback would prevent the core from executing
devlink_nl_info_fill() meaning that "devlink dev info" would not
return anything.

Make the callback function optional by executing
devlink_nl_info_fill() even if devlink_ops::info_get() is NULL.

Remove all the empty devlink_ops::info_get() functions from the
drivers.

N.B.: the drivers with devlink support which previously did not
implement devlink_ops::info_get() will now also be able to report
the driver name.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 .../net/ethernet/fungible/funeth/funeth_devlink.c   |  7 -------
 .../net/ethernet/marvell/octeontx2/af/rvu_devlink.c |  7 -------
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c   |  8 --------
 net/core/devlink.c                                  | 13 ++++++-------
 4 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funeth/funeth_devlink.c b/drivers/net/ethernet/fungible/funeth/funeth_devlink.c
index 6668375edff6..4fbeb3fd71a8 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_devlink.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_devlink.c
@@ -3,14 +3,7 @@
 #include "funeth.h"
 #include "funeth_devlink.h"
 
-static int fun_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
-			   struct netlink_ext_ack *extack)
-{
-	return 0;
-}
-
 static const struct devlink_ops fun_dl_ops = {
-	.info_get = fun_dl_info_get,
 };
 
 struct devlink *fun_devlink_alloc(struct device *dev)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index f15439d26d21..bda1a6fa2ec4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1547,14 +1547,7 @@ static int rvu_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	return 0;
 }
 
-static int rvu_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
-				struct netlink_ext_ack *extack)
-{
-	return 0;
-}
-
 static const struct devlink_ops rvu_devlink_ops = {
-	.info_get = rvu_devlink_info_get,
 	.eswitch_mode_get = rvu_devlink_eswitch_mode_get,
 	.eswitch_mode_set = rvu_devlink_eswitch_mode_set,
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 5cc6416cf1a6..63ef7c41d18d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -77,15 +77,7 @@ static const struct devlink_param otx2_dl_params[] = {
 			     otx2_dl_mcam_count_validate),
 };
 
-static int otx2_devlink_info_get(struct devlink *devlink,
-				 struct devlink_info_req *req,
-				 struct netlink_ext_ack *extack)
-{
-	return 0;
-}
-
 static const struct devlink_ops otx2_devlink_ops = {
-	.info_get = otx2_devlink_info_get,
 };
 
 int otx2_register_dl(struct otx2_nic *pfvf)
diff --git a/net/core/devlink.c b/net/core/devlink.c
index 3babc16eeb6b..817d978bb729 100644
--- a/net/core/devlink.c
+++ b/net/core/devlink.c
@@ -6773,9 +6773,11 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 		goto err_cancel_msg;
 
 	req.msg = msg;
-	err = devlink->ops->info_get(devlink, &req, extack);
-	if (err)
-		goto err_cancel_msg;
+	if (devlink->ops->info_get) {
+		err = devlink->ops->info_get(devlink, &req, extack);
+		if (err)
+			goto err_cancel_msg;
+	}
 
 	err = devlink_nl_driver_info_get(dev->driver, &req);
 	if (err)
@@ -6796,9 +6798,6 @@ static int devlink_nl_cmd_info_get_doit(struct sk_buff *skb,
 	struct sk_buff *msg;
 	int err;
 
-	if (!devlink->ops->info_get)
-		return -EOPNOTSUPP;
-
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
@@ -6824,7 +6823,7 @@ static int devlink_nl_cmd_info_get_dumpit(struct sk_buff *msg,
 	int err = 0;
 
 	devlinks_xa_for_each_registered_get(sock_net(msg->sk), index, devlink) {
-		if (idx < start || !devlink->ops->info_get)
+		if (idx < start)
 			goto inc;
 
 		devl_lock(devlink);
-- 
2.37.4

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
