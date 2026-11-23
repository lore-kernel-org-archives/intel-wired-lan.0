Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A8A606A31F
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=7JNYZxh7;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YXgU7ela
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A76EE80E6D;
	Mon, 23 Nov 2026 12:26:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i2DLpWC-pfbB; Mon, 23 Nov 2026 12:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 19F0A80E8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795436812;
	b=qTwr8l7QizC+4Y+WoW1/tE4rHI2kmMX5kXZTJf65vXjb3ryzlVhQQQ4jj8QaXtmOYyLa
	 3feEYRaf0N5o26Ytx363NqSM7c4hvienNMFnG/J0phQBUyGdIpAMlCfvLLxMMfhSJzSQ4
	 i/h+uZRhEPaeLyKZpVz9WhtfiV4AlulB59EcUAkJqNIQlFl/UU0FRZYc134NGIY2rhJrY
	 w6pDqPqz+F0pF7m9fOUENd/Rwm2eXd0Xu5ONgAv4wrO0qFDj4qKWSJ7qGpnLLU1AECl5V
	 oQkCmGMyKgcVWckbwt1ItWxa2/Eormt1eAU6WJwP2TdW/F7A9tj6WFRVQ/Lip+GeYyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795436812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xzW4b+onVpOHr4kEMCLzLbP6gjJ9XNbM8glzwO2gbbk=;
	b=nIFNVCCmeAwKRfX8UiDU3CR/kQV/ImI6F6GYurZUEbNOvUpOwHm+talD/tRySSwB+hyF
	 oTLOqh6+CHAf1oOlLqnnkAHSOTGTzCHtWsn+65NiA5ruDUfOAuLnfqMtWEeAMHFcUzpoZ
	 qvRgnzcAwoylatBs1c/Tzkead/bDwRo7QdO0pL9ZiVpDDOzUWBat5YxiBqixjYAx61K8m
	 T/hd4rYA6Vu57aIymns8Uz5FYgKn+FQhMDWLedyTFG6qVjgEKpA3Lu/WMNZzp0mCh8BMf
	 GwTZ9BeeO2aBh4rofFvs+ZWPiNBIToWRyylJw3/Da1joKR6zEEahSD+pG6H/Qp4yFQw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795436812;
	bh=xzW4b+onVpOHr4kEMCLzLbP6gjJ9XNbM8glzwO2gbbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7JNYZxh721z35+sCzsIZj8lXASBO89CXU5tIK5K15mcD4iKY5VvHNAl8ymWAUShn5
	 7bUM4CwfLDMn7uD9+0NrKeYNiuE8P8/QD06F+WKF0wkuVGiz6gNQ+Hi34Jv/J6nAIp
	 LylHofvXNxHece8kWwsweTj0hRV70zye2h8RzoaSc6yH7/rr12j/uVe6N/63LTNGRC
	 fzDzpRw2kOwV5hxMWv879JdwnpA2xNRZ5qZZvjoKhItwGlPCXBsfBTkaLjxcULDQcQ
	 Fgdr/Jt3vtTmesRrZPUsjBxw1KqXtwrLMOvhdwORq+UbI9gedXIjOyH5VnFucDlFDE
	 2D93Mz0JeqqpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19F0A80E8D;
	Mon, 23 Nov 2026 12:26:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FF5B3A8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3162740707
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52lcmt9ef9LT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 12:26:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 52DC540703
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jtornosm@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YXgU7ela
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52DC540703
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795436808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzW4b+onVpOHr4kEMCLzLbP6gjJ9XNbM8glzwO2gbbk=;
 b=YXgU7elaNdFum3nDaKmMRqRARqw/h0/K+yZfodqEJ1a9O/brVqCJxfC/xKrMcyo156Tjrp
 /bD4c9o7AoVA/CzCPuAIhQ5hHnL6ncuxcTjPNrcP6EdcBWWIDi0DA4J0USvDZ3Ow55K5ts
 t2f1CFYptx1pIAtcw6YPfgbsUVlmZYQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-G6PXkg9LMg-5w0r0NagCJA-1; Mon,
 23 Nov 2026 12:26:46 +0000
X-MC-Unique: G6PXkg9LMg-5w0r0NagCJA-1
X-Mimecast-MFC-AGG-ID: G6PXkg9LMg-5w0r0NagCJA_1795436804
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B543C19540C2; Mon, 23 Nov 2026 12:26:44 +0000 (UTC)
Received: from jtornosm-thinkpadp1gen7.rmtes.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D76418011D3; Mon, 23 Nov 2026 12:26:42 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: dima.ruinskiy@intel.com
Cc: acelan.kao@canonical.com, allen.lan@intel.com, anthony.l.nguyen@intel.com,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 Narpat Mali <narpat.mali@dell.com>,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: Re: [PATCH iwl-next v5] igc: Support ACPI-based MAC passthrough
Date: Mon, 23 Nov 2026 13:26:34 +0100
Message-ID: <20261123122634.1117670-1-jtornosm@redhat.com>
In-Reply-To: <20261012194817.10409-1-dima.ruinskiy@intel.com>
References: <20261012194817.10409-1-dima.ruinskiy@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tliKdAb9HWSTvNZA8thQnRcMr6JempzEodzVr8MZ6DA_1795436804
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only two minor comments, neither of which requires a respin:

- commit message: "of the any network controller" -> "of any network
  controller"
- a dev_dbg() on the ACPI parse-failure paths would help debugging
  systems that expose a malformed object; r8152 logs warnings there.

Otherwise this looks good to me. This was also successfully tested by
Narpat Mali, with the dock MAC passthrough enabled.

Tested-by: Narpat Mali <narpat.mali@dell.com>
Reviewed-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

