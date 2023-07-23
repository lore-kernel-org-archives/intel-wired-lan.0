Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7314DC001DC
	for <intel-wired-lan@archiver.kernel.org>; Sun, 23 Jul 2023 07:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E30860A63;
	Sun, 23 Jul 2023 07:59:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E30860A63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690099143;
	bh=j8UQnAAevmIgvwWjzsmG72qBNaJlyk+MBbYAjMrEHvs=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=KGNgObcBv3H5t+g7A9nP0kqd3B/50nNCGitf2wO24DzksIRe8GBnhOKJ7r6gMqWEX
	 2VW68JKwnn/vaDbAyJwNNrWSjCMtSHgVC4VUHwb4VMVaabzvRkZkn2HHjcbID//8BU
	 jOcHtMf65+aDvDBaonOXm7UppiPC3NHvBltuB7X0lhVJYn+UiNYnku1bqfjYvDIyfx
	 86Zbx4psbBnLYkrxyMubGiRA742cG68KvwwbTicZ03KtU0ItfX2AFUuW1P6btUHtGD
	 Tk2v4EZeH/TOEDfQXXAwgjkp/78jFk2fsz4gJt7U5h+GMGH4g7FeK6MvvCADoL2P2V
	 +kC5+BNbP5gjw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D3uUDeHk82Us; Sun, 23 Jul 2023 07:59:02 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4267E60BA2;
	Sun, 23 Jul 2023 07:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4267E60BA2
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 5127C1BF3DA
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Jul 2023 07:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28B6840484
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Jul 2023 07:59:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 28B6840484
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E9WhVV2vGVR4 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 23 Jul 2023 07:58:58 +0000 (UTC)
X-Greylist: delayed 463 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 23 Jul 2023 07:58:57 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EEBE40168
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net
 (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9EEBE40168
 for <intel-wired-lan@lists.osuosl.org>; Sun, 23 Jul 2023 07:58:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [39.174.92.167])
 by mail-app3 (Coremail) with SMTP id cC_KCgA3P79J3LxkwFN_Cw--.18699S4;
 Sun, 23 Jul 2023 15:52:41 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 23 Jul 2023 15:52:39 +0800
Message-Id: <20230723075239.3710086-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgA3P79J3LxkwFN_Cw--.18699S4
X-Coremail-Antispam: 1UD129KBjvJXoWrZw4DGFy5WFW5Cr4DKr1kAFb_yoW8JF45pa
 4Dta4Ivry8Xr4fWayfXa18Zr98Wa9xtr90gF43tws5ZwnYqFn8Jr9FkF909ry8AFWYkF1a
 yF4UCFyfZasrXFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
 1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
 b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
 vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
 cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
 nxnUUI43ZEXa7VUbEksDUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Subject: [Intel-wired-lan] [PATCH v1] ice: Add length check for IFLA_AF_SPEC
 parsing
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

The nla_for_each_nested parsing in function ice_bridge_setlink() does
not check the length of the nested attribute. This can lead to an
out-of-attribute read and allow a malformed nlattr (e.g., length 0) to
be viewed as a 2 byte integer.

This patch adds the check based on nla_len() just as other code does,
see how bnxt_bridge_setlink (drivers/net/ethernet/broadcom/bnxt/bnxt.c)
parses IFLA_AF_SPEC: type checking plus length checking.

Fixes: b1edc14a3fbf ("ice: Implement ice_bridge_getlink and ice_bridge_setlink")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 19a5e7f3a075..85730075dcb4 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7701,6 +7701,10 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 
 		if (nla_type(attr) != IFLA_BRIDGE_MODE)
 			continue;
+
+		if (nla_len(attr) < sizeof(mode))
+			return -EINVAL;
+
 		mode = nla_get_u16(attr);
 		if (mode != BRIDGE_MODE_VEPA && mode != BRIDGE_MODE_VEB)
 			return -EINVAL;
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
