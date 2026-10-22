Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4EB606A31E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Oct 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=Fo9bRoxV;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iBENXv+u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14C68811E5;
	Thu, 22 Oct 2026 19:28:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nf5a77FZTR7A; Thu, 22 Oct 2026 19:28:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AF05811EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792697283;
	b=gPEmyBk2VrK45bzd2l9hXOD7/ASd04poFVJ3F7RZNSQI1GO2mb77Cl8d+q6obG02VBVM
	 mroRTyKKYkXNhef1pcQO99RhdAFB5yYCBj2euQpgRvLCDvQpNRUNurK9twUlvPQooSElR
	 LRUyXG8m4H6CdKE1dcheVuysmppw9Efh+bPS3W2sDIIZ6Ez30fiT9+TQyswWsU7oSBwHw
	 indcxz2yVVx+9+nTctjZ/O+mDaVxgAZbLLAH5nhzUMXG90jG9Pn7PAnpWikYiT6xd01qm
	 V0asYqwFrjxkqPMxM2/TYEc6ZHzJZ+QjkR/M1j5JI9GbSMFCRWwdo82f+MElxfamzWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792697283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
	b=UEyIosF60iuv4DI16t/uxTrDofWVu2cknHXtkdNwaKMRxLEJoBOg6Bl6gpHjH0McbRmR
	 G9hOPsyoq29jOpPwzWOExIuU/AEtaPY8tERy+OLlOrb6rU1Saw/YYFGFYTLFP+1qbykHA
	 b8vV5H4Hx8UWOlp1v1jRPB0OEqy17O1ObWPgbB6LVzI6eNl6+ANN1QG4jhiB+CACOAetF
	 3opwkpC94HYF+mrf2u0dvQdXXhcWTcmWqT4sWebnAKU7ZHZC3pfgVznWr1c8SvaZSa2OQ
	 8LoDuutPVhl54RPMUrZ6O7KtJnw2o/t8+ObWRq2RAz8vmcVq98HqoSbkD30L9gCrpKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792697283;
	bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fo9bRoxVkehFTTw/AT+6U+Zc84co7HcO1Joz6QPppa51dpU9F6ALrC+QeL+7ETQKP
	 B/eJovcEKt8RBS24Sm6Xs6vsWDSIi3vLCyAB5HMvDQ2lxdXvakHThSWObnSKholjWd
	 XSoOqppdp8ghx2ORkcs5YIRC+jltbBDopu14/91wpdmUz47W2Ksjq6o/IcjqSZLwBh
	 JGdf2UT5tBGa/c/oOL0d7kQV5kxBtjCJ1O5XPl2k35zn3gX2Y1B5ebOnOt+LQ2/7pU
	 5rzZYTvAib/C8umDPQJJi/AW8FwLJh9Y6skwhkgUhkNQV8kv2rryP7mrfsd1zz7M4i
	 cvG7fAHqxnRwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AF05811EF;
	Thu, 22 Oct 2026 19:28:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DDEC23A7
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 19:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C42D040900
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 19:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id welkbPoMtp3Y for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Oct 2026 19:28:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA0EC408EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f31"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792697281;
 b=AKEZRYByscPZ0QAue03MHJwSPjuyhqzttu/JQj4CAm2JD2M01m0k4OBczqLE3SwWgmD4
 3SANT2PNkBqZO+qvI/vvGae6qJSC3hwOK/ilOWZotAdRoIhXIgRuQDJrEcNbMv/Moj34Q
 Z1DRBRMLtDCkUDqLpTPoUUJJ+H1ox4dKNdqg7jQ7agaADnTmoP7M+ZVbqSIVHH4NPgCKy
 xUFghq5eIOsYrWLsbrfij1SQpfZJIH0r6tH3+0OCa9v6F+M/KI+4imHd4NIK5jnAtOvQ3
 uvpEy+/cEcRE+/UNuzZjQ78kkek3K7JKoiCVfMOTXNrUcS05KZcgFNT5U5Ecohv8nbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792697281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
 b=rnCrk3ADvzmu7oscE885J6uqMk7J/8zTq6VLpgSlQsJ/gARdk9Rw7is/l/YATrV+p7Oa
 pVya3IhhX4HtZepKNWrT4nVMTmg3ZNyhr3pSb5EDPlw4Flf12eBR+M9onpw0iSOd6/5v5
 pwU3lUlbdfQZxR6qFa2yqJD3o3iBok+SyicXoDMzEmeBL00PliLjNzrG/1AzKppemmKQ1
 7S0Dl1IQpinH3pIahvCbs4eXJIR6s2K6uuhPigkLtkZb5jkWcIyhK8mzh46sF4mwomEyV
 wygodmhYFRoVSAA7A5S6dVEG3KZ/c2+V1cWefacwRWSVZS0nkpqB5HwZgF5DJj+rthQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iBENXv+u; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::f31"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f31; helo=mail-qv1-xf31.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iBENXv+u
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA0EC408EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 19:28:00 +0000 (UTC)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-917bab38b14so2488676d6.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792697279; x=1793302079; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
 b=iBENXv+ugYyegWn3WtaacDPO7lN96oNwA1WFC8EDwG53UpMfqhlV393OgojdC6J7k/
 AN/85LKri61kmHsjLNcaE8Wjt5RlFaGyHmBpXSKTAYGm8bP2D3mWSPT4ddCb87bx1uLO
 u7zfhSlf0pyTG61OO2irO1XsPBbznGIA5kvmKriAYUSlpiiS5hkFbBu6TDKIWzxx2st7
 8uWLrZOYC9NfV6Lb2j6AdR5pdiGOrYfIlm1QTdfddhaJNxbVueZfTw7MWS7CKDUtysKE
 CWBxLsFMFV7L09d2N28uBQvixEgiRmqjag8UhBRr3oCMVV6Pjyt8KSfwRG0WBUnpZxNZ
 OFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792697279; x=1793302079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7i5zp/nMBoh4FpTzc2q5LQUaQs09zWC1CfEISFvjXJc=;
 b=qob9vNBpJR91oZ49ye+szeSOGPkmr6Fv/WlTEqZH6cOIAKNEpshimK5KmcgrD5zhVE
 65M1Ga1uru+ZZJeevIA3Krm+cQArMdgOYZvhN8RR+ggC7z8yG8b4IQ3JFOBPj1gLDz7H
 IcjawYnq/NPLILrAVXmjaHG0NXwMRJFIKoFKENmwdOzbeYplFCNpe8l+53FCDfbu9vCa
 0OXHDosAhsd/g6pZmZxJsC3XHT7IPpxwKPt5TolKmUnIDXEnhHRVPZiHA6gsi7yHlyR0
 8WWsJnzJbeG3yBGR+ED3IvmkBSplVrnxwA0faTpWlO6kFhM0QPvsNI5/zDBugpXluR6v
 HTcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBznBeEl1BwnzyCVL3kUPTNjJtOarddtgsE88RRLD01HA0wR+qJM7/k7VXKk3VQQoi/4Rq+cTWjLxtpdmY0rv3Q=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJL2BLV2gtXqorlCiRN1Kug0OHmyZawcTK6lFAYP80XsRYcW4v+
 2nCGZVfKNF8m0EfGDTyYPE9F/c8iBGhm4piyQNXpiycPT9jKTtHGrtWK
X-Gm-Gg: AYBFou3TKN3YNByZ0ooodfF1RBgn8s/B/wg0QEohpEDWl9l8VmZPqZYBLx5D/LgPqlO
 f5glN/k/+jJ/oFCVOcCLscUigMv35eOAIque1HwRepImxYvej/m0gI8ucTv6gVg690WSMJYuMLw
 iX9QhlKUhySIPcEZqbT0rnEggQq31qQjNS1O79JtJAq5o4WF7LazNlhUUtuUxXCCouoE6fGvW+v
 4Z9HmNa6YKuQ0zJsE/ggF4PhUJ3QEsJoSHsVeh9cEhxBxcRfE+mY8GnxaJcKA0PrIpN2NnelPZj
 Ktbmmi5A+S9seei6aosnZtoLKEAe9aHGRylULrEx3qmObby1T84gmizMbQBT5NcWREvtSwrrL2H
 zQfRJsW4WhWH+dqhaGuUTRd7TUEIHejpm1BIUOMCyx9f1XZ6DsTwbrtgFByyCO1VH0/ruYWrkN4
 v0Psw4c7NIKW4SaplZKBFm7QI1TaGcO8BlKxB/+25yWvxOPTjiqYmmj7wozGIHEuyeKGgJBIO+F
 LKIVyjCUB5xxoHy1FIiFTykOQmYbFk7UgcFsPwNkudBOExYgB0BqMbr2UH3OTob93sO2ogOSdve
 C4w=
X-Received: by 2002:a05:6214:509d:b0:919:5a24:d20d with SMTP id
 6a1803df08f44-91c12eb53a6mr104325966d6.11.1792697279221; 
 Thu, 22 Oct 2026 12:27:59 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c396afa91sm370296d6.11.2026.10.22.12.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:27:58 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH iwl-net v1] iavf: reset the VF instead of freeing rings when
 queue disable fails
Date: Thu, 22 Oct 2026 15:27:46 -0400
Message-ID: <20261022192753.69765-2-oss.patchbox@gmail.com>
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

iavf_close() leaves the Tx/Rx rings in place because the hardware can
still DMA into them, and iavf_virtchnl_completion() frees them once the
PF has answered VIRTCHNL_OP_DISABLE_QUEUES. It does so whatever the PF
answered: for a non-zero v_retval the error is only logged and the
DISABLE_QUEUES case runs anyway.

The PF can fail the request while queues are still running. ice and
i40e give up before the Rx queues when a Tx queue cannot be stopped,
and ice also fails when an Rx queue does not stop in time. The rings
and Rx buffers are then freed while the queues still point at them, and
received packets and descriptor write-backs land in freed memory.

Keep the rings when the PF reports an error and request a VF reset
instead. The reset makes the PF stop all queues of the VF, and
iavf_reset_step() frees the rings once it has completed. Until then
iavf_close() may warn that the resources are not yet released, and
iavf_open() returns -EBUSY. During removal no reset is scheduled, but
iavf_remove() resets the VF itself before it frees the rings.

Fixes: e284fc88dfb6 ("i40evf: delay releasing rings")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found by code inspection as part of ongoing, not yet
published research. It has not been reproduced, as that needs a PF
that fails VIRTCHNL_OP_DISABLE_QUEUES.
Compile-tested only (x86_64 defconfig with IAVF, I40E and ICE, W=1).

 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index e6b7e8f82c7c..178bba609677 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -2718,6 +2718,15 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 		adapter->flags &= ~IAVF_FLAG_QUEUES_DISABLED;
 		break;
 	case VIRTCHNL_OP_DISABLE_QUEUES:
+		/* If the PF could not stop the queues, the hardware may still
+		 * access the rings and Rx buffers. Keep them and request a VF
+		 * reset; the reset path releases them after the PF has reset
+		 * the VF.
+		 */
+		if (v_retval) {
+			iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
+			break;
+		}
 		iavf_free_all_tx_resources(adapter);
 		iavf_free_all_rx_resources(adapter);
 		if (adapter->state == __IAVF_DOWN_PENDING) {

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

