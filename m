Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E55606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=56t7bCIQ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ns9ipHoi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2AC0810BC;
	Wed, 18 Nov 2026 05:16:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_eq3vWiPtFa; Wed, 18 Nov 2026 05:16:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B9758108E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794978979;
	b=LjruPRbKoxZEvOdGeLLUyuY7Ua0YMqx1SVU/QW3960bNJed8O47lC46IFnLNDhZVTbsj
	 MJ5EWS9LOfSK2/xzOKIr/CYZSCnt+BxETQaTa4/lWy7QtjgSjz64URmQGQAOuGKHyic6I
	 IlmGu+mQKi7z5Uwq/enNVUNQxu4UPqtS6PaQbQzX1e6QOZGN/Ix//UsnrxI/gomSjUYxM
	 v8Am0Swk77CrZAAb3dyxmBi7nVo7sVjlDExTi3q6Js2XUObIshafutpZH/8tWI+fPoQWT
	 qBWhEDiePZw0zJZqOSzDRR7bhYXc5bjObhS1IrLFpdjau6wrYDFE8rgaqYowvxwX0Yg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794978979;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Cuyjjq/ADVaIP+GusU/9yT03ulOQTHuNU1ExsSSvRD8=;
	b=L0LgQhyrEKtHw/HRHimN3fP6WNt3Z5UiXQ8T6C5NZmEmWVsuIwcmwyOXNft5d3QHe4Xf
	 yIQ/p7GWff6ou7m3gcnPMIECyGeO7mwmnePS8F//wuU/kxRSnkQYLGGGvkTuHmpvdPHsu
	 yYLu15ITo5/gTRUMW4WRV9t9/smS7rNM2y1+l5hEA/x1/B8TxgRZSW1aqEZrFGA25jyHs
	 tAeuIo0Hdi0cAX35aXUJAv/40SEkjaV+cBB+c59e8v950glLg8Oo72db8P0MtYuc4mN8t
	 yeH0IidGONn0A9nW2+T7uCgoOOTD7HnmjX76G/zIsYIY8t8LHfdtP3uQOKTx4yehmwA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ns9ipHoi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794978979;
	bh=Cuyjjq/ADVaIP+GusU/9yT03ulOQTHuNU1ExsSSvRD8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=56t7bCIQtaeQz4iuvX2eKPuMvLK8y+pt6ZTlFg6aq/QPqEPu25CXwLgfQhuBDLU93
	 cC6UY/H0jhNVXrH0399N1I3txgg/Kiq9erDLefMeKK4tg6LHNiI0FAj9fG073VsBZV
	 CPzu+YN+ZiH4/9sDjbjvGNorVtHEJD8567XS4zlVopvyLu3f0L9Z6aTpubxzq/+2RW
	 XdmAHZhfyE0SSI3z9MZiXCCMgd3JB/m8r+pPsr97m5Oq6LWmfCEeFQEEMUf2oAAnrH
	 aUXQRzYk76kM9PWQ7Jpde0xRAyX8X6XZNZ98XscObqjSkwQ2OZbYwpQp8GPToJyd9f
	 6sWMwR+bLCPpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5B9758108E;
	Wed, 18 Nov 2026 05:16:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E4790A32
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 05:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C92198108C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 05:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p0no3zaLrWqo for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 05:16:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 753E481098
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::82e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82e; helo=mail-qt1-x82e.google.com;
 envelope-from=lcy8047@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=Ns9ipHoi
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 753E481098
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 05:16:16 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-53634b8328eso5574931cf.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Nov 2026 21:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794978975; x=1795583775; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Cuyjjq/ADVaIP+GusU/9yT03ulOQTHuNU1ExsSSvRD8=;
 b=Ns9ipHoi+w2H7d8i+PamhDhLPaCMtWwDIdp2gkHMP9/NU9IUMVMg4Bd3tCSsOxamGr
 ltsCc18ocb1wHYQ7ufewZRJrRs3uPwjIZspQXep8iU0SzqwyWwdKC9c165zBdD8fQNEL
 PIvifb/Xjie8eD4y9KyUA6/gQFdn1euS75nHziENV/4Zs4TWljlbUA1mPRXx6k2FBA3o
 No3GXB9q+KtEQBwe3rFDpL9QURUsAfRSLLhoDSo1vhbARdN55maHg9PoyuoT7WwFfFg5
 +6n6Ac1tULI+gRM/BJYCsmyJq4rMGEoMTRYek2zzG7Eob/cpQrizEr5Qh+flXwhXtLXw
 TgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794978975; x=1795583775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Cuyjjq/ADVaIP+GusU/9yT03ulOQTHuNU1ExsSSvRD8=;
 b=MkC9PKdF0a6PPOiF2WMYzO9IGz+Nfc5Yb07cOYwodYnyKoeVpCf0+YO5cfaKgPNyON
 uwnhe6mxykCgxQLcaBmu27685pLvgzw6qLIRcMYHS/uJ60aSzpR59W+/DrqB7c+/h9Yn
 eHJG3qvCx1Wy0LKR4vbZRhiS4uOdksivzrjc8MJmstWOTpEn9gi8rRKiRzBZSv+y51ud
 j3jtYXCY+MLzIvUz9bG8XLhQk+yFrXr2tuuiExuVPAHd5rH/mFU3KQjniMfvQlAZUR2c
 5w6T9WISQP5zSEIu48k8CNJKEPDbe8AvIOV/4mrL/AyTiPULp1Bi3WjKVpEiytxeEqun
 0VUA==
X-Forwarded-Encrypted: i=1;
 AL+hErEQDd0bSXFdwUjgaGxdlEAJo9DSlwExH223haVYm9ALxzVy03SZ/40OqGW0Bcoy9eXpf+1NODvaY+E1dCSLsnE=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+cRfWBzfgiRZL9S9BgdidBIiqK2uxTuMvFCSv2W3MftTRPBWYf
 9TR/UIFq04+ILU+r2XZETtVJbvIFibeu5cbgA6/fyDm5ulCr8c6iWrDE
X-Gm-Gg: AYBFou1c+S095WSliYYcGnlEbqNHpEihN8Iqomw83JkjtpspVN5y6NghkAb5A1lmmTr
 tFt9hrjAMep21cFuy6CRzRlP9j8DKc0/uDuALEvT938/cL1ckSTg4X9YO+SEFLOQ09uoDZkC7Pl
 s3xg/0nkWOAlI/HMUf5zpw2Mqvr4IRrgNY6/eHhgtlrkfPFOd/nWMlNDfL3quoH4iFWrbXPyHGW
 aDHyWtFgh6UGq0qoNgcgPlanJvpnibGTLbuemBKRHQ3yIOcBTwQFESOB4whMQe3URfnktdm2XbL
 vLtq9iJKRWvQPOo2X4bk84PQkmkFuEvg2+79PUMFRQbInzuprDLzrW6HT2D+VIuafb3cfjMWQ8B
 x3ftf9f1q+yLKTxdnq02m3EiioN+XoHL2LgcrsqYwc5S47IeXSaYN2PIrWW1uPgIP7HWYnakQDc
 rePANs6KUYzaX5z7djZswF1bFD+wHQW41zWbrsCIJE1B6ZN3Z4ufPb0FEjaJlpxfbTzrUPc0D6I
 uXhHg4bAH89kKV0lAif1f9XsDgw+SpnYrhEVY4VnWaieKGc5WRlujg44DH0wLsYEJaUfGsGmOsH
 Eu7xtn4f5Ps/41UE7Y1b4Z+A6yYiaWOllxi37ODSCDI6609GEL5Uu6eaJupRM1j5IAwEqhFNnJr
 7
X-Received: by 2002:a05:622a:307:b0:536:64fd:7b5c with SMTP id
 d75a77b69052e-55d5a785e9amr25107371cf.58.1794978974791; 
 Tue, 17 Nov 2026 21:16:14 -0800 (PST)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921149f4f5dsm12799576d6.2.2026.11.17.21.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 21:16:14 -0800 (PST)
From: Changyul Lee <lcy8047@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Joshua Hay <joshua.a.hay@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH iwl-net] idpf: free the RDMA auxiliary device ID after
 deleting the device
Date: Wed, 18 Nov 2026 00:16:11 -0500
Message-ID: <20261118051611.3892489-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

idpf_unplug_aux_dev() returns the ID to idpf_idc_ida before
auxiliary_device_delete() removes the device. If another idpf device
plugs an RDMA auxiliary device in between, it can get the same ID, and
its auxiliary_device_add() fails with -EEXIST because the old
"idpf.<vendor>.rdma.core.<id>" or "idpf.<vendor>.rdma.vdev.<id>" device
is still registered. RDMA is then not set up on that device.

Free the ID after auxiliary_device_delete(). It still has to be freed
before auxiliary_device_uninit(), whose release callback frees adev.

Fixes: 65637c3a1811 ("idpf: fix UAF in RDMA core aux dev deinitialization")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
Found with a static analysis tool we are developing.

Compile-tested only, with x86_64_defconfig plus IDPF and W=1.

 drivers/net/ethernet/intel/idpf/idpf_idc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index b6cd1c25ae5d..9d3c55854477 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -253,9 +253,8 @@ static void idpf_unplug_aux_dev(struct auxiliary_device *adev)
 	if (!adev)
 		return;
 
-	ida_free(&idpf_idc_ida, adev->id);
-
 	auxiliary_device_delete(adev);
+	ida_free(&idpf_idc_ida, adev->id);
 	auxiliary_device_uninit(adev);
 }
 

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.43.0

