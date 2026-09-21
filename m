Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE818C982ED
	for <intel-wired-lan@archiver.kernel.org>; Mon, 21 Sep 2026 19:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 750F5406E8;
	Mon, 21 Sep 2026 19:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9X6DFt3QJNkR; Mon, 21 Sep 2026 19:47:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CED2240602
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790020041;
	b=dzwGPSxcAcAcsJpme1QX+iVqOj6Qu77MNSAa8mziBrzqbZV8Up9MFWNSV9nzws66L4EE
	 HES7fZj41ZNHypCxzUHLYzeyFrwMY/zqu09N6QKWk4OOqtq4CBkTaP0gy0ctbqrf/s2P9
	 8prQq8u9n0HJLotNAL/M5hTyAGaJxrEisHUZhtNisHdX/Yn2RVo5P0Ps4W65BlrD1ILXr
	 E5yYpgSLBH/LpPgUX/WhSg7LgmLu3em6M9O/2Cu7hQtuLhDQmo7ipW+5L5JNDdjaC1Ryn
	 ao1l1VR7BkJqFUQaeSPcDI1XeSaarbMh3YMHcMIY9DN1KHw9najQgDsMmQiIXQ22mJw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790020041;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:Message-ID:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=I6YUplc+23bJbMwh1vcB+IM6B+7n6OCLB5Q/ejoqP6c=;
	b=Tfd/IWr75WmwBzXIqqtgMDcg0twv6zsovtOj2J9O2dr+M3gdRLOBLhFxA9CiDOZ0hVlP
	 8I3HzGOHQYp4yfMBQiD2oszSxe/ABDFKZ1e/iRj//mrJBljlj+Dqg9UYT6qtl1Velm+cc
	 mYBCAooBQD9Nm6lpP/qXLhT79IiBX2Z6ofboGZuSVPNBPYQwdOitaZbsK4gHoAQTJPG1R
	 6cFrRzTTN4CJOH/GMW1vbs4o+GOwUdnpNtRViKMzr0d2RIoKeN6PqrobEXreCwF8ai4Dz
	 qsFQ34zTYVPrlvM1QYAgR/K9eTGJnrFwoSgxriRuirj167eStWtWM6i8LlAripKsVqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790020041;
	bh=I6YUplc+23bJbMwh1vcB+IM6B+7n6OCLB5Q/ejoqP6c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VNNnPP9CIptjWiiTt2+GxFFauSJrVUo9lyzrGXzvJxpdthyCwuptnPHjeHcUFhwxl
	 JpS7jyt83cWIE9PQzqNLwE8aQ1IMUOzdAvtdV5URFpduB8Vxcl6Nn67UBRXGB/iD3t
	 A0DJ58DAxUyL9jUFDDN6ulnJWDXJkkRIGxzsdbGkud2oVYs4Haa1M9xxEKrQTr04Dy
	 SePmJkdsXTyKpw+y3LKKDrhNILTxiaYrNkz+MCRM7narklRUDu35AOW3FVNAcmEKBm
	 4+WbxdN728toOLSD/Y7mUEXrz9aylWMBWmeiZBf1nPJgA0cehvlEeopDiASksR1Lx3
	 fk64zVksCFylA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CED2240602;
	Mon, 21 Sep 2026 19:47:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C3D033A9
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 18:50:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A96C3400D2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 18:50:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ETvEeAcGUzDG for <intel-wired-lan@lists.osuosl.org>;
 Mon, 21 Sep 2026 18:50:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1BB3E4005C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790016615;
 b=ealE/tyiRx4fNNPcP9NkXOQ1NnZ0aW2UtfZFgTe9NNeyZzVuODWLHn8DovMvb9m7+ftq
 OuTM7BKvJswGDk2O3r7/aURVFAwD9zkkSgTB111mZYqGmytai4JIRe0/Bk7QDl0+3YxNu
 0VEawpfdbHwbugbff3TCLyeQC7m0k4JVaVRD5BgiN5/iVo0E4UCDhSSldPixJ51PpehlO
 GzYeTzKDaGOs1C0qPIdjZcmosPVFkEI4xG8IGJKm1s1WwQjYR+mqIHbzjRpoXwmeT9612
 +4DH0TQUAEE8Splv/M6uoGnlc/dDlWxTxmvFio5WEdOAIVmqvfthLl3FtesM8IKVGwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016615;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-ID;
 bh=I6YUplc+23bJbMwh1vcB+IM6B+7n6OCLB5Q/ejoqP6c=;
 b=ABadcOowpReqUYPLtG1h/yaKPPwkBXmUBTf0rzQYLpXUUVi0Gop2WsWvez2WlrwBDJ73
 DA0gZlz1ysDLIq4AU3TN25UtBPJYpG3X5IzYYrQgS3Lby2TjLwAyVNepCGdauGLwg3wkG
 zXvF9I9Lm/oa6YRdJxiXVqRnSzW4fvtu3wzHBYFmvmwt51jvhI1qQyp1XJYmuujfT/Iat
 gAlS5qw2pjEqShcHpzhwkQzP1Me0JwMtPxg6s7TJAbxVezCsNN6jXzN3Na02HHIEW44gc
 OJO7pOEn8V2W95AX8J+fC2s/BV+IWzlHogkM+e/o3VcDSaKoG6bRNNI8xRRb9OD7obw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MCf82R8G; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::e;
 helo=mail-pj2-x0e.google.com; envelope-from=csh0052@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MCf82R8G
Received: from mail-pj2-x0e.google.com (mail-pj2-x0e.google.com
 [IPv6:2607:f8b0:4864:39::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BB3E4005C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 18:50:14 +0000 (UTC)
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-3a02902dce2so1325835a91.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 21 Sep 2026 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790016574; x=1790621374; darn=lists.osuosl.org;
 h=message-id:date:content-transfer-encoding:content-type:mime-version
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I6YUplc+23bJbMwh1vcB+IM6B+7n6OCLB5Q/ejoqP6c=;
 b=MCf82R8GF/gw3VzxqTlFiJFgDR9fpfLjHyta8ChBHxyqzM+XAp1fPmivhfXSM1v8e8
 PZxLbJEIVHJvz48Cx9l+Tki2d1VHcs/pJ0/VVVOkPRqSCTQZwibOld2nFONhuow0TJom
 29q6Ei2GYdCDLyYbiC4PKXbY+n9n5TRlc6ftH+32tvQR8i1tuE2IPB9ShJz3C2B8K6oV
 0ixiP3bgcmtLy7sJarpE0bVNZzDYo9xWoRpyVxT/E/gbpDw6n3W/KYSwQYQ0ER2J4ORY
 1kXulByRDWkiaFLoELxerpAG2Gq0Hsdxr3VPQ/q/QhgOMri5upYMQ1zcgSMwSsxVSpAp
 +Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790016574; x=1790621374;
 h=message-id:date:content-transfer-encoding:content-type:mime-version
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I6YUplc+23bJbMwh1vcB+IM6B+7n6OCLB5Q/ejoqP6c=;
 b=xCPJ5FIYkfUVxHPd6aPwmCA0CVs3qcNmGhxVWZr5379PEgnjt2b9L1HWP761Wsp/oQ
 gVSInclaDBnxU7D6PXqJ8x3aGkBDHtimJgVM7+G32hTABChCULyKfOgeSZbZXkFxAbb0
 doZqdoclWmpso/WaKCGqDXSJ1+9hC/4G2CSYc7cIwsi0Daj/gMpi5Ksq/j9ksvyxny0V
 dQ5cAHO7uu1NOE+EUsHu5bkTf8qnH3DJGuoUcQc+GiWMjE5qtW5QgzRm/LrBNhaUBCFs
 x+62OqPi8px2a+2+oOYdkHpuwPWIwSwucsxCGYMtWM8lyBd8iqNF2zNe4yYm87qEy9kG
 b0Dw==
X-Gm-Message-State: AFuF++lMKc70AC4p3CrkW2HbcN3fXt46Mfxv2bH+gKzZHcmFWGhU/gEQ
 0ge+eHNFq9I3RXlB1Ypphr7KIYtGA3rIzFOCSbM3sd5G49ocKpbkF57g
X-Gm-Gg: AYBFou1bDoSqsC1y4UNnViTTIt2YvV6TLopXm/p+adOpgcWkq+yhTd0ln3SjNUM6LVq
 zdUeJx375PqK2dlvRLVOBTsGUOUaTHz4ANOEFVagO4XJANDPlukDauZ+N9qVHSHdu1eA/4sfjxV
 N8BqTP42VmcC+ieWaf+pXuF7nYQX/mmlEhPPTnf7zB7gBIro0ThauJolyXUavXrp92hCoq3e2we
 SBA+wyF1LuYffqO2LwfwPMr4UbTjApuMRjsX9a3C1vIjkriFVpgN5enhB3dqsmVFJAJJqwNfemW
 UuWp1y6u3T4kQtr/GrVoBi4FEWqGrH5qRRn+jQurjhi4HjvVS3Re8J884w1R+yBZEuQlUsilb/+
 8NarlKpKFdA9zA4BMR2MSjrv2g3oU36ru+oacJgHYfpPgU0pwZAaKu2eZg5RoCUwLbfsvF/XvmL
 lPToVYaAgC2hs5o+T1pBSnxM/4YzWFMtc460BxY2QhxvAiYJXfGk2XpP6y8yU/zhY4Laj79cUXc
 jLUHeESJLbgGaM6QOmk9YA=
X-Received: by 2002:a17:90b:4fcf:b0:39e:6a7e:ee17 with SMTP id
 98e67ed59e1d1-39e6a7eef23mr11586799a91.35.1790016573955; 
 Mon, 21 Sep 2026 11:49:33 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e52d5adc1sm8579800a91.0.2026.09.21.11.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 11:49:31 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH net] ice: initialize the SF number XArray for allocation
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Sep 2026 03:49:28 +0900
Message-ID: <179001656821.91284.11640142428321627272.idr-bug-50@gmail.com>
X-Mailman-Approved-At: Mon, 21 Sep 2026 19:47:20 +0000
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

When a devlink port creation request omits the SF number,
ice_reserve_sf_num() uses xa_alloc() to choose one. However, ice_init_pf()
initializes sf_nums with xa_init(), so the XArray does not track free
entries. __xa_alloc() warns and returns -EINVAL, preventing automatic
SF number allocation.

Initialize sf_nums with XA_FLAGS_ALLOC. This also preserves the explicit
SF number path: xa_insert() with a NULL entry reserves the supplied
number, and xa_alloc() skips that reservation.

Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Found during source review at mainline
5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.

The ice_main.o and devlink/port.o objects compiled with x86 allmodconfig
and W=1. I have not tested SF creation on ICE hardware.

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482..f56c2b748 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3996,7 +3996,7 @@ int ice_init_pf(struct ice_pf *pf)
 		ice_mbx_init_snapshot(&pf->hw);
 
 	xa_init(&pf->dyn_ports);
-	xa_init(&pf->sf_nums);
+	xa_init_flags(&pf->sf_nums, XA_FLAGS_ALLOC);
 
 	pf->avail_txqs = bitmap_zalloc(pf->max_pf_txqs, GFP_KERNEL);
 	pf->avail_rxqs = bitmap_zalloc(pf->max_pf_rxqs, GFP_KERNEL);
