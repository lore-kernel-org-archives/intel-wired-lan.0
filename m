Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B12C4450A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 06:18:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2972C80DC5;
	Wed, 15 Jul 2026 06:18:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdXWQEMpRMfa; Wed, 15 Jul 2026 06:18:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A867080E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784096331;
	bh=GNA34ZVAFe+Zjxs6F20dktajo1LonGeHCUW7GzDGnsw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W7prwYAiwD8YUCaZX7pt6u+jwAJbiFR7+k46DaG1NWYjCtve50rtAACT3aa3YfA88
	 CvbVnUb/wvMas9gsRAfhMW+6sVFtBS8pr/ZP/dZ/I0GhplXpN3LpYg01HiVriVtw5Z
	 v/NiyUfcLDkkQJ3k3HzEgX8EW8gF8RvWSTwClqQ5tj6xvHt22SXa6jSgiJudk4w8O9
	 KpgVnf/Epbl9tb23pQmjOpIvFiMyg90IjbptvW5GIiB9U03EiPUW4dGRLd2AgOjU42
	 lcDoBKBbDiWk2Mq/RbqlmR1qtWw635JESO3F/ULwGRxJFzo6VG9q8+PMVD4Mav8Whd
	 Xeetzitx+uR1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A867080E09;
	Wed, 15 Jul 2026 06:18:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCD7149D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 06:18:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A252F80E09
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 06:18:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uFJymmxuj2LD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 06:18:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.182;
 helo=out-182.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6CA7280DC5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CA7280DC5
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CA7280DC5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 06:18:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Greg Rose <gregory.v.rose@intel.com>,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
Date: Wed, 15 Jul 2026 14:11:30 +0800
Message-ID: <20260715061131.34420-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
References: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784095987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GNA34ZVAFe+Zjxs6F20dktajo1LonGeHCUW7GzDGnsw=;
 b=vJeKyWE34SQhoigJZ0mLJv5fiWh7HpHFQ8s33lvfIDYX+wGgjskEcqf9MP6XM+7EWLVGJ2
 wOBZ5Qn7OPKAyiqfAlfER98FEMYYk28wEqZuVvwXdlvQpgGmv0FzvH7Dxv1FZfGmpsVYyT
 mFucntdU6STRSdwENCfNuh2IIQcm1+0=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=vJeKyWE3
Subject: [Intel-wired-lan] [PATCH iwl-net v1 1/2] iavf: fix ASQ command
 buffer leak on init failure
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
unwind path elides cmd_buf while freeing the other allocations.

The ASQ count is not set until initialization succeeds, so the shutdown
path cannot reclaim the buffer. Free cmd_buf in the common unwind path.

Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
index 6937b7dd44cbb..82a32f8e78c12 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -346,6 +346,7 @@ static enum iavf_status iavf_init_asq(struct iavf_hw *hw)
 	iavf_free_virt_mem(hw, &hw->aq.asq.dma_head);
 
 init_adminq_free_rings:
+	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
 	iavf_free_adminq_asq(hw);
 
 init_adminq_exit:
-- 
2.43.0
