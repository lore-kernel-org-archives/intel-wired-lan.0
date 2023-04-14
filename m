Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B053BC77B72
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Apr 2023 15:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E4858441F;
	Fri, 14 Apr 2023 15:33:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E4858441F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1681486393;
	bh=0NytEX9HI9UKnf15q5XCYJv04fz4rz6IBkWwSjxNHwk=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=9S8AefXHX4Xm5M1DZ4w8kvj3WRpdkjuaOLtYkhlCOhNan78wLMj8RCS27lJujlrrL
	 MrW156qNJp6Sl2xyZbYav9SlOG+YC7Gg87mfsiziPVt2LdPCdgP2miM8v13zmvIBH6
	 7QnZ1y6vsoyL0xviIi/LecI7bzJv0UUnizgjTX/1LrYmfJuljZhLkTs7n6xKIXC17H
	 AVbmJAXs+s3kINVnPBJ12WazByxMG9sMFfdJ+p86VmPe1HsDJ0oYcHPasVKi48It45
	 ZwspbxX8M/gPNvTc6v+IEfT2kV7JR1mBqqJANzEAWYYo28m9/8pOTGpBbPl3ti+hbI
	 AmrZin6JSt87A==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32hztZfL8FqP; Fri, 14 Apr 2023 15:33:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D43E84129;
	Fri, 14 Apr 2023 15:33:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D43E84129
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 2A4741BF371
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Apr 2023 02:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC76240128
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Apr 2023 02:09:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC76240128
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 53jz7PiwaFPq for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Apr 2023 02:09:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B930D4010C
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B930D4010C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Apr 2023 02:09:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="333124448"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; d="scan'208";a="333124448"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2023 19:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="779019528"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; d="scan'208";a="779019528"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
 by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2023 19:09:51 -0700
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Vedang Patel <vedang.patel@intel.com>,
 Jithu Joseph <jithu.joseph@intel.com>,
 Andre Guedes <andre.guedes@intel.com>,
 Jesper Dangaard Brouer <brouer@redhat.com>,
 Stanislav Fomichev <sdf@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 14 Apr 2023 10:09:15 +0800
Message-Id: <20230414020915.1869456-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 14 Apr 2023 15:32:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1681438198; x=1712974198;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=V6yxTKpwndzirxcebJgSFtOtxmxSXQn9YpBYMRBfZ4M=;
 b=I+ZIsV17laMjhQ5ZdZlfwphblWI64EBtoAbjtx1L6F4ZMovz2wQyvulO
 agNRy6q21DtEMB+IY8TrzD60uhj35nB8pXTJLTeCzaJ9WT0MMVyre33cl
 hlHiSQomxieaDnrAY0mWo4K8C5rozaJIJVB0xiNUqvEhSa4maiAcwOyDO
 WjAKADlNM37IdAlX10FdVTw13I591cXHGioyHgAx2CKCFwdw0MBjHvd39
 9/LMhczdVvW0JNde2OHHYPaZf1No23Ml43PLueK5UxOhMis/gkTubkR9z
 q9xxjw2dYhq+2sE35gWeS2jXz1tEgaUpmxsNVdn9irBZ0JfX6Phs9oT54
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I+ZIsV17
Subject: [Intel-wired-lan] [PATCH net v2 1/1] igc: read before write to
 SRRCTL register
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
Cc: xdp-hints@xdp-project.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 Song Yoong Siang <yoong.siang.song@intel.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

igc_configure_rx_ring() function will be called as part of XDP program
setup. If Rx hardware timestamp is enabled prio to XDP program setup,
this timestamp enablement will be overwritten when buffer size is
written into SRRCTL register.

Thus, this commit read the register value before write to SRRCTL
register. This commit is tested by using xdp_hw_metadata bpf selftest
tool. The tool enables Rx hardware timestamp and then attach XDP program
to igc driver. It will display hardware timestamp of UDP packet with
port number 9092. Below are detail of test steps and results.

Command on DUT:
  sudo ./xdp_hw_metadata <interface name>

Command on Link Partner:
  echo -n skb | nc -u -q1 <destination IPv4 addr> 9092

Result before this patch:
  skb hwtstamp is not found!

Result after this patch:
  found skb hwtstamp = 1677800973.642836757

Optionally, read PHC to confirm the values obtained are almost the same:
Command:
  sudo ./testptp -d /dev/ptp0 -g
Result:
  clock time: 1677800973.913598978 or Fri Mar  3 07:49:33 2023

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Cc: <stable@vger.kernel.org> # 5.14+
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
v2 changelog:
 - Fix indention
---
 drivers/net/ethernet/intel/igc/igc_base.h | 7 +++++--
 drivers/net/ethernet/intel/igc/igc_main.c | 5 ++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 7a992befca24..b95007d51d13 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -87,8 +87,11 @@ union igc_adv_rx_desc {
 #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
 
 /* SRRCTL bit definitions */
-#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
-#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
+#define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
+#define IGC_SRRCTL_BSIZEPKT_SHIFT	10 /* Shift _right_ */
+#define IGC_SRRCTL_BSIZEHDRSIZE_MASK	GENMASK(13, 8)
+#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT	2  /* Shift _left_ */
+#define IGC_SRRCTL_DESCTYPE_MASK	GENMASK(27, 25)
 #define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
 
 #endif /* _IGC_BASE_H */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 25fc6c65209b..88fac08d8a14 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -641,7 +641,10 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 	else
 		buf_size = IGC_RXBUFFER_2048;
 
-	srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
+	srrctl = rd32(IGC_SRRCTL(reg_idx));
+	srrctl &= ~(IGC_SRRCTL_BSIZEPKT_MASK | IGC_SRRCTL_BSIZEHDRSIZE_MASK |
+		    IGC_SRRCTL_DESCTYPE_MASK);
+	srrctl |= IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
 	srrctl |= buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT;
 	srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
 
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
