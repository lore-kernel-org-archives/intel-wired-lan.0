Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8A3E9D3FD
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Feb 2026 15:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32F1060D90;
	Wed,  4 Feb 2026 15:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RKDENXI_KWZ9; Wed,  4 Feb 2026 15:15:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F8EA60D62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770218113;
	bh=jZBip/yRzS7ouOSxeneo09lk7rCr3deg8mUb35+XzPg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=176ZyE+Piy9nCHduE7GK6O2fGkR9wH9w6ljVMY+t/DfiDN3vQr9d5g1OI42h5V1Eo
	 d9dgdHhPi06XCLMnzqoCNXLoCbQmu7rpGRdmuk8YKdPQD7bdBvbyb33An5pKfbp05R
	 TQEPtJrfHNM8qt3hSgrein2PN6HCU/6AzhzCA9KKxfTm0jb4dkNuzmrydGdAdZV8xv
	 +/dCpfGVFSGeuu6+9rXiK+4qy18pS+SHDuwHDK2pQQUOunW9PZ86iMX9pAA/71ZAPQ
	 34Xf9+9y2eUWckOwE9sL31+bL+UO3ZigQNFCSVaffe+I4VeekEOHKMoUNfl+UK6Y11
	 LMY5DRgC/w9kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F8EA60D62;
	Wed,  4 Feb 2026 15:15:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E4E2F5
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 15:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 085B840667
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 15:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WzglF_2OBr0K for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Feb 2026 15:15:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ED23640137
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED23640137
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED23640137
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 15:15:10 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E424260010;
 Wed,  4 Feb 2026 15:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BCAC116C6;
 Wed,  4 Feb 2026 15:15:07 +0000 (UTC)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jake Keller <jacob.e.keller@intel.com>,
 IWL <intel-wired-lan@lists.osuosl.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>,
 Sasha Levin <sashal@kernel.org>
Date: Wed,  4 Feb 2026 15:39:31 +0100
Message-ID: <20260204143916.694223188@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=linuxfoundation.org; 
 s=korg; t=1770218108;
 bh=pvxuWXpnmaQeTF/F3vyD2ppba+aIGrlZabTmkTefZxg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y5M5E+oTLdgae27Vd8sN8zv/FYoXofS6zKbCVvVhY5xeD/PVvn0aYe0R2JeoaXJxQ
 4lUtmrNaIDzIzT2tWX8DgEXJt2nYwkROZQsCV9HSKpnAUfSKOs6LaI410wzfhaNSRK
 4Mix7kozWRD7oS+0+r2/h/tnBHiY1jOLQq+jMArE=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=Y5M5E+oT
Subject: [Intel-wired-lan] [PATCH 6.1 197/280] ice: stop counting UDP csum
 mismatch as rx_errors
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

[ Upstream commit 05faf2c0a76581d0a7fdbb8ec46477ba183df95b ]

Since the beginning, the Intel ice driver has counted receive checksum
offload mismatches into the rx_errors member of the rtnl_link_stats64
struct. In ethtool -S these show up as rx_csum_bad.nic.

I believe counting these in rx_errors is fundamentally wrong, as it's
pretty clear from the comments in if_link.h and from every other statistic
the driver is summing into rx_errors, that all of them would cause a
"hardware drop" except for the UDP checksum mismatch, as well as the fact
that all the other causes for rx_errors are L2 reasons, and this L4 UDP
"mismatch" is an outlier.

A last nail in the coffin is that rx_errors is monitored in production and
can indicate a bad NIC/cable/Switch port, but instead some random series of
UDP packets with bad checksums will now trigger this alert. This false
positive makes the alert useless and affects us as well as other companies.

This packet with presumably a bad UDP checksum is *already* passed to the
stack, just not marked as offloaded by the hardware/driver. If it is
dropped by the stack it will show up as UDP_MIB_CSUMERRORS.

And one more thing, none of the other Intel drivers, and at least bnxt_en
and mlx5 both don't appear to count UDP offload mismatches as rx_errors.

Here is a related customer complaint:
https://community.intel.com/t5/Ethernet-Products/ice-rx-errros-is-too-sensitive-to-IP-TCP-attack-packets-Intel/td-p/1662125

Fixes: 4f1fe43c920b ("ice: Add more Rx errors to netdev's rx_error counter")
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jake Keller <jacob.e.keller@intel.com>
Cc: IWL <intel-wired-lan@lists.osuosl.org>
Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9a540b85756f4..2737050aae218 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6546,7 +6546,6 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 				    pf->stats.illegal_bytes +
 				    pf->stats.rx_len_errors +
 				    pf->stats.rx_undersize +
-				    pf->hw_csum_rx_error +
 				    pf->stats.rx_jabber +
 				    pf->stats.rx_fragments +
 				    pf->stats.rx_oversize;
-- 
2.51.0



