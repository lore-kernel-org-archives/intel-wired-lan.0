Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C85C83F2A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Jul 2025 15:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4192260BAC;
	Mon, 14 Jul 2025 15:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r2PkQur7-w-L; Mon, 14 Jul 2025 15:10:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFC4860E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1752505814;
	bh=3bhrYXWJvKjSvf77mbHNuVoet9w9SexuVEXBSFz8Pbs=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=emY/97I1UZxUNYefOEIHJ33LVPAr1Il7yOBDIqr8SeQmG6Vtb+zhU6ztUsVywENzY
	 7t/mGcZVyi7hKVwnvi/Ye991KYjrLYLWZuh2zIVm6caEAWChoN4B6yQeIMW1+tjus5
	 5elLDAJorP2wxcakWKnDQXAZQEaB/lpLJe/mo7K6afU503b9hLp83TAWc8aY31OIAT
	 DQcva0Z+M0Rcpo+xLc37vJkVGDWmIVbkjys4mrUajnYk6EAM+hKiMwhq/W6mTv6cZX
	 bqTfKC8AuvqgEVsBchwsuQQhKItx4mq8/FMKjVzcmEVz5w+GYfnsYwdhfHgGy67LHB
	 cDsTeUWYezRlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BFC4860E09;
	Mon, 14 Jul 2025 15:10:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01ACD5E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Jul 2025 12:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FC2E40492
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Jul 2025 12:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDkvgcORncuB for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Jul 2025 12:16:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=166.125.252.92;
 helo=invmail4.hynix.com; envelope-from=byungchul@sk.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 87FA340472
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87FA340472
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
 by smtp2.osuosl.org (Postfix) with ESMTP id 87FA340472
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Jul 2025 12:16:19 +0000 (UTC)
X-AuditID: a67dfc5b-681ff7000002311f-b3-6874f17a8079
From: Byungchul Park <byungchul@sk.com>
To: willy@infradead.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 almasrymina@google.com, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 akpm@linux-foundation.org, andrew+netdev@lunn.ch, asml.silence@gmail.com,
 toke@redhat.com, david@redhat.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com, wei.fang@nxp.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, bbhushan2@marvell.com, tariqt@nvidia.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, danishanwar@ti.com, rogerq@kernel.org,
 nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, aleksander.lobakin@intel.com,
 horms@kernel.org, m-malladi@ti.com, krzysztof.kozlowski@linaro.org,
 matthias.schiffer@ew.tq-group.com, robh@kernel.org, imx@lists.linux.dev,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Mon, 14 Jul 2025 21:00:46 +0900
Message-Id: <20250714120047.35901-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250714120047.35901-1-byungchul@sk.com>
References: <20250714120047.35901-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe5z39q1ybWaeSfZNFWzxKgbKttZYoz66YmLidFvGtFm3HDr
 ALUggss2hqihUTC+ZK0WBaFYXhRsBSq2yFqmTNEVBFKkgEImoEVFtKFUYa3Eb7+c88v5n5Mc
 Hmt6mIW8Pi1DMqTpUrSsklaOqS6vPDyeIX87XrsaLDXVLLRPlDBQNZkFV544GeioEOGWb5IC
 S2U9grfhXg7s+QEMEy13WSgtCWEI156kwfJvHg3vaqYw/HdnkINWzwcaquxbYKD8GQ2u4w0Y
 vO+WwWBhKwsn8yIYzP1HWZh5HGHAHX7JQa7TRoH7RR0HvvoCBs5OWTE05DyJZg11M/Co0cLC
 oyPtCPqrZxh45okGBm0BDgqqziPw3K5gITdvDQTr3nLw+lwLhoGCDTBtyoQ7xZ9D6H4QQa+1
 i4IZl5ODh/3XGGipaaCg82kYQ+hEEQvGsUIEXeZGCtqKahkou99JRffYDt0z7yk401HMwlDe
 AIIO7yANF/4oQFDT5Gdg3BU9OTJpYTdsIt7gK0ycfWWI3KjoocjIqWmK+JvuUeTm+T6OFNsP
 EodtOSl1jVLE6O/AxF6ZzxL7m9McCXS7WNJqitDEUfY7GXGY0dYvdyjXJUkp+kzJ8M36PUrZ
 9ToX7/cqsiKhK0wOMvNGpOBFYa344rSV/sSem2fYGLPC16LfH8Yxni/EixODd6OOksfCA5Xo
 dpioWGOesFesa3R/lGhhmVgabGdirBa+E0dLCpnZoYvEqtrmj44iWr9U9BTFWCMkiE3GMjzr
 XFKI+aNLZvkL8S+bnz6F1MVoTiXS6NMyU3X6lLWr5Ow0fdaqn/al2lH04cp/fb/Tid74tnuQ
 wCOtSg3PM2QNo8tMz071IJHH2vnq530GWaNO0mUflgz7dhsOpkjpHhTH09oF6tWhQ0kaIVmX
 If0sSfslw6cuxSsW5qAs0tZonPrtYo/slg8ds9XPtauazduSd6nijyU6N7YtDlQnWB6YA9uU
 S1ZKpun6IdmYuGK8+eLtIe9SX/vm0iNq5cPyvdbPevv/Gd5auXGz78Dfw9dPKEa++iVu04Xh
 hM62RVd3LaWnuR9h+IPjWpFpMs5qyR5L1i74/s8fbHMTb3Vp6XRZF78cG9J1/wP0SuBYbAMA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5//ubkaHabUyahoFIGQXc0XijCEOgRFEFH4xVYd2kxnbFPU
 kMxW4UqtLFCbpGh5i5SzdNOmxSZldnOassp57WK2ytKsNdO2om+/930e3uf58LJYYaXCWY3W
 IOq0qkQlLSNluzefXp3x1aBe65GWgLnuFg2uiTIKan+mQeWgjYKuah7udv4kwFzTiGDS95oB
 KacPw0TbQxrKy6Yw+OpzSTA/N5Lwve4XhrcPhhlod/wmoVbaBQM335FgP2fF4Py+Eobz22nI
 NfoxFPWfoWH2lZ+CFt9nBrJtVQQ4Sx4Fxo8NDHQ25lFw5dcNDNaswUDgSC8F3c1mGrpPuxD0
 35ql4J0jkOqt6mMgr7YYgeNeNQ3Zxg3gbZhkYPxqG4aBvBiYKUyFB6ULYOqxF8HrGz0EzNpt
 DDzrv01BW52VgBdDPgxTF0poMH3KR9BT1EzAk5J6CioevyACPfZC7+w0AQVdpTSMGAcQdDmH
 Sbh2Kg9BXaubgq92IxkTKzi9X7Bg81Qg4U71S0IYvThDCO7WDkJoKvYwQqmUIliqIoRy+wdC
 MLm7sCDV5NCC9O0yI/T12mmhvdBPCpaKk8KopQjtWRon23JETNSkiro1Ww/K1PbxbHzcGZLm
 n6qkslARa0IhLM9t5B1NBXSQaW4V73b7cJDDuHX8xPBD0oRkLOaezuNbLIVEUAjlEviG5pa/
 JpJbyZd7XVSQ5dwm/kNZPvXv6DK+tv7+X09IYH+9ZAgFWcFF8a2mCnwRyUrRnBoUptGmJqk0
 iVGR+mPqdK0mLfJwcpKEAu90M3P6kg1Ndu9wII5FynlyGDOoFZQqVZ+e5EA8i5Vh8jGPTq2Q
 H1GlZ4i65HhdSqKod6DFLKlcKN+5Xzyo4I6qDOIxUTwu6v6rBBsSnoXk2TVN3M74cpfnUM54
 9I+JKHfo/KvX4iVnbO6Q8/fSvft6kndoV1eyi7SK0PMprLM+rm/Q0u46F6uPjDew62O3vZFm
 Vux/3zF3eUeO6r2nMXxfwljm/QsxKH08OuLwlmXSgczGJZffkttHL0UbzScaEkw/itcUjJ61
 xkWNdE77M5SkXq1aF4F1etUfkfJRL0oDAAA=
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 14 Jul 2025 15:10:09 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=sk.com
Subject: [Intel-wired-lan] [PATCH net-next v10 11/12] net: ti: icssg-prueth:
 access ->pp through netmem_desc instead of page
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

To eliminate the use of struct page in page pool, the page pool users
should use netmem descriptor and APIs instead.

Make icssg-prueth access ->pp through netmem_desc instead of page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index ff5f41bf499e..5e225310c9de 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -367,7 +367,7 @@ static irqreturn_t prueth_rx_mgm_ts_thread_sr1(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	prueth_tx_ts_sr1(emac, (void *)page_address(page));
-	page_pool_recycle_direct(page->pp, page);
+	page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp, page);
 
 	return IRQ_HANDLED;
 }
@@ -392,7 +392,7 @@ static irqreturn_t prueth_rx_mgm_rsp_thread(int irq, void *dev_id)
 		complete(&emac->cmd_complete);
 	}
 
-	page_pool_recycle_direct(page->pp, page);
+	page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp, page);
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

