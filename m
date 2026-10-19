Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA49CCF2DA
	for <intel-wired-lan@archiver.kernel.org>; Mon, 19 Oct 2026 06:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03DD4606EC;
	Mon, 19 Oct 2026 06:58:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ACjFdUndKJtk; Mon, 19 Oct 2026 06:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2FEB8605FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792393113;
	b=SL953tCp171LAA4y/as20z6zrQTkCQa06fNJajuNabVZvmJc5BPhe5BjxZnVoYEy30hX
	 XRfJpeyxrkxpOaf6q2LEQJrXhKuscg2rfVU1ht/qDtiFu7eq5i6b1T6sjOI/RYKaTwgtS
	 BwUN+VKnmDwkm5PdUNO7KuUW662finrigWLvl2RNr6g9VrDtee4BNYwlr8/D3Ae3uBlmN
	 TmivFRnxskkPk7b58rEsNq4fnv3p8//wT6fKxsuPGJPkt8YhOrbSCJNL3FI2kNSNRa+54
	 +h+BAE15EwXSf07CjyBkD5jumKlmYR4f8VQ0MoPWU2uZ6lyeHj5If0tHZnCSy70EaVQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792393113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZKK2mK9WchO5j1LrObMA8qjj5chpCR85FD1KEc1M4Jk=;
	b=d2YGVq4welge/BkhlvbVUUCVvqG2c6TePh5JQHc43fByiyL0nv5Nl1z+I6LRW9gMDzTJ
	 ru0jdKmJrnhlAjzWUpUO0oBalHGeXK4WYyEC/wUeGdUl6tTf70nMMRzvSrrkvVo3An+dz
	 kEm2fN8GYNqK9WuJpFC+qP2+3nSURtgODu83CWyLQpOpL5eRgBO70x6DcEkpb+Fom+OR7
	 MCqeIu9+drsMNi2xBDvwnzgekEHFHUOt+z/fA1/r3+qTWrwxpUZIJnUElXm/rkm/qNi7Z
	 Rb2TH2yJy0LrrlhIcbXBBYu98Cd/DMi/v5c56HgvNN25auAYMyXGm4zlaHWOhSwajZQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dx1CqXD+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0ubsLNN;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dx1CqXD+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792393113;
	bh=ZKK2mK9WchO5j1LrObMA8qjj5chpCR85FD1KEc1M4Jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x0n+G/c/ywsN4L9OQMtDolsQE+zAThIsGYeTD+zuSMm7qnZV59QjqAnGGTFpN8X5G
	 OCT7RKLWF3dg4DoZ6lwr71Pwa6iICp04g+gL7GMNzJa5U/yNuO1+D7cU+Ht2ENameu
	 7IKFvxdFK6ll8+zC0hiItVaIcDs/v24n2nwjdmJgfUnTySpC0DImCgPu8m/dttUAer
	 sKtY0m8jSP06L581SrAmhaCEQLIjYk5UsAzw840Bpq+XvZZ3u0Hppjv8PVmvQVEj+5
	 RLJGNegZUdMcHczpOXQDGyV65nr765qFJO3ttwvcHV41gEEbM+oeHQpFLnfbxKuDIU
	 XCU3sJrfjSeHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2FEB8605FD;
	Mon, 19 Oct 2026 06:58:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A838F2A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99A6C605FD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:58:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DvVknKe-2wBF for <intel-wired-lan@lists.osuosl.org>;
 Mon, 19 Oct 2026 06:58:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5812D605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792393112;
 b=lK1RlSByjDka6JAMz6Vf+014d91Uf00rBlfqx9Z3aPFTFu1ICYSY5+6wsY1sWeR/HeSs
 aWhiOa5dVWw92q/q2RaxFy/RNNHfI7Jz6A4qVHw5qq5KLyFzXCZ1ZBN57Ogp572QkHBuY
 aIufAAHPYjHqy2QPD/3dBTHPYaG/3yqtIr4L+iGgycWAj/ZFc/PbUluKGvKETustPT73O
 noJHB9YFHf3SCzG2gdQYbfTfPnwzpeZPMfLKLdJgp+IaBC2PfuROFWZSPNJQ6Z1KeFIP+
 816Hp6kTCeM3sq+R3OO7H0e72O+zhFNYXViHTRLLjrQaaQ9HVnkvzTw3GOc7x2Olpnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792393112;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
 X-Scanned-By:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=ZKK2mK9WchO5j1LrObMA8qjj5chpCR85FD1KEc1M4Jk=;
 b=KlSbBN/ckkPGQ756+E/1+jdpWW8HXH6vc9I2yxL1WRfh7vd/RrBnmf69q1Pjnl9j+anz
 gg9bkOIQcgGpKyqJ0Tbx54tKT1O6tAMmNcwzwHWN3GX8fa+/GBNHt58tcMzdCRHnw6iUj
 68oF8qKGjyXnG0nQtKtKXnUOl+9KzmCMqzTO3k+z6taOuvGorLQItKjxTOoBbrdO8Kkr2
 DKdnNVIMnCgCA1NBfaof0mMvX9vHeusdAPM3aBjOcdg/KL/Tu12nsiAiMXiFzRoRF6dvF
 78UEZWTAWp4EfLTe59Qv4FKHmSn7ML4h5CaqEZWLIFpsAvZSWFZT/HGqkSUT0P98/Fw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dx1CqXD+; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Z0ubsLNN; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=dx1CqXD+; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dx1CqXD+; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0ubsLNN; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dx1CqXD+
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5812D605F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 19 Oct 2026 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792392808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKK2mK9WchO5j1LrObMA8qjj5chpCR85FD1KEc1M4Jk=;
 b=dx1CqXD+mf6WN4YQFkLMwnoYQN6xopFprZGCZpR6XqgExbPqiPD4Hmq27/Dk2kz4Brc3JX
 Q+oIacZ7y8z3yaMNnX3OrM7Er9xoV4bgtgndXMkeWKMqh2wF+YXnonlgJAr1/22iT4Xpdg
 Y6LViauSAWtGQcNp7zZeNj5HACG4ZlU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792393109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKK2mK9WchO5j1LrObMA8qjj5chpCR85FD1KEc1M4Jk=;
 b=Z0ubsLNNaa7CVVYvpjf9b6cqvR4vfjnf5xxN+rafrV9EJDz42mhtLeZZ2Xo2//vKfEMJx1
 UH3siaqg34DJ3GbXCH+8VUuhLsAT2DmcxHSOPS7D4RWWrWGVlBwS3isxZijGxGrEeKkpV0
 Y0tltxF57jgMoz5VApSNKljUhG01eAA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792392808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKK2mK9WchO5j1LrObMA8qjj5chpCR85FD1KEc1M4Jk=;
 b=dx1CqXD+mf6WN4YQFkLMwnoYQN6xopFprZGCZpR6XqgExbPqiPD4Hmq27/Dk2kz4Brc3JX
 Q+oIacZ7y8z3yaMNnX3OrM7Er9xoV4bgtgndXMkeWKMqh2wF+YXnonlgJAr1/22iT4Xpdg
 Y6LViauSAWtGQcNp7zZeNj5HACG4ZlU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-16VY8XV7NuCJI70W4peeCA-1; Mon,
 19 Oct 2026 06:53:24 +0000
X-MC-Unique: 16VY8XV7NuCJI70W4peeCA-1
X-Mimecast-MFC-AGG-ID: 16VY8XV7NuCJI70W4peeCA_1792392801
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D8DB1955F22; Mon, 19 Oct 2026 06:53:21 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.48.130])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4224A1956086; Mon, 19 Oct 2026 06:53:13 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Dave Ertman <david.m.ertman@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Kamil Maziarz <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, linux-rdma@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 linux-rt-devel@lists.linux.dev
Subject: [PATCH iwl-net 1/3] ice: avoid RTNL deadlock when notifying the RDMA
 auxiliary driver
Date: Mon, 19 Oct 2026 08:52:59 +0200
Message-ID: <20261019065301.3983537-2-poros@redhat.com>
In-Reply-To: <20261019065301.3983537-1-poros@redhat.com>
References: <20261019065301.3983537-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: vsMYLT29S_L8xtdPqq0ealOvFdMGdFWWe3QFQRu_14s_1792392801
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

ice_send_event_to_aux() blocks on the auxiliary device lock, and the
dcbnl callers reach it with the RTNL lock held. The RDMA auxiliary probe
takes the two in the opposite order, because __driver_attach() holds the
auxiliary device lock across ib_register_device(), which needs the RTNL
lock:

  systemd-udevd   state:D
    really_probe                  <- holds device_lock(&adev->dev)
    icrdma_probe
    irdma_ib_register_device
    ib_register_device
    setup_device
    irdma_roce_port_immutable
    ib_query_port
    irdma_query_port
    ib_get_eth_speed              <- blocks on rtnl_lock()

  lldpad          state:D
    rtnetlink_rcv_msg             <- holds rtnl_lock()
    dcb_doit
    dcbnl_ieee_set
    ice_dcbnl_setets
    ice_pf_dcb_cfg
    ice_send_event_to_aux         <- blocks on device_lock(&adev->dev)

Everything else that needs the RTNL lock piles up behind lldpad and the
boot never completes. The probe side cannot be changed, so use
device_trylock() and report whether the event reached the driver.

IIDC_RDMA_EVENT_BEFORE_TC_CHANGE has to arrive before the traffic
classes change, so ice_pf_dcb_cfg() refuses the request with -EBUSY
rather than run it behind the RDMA driver's back. The critical error and
MTU change events are sent from the service task, which consumes their
pending bits before sending, so those are re-armed instead.
AFTER_TC_CHANGE keeps its fire and forget behaviour, it can be neither
refused, the hardware has already changed, nor deferred, every lock that
would serialise a deferred delivery against the dcbnl callers forms
another cycle.

Fixes: 348048e724a0 ("ice: Implement iidc operations")
Cc: stable@vger.kernel.org
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  9 ++++++++-
 drivers/net/ethernet/intel/ice/ice_idc.c     | 20 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    | 16 ++++++++++++----
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 0bc6dd37568792..2022b46c990cb2 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -355,8 +355,10 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct iidc_rdma_event *event;
 	int ret = ICE_DCB_NO_HW_CHG;
 	struct ice_vsi *pf_vsi;
+	bool dcb_ena;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
+	dcb_ena = test_bit(ICE_FLAG_DCB_ENA, pf->flags);
 
 	/* FW does not care if change happened */
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
@@ -406,7 +408,12 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	}
 
 	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
-	ice_send_event_to_aux(pf, event);
+	if (!ice_send_event_to_aux(pf, event)) {
+		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
+		kfree(event);
+		ret = -EBUSY;
+		goto free_cfg;
+	}
 	kfree(event);
 
 	/* avoid race conditions by holding the lock while disabling and
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 102d63c3018b1f..7fd35ce966ea65 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -34,30 +34,42 @@ ice_get_auxiliary_drv(struct iidc_rdma_core_dev_info *cdev)
  * ice_send_event_to_aux - send event to RDMA AUX driver
  * @pf: pointer to PF struct
  * @event: event struct
+ *
+ * Return: false when the auxiliary device lock was contended.
  */
-void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event)
+bool ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event)
 {
 	struct iidc_rdma_core_auxiliary_drv *iadrv;
 	struct iidc_rdma_core_dev_info *cdev;
+	bool sent = true;
 
 	if (WARN_ON_ONCE(!in_task()))
-		return;
+		return true;
 
 	cdev = pf->cdev_info;
 	if (!cdev)
-		return;
+		return true;
 
 	mutex_lock(&pf->adev_mutex);
 	if (!cdev->adev)
 		goto finish;
 
-	device_lock(&cdev->adev->dev);
+	if (!device_trylock(&cdev->adev->dev)) {
+		dev_dbg(ice_pf_to_dev(pf),
+			"auxiliary device busy, dropped RDMA event 0x%lx\n",
+			*event->type);
+		sent = false;
+		goto finish;
+	}
+
 	iadrv = ice_get_auxiliary_drv(cdev);
 	if (iadrv && iadrv->event_handler)
 		iadrv->event_handler(cdev, event);
 	device_unlock(&cdev->adev->dev);
 finish:
 	mutex_unlock(&pf->adev_mutex);
+
+	return sent;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_idc_int.h b/drivers/net/ethernet/intel/ice/ice_idc_int.h
index 17dbfcfb6a2aff..e7d249d6140d92 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc_int.h
+++ b/drivers/net/ethernet/intel/ice/ice_idc_int.h
@@ -9,6 +9,6 @@
 
 struct ice_pf;
 
-void ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event);
+bool ice_send_event_to_aux(struct ice_pf *pf, struct iidc_rdma_event *event);
 
 #endif /* !_ICE_IDC_INT_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3aac..edb62606d2aae3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2313,11 +2313,16 @@ static void ice_service_task(struct work_struct *work)
 		struct iidc_rdma_event *event;
 
 		event = kzalloc_obj(*event);
-		if (event) {
+		if (!event) {
+			set_bit(ICE_AUX_ERR_PENDING, pf->state);
+		} else {
 			set_bit(IIDC_RDMA_EVENT_CRIT_ERR, event->type);
 			/* report the entire OICR value to AUX driver */
 			swap(event->reg, pf->oicr_err_reg);
-			ice_send_event_to_aux(pf, event);
+			if (!ice_send_event_to_aux(pf, event)) {
+				pf->oicr_err_reg |= event->reg;
+				set_bit(ICE_AUX_ERR_PENDING, pf->state);
+			}
 			kfree(event);
 		}
 	}
@@ -2336,9 +2341,12 @@ static void ice_service_task(struct work_struct *work)
 		struct iidc_rdma_event *event;
 
 		event = kzalloc_obj(*event);
-		if (event) {
+		if (!event) {
+			set_bit(ICE_FLAG_MTU_CHANGED, pf->flags);
+		} else {
 			set_bit(IIDC_RDMA_EVENT_AFTER_MTU_CHANGE, event->type);
-			ice_send_event_to_aux(pf, event);
+			if (!ice_send_event_to_aux(pf, event))
+				set_bit(ICE_FLAG_MTU_CHANGED, pf->flags);
 			kfree(event);
 		}
 	}
-- 
2.56.0

