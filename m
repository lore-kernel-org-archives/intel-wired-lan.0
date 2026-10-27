Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC96606A31A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=E51CxU6W;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WkXEiIDx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8A4E60758;
	Tue, 27 Oct 2026 09:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J18siOE8TeOX; Tue, 27 Oct 2026 09:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 595F26074E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793092737;
	b=IYKqtJlK1uXCXVgmKBhXkhLY5yFntesP2wgoMBACBSy7NwZBOBawEQxU4tVBN1+iKh2t
	 JEIx8revug04adRP3e1wG0fn2RFn5jf7xRlcS+VhpJ3riBsLU5l2E/Jh0wXmQrKSw5owj
	 zZ8ObIQIhGVMxKu4he+EFtlrh4iKHxjwXH9ERCPJffL3otY6be84l0VT0CGs0bHdSVp/j
	 h6QodATQgB+VZ59Yz7J7MwAl8w1O829aCaTfdcyhNrpVxo28PObGO2q/mKOzUt0Ttd2c/
	 1dMiS1FASZChHIIlsNz2OCuthyrWAghSDB29CBc7A8Yo9IHqITCPkR9rxhv1h7l3lBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793092737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=B8DcCnnZ4gfS5p5Vm77VvkQ6VYZYAsyTMVTLHXLkmBg=;
	b=mflKRTMPL3/LbqnmuzMjlRf4T9FED4L/OEVjfhjySxvK/Tz/XSjFIFGkuHgP+WSOW7VA
	 akfpV/2WJQ78gxTAun/bfGW/ElgJjX7ke1Ze3y+qkIakqrEvcASLzvAVqwe8VUYhEQObU
	 2ewKVIm6c6fAEHc4SU4f9DU1ASVT2CE/pJJhCGhZNS3jf31pAq3cM32hkk3JUCHFHswkw
	 4Q3uWpeBGdb2T2RXJy7/Upvl8yBklA1t38bLinamolNfZQTo9m6Lq02QRj7JQrq2NS/er
	 Gqls0njuS8amNIeUmuNzECtYDx2fSwZbBisvelHhGliUgk2qUUBNzwvkt47VDwCcMMg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793092737;
	bh=B8DcCnnZ4gfS5p5Vm77VvkQ6VYZYAsyTMVTLHXLkmBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E51CxU6WyMXZqThbSGE+6FPPOBMXLh5iwhHhLBc/fb7c0OpD2/6warQg8Rum9dJVZ
	 r/LoAl56leEKRJeqz82Hk4fjHFqiaqQ4bgyKqcApa+zLoPDv4GF2ljLsmwkDI/Ypzl
	 GQb91iVRuXrcYI60LEoLSnTe+6Fge/8ebkHeZCjYQa3AoENTT+vAzw93WyMB7fMl3D
	 ukRoSUyS16NXqyhQ45wpbykuzM/hT6/VypFkmAzctHr9nlcIRbiXQHLKXVEYDbDpYg
	 k83KZ1om2g1ZURCun/dlLdbWG8vS713pGkjnoyX1GWT0ebVTDZ5/WtYd0cGtW56H+b
	 xQYbqTAFBIzVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 595F26074E;
	Tue, 27 Oct 2026 09:18:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AF6482F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 09:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACF9F40483
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Oct 2026 09:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVSpnOcyc4Eh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Oct 2026 09:18:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D892B40478
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793092735;
 b=fyluRIBcZtlvqgayLlgdMjTEVma2oSAIt4+YR5LS88jE7pLyQkOyPOb77H3plDFxktyY
 aSqeYUQ5BSYOO1cDmM/LduhSyEhNJfgs5Gjsuf6qbl2XYNygYPbb8X32aw/GBKpO06/PY
 F1ZWcE32Iu7qPN7oKUmdzwD+fuXi9Ym2Lfgvv8GE1zrcWcdiMDeiT7hLByfaHJd/Dutjj
 r4P11flqkLPk/ml3TWLmjm2NX3oDtvPW4avw+ht28LV4kDc1k9MATDN1SM2Lx0qxo+ZMM
 tdikAfIeS5MrBgFXeT9NSZd9ju3+ued7A8iH60UWP1QWLdQQkgX8eZYy3hpM0SbTarQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793092735;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=B8DcCnnZ4gfS5p5Vm77VvkQ6VYZYAsyTMVTLHXLkmBg=;
 b=UnhlfePoVSBWEHsXMwE7c4geRor3VW8HQeXFmopfVjMLoVQZNCsrxy8gHNr4PMcawYE0
 1MmZYQ73VJg78rEJg1dN7bcykICkwDKyRQCRS5hRVOExQPSODltwet+LupoM5HPMh5BNI
 4fDJPUabaptW98SLoKxpFvlYvi8eNjh/piHDfFfJ8Og7fu3dWOREhU5tvxprEosphTtfr
 sXzp77+gHO/bxGSVXEDP/9e5EVdte5UGXtezr8AYVYNsOKNPD+rSNfsvXlvcKHpHo53EL
 zJbbOB9yPflPld/9EHAoSdrat4HgduQ66T6jlR2GBq+D5AIpisiZOXCQ4d46M1MBQKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=WkXEiIDx; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=sashaneftin@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=WkXEiIDx
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D892B40478
 for <intel-wired-lan@osuosl.org>; Tue, 27 Oct 2026 09:18:54 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so25175755e9.3
 for <intel-wired-lan@osuosl.org>; Tue, 27 Oct 2026 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793092732; x=1793697532; darn=osuosl.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=B8DcCnnZ4gfS5p5Vm77VvkQ6VYZYAsyTMVTLHXLkmBg=;
 b=WkXEiIDxyL6J/ShUkm+mNwEc7Zu/ygbEQzu7MQyzsfWnDaS3qXfsD6UXcfobA0otP6
 IjOQum+HtaoIb8tigZoObOQIqcjZbvG5d4ePN7rKsIEvjR7kbGqxn/HhKeTaB2Kp8bbA
 2qwPOO2UJl+TV4iJpKbo+lihiLeovtsZ/+pDSaOQx8VcPy8W6vG1F2F+k4p/MRUNQJ8h
 hboUT4pAhJQWbz9IuSfBIaCCDgzVlBfNwJLFKJfCqaVXO0A5j7QpUSBLGa48v78NgauQ
 AxeDyNpuRt01rq7ldKFmqvHAGDfnFVhBZM77THQALfIOPcZMbbZEbJjdnyTLQcln4f9A
 Kafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793092732; x=1793697532;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B8DcCnnZ4gfS5p5Vm77VvkQ6VYZYAsyTMVTLHXLkmBg=;
 b=2E+UaZC6pSh53knRf+rFYtJiVQRTAf9zVt/chn0Yt+DYQnaGX/JvQOtZP/3KEGTV/x
 JlzzEBgcye34IXEEv2JnAy90nA8Rs3ST7sOajzaIQOStZxftcDZtJLSYi6BWSWQHkpWB
 plps/USKi367EwEsHzbFu6DE4IyT6GWgpV1Y48SxFl11kwtpgKMhRhafGcREMzTcMN74
 GthXSjPbay4bDM501Kp/4unPqsjsnCTEz7u8mkVa4CkhCTaPVo2fE2HICuPCY3bYacMB
 ZV38LhDUl/EuJJd3KlAv+AscIuYS5H9Nh5xNVxPbQtuFr9GkJKeWSfhPoR4z5jHrAWUh
 xzDg==
X-Gm-Message-State: AFq9FYJZ/3xIAaUSarfeZkV7E9aUbdEtgCTXsibFx6T71p+EnOnPS9++
 ohE1KbhkMjFRlfekHfXcEw++kSz9w/T8AOrlKW7aTgfBdkMWTcAiy6Dm
X-Gm-Gg: AYBFou1W6hw8l+IIrRY/8UQqmWRpBuajyp0UUp1GtdGVuU0K4utRTgtCDT+QyCj3fDi
 Spr9Yx8RVC+sX96yRiF+KDGjXDM5Iq8ASCE/2xn5I/aWF3UL76fm4XBD30xmixj6zFwT6tO+V0h
 F4ev61zHW5v9D+6WZC3KCTLmmES6g3H9W9ddM8GhBvKa33v32SI73BM6P2PW+oSoEF9uv1kLhdU
 ZbzdLZsdAL2l7Y/cD1RfBAlRXsmDj12tgmc7zcPgg7qe2HRBL3pWr9RUY7uAyMEWzfjyYF2R7MH
 KPpKXMSCTSPGEkZbrTDSKkMPsxIr++0xmmVKv4dng9lEVVtBCfQTg8a2xbK9byiYlvHyA13p6BG
 IIIlGUOThCVA2ptVj+LdlsBU9lmuR12Al8CANvrVObtlynlPFVoCkDqFH2x9pIUZZup4C0aMl9Y
 2Sac+HHMrWapLDJsVC0gZdm5ZcAGgfkyCIpgipXHJzFjSWUde74TEB8CLCPx05wafHy7GBVkbLe
 B1D+9vYDMpt5elB1uNuL7wJCZIT19VLzmS1TvoGVQR5H4uhJm2x32zL6mvW1EgJGjjAE3wDcsOq
 898wGcNuMI6mcrwRXJY/i8O4ysqqu+o=
X-Received: by 2002:a05:600c:4e87:b0:4a1:efd3:9862 with SMTP id
 5b1f17b1804b1-4a35acb13d1mr175663895e9.21.1793092732389; 
 Tue, 27 Oct 2026 02:18:52 -0700 (PDT)
Received: from [192.168.1.214] ([185.175.35.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a2d9280sm250083205e9.13.2026.10.27.02.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 02:18:50 -0700 (PDT)
Message-ID: <f67f4991-3cd3-4897-825e-2b5af5e4c96a@gmail.com>
Date: Tue, 27 Oct 2026 11:18:49 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: intel-wired-lan@osuosl.org
References: <20261024163701.134489-1-sashaneftin@gmail.com>
 <b48f890c-c5e3-47f3-bec4-08a442dad168@molgen.mpg.de>
Content-Language: en-US
From: Sasha Neftin <sashaneftin@gmail.com>
In-Reply-To: <b48f890c-c5e3-47f3-bec4-08a442dad168@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/24/2026 7:40 PM, Paul Menzel wrote:
> 
> Add a Fixes: tag, so it’s easier to review the change, making the 
> function unused?
> 
This patch has no functional change and targets next-queue, so a Fixes 
tag isn't needed.
