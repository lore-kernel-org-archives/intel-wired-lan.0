Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663CEEB1070
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Mar 2026 15:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42D8C41CBF;
	Tue, 10 Mar 2026 15:27:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nR36Zl-dFFqV; Tue, 10 Mar 2026 15:27:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B62A540C28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773156458;
	bh=hW7ZW/AdL6DqQMQ550rS8xJYq7Gaxx6/BDwT0RbjjT0=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7xFhd4oc4SqXEZJZSJLF0cH7OC8GDF5BeYtbRQWn/l2zwJLVt0KzVM+gbAW4nxCX
	 /hA0Zpy9Yks0rmQfV7ARbVtot8hSuEQVRSLmAC12MGg9dTeTDoj+Xyar055DJF/n70
	 LvkzoZvyXOuPrPcn8yUvGsENUyEg+Ft4e2QtOPPjqe0d/TCnCbVJXgRLm+grxXcvpT
	 IbU5Lye+O2L9S0UADOShd1d0C9Zoc0CqmN3EkIT+g6Wg73qgx7Ioo62cGQ8b6DRSPL
	 FoNMXGRlHjbhmH4ohjaJCm6EmhmnLbCCAq9eKX6Gz3v41oAiRmX+Bm5+aBLnAKZus4
	 yBPzXM6EDJvlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B62A540C28;
	Tue, 10 Mar 2026 15:27:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E6FE201
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D26460B3C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PX_L7n9lIGvM for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Mar 2026 12:05:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.42.244.120;
 helo=mail.avm.de; envelope-from=phahn-oss@avm.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 87A8660B11
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87A8660B11
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87A8660B11
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Mar 2026 12:05:08 +0000 (UTC)
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.55.2)
 (envelope-from <phahn-oss@avm.de>)
 id 69b006ac-b734-7f0000032729-7f000001c05e-1
 for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de
 [IPv6:2001:bf0:244:244::71]) by mail.avm.de (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-28-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1649; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=K9CWTyYKGB0w6Tk2xrcCabYj/9tltesZ0HvDiXE6CGA=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAY0Ab3VO2a9CLyi58wXwo/lqSwdB2G61GV4k
 bTbJSvyEGOJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGNAAKCRA0LQZT0ays
 24mRB/9btDfW+RDwuaye8LPDtf1ZUJwDncM7Zgyp6SHFDbDBBUCY5jMLThJncFGvw3pVn6MHlrR
 e+vSLwaJsDAVLn6K23Z4PPrutM/glgm9IAew2t89ZwRwFxQzfV+39rXZfBmOC/J16tW6tO1iy8k
 2C61WhK0hJtogp/FtZ3yHRbCwt8dKoLmF2qlw1QSQLKl8LOMWf3xw4Hzsu7PORnm8NiE+tP0SiT
 14xuZtoKpdLMjWGJyLVgKFIFQUVZBRep4Y+ogBPonV7uWFQl+T8Y21kTTXl++qp7tP7BH5AxDRw
 qjRRlFGTUp8rPbK2m+WUcf3WaJPpbUCWbYm05Bbm4z30Dms3
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-025C1A3D-E80041E6/0/0
X-purgate-type: clean
X-purgate-size: 1651
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Tue, 10 Mar 2026 15:27:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=avm.de; s=mail; 
 t=1773143726; bh=K9CWTyYKGB0w6Tk2xrcCabYj/9tltesZ0HvDiXE6CGA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ITpeZZvCuurO6PtLvdRtRS5nd/bZCx1ndt94VbmepmWY6QteCwWswdiO1VbAljY8r
 fKxVkij1nMq0v9Gab/FV6dxJIQZxwXhWwA5TgvQnG1MilGO8jeOzxFRlzhEz0vggaA
 hWfQSJYU7rq79j74Br0/ZAepDgNZ+brN6WE4sbn0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=avm.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.a=rsa-sha256
 header.s=mail header.b=ITpeZZvC
Subject: [Intel-wired-lan] [PATCH 28/61] net/sched: Prefer IS_ERR_OR_NULL
 over manual NULL check
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

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Jamal Hadi Salim <jhs@mojatatu.com>
To: Jiri Pirko <jiri@resnulli.us>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/sched/cls_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 4829c27446e3369ad2ae9b3fcb285eca47d59933..4208225e7a4acaf0c331096ebf941f68cc2ed992 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2444,7 +2444,7 @@ static int tc_new_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 		tcf_chain_tp_delete_empty(chain, tp, rtnl_held, NULL);
 errout_tp:
 	if (chain) {
-		if (tp && !IS_ERR(tp))
+		if (!IS_ERR_OR_NULL(tp))
 			tcf_proto_put(tp, rtnl_held, NULL);
 		if (!tp_created)
 			tcf_chain_put(chain);
@@ -2612,7 +2612,7 @@ static int tc_del_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 
 errout:
 	if (chain) {
-		if (tp && !IS_ERR(tp))
+		if (!IS_ERR_OR_NULL(tp))
 			tcf_proto_put(tp, rtnl_held, NULL);
 		tcf_chain_put(chain);
 	}
@@ -2741,7 +2741,7 @@ static int tc_get_tfilter(struct sk_buff *skb, struct nlmsghdr *n,
 	tfilter_put(tp, fh);
 errout:
 	if (chain) {
-		if (tp && !IS_ERR(tp))
+		if (!IS_ERR_OR_NULL(tp))
 			tcf_proto_put(tp, rtnl_held, NULL);
 		tcf_chain_put(chain);
 	}

-- 
2.43.0

