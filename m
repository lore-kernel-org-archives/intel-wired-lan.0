Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C74CA5FE3
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DD4A410F1;
	Sat,  3 Oct 2026 09:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtjS_jAGlOEy; Sat,  3 Oct 2026 09:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 02880410F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021370;
	b=L8zsGapIWjPfRUatFSujepRSeNfSU/+AZJxX7gohZtrO/a0nUFGPFh2Z7cBvPE5DjfT8
	 MPPhd7U7G1ViRKkMK4XX2LIRB9mJUzd2pXIuos5uJ8FqqnZA47+KTVL84W8I+CAw/lCgF
	 8QNuvwcNSTnonZUzlVoAcDjR6N6JrqgbdbB+xalllv569LXimBPZKx+/pVj7Q0kKZg7m/
	 Bhn2ptrbEYuM0OgfvaU638SEPzxIVw3mU0CErimESM5fxmZrdATfpFCwRaKt/6+dCkViP
	 1HLLswONybnzGzYB7K5ISEZsoKNf6j4iwBsQhk+1wIKCm2RINYl2x1lEfmujHnURA2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021370;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
	 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
	b=iQM82BXYO5oMYvbzmXnvhxV3UL0FoxuMviEDuFqkgJUxx+cInTCWe35YZI8ayK1NJ2u3
	 0VS1QjK3r/PiruS7OetWXh3dm9ckxkqqUi8LSO3ozOlY6LHG5o2KDEv6UFSOPKmuzn4/h
	 D0HAbHfGyU3gpfe6KHQhyiASFuxIBNidMI3sbGyifNODuHQGx7xTVxD0wKit6l4Isy0Ez
	 LP/dUf2I1AfBzJVZtHJPW5TPns8rccMqlkfKctQq+wRTu6CmnFu/XoUCxVoHntfOBuW7y
	 OKRFwzunI2rEd7eNINZXsa1fzpO9UXQn0FLebdwbo1+ppFZDgRPzsZOItOn98UxZNxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021370;
	bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqRdvL2QiJP4e1Wi9CgfOraatiwD4HkQqLaqIh2Q2/TJNDZV5CuWT2s9qrCcdZIFw
	 ItFSJpI0N0lKed2lyvvb4IColoEWs4CnIjCXYqNVbeE6YVZviDBoIdh/+lgN3WL3CZ
	 jvcnOVcZp1+UJmHj3L4g2V61qV3wrmevdT2r4CFcUNfkolx7InVfJDKOO+HNzjWEmX
	 c0FpQQ8D8oMH9eQy9yfZhRiTsofzoTq5Tj53Q089TPpfXISU4ohJ+Lly53fOXN8/Hm
	 4jZRogzLPWg7fri8hkVqtT5rqoQf7N1kMTmp00xgrVhjbMe88Bi2OAFXeKz5DyQyiT
	 yU70cACNdcS/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02880410F7;
	Sat,  3 Oct 2026 09:56:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC514263
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE1A9410F4
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J_wqfT76U5Xb for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 25956410F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021367;
 b=HRoCQ/gNCJDBS/nVk97dt5oyiODu+qDtXOTFC2eoel0gfj/vQuRqKT+SC8W97N5owz1v
 QketK7Ye7fHoqxQVkH95liJiHbjSKPEL/qLD263qr26hYx8bIEQRizrAt7Dtjg6BZdASu
 Jit1b/CeVRitZ5xg2q3P7X+WlSiZAT5apNJs21jH04VHiMKEcTLFYhsIRJtZ/Aww5kpCG
 z/Jfac3HbBnxmi5L2ZpeAOWRF4A8vTuX4r4+IbTzufQi1KEYq0QLHUMshET+b+BjRKVgR
 T4gickvfVMUlPnfRQ5tMFAm/AZXaGvZLXQJvT9AlRg2RiC7iKYM+0wMNqyh2A787smA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021367;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
 Content-Transfer-Encoding;
 bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
 b=TJ0xZvI+WEb3no5QYF/3PpaOkgwH8BzdVvy6KWJs+ZIojxxsa2LIHWy4btA47QWEVY4D
 y6a2mn1Rf+bPEljZn6qhHjyt5jPbEim+U87LqgW4dZ/PFQQvvqXRTGTTNYF809OHe+JBW
 Bho/+89C5G2BdjzDcvf2yx+hXAPZlXHhO6u/fh1UVgx6IKEuERkqc7HIEflkTfcTsyHiS
 l6Ag8fCqJseRfWZfQhPsj+RKB7HK8pPllGEEd/eO8CUVEBvy55aMTM5wc12SaBXOcgQLF
 29CMtsinXEyvyo752AZGDYdGjbcV2SXIDQ5QaYHl7hy3LvxbgtvWi/MibJ276lN66Pg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=FmPy7rQl
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25956410F1
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
 b=FmPy7rQldKHMF3zKPW7A2/AiJzHw/iWCSF1S3Q6l6Gy3/xXD/1cKLI4kRzLLEIb1KtaSAx
 8dKi8pAulMYjTNJgl9Z59tYK6S7WXBg6t1drSg4ar2/2kcabPVlc4te4wv1lWLw7ld4xps
 civmG0Kj+pLCVBx9CYVXnQCzfPRDp/I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
 b=FmPy7rQldKHMF3zKPW7A2/AiJzHw/iWCSF1S3Q6l6Gy3/xXD/1cKLI4kRzLLEIb1KtaSAx
 8dKi8pAulMYjTNJgl9Z59tYK6S7WXBg6t1drSg4ar2/2kcabPVlc4te4wv1lWLw7ld4xps
 civmG0Kj+pLCVBx9CYVXnQCzfPRDp/I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
 b=FmPy7rQldKHMF3zKPW7A2/AiJzHw/iWCSF1S3Q6l6Gy3/xXD/1cKLI4kRzLLEIb1KtaSAx
 8dKi8pAulMYjTNJgl9Z59tYK6S7WXBg6t1drSg4ar2/2kcabPVlc4te4wv1lWLw7ld4xps
 civmG0Kj+pLCVBx9CYVXnQCzfPRDp/I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
 b=FmPy7rQldKHMF3zKPW7A2/AiJzHw/iWCSF1S3Q6l6Gy3/xXD/1cKLI4kRzLLEIb1KtaSAx
 8dKi8pAulMYjTNJgl9Z59tYK6S7WXBg6t1drSg4ar2/2kcabPVlc4te4wv1lWLw7ld4xps
 civmG0Kj+pLCVBx9CYVXnQCzfPRDp/I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
 b=FmPy7rQldKHMF3zKPW7A2/AiJzHw/iWCSF1S3Q6l6Gy3/xXD/1cKLI4kRzLLEIb1KtaSAx
 8dKi8pAulMYjTNJgl9Z59tYK6S7WXBg6t1drSg4ar2/2kcabPVlc4te4wv1lWLw7ld4xps
 civmG0Kj+pLCVBx9CYVXnQCzfPRDp/I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOCmwHPtzTYT/gyY2XRpPR2YFlWEaS8VgzS3JngKmTo=;
 b=FmPy7rQldKHMF3zKPW7A2/AiJzHw/iWCSF1S3Q6l6Gy3/xXD/1cKLI4kRzLLEIb1KtaSAx
 8dKi8pAulMYjTNJgl9Z59tYK6S7WXBg6t1drSg4ar2/2kcabPVlc4te4wv1lWLw7ld4xps
 civmG0Kj+pLCVBx9CYVXnQCzfPRDp/I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-jY-P_gUgPbW3UAvF3S_AUw-1; Sat, 03 Oct 2026 05:56:03 -0400
X-MC-Unique: jY-P_gUgPbW3UAvF3S_AUw-1
X-Mimecast-MFC-AGG-ID: jY-P_gUgPbW3UAvF3S_AUw_1791021362
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48af5a07314so188561f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 02:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021362; x=1791626162;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YqGVpdSP2zcszRi0/wYGQr7kElxokpmPd3Y6IXpKB/A=;
 b=zrWPmBY8ufwM7iqgcE6YXsZh21p5YfuO+3WcIC3E1tuzF60+6qg8BfGW3+arzpKsaA
 ZGWnT9GtEZoNZ7ny+xLE4AeXYfSqCtefejKM8/mbvhBzK0yeevGPUL6lYyms4sGzrvXt
 RppPkXeDO9KeL5dmMTvPlglXxqFbo72VFl0iRHW8X8VUu4UXlp97qoCWEyk/aii+tgQI
 5qqindvZpDMsG42UkUWC9allOUyL3DtBMy+zr4Ifmi6CujxD0lBUpG9OMlahYe4ITHFT
 yIKkGaEPatqI08Z5MRgSrPHXqC383GAKQ0Sy18AXa9EHRe3cMu+2UackxosIOFWZIzlk
 1wNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIz8dugthFXkEh3Rh+gMLivF34eJmgtsmHVRKm09AhAdlus2fDbB9AUR0TjH9U0H75IDrHTnlfjT4uaplULzE=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKVbdUOBA5NQ6HnfACG21Zrx35OvgspqeqP4v6uzt6Oie4oHIn5
 O3eRBbWN6FmwITVp2WTCuJB1KkEtJPKZr+xmafiRmLLyTZFkiCd12LVqLJ3WdVHUoZT7P3HWYBT
 bpDA5xXM72907ZS30bB0UiLZcSVsjIo9oVB1Aa/nm3rRwOARkmbf5mnxk+gci2QpuXwep2l0=
X-Gm-Gg: AYBFou0lVQYKkmDFGBS7TNT9ZZScqnj5v08VrqtJGcl3Yy2rKCw2tpz773AumErTFVg
 jqH6zGYY4rDjTeoHfoPfcPiVaahV6SI+/MJrUEy3MuXiH9Ifvxl5Nkx308pyMFgqNck+FyIYUo5
 67U4xoZvZinDxZeh98gkNJ4Cbo+GEQ6ofvgEh4E+tAjanHgNsQH244YsgA7clI7f6uKuc0t2bAT
 hglaDb7jPXDUOKjb3f79EL4BODnle5VdguMGi3JZ//WxbU1pkbCzxP5zWBtenmcSvAg+C3qyua7
 NA0Ku1kEinOFmAXMPjs65mv0qfaCOkw8noWEWKUL3ztx3PRgfDP3zA+YGDJsIhaOKWmB+Mbzk4N
 c8nv8TwqGwe747OkjCx2jAMhHAorwJgNiejzRx+Y=
X-Received: by 2002:adf:f108:0:b0:48b:e50:715a with SMTP id
 ffacd0b85a97d-48b1273e612mr6550025f8f.34.1791021362509; 
 Sat, 03 Oct 2026 02:56:02 -0700 (PDT)
X-Received: by 2002:adf:f108:0:b0:48b:e50:715a with SMTP id
 ffacd0b85a97d-48b1273e612mr6549985f8f.34.1791021362095; 
 Sat, 03 Oct 2026 02:56:02 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f06b3sm11631234f8f.11.2026.10.03.02.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:56:01 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:59 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_08/10=5D_ice=3A_dete?=
 =?US-ASCII?Q?ct_a_PF_reset_that_does_not_complete?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-9-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-9-poros@redhat.com>
Message-ID: <07E47138-2DB2-4824-A535-03CA9CD2F73A@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B8KqzA629u9wclAE9i-TY4YFRbJKHquAVpejAKwRF8o_1791021362
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On October 2, 2026 3:07:50 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>ice_pf_reset() polls PFGEN_CTRL.PFSWR for up to
>ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT iterations, but
>the timeout check after the loop still compares the counter with
>ICE_PF_RESET_WAIT_COUNT alone. When the reset never completes the loop
>ends with cnt =3D=3D 5300, the check does not match and the function
>returns success with PFSWR still set. A reset that completes just when
>the counter reaches ICE_PF_RESET_WAIT_COUNT is reported as a failure
>instead.
>
>Check the PFSWR bit read last instead of the loop counter, the same
>way i40e_pf_reset() does after its poll loop.
>
>Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/eth=
ernet/intel/ice/ice_common.c
>index 04633103e3e610..0ffd6b5b81239e 100644
>--- a/drivers/net/ethernet/intel/ice/ice_common.c
>+++ b/drivers/net/ethernet/intel/ice/ice_common.c
>@@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
> =09=09mdelay(1);
> =09}
>=20
>-=09if (cnt =3D=3D ICE_PF_RESET_WAIT_COUNT) {
>+=09if (reg & PFGEN_CTRL_PFSWR_M) {
> =09=09ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to complete.\n=
");
> =09=09return -EIO;
> =09}

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

