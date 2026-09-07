Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F88C79F82
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7954880BF3;
	Tue,  8 Sep 2026 15:14:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GPOyMpObzMYw; Tue,  8 Sep 2026 15:14:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9734880BFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788880442;
	b=UQ8yCofZkqPhxQbQDtWj7YvZigesfoKcZuxw/dpShWBmw4qtTYVhhIuatdlY218Raae+
	 CaIT8HA0VuOAwvjLqsvpRknL2DZ0CooIkCiG6D2QdExxDSXI1ShhKyVV0Wvz8GM9xDHvZ
	 Unum7MFn8qfk1DRYHxr1kcYtDoVkyuAU3C6lSZVhWUeWbQKxKULWITdqXe/u7u9BUecte
	 WTgZsfRhXK8C+Ck3FC+UfORUPZa+uvVQ8b3SjPF6k7tVT8VcEIjU02Fs9bQIyVy0CBkzw
	 6s52YOSxHxtc6msIQBdnllx6xMy6jSuo9+3UI90iWTjm4uQZaUDdcsLmUTXgHN8M0XQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788880442;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2PD03fl7XZ6y143t1i1zJonTPm8hoG59RG3FMhqUEKQ=;
	b=H7z/HSzZ3y210f6lGmofRl9WlkGq2bUF65I7p3T6AhceJwMKhDuwftbbCifKPhl8G5JR
	 jFEjWafGvBq4ePdhOEdz6CMm6x9DK8Td4/hwOrvRQKcoLGauglQyPw4k9o5hIvilbEu4T
	 8zDCePxVlbCudbMPy34M4y+vbAqolB7OS7Rv0Q5iUQIgme5sNsXwwf20IITOXz5eSx5BH
	 6vZRXvsrCM/6EbkxKutBNIq44MqcZd1DZePoSPa0b/nm23ILcjIglacwWdL1nkD6+8e5D
	 JCylTttGRB7IqjlyZhR8KYUblU3wLiyy2s81DYcKzKxRQJiOfXXbn7uEAAlYUldSuoA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788880442;
	bh=2PD03fl7XZ6y143t1i1zJonTPm8hoG59RG3FMhqUEKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l1Z6V0VKsMCFfTRNKBlF5CE+83jbjMhknZzGKuUkvUvRvXHRkEchbPVgX3VL6rq21
	 yxijfvtnYFo6rFYEIi7fQ6xDePbpn78hr3yRLzRXlEGGM/1Bo0AaJHZyr2610b1xuQ
	 UrCw0d59647m37rWtbaNYgErodb7+u2FS9z83Ta2256BpOXFXtSv4Df+IqNNm2bJQG
	 fGL9VU3QOi5MhPm8CgWrv0r+jOpSwMctJwa2dbndOBItspVVxGLx61qoOYBQt6l5i1
	 bNFkbGL5SIQVlAZfA7dnqUO/Uj5/GVUsQ3YvOirSsyIzMXFEdEjMSkIr25i0XAZC2r
	 Uxat3OnVjBpEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9734880BFE;
	Tue,  8 Sep 2026 15:14:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 891FFAEB
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B0D5400F5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WzFNtawpPUVe for <intel-wired-lan@lists.osuosl.org>;
 Mon,  7 Sep 2026 09:55:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A1980400D5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788774910;
 b=qMtVXZ6exaiqWM3WPRBXmz9lPGsPx+9KbnmoQVCsQ/7xygb/WgbzzLXkV+hgWpr7dL15
 f4Y69XoUVZrum0AmAE8xwE8yDavqz0rob77HwR+4LyIgnY0H0XC5QFjJW5Tb19Vmokj9u
 rb+C6vo1bE81FU34t4KwKnBaIAGz9hJMBp2rnWWCdGruuhcgsJqtTqLsmbPvbZIa8BP5f
 U70q/s0SxRbRn4HNuUuIXojiKDBSvwPR7e6qBbxLJ1kYMAh9g+LtxoN2Tmkx9dS39xdI0
 A29EtWFbj3zje9+aLU9X+J+IyBdWw+ZB0ZozXvCnUrkaniXliY4cyF/rLzIDC6lIkYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788774910;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=2PD03fl7XZ6y143t1i1zJonTPm8hoG59RG3FMhqUEKQ=;
 b=jEmgFpS2DQ5JxrjW5WkqStov5X1Sm0Vq84ylj+PF+5OZ1xHCQKf9Epan0EiuFToUpJuS
 P0js57+r9kBgjF/EU41pApJnZBru03di6/upO4ZzfYd+Rga9gVFl1y/liwYEdKswrZ7TT
 S3+6GygoHUOYPQDECoq9Om1wTcfCxldhlLPJGhxS+dSCbtr92LzY2fKuyPNC2Ovmg7lwq
 uRveTnchQNP/ghPRHZoyGmB+KbDT6uB1tkcG7fdeV62RneKlLWeon7H8IklNIiloQQoFq
 Hma54ymmjkkA6NmoN/csYKkYw3nlgmzax8h6fGGTJ126RNwbPKQQMTt62lcRFoSUfHA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eH7r59Nz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=hemanth.selam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eH7r59Nz
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1980400D5
 for <intel-wired-lan@lists.osuosl.org>; Mon,  7 Sep 2026 09:55:10 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-383b4a3755fso3286748a91.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 07 Sep 2026 02:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788774909; x=1789379709; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2PD03fl7XZ6y143t1i1zJonTPm8hoG59RG3FMhqUEKQ=;
 b=eH7r59NzHMEbc3qijOljbFhYeN/m7fm+CQwNBsYSmN63EJwbYNUBsZoid6xvj3O1dJ
 rxE5xJP2JRkb0ntzIPnVS3bAJK1+fLtPhtCtpjxMkHHWLANnW6OC1Lv+2h0wfVWf9zjT
 P/0zKB2MdZ928Y7KjVM0oXI5Z+dRqfcFOId95GYyxWiST2QT4k6VsWE5UaGTwZDQdWt0
 x3wuEepai1ogUaRJfBIibzl23daPYY1Z6VXFrd8Vnqcpj+l33gdU6mMgJwEFboYxKiIC
 fit8h+fv4ezLCAMGMgAqHq1/PSTBqUOov+mKrMX71DkZZy2dSIwVmakmzboMiq5VcvKb
 m81w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774909; x=1789379709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2PD03fl7XZ6y143t1i1zJonTPm8hoG59RG3FMhqUEKQ=;
 b=SargU0QGU6pV2nWmfUVWX/+Svn4uR913mCGTIxkeTtC2wl0+IJJ0eLXEiO0nLJFehQ
 VTnN9qJtLJ3WTAuxpFELcr8iWL8Fk+hZ2tyauHfOMpQQUgsV9eSNFRLbyll9m5j4+fku
 l/IZeIB3qDFPAcxvlObA1bupghe5jeLBZ8ZD3Bp3LZORsfvsgzJUQ+vFBQaiyRKpfLrH
 HzZEcyv95L6aFQ7Bc/MODEP3+5M79nLw18i7dFGBSUTbGDn2dHGnPfzVPr3dk+uw8B+C
 lNAiV5ilwvZZy/hbYzYqt7lIlWLSVtdfvG9WAtvdfE5gG/egQ1Tp+dyVs30L4b/NUxQs
 /zpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEjp0bji/gOiPpK7Fg+qlO+wRPOQlhrarfTI7JxTRMC5LuMicaYbSeQza5rQbG3rcppar03dEhRiUqGBeGohE=@lists.osuosl.org
X-Gm-Message-State: AFuF++nmHFixXpuTfcB7qpmsY3M3EQH26W0pcRl++8f9kWWc0VvQSr2D
 UpOQ4NS4g4xFRg3m1qPdhrg4lzR4nJiHV0GjmE8+VN01hZuEkbSj/l15
X-Gm-Gg: AYBFou3yCZwy7Kp5h518AYgT9kwmeojUuks7EQDjYMqkTHS0FqN/FlksP2AL5FBlmPD
 B/GyMKNw2JRPHvBSYbaHVR14VWSPmlsINeubdHUtkvPbkcXPMKWOvtNxewRDHGPY1nwlL40df3z
 V7esRw/SQhuVKdhEJpni7kRiaCGWiYb30PuANd3Kg29Yqg97VvynHtAwlPgoXxpm5cdoTElzk/0
 OARhXHWV/a5DdubBVUaKuO0Jq/F2SpIC65ed0C7Yb3uQ/2CVtDwY7sn0LOm3Mc4C5f4qeRVGiDv
 sJ4FMG+qz9hnkgiD94vI0Z5FsDIJlDgfAo97dcKkXZ3ALXboR3Gfvl3fO8TmXEazz4h9n9gqZQS
 qhJQU1NgqquCGa8j53vGGCUKB+ir+iqqYzypHuNDB9FmB7kKAZyHJIo0I9XOvj2vhjqmL6/KbEB
 rYgjrwTTY8OiSsFqB7rDvxdz405s8ZMWDta10R89sFUFMu7PFDDCOC9LIvU3kEO10HrKq3lw+cK
 rYwO2MFxYQ4iNo=
X-Received: by 2002:a17:90b:3803:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-39b25eef036mr31016094a91.0.1788774903375; 
 Mon, 07 Sep 2026 02:55:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm34831030c88.2.2026.09.07.02.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 02:55:03 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: [PATCH iwl-next v2 2/4] ice: fix typos in comments
Date: Mon,  7 Sep 2026 15:24:44 +0530
Message-ID: <20260907095446.27290-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 15:13:56 +0000
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

Fix typos in comments, found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt. Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---

Notes:
    v2: designate the patch to iwl-next and use a subject prefix naming the
    component, as maintainer-netdev.rst asks; v1 went out with a bare
    [PATCH] and a "net:" prefix. Rebased onto iwl-next, diff unchanged.
    
    v1: https://lore.kernel.org/all/20260907064528.6602-1-hemanth.selam@gmail.com/

 drivers/net/ethernet/intel/ice/ice.h       | 2 +-
 drivers/net/ethernet/intel/ice/ice_main.c  | 2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c..e5f940d324dc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1105,7 +1105,7 @@ extern const struct xdp_metadata_ops ice_xdp_md_ops;
  * ice_is_dual - Check if given config is multi-NAC
  * @hw: pointer to HW structure
  *
- * Return: true if the device is running in mutli-NAC (Network
+ * Return: true if the device is running in multi-NAC (Network
  * Acceleration Complex) configuration variant, false otherwise
  * (always false for non-E825 devices).
  */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d88835482d3a..fe47ec0ba809 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6202,7 +6202,7 @@ ice_fdb_del(struct ndmsg *ndm, __always_unused struct nlattr *tb[],
  *
  * Features that need fixing:
  *	Cannot simultaneously enable CTAG and STAG stripping and/or insertion.
- *	These are mutually exlusive as the VSI context cannot support multiple
+ *	These are mutually exclusive as the VSI context cannot support multiple
  *	VLAN ethertypes simultaneously for stripping and/or insertion. If this
  *	is not done, then default to clearing the requested STAG offload
  *	settings.
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e04de0215596..9ef1aa66fa2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -924,7 +924,7 @@ static void ice_sriov_remap_vectors(struct ice_pf *pf, u16 restricted_id)
  * is correct etc. Then disable old mapping (MSI-X and queues registers), change
  * MSI-X and queues, rebuild VSI and enable new mapping.
  *
- * If it is possible (driver not binded to VF) try to remap also other VFs to
+ * If it is possible (driver not bound to VF) try to remap also other VFs to
  * linearize irqs register usage.
  */
 int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
