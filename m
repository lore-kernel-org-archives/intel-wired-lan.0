Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B22606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YOEptMn5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KjJhwB/8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9868280DCB;
	Mon, 23 Nov 2026 16:24:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3m-YALXPNUzr; Mon, 23 Nov 2026 16:24:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02DE880DD1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795451093;
	b=ZbADRTVF/l8PJBHkb6zjdguKCII3/ZZruCqo5wtCGyI4cseK1B0zi0WJ99Ev93/feoRr
	 cqI/ZsBs3XMgLPPREwN3tZvO8KOJPchARZ1zrxTv07habG/C/Fkcr1p6oQoWbtlIkJfvl
	 AqT0wYptBcj+J/egmzPL0wK2z5todezNhCK2vVWivLaNHQGiVeSMrqPDR1tFggKmBZ5bo
	 IVCFJEgIOAVlU0077dRF5p4Ymc7b6rPqDDiwaKNMm3uLg8CfhFCQibmRuKkLlzcc/49s+
	 irCMN1LlFLS78ON6fsD/hlXkoMnNxanz5QiJeLuibYe2CEa1mWjW5FXB6JyfslnxaSQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795451093;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
	b=QgBiInC2xSx/693Lhk5TsztF9g+T2GP4yi1/nC7bKw6P57m1oNRPNujOjgNDxIsww7i8
	 7jtjHX22FFrXpPwIYhswkFtSHyjLxQaanvZDdkyuUCmRMUTgDC29KuUV4qlI6XypiC+C5
	 EMiKMqgFUrCdT/J8CRhCu7+Oto9ufESMwIQzaGX1Jg5XKlVHsZ0GlAMGbN+iiXl6uilSB
	 VVAvjUrbWMY7wlIJv5R64JdqtPQbF5s+evRWn/znGTqQ4NHCrauhLLclgbMPxQA1N9zCn
	 zP7C7+8iz72pgTQ5LLbaFep3znbxVxcQX/2Bn+lZp6lwZaooejjuYaOR6KVHnyyheGg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795451093;
	bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YOEptMn5WRCCLJOSVyfdN0EI9cTlhC7i4aKH14Lqr9kb9vIqtwL/BjXDgwX1Rvl78
	 xmt5FkukmgP3xQ2jC8PNPAnchnVqKtFnUzvhFet/A42bN0nlfarRzwpesy3WvPsXqu
	 Dxp73Z6QDo61WPiAaJ3N+/vz5GIR6WKHMX7nGtvvGS+kiZuMmpPwERhcNrah2N820M
	 Hi4YUxu1dCrUVtmPlGQWqgewWnrBlLysscdvP+wYoihJhwOSFKlPZF+b3H2SCVuoch
	 qDpANCgwZHdfsYMQR2KYS28HU59TDZsOaGqeEVJn0FUGi5mKLhZdxc5/LusqQzsSVE
	 QplB7UkWlEP5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02DE880DD1;
	Mon, 23 Nov 2026 16:24:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BED00465
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 19:09:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B09C0405FB
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 19:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 62WMOdd_n3JK for <intel-wired-lan@lists.osuosl.org>;
 Sun, 22 Nov 2026 19:09:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AE3FB405C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::630"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::630; helo=mail-ej1-x630.google.com;
 envelope-from=redrakok@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=KjJhwB/8
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE3FB405C6
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 19:09:09 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c3fae9338f0so38046866b.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 22 Nov 2026 11:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795374547; x=1795979347; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
 b=KjJhwB/8ZPHV0nKEY5vTvhBtS2UnSRAgSQvUd6S/n7TMcM75gZM5Qmbh23snnFSdxk
 A6/NssqAAg5+IWMNTVSQnMq6JrtY2+y0StmUn1hiJPSGs8aqBSuGVTR+F73s7gma2y8k
 2aNR7/ZdRJOeQxmxzeuXIpOd4c2lHtn2ECNWdmWbvtQQ7izYkNX+SWY7Bxy4T4mOLIB7
 xzAJhNYLomVah2Lobv5/fJIVQSmcvweUpJ78gvQoXYAIj7D4fgZlAcN+bFDRqT2uAgPh
 4ZaelDo54iQ6MUHeptz/pJUVb4M3Iip+fHefxGQK6ICigakTPq6EtysEAVQ2ZAOj+qO3
 Puxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795374547; x=1795979347;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CB+Tc1Jtd3vDTOOqs8UPEsfneIWH1RMR9VJaPDxr1HE=;
 b=EJKWXrq2zQq/Xq7hvDXMqhWlNLvEvG+3voeuWwcn1omd9prJhRiwfwYvKxBs/t+gtf
 2/Ex8RopnOIAUHgjMwy3ap1WQR6FWBk3XRBywLX3N2yqiUHhmJDtLOv/SdObyunf6Iwj
 +EOY5u45vDRRVG9DYmpRx8WnOayx/xlNyEaQ/711ufc0rgMqMNQLbZoC+lnWuYa/QHmo
 0y29KB/Tcpl2ZdtXIO/yTbtS0OSHEK5JQ00NO+dOY8mY7rr245Rm5+IJfbHKJKmpJgo5
 K5cjzk/6PY1fnqzV4kMDK1vUmAgTKyy3N6DaTxtZ6ltnhyoIlVqxuvOSP/VclcFq/iAd
 7NpA==
X-Forwarded-Encrypted: i=1;
 AL+hErFovcnc5UeV2rPOJCsOnzYQkItV/qYuHoG0iEHIvT72HzxoEDndHf4fL3jPTdji3DV5YY3tn8vmWS3nA9Q+fFU=@lists.osuosl.org
X-Gm-Message-State: APuU4Z813Xngq/rPFanoG5+5CT/1H+wGGIBpAM4oHezq+UyXJcrR6mzR
 x24k/UXCfcl+HPE22J/JgtCG0UDGxoiBDtr/hPTMAmI7SVDkvRCSCvh08SggagZuf+03RxRc+ZD
 FE3xX6cM4BggC04rtv88AIYGnmLlxsdg=
X-Gm-Gg: AZFdTZeRDe7xTvhXfmBLoJlYs8wW/D4EGLYpVFaxP8QqDPeiknLXW7XfG6FbAP/ItAo
 +8DUQyQ/xVIRTwjSQgBT5bhSm7y7XK7meEF5/Zu68LAwm3ykGQXTTszXvqyLFXHqKmkIFpbGkf2
 ZkemJ99Fr4lKC5nU3ntKhlrtmBnJTJORFIzDa0YeEf9HfkiiSkDL//pFUQCQXoqNZ0UheO0ssTU
 76oOdxPM31KwYDq7oIlseCa4rq+zsx/MeiXIJIFkqX9nolk8yegGHhpg0FO8/fhiIswiNrdmC8Y
 Rst+jKVVH32rJhGo1JAGQGNHgip+xWWpGqqLXsNObUuou8Qzmi+p6dS3FTjN0SlBLXop+90Kn3U
 DlInt/v2W5KcGXZ6PdwpxJmigxSSkwG89rdFooIFzvH0emzGNeFXPVdDCB/LBIM/w3N91LhAbzt
 DYtYwW1p8VDfy9sGC+o0zsGvaV00i4ay0UkuBQWY8322S7F/tjW+zFweNx+H3GHrMKvj+8sMcG3
 1ABwWgXeP8dqpB+UZfUsfKFSnL/26t/0X4+JIUU
X-Received: by 2002:a05:6402:22ed:b0:6ba:b1ea:3994 with SMTP id
 4fb4d7f45d1cf-6bab1ea3a65mr739297a12.3.1795374547296; Sun, 22 Nov 2026
 11:09:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAKfe=Pq86f11-_GJNRwCN-m_TAMu-Dc6B0RvgqVk28=waXkVow@mail.gmail.com>
In-Reply-To: <CAKfe=Pq86f11-_GJNRwCN-m_TAMu-Dc6B0RvgqVk28=waXkVow@mail.gmail.com>
From: George Kokolakis <george.kokolakis.ece@gmail.com>
Date: Sun, 22 Nov 2026 21:08:56 +0200
X-Gm-Features: Aa3M54pDBYH5_5YP0kBblreRGNzte-1MvevIdDloABJWZtDsbnl1nNqNWjTdzKc
Message-ID: <CAKhuk+kK90gTr1AgG-B+MrxtZ9N8K91B+1v4xcjA5zD_JpPT-Q@mail.gmail.com>
Subject: Re: [PATCH RFC v3] ACPI: PM: Use EFI power off on Lenovo ThinkPad T14
 Gen 5
To: Gabriel Giner <gabriel@clicseo.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Nov 2026 16:24:50 +0000
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
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Could you try "modprobe -r e1000e" before poweroff on your 21ML? If it
> also stays off there, the quirk probably belongs in e1000e rather than
> in the ACPI poweroff path.

It stays off. 21ML, BIOS N47ET30W 1.19, I219-LM 8086:550b, kernel
7.0.0-43-generic, my EFI module unloaded (plain ACPI S5):

  modprobe -r e1000e && systemctl poweroff
  - boot that followed a "systemctl reboot": powered back on within a minut=
e
  - next boot (cold start after that bounce): stayed off

Same warm-reboot carry-over you saw; it also explains why my EFI
workaround passed some tests and failed others.

Interim workaround here: a systemd-shutdown hook that unbinds 00:1f.6
from e1000e before both reboot and poweroff. reboot -> poweroff now
stays off with plain ACPI S5.

Rafael, please drop this patch. Adding the Intel wired LAN maintainers.

Thanks,
George

=CE=A3=CF=84=CE=B9=CF=82 =CE=A0=CE=B1=CF=81 20 =CE=9D=CE=BF=CE=B5 2026 =CF=
=83=CF=84=CE=B9=CF=82 12:25=E2=80=AF=CE=BC.=CE=BC., =CE=BF/=CE=B7 Gabriel G=
iner
<gabriel@clicseo.com> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
>
> Hi George,
>
> I see the same power-on after S5 on a ThinkPad T14 Gen 5 (21MM, Core
> Ultra 5 125U, BIOS N47ET30W 1.19, kernel 6.18.63). An EFI power off
> handler, built as a module along the lines of this patch, did not help
> here either.
>
> On my machine it depends on e1000e being bound to the onboard I219
> (00:1f.6, 8086:550b) at poweroff:
>
> - "modprobe -r e1000e && systemctl poweroff" stays off
> - "Ethernet LAN" disabled in BIOS Security > I/O Port Access stays off
> - with e1000e bound it powers back on every time, without a cable and
>   on battery
>
> Ruled out here:
>
> - WoL (systemd .link with WakeOnLan=3Doff, confirmed applied)
> - every power/wakeup flag under /sys/bus/{pci,usb,thunderbolt}
> - every /proc/acpi/wakeup entry (LID, SLPB, AWAC included)
> - Thunderbolt, USB, WLAN, WWAN and Bluetooth disabled in the BIOS
> - xhci_hcd.quirks=3D0x42000
>
> The state survives a warm reboot: after "systemctl reboot", a poweroff
> from the boot loader (systemd-boot) also bounces back on, while after a
> cold start the same boot loader poweroff stays off. Hibernate (S4)
> stays off.
>
> 00:1f.6 has power/control=3Dauto and is runtime-suspended while the
> system is up, so at shutdown it is runtime-resumed and then goes
> through e1000_shutdown(). I have not narrowed it further than that.
>
> Could you try "modprobe -r e1000e" before poweroff on your 21ML? If it
> also stays off there, the quirk probably belongs in e1000e rather than
> in the ACPI poweroff path. I can test patches or collect more data.
>
> Thanks,
> Gabriel
