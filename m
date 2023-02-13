Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14F1C636CC
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Feb 2023 19:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D55781CEF;
	Mon, 13 Feb 2023 19:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D55781CEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1676316341;
	bh=f3mnw4M/OKwDVwZz9Y2DDnYFWMaxbsN3Q6xMIa/Bm/Y=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pICe40PDGGioMvSqFT04Z1njRRKtnhxavFPvLwKlGncUyBM5Mt50Bt/OYzsqHeIHS
	 hqzM0MTTlTdV4rHUgGisGRg8SWr7N+RBDynFig3gue0TbYrqI++bLtc96o94K/rtXJ
	 j+G8Hdijdcb0cTQZaQjU5XyWC/t1af6qdx2ycSQBp0z7uoRnEM+VmbjJ/sEkwkDjrV
	 a0K5KLzBrGqchCHyyha/a0DQ+n5xImiCLAs/41ZsDiISzeR1g2aWJzljDysBhfDAci
	 EtVbhvRobCsXsOhN0mCEsC7OeU16bFNmjPZm5y34ywez5ZR7XU1ajsLSxVAgZSxcGD
	 WJsaLsNNzyTnQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GutGh9wAIWbF; Mon, 13 Feb 2023 19:25:40 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 585BC81D18;
	Mon, 13 Feb 2023 19:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 585BC81D18
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1AF781BF289
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Feb 2023 19:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 012D680DD1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Feb 2023 19:03:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 012D680DD1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1sWNo5hxgxJz for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Feb 2023 19:03:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7BE3E80D4B
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BE3E80D4B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Feb 2023 19:03:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332281401"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; d="scan'208";a="332281401"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2023 11:03:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="670928975"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; d="scan'208";a="670928975"
Received: from paamrpdk12-s2600bpb.aw.intel.com ([10.228.151.145])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2023 11:03:33 -0800
From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 14 Feb 2023 00:18:22 +0530
Message-Id: <20230213184828.39404-3-tirthendu.sarkar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213184828.39404-1-tirthendu.sarkar@intel.com>
References: <20230213184828.39404-1-tirthendu.sarkar@intel.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 13 Feb 2023 19:25:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1676315014; x=1707851014;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9TYGTju5wJ26T7VHIbNLTsOJgKK+6HVcw3Qa/CXWZys=;
 b=Q7QCxfKNzzNH1Er14LF3AJrq28f3lan/IvQ3TypF3AWcq5VEbrUo06D2
 lBbXKiZIbOCIXpWRcPpt/Pu5IRFCBjiSoOYI0kDQ0DRDJnEJJ/8STH6mK
 wdkYKYBKmsSSFsXvt8QyV4u//PeRVu437vu7wIzGWhy5E18t/rX+v+NO8
 cseYNKr3VFlmxANt3RNI9bs6iRqGWQSldzo63cgEzpaUtBhTG700/hMEi
 pTaJcenqLpp2QWdrGNVU9ycWJmfDTAeTYQn0mHZKsH4YG1qfM3wegDzHp
 3s5nS1JxEBxE11DdXIRdshOnIFjYm+o7qL2hoz4Pjv4tgDTkc4SolexFD
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Q7QCxfKN
Subject: [Intel-wired-lan] [PATCH intel-next v2 2/8] i40e: change Rx buffer
 size for legacy-rx to support XDP multi-buffer
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
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, bpf@vger.kernel.org, magnus.karlsson@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Adding support for XDP multi-buffer entails adding information of all
the fragments of the packet in the xdp_buff. This approach implies that
underlying buffer has to provide tailroom for skb_shared_info.

In the legacy-rx mode, driver can only configure upto 2k sized Rx buffers
and with the current configuration of 2k sized Rx buffers there is no way
to do tailroom reservation for skb_shared_info. Hence size of Rx buffers
is now lowered to 1664 (2k - sizeof(skb_shared_info)). Also, driver can
only chain upto 5 Rx buffers and this means max MTU supported for
legacy-rx is now 8320.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 672038801d1d..d7c08f1d486a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2903,7 +2903,7 @@ static void i40e_sync_filters_subtask(struct i40e_pf *pf)
 static u16 i40e_calculate_vsi_rx_buf_len(struct i40e_vsi *vsi)
 {
 	if (!vsi->netdev || (vsi->back->flags & I40E_FLAG_LEGACY_RX))
-		return I40E_RXBUFFER_2048;
+		return I40E_RXBUFFER_1664;
 
 	return PAGE_SIZE < 8192 ? I40E_RXBUFFER_3072 : I40E_RXBUFFER_2048;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 768290dc6f48..1382efb43ffd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -97,6 +97,7 @@ enum i40e_dyn_idx_t {
 /* Supported Rx Buffer Sizes (a multiple of 128) */
 #define I40E_RXBUFFER_256   256
 #define I40E_RXBUFFER_1536  1536  /* 128B aligned standard Ethernet frame */
+#define I40E_RXBUFFER_1664  1664  /* For legacy Rx with tailroom for frags */
 #define I40E_RXBUFFER_2048  2048
 #define I40E_RXBUFFER_3072  3072  /* Used for large frames w/ padding */
 #define I40E_MAX_RXBUFFER   9728  /* largest size for single descriptor */
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
