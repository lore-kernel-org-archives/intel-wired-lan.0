Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E61606A31C
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AgcTRPgW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JwO9YrLQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55122606E1;
	Tue, 10 Nov 2026 10:04:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NNw_5jcZ6lgC; Tue, 10 Nov 2026 10:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AA3FF60760
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794305090;
	b=KRWu/MDjnG2j/Pgl83CDTGk/fU+urpx85DzASlH6649PPt4/WJKxsucMaxQ/rtRkrF5J
	 /udinfCxL6DicOUWVCj+85UAZM3dJieoMRBCF2kLdGNW1lD5uBM0/3tsG6n0awyBQUbEy
	 vc0l7Br94mUQ+RORh/P59wIdqptCSdsjR7XwAmSjbSuLJaPFpUNXa6KF7LqufCXvQ4qEN
	 D8UguEv68VaHEGD2WC2XhIKkT8D+MwXvXSLY/3TwCDcR2CV7VBE0Xr9jr2PfZPgeA/1VL
	 7XTkyF1IEHREsHkPTyD32aboJNKx7MEVMh8BEB7WmAgF96ckAIbjFjMtXYUkNDuXe+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794305090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
	b=B3jcB36m5Lb7N6SxbS5518fnBulYNZb4t+I3Y23B/pzkmb3pNG6rwFmdALEmOcna/EnT
	 qZ6Cft3sFlhn9XTsHrEKThKBnQs79fIq8xBP0FsOTb07ZjYOnnm0Ycqp0PIO/px8eH8yI
	 O3trAZ7ef/qj4YiYnaTdgzpXrScuVic02paDtdOJqImX6siTmWXPSSgKy+2jN7vDZUPCf
	 hdjvYihoZwVmEFJ2DrNU7TaNgR48MkNKWIMdGu1/H0+vUCDVtaGoTaRCwwgSuZKw4JIiE
	 TwrLDfx90vdPeOJYGU0325ZDv9FhfXQOkp8JM5Op45MtihwGuIlhrrV8P7CMK5svexg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JwO9YrLQ;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794305090;
	bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AgcTRPgWajVxBOBK7CKPtylt2M46ICHsz+xtBm+UeD8tIJ8HzuSwXqYl1v31QJz7Y
	 nAHhUZkOgGzvO0/Td/9oUQ/VcwcWEfMQ0rNHx9X3jeIOzgr7TFwlCtbVFg4NIasqlY
	 eVc7hub1MhMP+WizS8XLhQv29J/cMLqv1UGbABq3zM6wrDlT7v0NHYo8ln/sxkkS4W
	 3sLL/HOGgNB/UuVRV3Fqm9YTHRIFqjx9ByjDDGWT1Tvpvjgymi95nxKCCcPCP0I0lM
	 8SABpzMVT9QmFzsZ7qBMqDbeRM6AEmbHtbFPp37+XSJEDHrlQsUZ7yF/6c2EorLiUl
	 ZhHzxVyOLHefw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA3FF60760;
	Tue, 10 Nov 2026 10:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CA0FD7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 10:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E1F060760
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 10:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wq0hxZ54OLiA for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 10:04:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 54157606E1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::c30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c30; helo=mail-oo1-xc30.google.com;
 envelope-from=danividanivi@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=JwO9YrLQ
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 54157606E1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 10:04:47 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-716c0217635so1555050eaf.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 02:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794305087; x=1794909887; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
 b=JwO9YrLQsqGHxlHvIYlU+O8QJQ/CDPDh80wP2QtWjF7V4KFfP/1Oi7NR2vUXG+V2Pj
 dDRECQyO3+CaS4VYbNz2LwtZGNQD3pGASKc1Dp4p25hPydandGGrP7Iq7o4vCuHnSnq1
 t6rLGzGdjqVjigWGQ4a+yrpYnJu3n236is+3JFlItHeypHqyekvX8mIhwQHbpM5/kngJ
 hIhfOuh2o1FSOLbTqYOhUS/YAUwHCMWg7fT9gcvqGeqThvX3Tsa78GruBUgTFb7fUH2z
 328Ko5KXkWZ6lFUKLt1/LLpRY7mL42C//KIGNAYDS8s4+kEYLIzDvlkt47GW5uNmTb50
 nE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794305087; x=1794909887;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c8SH9EDnCkmjUHGPR0P2Z3gz/VtKXf2f2iywxNQfoIM=;
 b=YEsmZv6h5nqWq79r6G66fi75FnoAZqgyx5jDw9+ExS1oTVFMx9+ZfIjxnPtofv05Ue
 zsVghva4u733c4RyFEpycJX0nppUpfjyb3ApLlh8vqW6FNEfkn6/u7UjChU3dh951hwE
 /brKbjcIUeavfKX6jQY52xCC1rR9kF8dFZ1HfEzlEKrSxfS8zhyz0DLBzRMZFgxfv1oc
 jwGwtM/fklfavbIHpC2R09YLoVaRvl84sIBvw2Qpw73nWpeE4C/XGHOUzVSSXFt7aVHi
 SD8evctTJNdBGiIbnSDGXOeTjIafSK3h3+HqvfgBXWl/c/vizUU8MgoIlTq9Tk16CK6X
 Z/Uw==
X-Forwarded-Encrypted: i=1;
 AL+hErGzTSeQ95HFsA7g0r6IJZ7njgzD1m703tNWAX8zxKI2tCJ+v2DRDDDGt+PwVBjH4NeQmTeEVkl6/3XKbPh1r6Y=@lists.osuosl.org
X-Gm-Message-State: APuU4Z90IOYr9hR33UXil3C5L9evNhh13K/1x7XEizPEEpr9BJ/6EGbX
 YNQl/CFIKdqF+2ATJW2udmiHXw8juscVv9Bh4EUjdtEx11oIbOp90VfAhqyh1ctuyn5vckYCosG
 1QooE97pn/zWYSOCq6qD8yYcHPjNx6p0=
X-Gm-Gg: AYBFou3GeqQgbI3oS7qdENwJw1WXzpSD5EIyYI08PVdls/T6AKRSh8oxZ6bTdy/47Uv
 eXN4mr7NJs6sQtsIsS4Kdk0XngHGHXEMXExetBcBq6zqK4RDY519EaP04V3vHWi75VJB4JiggD+
 fx/WoC1ezj7i++lSK16MItaUqkoVTpZMi3AJFK82DoPCpCl0egRppFznrNis8KnjosC0oEA1MUE
 UqQYlts6cR0P2pxJuH5i3eW3E5iiC/dfhiOb9hgIvsam5lk6XNDj8mEW8Z8ifQ91YUhxWdGRiRr
 8C3+rymDHyQ3kQEEaNjcOhjMInhSbHHxzSK02yVoBeM0NqSrx5ufZUB0YGfFKPL0lS25yn4M4DM
 JyulunTk8oBu0QzYV+HB4kNJ+wN/svfYbWDdYo3gQEpWV5p3KIeH1rXyWtKY2evW8Eq7SjN4UGy
 ABsT/RJ3EgLdfad4DVE4Drn8ffHfMj7eIqJJWm+AMHfZ3tQyKp1B+CWaLid7eqdAzdSFY37b8b
X-Received: by 2002:a05:6820:c0d4:20b0:6f7:e193:8326 with SMTP id
 006d021491bc7-718a70211bcmr533260eaf.32.1794305086687; Tue, 10 Nov 2026
 02:04:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260925112850.189302-1-danividanivi@gmail.com>
 <179068206160.434549.1717741783856466607@kernel.org>
 <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
In-Reply-To: <02c36d47-ad50-4f2c-88cc-6c91f62bba00@intel.com>
From: =?UTF-8?Q?Daniel_Via=C3=B1o?= <danividanivi@gmail.com>
Date: Tue, 10 Nov 2026 11:04:35 +0100
X-Gm-Features: AclHuK8llmPJAPoIuNJK-9z_1ADOqNSF_GH_KJ9E3vYufuFCOTh_YkEnA-aSzHQ
Message-ID: <CAD6rab8LEfZcQgcZLmeiDzd-PUi56h=9aBEsuOS2qnoyZEsdxA@mail.gmail.com>
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: netdev-bot+sashiko@kernel.org, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09/11/2026 12:45, Ruinskiy, Dima wrote:
> I think this patch might better be split into several patches.
>
> 1. Adding the missing IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226().
> This was probably an accidental omission.

Agreed, I'll send this as a separate patch. Note that it also changes
the TSN code paths in igc_tsn.c for I226-LMvP (they will now get the
i226 behaviour), so it would be good if you could confirm that this
is correct for 0x5503.

> 2. Addressing the locked vs. non-locked call to pci_disable_link_state
> (the possible deadlock noted by Sashiko) - this should be looked into a
> bit more, I don't know off the top of my head what race is / isn't
> possible.

I believe the deadlock is real and already present for I226.
pcie_do_recovery() runtime-resumes the affected devices through
pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL), i.e. with
pci_bus_sem held for read. If igc is runtime-suspended at that point,
igc_runtime_resume() -> __igc_resume() -> pci_disable_link_state()
takes pci_bus_sem for read a second time, which can deadlock if a
writer queues in between.

The L1.2 disable done in probe is sticky (link->aspm_disable) and the
PCI core honours it when restoring state on resume, so I plan to drop
the call from __igc_resume().

> 3. The actual problem with L1.2 substate this patch aims to solve. I
> checked with the HW team and there are two conclusions - (a) it is
> strange that L1.2 is enabled somehow for I225_LMVP - this is not
> expected.

You are right, and I was wrong about the mechanism. On my setup (HP
Thunderbolt Dock G4, I225-LMvP rev 03 behind a Goshen Ridge
downstream port) the NIC only advertises L1.1:

  L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+
            ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+

and the upstream port has no L1 PM Substates capability at all, so
L1.2 can never be enabled on this link. I will drop the I225-LMvP
part and investigate the dock errors separately with AER enabled.

> (b) generally it is probably best and simplest to remove any
> device ID checks and simply disable L1.2 across the board in this
> driver.

I can add a third patch doing that if you prefer. Otherwise I'd leave
it to you, since I have no I226 hardware to test it on.

Thanks,
Daniel

pw-bot: cr
