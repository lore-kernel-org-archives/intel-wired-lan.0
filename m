Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4366CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7794B6083B;
	Fri,  2 Oct 2026 13:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6S0EaZaGI-Oj; Fri,  2 Oct 2026 13:08:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCBCC606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946529;
	b=U0rDl+30wpbijMX7cmh0/IMrFvCYhuy9eJfWyLV1Z/gCZ1C6m7UO+StAOE+i6x9JKBVc
	 Rnlm8+8GvsS7DW8mkL+gwSpqONOc4N49+ql3WTe5868XiF99ifZuDOImvzBYYKyMLFcL9
	 oyhKaEf0eVaVMY0jfS948Fji4yuBm7BUJi1V3eSf7C8H4KtQYHuugUb7J25mN4N1sn0wB
	 qWC6fBwBVl53RUAM+JpUWiFKl5b9OMld64Dr3NujlkcHxnUwYtUyvHWEj3Ee8Z8p9egZn
	 w3F+UuZ9DayYizhy2Nx9ZDRcW0LvlnFcQpMOI+4+vUNdgYjbMYNT4xbe4H2OTIZGW8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eN97Wzb1hwaGIFrjsjx3HavMNO3OT/k+Ap5QlKepMp4=;
	b=Pys4BYc31aLn5kLJ1WVkGOHDtMTpyt39H/eA4/WqMPwkgcG/Om9Sj7Ge5C3O+c26UIgA
	 BZKOyDYCHK2P3caCGycbVoL8Y5MGGqkbzoxPEjuRHw9FqWDKjbAU8RWp5Ah95SJnAPn8f
	 y2cRl3SEoRmnlheNMoOcGuPi2ZuyM8gCq9H87OIYj5DI72tnCfx4M85d6gGau9k+m8mqQ
	 1KQjSa5G8Z1MCcs53ERnzKLFkxt3oM3pkO/fG4S4CSDVDdKvz7cYQXqJNwN+bnalWWaER
	 lxMd7+K8TtYC8lo/CheUpT5hFqa3HJZToDeyiHgp84Ok6dvzcWGhXqwHrngHi4+ibUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9XBztkL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946529;
	bh=eN97Wzb1hwaGIFrjsjx3HavMNO3OT/k+Ap5QlKepMp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8fYadjHZ3SIALE+pii0KuZNulz2E4lPX/KULgSKvcoWXcMoYB7TMYCuKYWL7J3amt
	 6o3vtRfzxkCUdQgWqzVZZJ18jwu8UT1ds9jI4QaPn6eeM+XudHzekPZ4aReYBZkAU7
	 Ss8wwMcE6PlY7asyo4m7flJUb1eYEeQHSMYtK8ycg/hkC7/nW2bVkHDhDx/NyKLOzE
	 v7gd31FGtL4Cdy7CxD1emuowucfmYvrS7aKvXI8Ap+ID2f1FS4OvDnJZdvcxk56U4j
	 rX5PGFYy/pcQHdkLrKFbXqlhII/yipOUmxESpqMDYIQpEgIVgVdo3umadM3JOKiB0n
	 FncxPjBvRXcCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCBCC606FD;
	Fri,  2 Oct 2026 13:08:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AADD34D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BDED6080A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H6HIZFD7XquY for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:08:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5577D605E9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946527;
 b=bRHEF3B/pWBitMefSu61B0HGVsXc5uhDq6cL0nroWMxXDfPC2E6NkFiEK1tI169+Nqha
 xxu1vGg+SjU70UXivy1gzv/Wt/jlG83h1UsIaMKkHVbHDMMjRdNkDIDKXXF/Sy3rAYFzn
 Ch73PWjtx2Zm26nXp24BRyssd0Eqd2YT8B/0VFZiDbd+GqLTwevQ1sdblEbUDJtXhPbL3
 ICkkp5X4+ovB19OMa3S5hydbSi7NaBEIIeRmfF/p33frY81R31U24C/HlRd6iQibaDmby
 iTi504zLVUWADmZ9J+D4CGyJ4KguIhgVwTAcVbw7xQtQmIc7tGNY3gOkCb5nceClozg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946527;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=eN97Wzb1hwaGIFrjsjx3HavMNO3OT/k+Ap5QlKepMp4=;
 b=IsE0Yv6l6QHaMKTGdsZSqOHHKV+DGULPS2zSgtMzZz3pyKTEUzL5aUF7VQEzsabwXkG8
 2flNrY7PfPK3UDWoI7WB9GGFfsD6ay5abMPpqArAVMWuRLbUulXMhASrmy2TfdDsJQkr1
 YlqHV3kEw4/XkZP2xUs4saJ4FQNdYfYLOXJADxe97p6ZCEP7zH9A1DkyrR/nznuqIOk1d
 UuXS6A09T3k1I0HQlOvZPmiaW/LUHnH8bgXXAYX+IKRZAZk6HSsfezi5B3LVkw2R6mnDM
 sMAWWANd/qzgh1CFzpcwWyT7Bvt2mro8tmMvLH3k+K46lA/Ho8lnFm/D8z+bwGK+DWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=G9XBztkL; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G9XBztkL
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5577D605E9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN97Wzb1hwaGIFrjsjx3HavMNO3OT/k+Ap5QlKepMp4=;
 b=G9XBztkLr1TiYA1qLw5u677KvgpiZbcKJdbPNxvcLtmeTm8tjCgnjXmU490OPYo2mY65n9
 aZDHxJR3A8kvjqIlZ29UHm3gV9cOJyiXseqTtg0cZsDDQGhq7BFRuIRVwDQ/nYAgv9k34Y
 /Jrdhr1Fi4w4CnmkZ5I2jjP7izNgGxg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-zxc_ipEqP0ychNpcLssyoA-1; Fri,
 02 Oct 2026 09:08:41 -0400
X-MC-Unique: zxc_ipEqP0ychNpcLssyoA-1
X-Mimecast-MFC-AGG-ID: zxc_ipEqP0ychNpcLssyoA_1790946517
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC6801954219; Fri,  2 Oct 2026 13:08:37 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC7F2754; Fri,  2 Oct 2026 13:08:31 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 05/10] ice: report VF tx_dropped with tx_errors
 instead of tx_discards
Date: Fri,  2 Oct 2026 15:07:47 +0200
Message-ID: <20261002130752.2597259-6-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: cjaJnEVFljMZN5DZrhGPasYpTlBXDpLV-hcB7j3UmZ4_1790946517
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

ice_get_vf_stats() fills tx_dropped from eth_stats.tx_discards, which
ice_update_eth_stats() never updates because the GLV_TDPC register it
would come from is not implemented in E810 hardware. The Tx drops of a
VF, such as switch drops on an anti spoof violation, malicious driver
drops or TTL expiry, are counted by GLV_TEPC into eth_stats.tx_errors
instead, so the VF always reports zero dropped packets.

With spoof checking on, a VF sending 60 valid frames and 30 frames with
a forged source MAC shows:

  vf 0 ... spoof checking on, link-state auto, trust off
    TX: bytes  packets   dropped
          3600       60        0

Report tx_errors as tx_dropped, the VF stats have no separate error
field. With the change the same test reports 30 dropped packets.

i40e fixed the same issue in commit 50b2af451597 ("i40e: report VF
tx_dropped with tx_errors instead of tx_discards").

Fixes: 730fdea40bef ("ice: implement VF stats NDO")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index b21279f0f5f1e1..8faddf8ba0d523 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1640,7 +1640,7 @@ int ice_get_vf_stats(struct net_device *netdev, int vf_id,
 	vf_stats->broadcast  = stats->rx_broadcast;
 	vf_stats->multicast  = stats->rx_multicast;
 	vf_stats->rx_dropped = stats->rx_discards;
-	vf_stats->tx_dropped = stats->tx_discards;
+	vf_stats->tx_dropped = stats->tx_errors;
 
 out_put_vf:
 	ice_put_vf(vf);
-- 
2.55.0

