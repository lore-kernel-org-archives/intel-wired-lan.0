Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC334CC6B2D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 00:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D45080F61;
	Thu, 15 Oct 2026 00:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dho7kqUkF4XY; Thu, 15 Oct 2026 00:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D751980F56
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792023248;
	b=WyzeZrhtYVPg0ryRQdpKNVIQUH1Ls4ykEONGqWWihNRRSZokOZFWDkT1t+OkxQ4AmV0g
	 B2MwtrAaTbdDeg1ClKJYZWwiQIyjc+RueAQp4CmTbnWX+M5YeN0iOkFw08szmmhW5oXJN
	 6GugpkC75eAuihj2KZrv1D/NaKNqDw8SuyDSElqATJyXI/zVNEwxplXcRMGnuqYK3E1Vi
	 PQ7EiI/SExr5zeBhP6l3lKE8dt3umfzSMoLX6l9Vrv2OUYXmE0LF/DR7g9GwDDRWJd4S/
	 WUGMDDIlgori9t+7JTPhJOO37Fzx02XzSaf5IdwnsSolAxzRd4MChq5dFzgoYoFQo9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792023248;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=oRL1ve/939av3S+iigZfizdksEHgH92h6JRbHrgg2vM=;
	b=W2kxaCEojbpNfnW6wqaPldlmwmw+RtuVDD3v3bB3gzwMNH6uvKmi3+PidXtY8E5xDTk7
	 xNeX+S/8nDBtpiXpIq++/GDQcDBs/EUIolXaxIvdf6lzS4O1BdjS3CZV3b1gO17Gr40/g
	 /RZjb7w6HZz3xWZSVjmumdPPIS0HOG7szlOwglGFLhaKj2asC+zwRxZlBhrYBsuyAuQ/9
	 W7arVKUs4XG64+cY1PuuwnaDMRXa91WCIb8jG5c6+I+9ZPEZUE8GBk3iDE7V3bG3xEdr6
	 dyeF9yNOALQNR9x816aRGMPz9XH6vkoENepEylr276RJn1SLlag8KrGfAxKMuj1FRxA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jPpeWjcW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792023248;
	bh=oRL1ve/939av3S+iigZfizdksEHgH92h6JRbHrgg2vM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gby4OPX7SbCCcQ2+YFrJw9V2u9+gyX42oN+ula66ikDn5O3NsL7fKXUEPlSczhc4Q
	 cRH5HGlsIXK2BQ/pbtz4mTchold8s6fJLKvW7Bi0AVYlWHpFsHRWJU8Amp1L0Y4MCq
	 HwAf1f7v+p6STQjjm0k8rgeIq5lo/ZCv3JXr8QMxy/t4zhjQu038GihC3TfxVwSURP
	 n6O+B+Il/f6lHIWlPSHW7je0UrEdU82oczfL9YriXGMODpOIkKBuZD0CmfN9zBuqGu
	 ECTBd5g7rpg2suTAbtPnZFISRnaWFsfOyk6dVfi+fR4lpPRPUqhLxnglN/+P4ukdNF
	 Fl53HQoTo2pJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D751980F56;
	Thu, 15 Oct 2026 00:14:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DB422E0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B80E80F56
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxSQ8PdFqgoN for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 00:14:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28D1B80F55
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792023246;
 b=rFUtXcRWdFEPnZk7Et+7w7l3oQvBiPj2DLfWARsD2pqyaSy2SH6I23SNzkcgtdasuV7N
 9O2zoWENqJGFnd1fm0Tk8TIwrd5Sxpia6B/TalAI2IjHizKulkCAg74z5HWFrq/D2GPbj
 rIx36udAovITbvOxW8Ef10DysScSXMSggxgbpqv3I1VxSIfCe+LUqlgkEqCQQ9wrnOgUd
 HVjuSIcxLsszlcp1SERw6VLeRRaAFKk/AR/xsFPyIlkZGBYYAGWnYK8SWDAqK7BrunlXZ
 36Mv+1XmSO3Xq1DFcHiMofDhKDfuD9GTKfIeJgigrZmJ1D4lYK8vXiunzP/H8yTEA2g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792023246;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=oRL1ve/939av3S+iigZfizdksEHgH92h6JRbHrgg2vM=;
 b=MlcKumJgkCPcm+43nQ8q0lMCzQ/CykV+5f0WH5KVq8T322KTyCc1Dit0EiO8Fly3eghR
 afmKpS2AkL86IzGqMAW4Xg/6zrQiN3aWDE6bNw/D6S9euYMIJtJdPDZ00zUBkPBo/2n2g
 EhxZPcDnpOi3/KsmvqnoAy3t/DHuA7vrHE4KzqAYGGfj+l+tGfkltkTK+k3s9Qds/NWaa
 Go1SxQgR4t+MiYc/y/1e37f4ZeGg8azrdTspLA8aki5o5Nn2Ndinq8WSRBTUzTnNjmKOq
 L9v2t2xK6bg2oJ7g7HUmZQQRWWpmxOXpbO6ii65Fo8ZjI2oVs4eWKZTp8Om8xO7jfbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=google.com;
 dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20251104 header.b=jPpeWjcW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=namangulati@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20251104 header.b=jPpeWjcW
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 28D1B80F55
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 00:14:05 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a021c28046so4855e9.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 14 Oct 2026 17:14:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792023243; cv=none;
 d=google.com; s=arc-20260327;
 b=c36hnjt3tIifavohRD9UL6OapVe7WCpaFbwpsqYL9f0aNL9Y38dVJ7iget/at6tohL
 tOzyIDPSNiMPdvHlhBOHacA2kpqcSzxaFxpyjiQS8do1bGC+c6iNTCKXnn+/nRCk9+PY
 WCnrViUQxSGsG+m2hPrpHraTZ9snrIf0kzR7rlh44isnH2ujX6MLkINJMLkhftd6ZuBn
 WqzRWbkIXKS8MfbzQCmtdmB3Q1utNCbzuYeuJSa0XDhyEM2AUSMSU1YvMqjAMUJ5rzOz
 XMRiiO4DlYsou4/QPO7KK96LRsfU5NaUCsMwlFfi5rEJI+381ZId+/P8GVKICSb2Zemm
 AV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oRL1ve/939av3S+iigZfizdksEHgH92h6JRbHrgg2vM=;
 fh=ReKaLVSogeg5hKc6LikMTBCpEDc5Btgk9cZTw5EOgpo=;
 b=Pn5Mtuu/Uq0aPfwXc1nC8L7xr4lY+NS4TpBPixrhAGY20oVFnKMkvrc+uYdp4nvEp5
 4mrRx0jconY3mikxIzXyvPDhbKUakpFdsSDcSo3viDuA0H5uai++9+2H1dOFIqVdFJOy
 Q8/xQEBv3kSp9XITgtc09yE2ZwU1cpW//GC84h94AUjWj/i1YuExZ7E7usotv1SySJjo
 XQ2Um7obb5ZQDqr5Ti5ZYBzKKD1fBaChd/eT9h7TjFUhR07der/OGbsow2UV46Qjqudl
 ZteZI+9ZpG6DdqLqR8jueLQrRT2ryvZjEaTgI4tvnB42mvKOo2XjlBsdVj8/dkSi06LN
 VSNw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792023243; x=1792628043; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oRL1ve/939av3S+iigZfizdksEHgH92h6JRbHrgg2vM=;
 b=jPpeWjcW4A/0APM4hjeScHH0ZJzr01h8ldzYYEtfzanlrivVT1YGmmNXJAme3fSCQU
 HlIwRrnMbJhzOtOPYXmKZOs7Dg0vlg+K/5kxD153a/3JgY/vBx9JN7PUcogHY8jHKP6X
 1V42VzZrHZuAinxrr3Q1lqDdhyrNLDRZ+vuWxg41lxbsvFvBRS/AxGQUWy5TbwT1X0ym
 0qD5E4sVEvOQ/n04MMEHL/3JICQdMLUi6nScSy04M34RlMSvAxupdo9VjQ+RqfYADs7m
 wdAq70FOP0jxsj3ackIhn/4VyqOF/6cM3sgXGVBfMBXwa0MEMq4MVYUIvg0LqWPXB46M
 0GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792023243; x=1792628043;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oRL1ve/939av3S+iigZfizdksEHgH92h6JRbHrgg2vM=;
 b=fSsr7ED22sfPkhH6kTVxQcdRPSEqoKLsH2CVHsXxGqX5Jgp32zZYpUiORp/W9gmcyV
 P7QIkgz2VDJ2TMGgsCOmecdCi4LIlR/j3W7ZKnhQdWNy3fv7dfyb5TW2KVRmbijgTKFp
 onvWHlHpNbKrczCw8JlMMMxkU7UCfHTVoZ/T9KlDbTj5P0COyMw8Ea1GrLQmi7JWgbuF
 /d1tr3Gyz/1iuUaKunmLfPluq7EowtjBBFOONf9dq18wCj2jEgfFM+a69cHWN/In9jQH
 EeNZrGsave7WuV3JSIRZjFblRmQ6OPa+BoX20SWtFIZZ4IyzFxeHkYSvLK+AdmUDv9+h
 elrQ==
X-Gm-Message-State: AFq9FYIHrRw4k1eQ7utEdd93sxaER0uT7plxiVFSdpM5ZE0/GaRt79Iq
 6JWrRFE2t3rDSf94fSJcyAdVnII1JDO8J6Avb/UZzq8U0sjYeHTTYt8pMXeKBRq8bT62d/paBJV
 72q1At2aXiP2HnoSMYPaMDQ78p5qWwxDqKEKdJ+7l
X-Gm-Gg: AYBFou175sxW+jH8Czvj78/V0HNEszCjDg65b1a+G+GB7A4Rp7BzEyH8Mmx5e57yGn+
 r75AC7Whh0bT+jHsQZ081n+LhyWjNGgpvGtH9JLqc6WBiByiEOF/oBrnKVekLx9mZAl3A7fM+Fm
 oDM6n24WsUzvnK9+9L3CWfJV/2UcSlgx7MYdr4e2R9C8fnmg3k/sx3qEM3j3CfIsUlHeqBDwcq0
 zdymFz5ugoD1iNKc9yaxjBJ+PXl+PlHmtmTLBQ44ztObV+2vxyhJwmo6QyjcdfcrdmE70zVAgxk
 XvDrTVSsY6KGt6jyC0aML/HM5/FjP38km56OJovo7T+gTqz7n0vP4Og5rsyTcUqmvfP4MFwfV5M
 OwVFjGq4tSw==
X-Received: by 2002:a7b:c30d:0:b0:4a1:97a1:b4f3 with SMTP id
 5b1f17b1804b1-4a1c205054cmr30675e9.10.1792023243071; Wed, 14 Oct 2026
 17:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261009212537.3996-1-emil.s.tantilov@intel.com>
 <20261009212537.3996-3-emil.s.tantilov@intel.com>
In-Reply-To: <20261009212537.3996-3-emil.s.tantilov@intel.com>
From: Naman Gulati <namangulati@google.com>
Date: Wed, 14 Oct 2026 17:13:50 -0700
X-Gm-Features: AclHuK8FodLihAP7BGlBxxnz61zd9omOZ33_dcfVZmfnmdTndSjF18-OMJSC1pk
Message-ID: <CAMP57yWp8O0gXQLcXhtuLwEV5sYs3rJoGWepzO5tr103k_da8g@mail.gmail.com>
Subject: Re: [PATCH iwl-net 2/2] idpf: release PTP before freeing vports on
 the init task error path
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, milena.olech@intel.com, 
 konstantin.ilichev@intel.com, joshua.a.hay@intel.com, decot@google.com, 
 madhu.chittim@intel.com
Content-Type: text/plain; charset="UTF-8"
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

Reviewed-by: Naman Gulati <namangulati@google.com>

On Fri, Oct 9, 2026 at 2:43=E2=80=AFPM Emil Tantilov <emil.s.tantilov@intel=
.com> wrote:
>
> Release PTP, which cancels the aux worker, before the unwind frees the
> vports, matching the idpf_vc_core_deinit() order. Previously it was
> possible for idpf_ptp_update_cached_phctime() which runs via the PTP
> auxiliary worker to read a non-NULL but already freed slot, pass its NULL
> check, and dereference the freed vport. This can happen on driver load,
> where any vport past the first fails to initialize:
>
>   BUG: KASAN: slab-use-after-free in idpf_ptp_update_cached_phctime+0x4ad=
/0x4d0 [idpf]
>   Read of size 8 at addr ff11002129215050 by task ptp3/10120
>   ...
>   idpf_ptp_update_cached_phctime+0x4ad/0x4d0 [idpf]
>   idpf_ptp_do_aux_work+0x37/0x50 [idpf]
>   ptp_aux_kworker+0x64/0xd0
>   kthread_worker_fn+0x289/0xa20
>   ...
>   Allocated by task 8820 on cpu 32 at 2113.761375s:
>   idpf_init_task+0x321/0x21c0 [idpf]a
>   process_one_work+0x917/0x1940
>   worker_thread+0x5a5/0xfe0
>   ...
>   Freed by task 8820 on cpu 32 at 2113.809014s:
>   idpf_vport_dealloc+0x8cf/0x16b0 [idpf]
>   idpf_init_task+0x245/0x21c0 [idpf]
>   process_one_work+0x917/0x1940
>   worker_thread+0x5a5/0xfe0
>
> The aux worker is armed in idpf_vc_core_init() before idpf_init_task() is
> queued, so it is live throughout a failing init, leading to the scenario
> above.
>
> Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reported-by: Konstantin Ilichev <konstantin.ilichev@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index a1c739cdd540..9c541dd6ed4d 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1747,6 +1747,8 @@ void idpf_init_task(struct work_struct *work)
>         return;
>
>  unwind_vports:
> +       idpf_ptp_release(adapter);
> +
>         if (default_vport) {
>                 for (index =3D 0; index < adapter->max_vports; index++) {
>                         if (adapter->vports[index])
> @@ -1760,7 +1762,6 @@ void idpf_init_task(struct work_struct *work)
>                 cancel_delayed_work_sync(&adapter->serv_task);
>                 cancel_delayed_work_sync(&adapter->mbx_task);
>         }
> -       idpf_ptp_release(adapter);
>
>         clear_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
>  }
> --
> 2.37.3
>
