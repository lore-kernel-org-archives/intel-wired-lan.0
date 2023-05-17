Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A171DC77B7A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 17 May 2023 01:28:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25DB761385;
	Wed, 17 May 2023 01:28:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25DB761385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684286891;
	bh=T1X7W3wZRO1mU3iBhB8clNOMN8W9OZ60IQ2gfnJ/h08=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tTr4+OANA4t18rGR0dEXvhOZROCL+clYkdb0WO3nQl2pblIndbAwNWYEH+ZUQz0wO
	 dsiUcubl/9ZpyUF+hp8/gMXaTGKjjzMYtn5Exh6MXHmcQdEtNutQzXh9fYKzIrXOWB
	 9oAWEF8WJPxsOVXz6W2rjqIQjnzZBg6lerXqqby18MzyqiuC+ZIgTwMEMwUh8dQyjj
	 UQ7z0ew5jEOBX1o5UzwsvsVgw2TPUHxmfgm79/IFuZLX5WfCUojFBL+WzHv7G6DDTs
	 wsTWs3WEi6aTwApA9kY7OzbnWUtfFJAxJsDttJjRrC2VBVgO/X7k6L5/giS2gYA9fG
	 dWvUDiLzooMqQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yxFwItAEtrID; Wed, 17 May 2023 01:28:09 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7450961379;
	Wed, 17 May 2023 01:28:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7450961379
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id CCB381BF2B6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 01:28:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BA3240C12
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 01:28:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BA3240C12
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rwgZp5f7Z_UF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 17 May 2023 01:28:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 459AD403FB
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
 by smtp2.osuosl.org (Postfix) with ESMTP id 459AD403FB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 17 May 2023 01:28:04 +0000 (UTC)
Received: from john-VirtualBox (unknown [111.18.136.15])
 by smtp2 (Coremail) with SMTP id C1UQrACHj19+LWRkaM5rCA--.15260S2;
 Wed, 17 May 2023 09:27:28 +0800 (CST)
Date: Wed, 17 May 2023 09:27:26 +0800
From: Baozhu Ni <nibaozhu@yeah.net>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Outreachy <outreachy@lists.linux.dev>
Message-ID: <20230517012726.GA1785@john-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
X-CM-TRANSID: C1UQrACHj19+LWRkaM5rCA--.15260S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF18GFW8KFWDJFW7JF4xZwb_yoWfWwbE9r
 4Iv3Z7KrZ8GF1Fkr45ArWxZ342kw1qqryvkFyfK3savryDZr4rWryv9r17GFsI9w4fJa4D
 AryaqF1fC3y29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnk-BtUUUUU==
X-Originating-IP: [111.18.136.15]
X-CM-SenderInfo: 5qlet0x2kxq5hhdkh0dhw/1tbiBQByelsVBYuNKgAAsq
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yeah.net; 
 s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
 Content-Type; bh=FMRYP780oGsC/V150FLH6SQ7V5SyK3kirmT0MA+o3jQ=;
 b=nyWd2aKVJRk1LmAs2nu7eLkLXg4knrgjmR1HWQ/2YkWMjk7fgm9Iee+4tMiZNe
 k0a7oAb0iCtEfIgmeWGpgMrs2KCvS/43HGuSetgP0v0LVj/Uht/IXS+cHid2GQ5i
 IgHL7+pyuQrPliYzw5kuNgOCudnxPlA/9xB4KUS6/BJOo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net
 header.a=rsa-sha256 header.s=s110527 header.b=nyWd2aKV
Subject: [Intel-wired-lan] [PATCH v2 net-next] e1000e: Add @adapter
 description to kdoc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Provide a description for the kernel doc of the @adapter
of e1000e_trigger_lsc()

Signed-off-by: Baozhu Ni <nibaozhu@yeah.net>
---
v2:
  - let the subject and description clearer
v1: https://lore.kernel.org/lkml/ZGNl8yHEko7LpCBr@corigine.com/

 drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 6f5c16aebcbf..cadeb5bc5e16 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4198,7 +4198,7 @@ void e1000e_reset(struct e1000_adapter *adapter)
 
 /**
  * e1000e_trigger_lsc - trigger an LSC interrupt
- * @adapter: 
+ * @adapter: board private structure
  *
  * Fire a link status change interrupt to start the watchdog.
  **/
-- 
2.25.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
