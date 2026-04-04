Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B54D73094
	for <intel-wired-lan@archiver.kernel.org>; Sat,  4 Apr 2026 15:19:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9E3B360AB4;
	Sat,  4 Apr 2026 15:19:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ue1VHYUJehQ8; Sat,  4 Apr 2026 15:19:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C9C1160616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775315995;
	bh=rkgGr8EsR9RtM9L2b9YguWFCNMs95qhgtRw9JO4XWqU=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=5t08X/PGVmKFTbI5ZnXlc96RgA5IznchfZdoswD+UkE12oOP9StBmFtTrdpZ0Uwe/
	 dXqzDxEKWGA4LaavNMfM089RMCrRMXRDbnv0zFSSKs40zv4taU8oogu3OVDNVgXH6e
	 1Ztz9YtUeBAwG1rqsGqsGVRgJYimJiA1o//T1zsIhtLeL9pdk/K0w1exlHmoYsoRUW
	 LeQD6H0sufw0lwL1/jaDiRTEfvjovhMugT4UBDiTK7ZYqEM6R/++oDcjCX0I7Bb9VR
	 3rgAkJw5bc+JSmiI8dYki69f9DANI/bjickAt4wZufvorPAAMMDrhoMvUSVwPx0wkH
	 64ju3N1Spmpqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C9C1160616;
	Sat,  4 Apr 2026 15:19:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DE3D891B
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Apr 2026 15:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFFB14043F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  4 Apr 2026 15:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K6g0XJLiwvAN for <intel-wired-lan@lists.osuosl.org>;
 Sat,  4 Apr 2026 15:19:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1383E40426
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1383E40426
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com
 [IPv6:2607:f8b0:4864:20::132c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1383E40426
 for <intel-wired-lan@osuosl.org>; Sat,  4 Apr 2026 15:19:53 +0000 (UTC)
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso3157807eec.0
 for <intel-wired-lan@osuosl.org>; Sat, 04 Apr 2026 08:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775315992; x=1775920792;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rkgGr8EsR9RtM9L2b9YguWFCNMs95qhgtRw9JO4XWqU=;
 b=cLkxf4wzhRwZ7P5o6xYxmnI89Ir6CXqQ9k5gQmmrLJBpEkbQTGhvWyikNqv80NUBJG
 XcvFEbMod5OInPSqtP7NRRqT/74XKBs1yTVDqh3rruuBKKXLxyU+TLfcdGacjAAJtkLq
 YzzwZBUwkdK3Z8AIxcWwZ/B/T4tQM8DG8R9RgHE2Aj2Y2jk83ClFnOIX6g4R8ubKRfE9
 QxAJ2m8TsoIqVG69MwPJW0En6WzPnFdjs35ANn0hPdEywwS2xyapxrBt24F6nEeakn3D
 KZ+UWyi5rwHg1fNqziyxF4h+XHL7TAqDHJCRyZ+ZB99ZowoFzIsG3L/Rer0zJJ+yRHWF
 u6RA==
X-Gm-Message-State: AOJu0YzIy6Z3/bJWI1NLoWRClVoccRm+kEbtm94USaqRO5VREXReHyqj
 InCQ4thwpNYMfv7/IgV6SV0X7nLdI7UOlktkPDepv9TbhViY1QsI5bZcgTB5cw==
X-Gm-Gg: AeBDiet9h32OQpFqfBRED8f8VX9bOuQCJ9i/e2vQtLrcqqNIrFUKP08Xzbc5zq4VHdM
 rvM1U+vaNwzVDprkQac/n/tURfBaAYGWepwaHEq30fXI20ZFIuCHeBrjFNK5k+kZJGPjKofu8zX
 VZwX23xvssZGm+NDqCxomM15d4FHPL2ByQx/YfunkL3oxqL+UIkySOleHeWo4l3T8Qwv0QPYQG/
 XznoY0h76SOdFvFPX+vWWnjBB5IlDxGi6PujAY4rPdb/Tv9wE0u2InW2CCEVWJgmV0NXWqMQP6A
 kwCi5bPUL3CNbpk1t3VfepIaTs15aAKjrd5bikKM86nimtsgkmshLF93Yqsh9M9834TyWylj3ap
 VuLb2/za7D63QCY3rXBzQeXy7tK680aUiQtUSb/51dBg+nVzWRg+9cbcc5mn6ja2EV8tlGWAzFM
 XKxM/+sFeBdaJhNko7FDdaGfuL
X-Received: by 2002:a05:7301:9bcc:b0:2c8:fe46:eeb6 with SMTP id
 5a478bee46e88-2cbfb99005bmr3449573eec.16.1775315991895; 
 Sat, 04 Apr 2026 08:19:51 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:62b::23? ([2600:6c5c:6b00:62b::23])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cc6e17e0bdsm4378419eec.31.2026.04.04.08.19.50
 for <intel-wired-lan@osuosl.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 08:19:51 -0700 (PDT)
Message-ID: <f8ffc8de-4b1b-40fd-8807-ee8687fa984f@gmail.com>
Date: Sat, 4 Apr 2026 11:19:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: intel-wired-lan@osuosl.org
From: Matt Vollrath <tactii@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775315992; x=1775920792; darn=osuosl.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkgGr8EsR9RtM9L2b9YguWFCNMs95qhgtRw9JO4XWqU=;
 b=X3Evx9+J5GNQHd41221dObUCat+LophjGz+1HtMED0+Y8TmKk5jv8YXLO4aCtSOM5y
 Q4qyVO4zWWK3LK/eV/SHhkIZWjEUmw5bKmLx7S5rKVnk52e7dDcagAs+9hgDSXT8vrCs
 nECkQTzoG6cgJK4VXV+5dFDEGJ5/5v1wIeZcLbZFvkWsUgk0tjDVmgMcZcQafLTHQrkO
 T3BYiIxwkGJ2IBnleaLCOsMFIdpjIWbBtaF26BrHkiqEGwzTNH3vIZIa60sPvmhgigNA
 Lkeq/sQs5/vld3auYjvpNALplKKaXjEZPLmPl1HF4IETKGMB1Yiv7BTYMQ+lDfGgaNZR
 0UjA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=X3Evx9+J
Subject: [Intel-wired-lan] [PATCH net] i40e: Cleanup PTP upon probe failure
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

Fix two conditions which would leak PTP registration on probe failure:

1. i40e_setup_pf_switch can encounter an error in
    i40e_setup_pf_filter_control, call i40e_ptp_init, then return
    non-zero, sending i40e_probe to err_vsis.

2. i40e_setup_misc_vector can return non-zero, sending i40e_probe to
    err_vsis.

Found with coccinelle.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 598739220dfb..dacdf5fad2ea 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  	/* Unwind what we've done if something failed in the setup */
  err_vsis:
  	set_bit(__I40E_DOWN, pf->state);
+	i40e_ptp_stop(pf);
  	i40e_clear_interrupt_scheme(pf);
  	kfree(pf->vsi);
  err_switch_setup:
-- 
2.43.0

