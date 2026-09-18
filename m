Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F371C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:32:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 613E960DE3;
	Fri, 18 Sep 2026 13:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLuLVroJ_sU8; Fri, 18 Sep 2026 13:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8CDCA60E27
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738362;
	b=D9OZAKSbWDWC7vFCjfqK5/TfgbnCx++Ypsc7v9/4ui4svzJg8CE2VJ5SGr4dvEdBa9gJ
	 aeIR+gcDY1EXolrxN5YHM0L+3zcloMJZrygmIz0uDOnTd3oc4COzxh0eECQrzNzgzyO1g
	 YrimLdJjjktJ63AoVUI8UdbQbF1LiQ/aSANRUZQ+0CdDzJXa+0ZhJ21pb6bqe8Xyo/cOS
	 l+QkbK5OqWQP42nnz+zPNCZFsOHQmjB1xjvnAEW0gSujN3SaYjp5ZMCyQT3ptdkq9k1wE
	 V4v1MEc3PNU2BhfyOv6TzDMmtnCEPUEPCJTxbWYEnOTEwrlTbULVE4Wj7T/gmGPI2XA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e4varR05R1mpW6aj3L5RsYrD+mVoWr0zhtIcQQ1O/JM=;
	b=NCPrjKyshjG4F494k25wv2Wr4VlWmKnhvvUkjBSpbioWJ9rkh5QuRi4X9534ybt3xd80
	 qUr89JAJQEcyUUup4gNiEuGN662uWrZsIGMzyxIXdFt38Gay1aHcoRdTrUJ6XJSDkT2ky
	 t1Y3C7QKK3rGzRWgDztLDSq1ujH1Hsvbg91A8Gccd9Sf7YRV8Eh0H92I+ZrzSeHBNZAdT
	 v2JoIoj8uTqRa3uJtHUPeA4hNMktDgDErhWYSBnVle2DHVx5xdvW37ZUKPLb4uyGlG9BK
	 d5m6M09Q+PuZP95KRrwVTSgxtF4He7//5WGittamAgi6zJWRYlE3kl6zL+rzA5Bsu4A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738362;
	bh=e4varR05R1mpW6aj3L5RsYrD+mVoWr0zhtIcQQ1O/JM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uhUifmF1jnacHTCh5wJeDbvZmE4sT6RZDtyEUqRwhQhmTmE3EOMlrMs++qr/+6fTs
	 FRBhE0BODbpBzwLkOdagrGAqHyjcQ8ZUJOSK9wo7BKKp6K+UFr5Vl+PB6BvhQ4FEu0
	 iw+R3t4mcaxnGoxUvFAkQrkug+6pmu5Zg/WzssueqBG5luvmlv5ofiw4904R/rPquY
	 u5+2J54mIfQQBVfN9WYob2CIGB7Kua0A4eOz5Y4HufbySui0oQZuuW/07zdD0Wpr/i
	 Yxk1BHjcOSS+0O02DG55bmfwSCzlUopfSSTvpE5tknOLzJTjNA/ZVGra8//sAiOiYM
	 Bu8GwdBXzGEOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CDCA60E27;
	Fri, 18 Sep 2026 13:32:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 92A44279
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84A03400B4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Itqq7bUs6zJX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:32:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D768D40348
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738360;
 b=H14jJltVvEfGHRAH2ZYgnH3em5+07tyHM/KLxNt8a0I8gKT46MKUmWiq5t+JvK0nY/Zw
 w9ZDkfq+c4M89AwJAtC2LJLVlmoj696iVWydiVETAthavljFRTh3zgcZ6Zp+9vfRixMMR
 NkCPGBzf6VE53G1pGS1I0XHhITaqf1AyGRMqb5MEmqoHysxio8kfYsFqFEuPSrOM00ErG
 vWqnaibZ7VqqmToqcCBNPx/GDl7ydslr239C5zEgknjwIevIAwixDGuWYUAcxaq46AfUO
 hkY5K6WWspzwHyziQ2IutC5ZDwwnPddGANgKr4PvQ/O/5v+x/02amo/MTxeCJT6Czzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738360;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=e4varR05R1mpW6aj3L5RsYrD+mVoWr0zhtIcQQ1O/JM=;
 b=pOZBGmVom1Fy7QKXqp2vZkXrxmmlKE2eE0uYm5qHNeEN4rbmJtuSAqWjDVeoqw+R1CeI
 OQubHtwjfyoT5PJpjn2vCheYWwiNgiijwuAW+efxVREL8OXgHcTD37mQwhndimVzLg+B3
 PoltIPqUuxMG+LRhm1I976ZmDQ7PQ6bevEdo2E4JWyW7gr/0fksfO/7qgra9PyXzGWLvA
 gk/9rrjdJoKvAi6Rn9+XNI5VRtuVmsnT8kS7eInaPiWc52VbY0BEluZVbYUieVTAAxzbM
 R281zeRGsr+1YoNULU1qv9WIrW+tnO9xUZOWzwKIqnub/7MfyM7qkxMUPUSNFtUBjDA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=R4QahaTk; 
 arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R4QahaTk
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D768D40348
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738360; x=1821274360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=obzIt/8/SPc/HlGDlPOusLf41Nts5aDL0HrOu18ivq4=;
 b=R4QahaTkQV8dxPwOYrVsWb66Eqk4BS9wXI4VablXgvyLVEbEvN84FqqO
 35wW7106NFU2ax5/7zof8H3PXUnpkFjU/f8Dub3cKEC2zMtUlY36T9mS4
 S7uQyAW8wd51H4xZW0OfQq1P88yLP5nHa0YaYB+9rNu10Pyl10cTRWZMM
 KcIDFsnuZNwPkND5mDXt4cyXTbDYYw8OPTZawwVWdC6CvnBTMV3VNEAwN
 rd6oVX55aRMBgigWuxrXQXHlm2LTQzMd0KLoFIcTEEcqd6587zQIJJrEt
 ET1ilHEALPe/apJ9iugGgG5pPTXyi/kJrWvlwIkYT+wlArBrRp85EgPQn A==;
X-CSE-ConnectionGUID: Ucy8aa3/Q5Sjmnt+6d+faw==
X-CSE-MsgGUID: 8UPVXmHcTnOMAW1ykz0p8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776417"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="115776417"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:32:40 -0700
X-CSE-ConnectionGUID: 8akHuPLWQYC4xmWaesgv0w==
X-CSE-MsgGUID: GAuhM++uRkSURtjY+FmRkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2835249"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa013.fm.intel.com with ESMTP; 18 Sep 2026 06:32:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Konrad Knitter <konrad.knitter@intel.com>,
 Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3 2/3] ice: fix autoneg disable when link partner
 doesn't support AN
Date: Fri, 18 Sep 2026 15:32:33 +0200
Message-ID: <20260918133234.4169074-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
References: <20260918133234.4169074-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Konrad Knitter <konrad.knitter@intel.com>

Disabling autonegotiation was silently ignored when autoneg had not yet
completed (ICE_AQ_AN_COMPLETED was not set), leaving the configuration
unchanged with no error. This could prevent link from forming if the
link partner requires non-autoneg mode.

Extend the condition to also allow disabling autoneg when the link
partner reports no AN ability (ICE_AQ_LP_AN_ABILITY clear). Gate the
ICE_AQ_LP_AN_ABILITY check on the link being up so that stale or
zeroed an_info when link is down does not produce a false positive.
Introduce the helper ice_autoneg_disable_allowed() to make the check
explicit.

Fixes: f1a4a66d2310 ("ice: fix set pause param autoneg check")
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 26 ++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a257b7d..4ce198f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2501,6 +2501,28 @@ ice_ksettings_find_adv_link_speed(const struct ethtool_link_ksettings *ks)
 	return adv_link_speed;
 }
 
+/**
+ * ice_autoneg_disable_allowed - check if autoneg can be disabled
+ * @p: port info
+ *
+ * Check if autonegotiation can be disabled based on link state.
+ * ICE_AQ_LP_AN_ABILITY is only valid when the link is up; gate that
+ * check accordingly to avoid false positives from stale link data.
+ *
+ * Return: true if autoneg has completed, or if the link is up and the
+ *         link partner does not advertise autonegotiation capability.
+ */
+static bool ice_autoneg_disable_allowed(struct ice_port_info *p)
+{
+	u8 an_info = p->phy.link_info.an_info;
+
+	if (an_info & ICE_AQ_AN_COMPLETED)
+		return true;
+	/* ICE_AQ_LP_AN_ABILITY is only valid when link is up */
+	return (p->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
+	       !(an_info & ICE_AQ_LP_AN_ABILITY);
+}
+
 /**
  * ice_setup_autoneg
  * @p: port info
@@ -2539,8 +2561,8 @@ ice_setup_autoneg(struct ice_port_info *p, struct ethtool_link_ksettings *ks,
 			}
 		}
 	} else {
-		/* If autoneg is currently enabled */
-		if (p->phy.link_info.an_info & ICE_AQ_AN_COMPLETED) {
+		/* If autoneg completed or link partner does not support AN */
+		if (ice_autoneg_disable_allowed(p)) {
 			/* If autoneg is supported 10GBASE_T is the only PHY
 			 * that can disable it, so otherwise return error
 			 */
-- 
2.52.0

