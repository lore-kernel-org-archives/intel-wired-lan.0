Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC295C3A5A7
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Dec 2022 16:28:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3BE5540122;
	Thu,  8 Dec 2022 16:28:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3BE5540122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1670516918;
	bh=b9E12N+JDWWzJTrfeYmFjov9a6lNRXuSyieQZzwFBRk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=M59EHF0k7Xg8730DPNfZtLvl6Y9H+vtpTS6pR2wuP+PbVk8waMJ1RQ0t65QujMWIl
	 Swo8hyPk6w6R5b79qkU+0xIWgHRv0NYWM49ls/KzioxoPrMU4EalVjmb/Tp98TmZ1J
	 tijTLJw5sChk0JtZ6DLsWqqU5oCeUUTW8gbwtunJ1daWrwGXKhEIEtuaNTDGSOAy/V
	 d3Hh2/+7iF4iVIA+O+8Pbcd2XvH34FbVTPXdctAePEg+LvBmVd8OCZyWNsKnjkwRPm
	 HC8JzfywLzckO+knqDchb1sRilf75uxJm7xtUuI9lV4q2XATXJ6Jvr4dQAQVvZHk7F
	 CNn4wQ1V14B9g==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nFCFCS9v8ZHK; Thu,  8 Dec 2022 16:28:37 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A5144014E;
	Thu,  8 Dec 2022 16:28:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A5144014E
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 816FE1BF313
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 12:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5591660B1B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 12:58:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5591660B1B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CPuKQNIvpING for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Dec 2022 12:58:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07A2A60760
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
 by smtp3.osuosl.org (Postfix) with ESMTP id 07A2A60760
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Dec 2022 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [124.16.138.125])
 by APP-05 (Coremail) with SMTP id zQCowABHZ8yH35FjhEHKBQ--.43615S2;
 Thu, 08 Dec 2022 20:58:47 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: jiri@resnulli.us
Date: Thu,  8 Dec 2022 20:58:47 +0800
Message-Id: <20221208125847.45342-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: zQCowABHZ8yH35FjhEHKBQ--.43615S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5uw4Uur4xAFWxKw43GFg_yoW8ZrWrpa
 13JryYyrW8Ar4UWrnxXF1jvFW5uayxJ3409ay3J3sxZF1qyr4rt3WqyryYkr1rGrW2va9x
 tF15AFZrCasFvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
 0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
 17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
 73UjIFyTuYvjfUeWlkDUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 08 Dec 2022 16:28:28 +0000
Subject: [Intel-wired-lan] [PATCH net v3] ice: Add check for kzalloc
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
Cc: leon@kernel.org, intel-wired-lan@lists.osuosl.org,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

As kzalloc may return NULL pointer, the return value should
be checked and return error if fails in order to avoid the
NULL pointer dereference.
Moreover, use the goto-label to share the clean code.

Fixes: d6b98c8d242a ("ice: add write functionality for GNSS TTY")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v2 -> v3:

1. Use "while (i--)" to simplify the code.

v1 -> v2:

1. Use goto-label to share the clean code.
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index b5a7f246d230..90c620c26516 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -462,6 +462,9 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
 					       GFP_KERNEL);
 		pf->gnss_serial[i] = NULL;
 
+		if (!pf->gnss_tty_port[i])
+			goto err_out;
+
 		tty_port_init(pf->gnss_tty_port[i]);
 		tty_port_link_device(pf->gnss_tty_port[i], tty_driver, i);
 	}
@@ -469,21 +472,23 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
 	err = tty_register_driver(tty_driver);
 	if (err) {
 		dev_err(dev, "Failed to register TTY driver err=%d\n", err);
-
-		for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++) {
-			tty_port_destroy(pf->gnss_tty_port[i]);
-			kfree(pf->gnss_tty_port[i]);
-		}
-		kfree(ttydrv_name);
-		tty_driver_kref_put(pf->ice_gnss_tty_driver);
-
-		return NULL;
+		goto err_out;
 	}
 
 	for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++)
 		dev_info(dev, "%s%d registered\n", ttydrv_name, i);
 
 	return tty_driver;
+
+err_out:
+	while (i--) {
+		tty_port_destroy(pf->gnss_tty_port[i]);
+		kfree(pf->gnss_tty_port[i]);
+	}
+	kfree(ttydrv_name);
+	tty_driver_kref_put(pf->ice_gnss_tty_driver);
+
+	return NULL;
 }
 
 /**
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
