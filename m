Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA0606A32E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=5zYTkxtU;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rqm7EYMq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A7BB80E4C;
	Fri, 30 Oct 2026 18:33:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P3Ja1k0jYbPb; Fri, 30 Oct 2026 18:33:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30DF8809BF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793385233;
	b=Bj2FDWvmM4gCm+0J9G/V1K7Tbxq6ifQ+/xOi3HmLcDv3P6kwLgY/t5vKmytsWvKNKhJ9
	 J3RXa8QhybLptmzKrCkzvSghcsz/AcGwGzIoxra1MS1skw3sZK7jjCF7Qv35gnCTPME23
	 rOV25JoBuMWodlvs9qwxJy064jEpk7Yn+q9/wtbSz3DQP3zyEMFsOyyEMNVak/TJ1SGGK
	 Z3DQ836OX2ExhNrD8uaWC44TkoeH3+BPN8bXPeiGUHBeLeCPr35VScJQ6VXoA1cYnMEev
	 3hqVaOaohF+Ax6zeDUyS8sdQj8jFddufhClVPzPZ5KYC/YK0P85kDiwlJ/okZDZZgwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793385233;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=n+s5FGGcYwr65sgVMPtFGYslhUkE59pesnMOY/vd0Ec=;
	b=Foq/ODGo6UBIJReA8mcyiJ8ZnAyTbbIczusGTfa67i8R+d1PP99/pdpvGruhP9FF2nNn
	 lQExkR9UTTgXHiIDr05UiUpaLuNwY12qZ6V38WdwDAiacDq0IZsGJYtLyBPqYIxbpfMW0
	 PtTzXvZMlhbSwGo2JMn6Mwz3z7DIBO3xcnm0hL1+K+OYU+4bJiZDrxC29zuAEZEy5YhR3
	 WHlbQ8QWV7CsxLlQhoJR8UwrtdJSUDw6dfRm5Cw/qVEkU4jKTqalT1b99ARmYtV3UAzgb
	 POOifxV6BSopLNHOxpwwpMrna3mbXOvkgB31WbCIhOXAW0f2boqqHdQqnKfhug3I1Jw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793385233;
	bh=n+s5FGGcYwr65sgVMPtFGYslhUkE59pesnMOY/vd0Ec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=5zYTkxtU9eQkBvKrl63T1ml6M85mrftfLtggcxrm2YLCnUl9nqZ1UGI46619cb9sS
	 a/01WiSbRRFWPUtH9ZDydI6TAFBRyavwcbEKi9VTKs6o2g5BVFofywaBP+SsMOUXov
	 YiEkNRyc3x0aBbGg0O8ER9xouXxjyM3OZswDNepD4z11xC5xhRg2t1flPlyJqyTe8d
	 eYbvvrWbVKCUJNSks8/BIGC1FNsii0zvD1/Q/OJzdwoSnMX/qBb9LoAKKRy3mPFWvm
	 Y4BhRZHU3qwB/DIp/jg1/FNt3AdNt49PHJF2PlxNidLXerKFi6cL9JaW2kRHqaB1Mg
	 NjrrMcNIdzOVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30DF8809BF;
	Fri, 30 Oct 2026 18:33:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2019C712
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0581E40B4B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:33:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PzVu9r2UeXfd for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 18:33:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF38F40B4A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793385231;
 b=pKoTkmQLnOgmdf3s8SNp33CO4exJujiEnsMRw3xaMz9TB9UQ+1SAGxZcWjtaxUQM041Z
 abixr+Hsfix1EyVnpKHlcRn0XXgVeUIQ07SzS099dAbVA6SAyuCaA/1c9hdWMe7NrODv3
 YZ0bJvnoyFctdfmG0Htos+d4Sfc+iCWl65RNQZOxTWWrI1zPsz8GTOxLcvUmyubFJ5Zhq
 sIJemAtFEgzyiqhtwj+DJ6F83+E/vRFJ0SM4HnDcAzkpJm42BpWiiX04iyjXGc4QO3dXx
 9Si9KQFtU6o5S3TSOYZvqHag7fpxI1nj+nXS9Qw4522jmCfZBEsd8OiSR4IK6ds42sg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793385231;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=n+s5FGGcYwr65sgVMPtFGYslhUkE59pesnMOY/vd0Ec=;
 b=lWYUMRqRbnoyDHTP1XyhiE5Jkm7Y3uCCYTqkV1LqLVtdcurBn8BM9DxzM0CGiIIbil4U
 05cAY3N1l8cCSK2Qt03f4EWLeFXDdPEy800ZyE/CPongMwja/NzL506+B1NXDj/apZ8bD
 MbFTwuBuTRhiBOyxWgq6kzhlZmxC3h++vs3NlIl7efXFjC7WiS80VkYjT3gHVl1JRQtFH
 3GqvoFsjyS+ZpC8lTXJXVR1QAsuDqk0o+MqtU+0MaYciTmVWcMGLJ56errEQXeGHj9t0f
 Aq36XRpQERTsPnEuJDgjoPIijztkMkMEPWdCNcvI0uUgkAh3JG+1v6yoRAzyCC41Mxg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Rqm7EYMq; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Rqm7EYMq
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF38F40B4A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 18:33:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85779601EE;
 Fri, 30 Oct 2026 18:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABE81F000C1;
 Fri, 30 Oct 2026 18:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793385228;
 bh=n+s5FGGcYwr65sgVMPtFGYslhUkE59pesnMOY/vd0Ec=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rqm7EYMqYWBsBnU1PVI+5HL9VyD/em61cVfv/bJBUJmXaEbg9rShxyGpVTL+Yg9AT
 KGViwAP/VKX/t7IPXSo+RDSe0E5MjGpt7a8q8Scb9rSDsvy6D7Z/k39xGCiF5V2MCk
 dN7FHoHRXGGgaDcKZL5Sp5j2tRRIbwm/ZjqzwGQxKkV7FCJD1TZEnGRKtmIF4J528w
 k7jc3UQNNzvbf3pbcbidaYMBiyb/5ApjvsmA0bTrU0Q0ei7EtMn4vN3rulzcpz7QSm
 aVJE3qxvLDlJjrHxhUzZRICcw8aVQc3jEnqg4n3DUo7ZvS7sgAEj7lwU8xZ/9I9/5X
 EhK31jlJzojbA==
Message-ID: <sashiko-outbox-191412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v4 5/6] RDMA/irdma: Support UMEM attribute for
 CQ creation
To: "David Hu" <dhu@x6u.co>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261030181512.2056056-6-dhu@x6u.co>
References: <20261030181512.2056056-1-dhu@x6u.co>
 <20261030181512.2056056-6-dhu@x6u.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:33:47 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] RDMA/irdma: wrong DMA direction in irdma_setup_umode_cq() via ib=
_umem_get_cq_buf()
--

commit 8981c5869a8245f4b87a31412a16b517815f3a39
Author: David Hu <xuehaohu@google.com>

RDMA/irdma: Support UMEM attribute for CQ creation

This commit adds support for one-step user-mode CQ buffer creation using
UVERBS_ATTR_CREATE_CQ_BUF_UMEM and IRDMA_IB_ATTR_CREATE_CQ_SHADOW_BUF_UMEM,
sets up hardware PBLEs directly from the pinned UMEMs, and adds UMEM and PB=
LE
cleanup in irdma_cq_free_rsrc() and irdma_resize_cq().

> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/=
irdma/verbs.c
> index 9f4905fdb791a..41e56ab8aa6df 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c

[ ... ]

> @@ -2767,26 +2793,87 @@ static int irdma_setup_umode_cq(struct irdma_devi=
ce *iwdev,
>  	if (err_code)
>  		return err_code;
> =20
> -	spin_lock_irqsave(&ucontext->cq_reg_mem_list_lock, flags);
> -	iwcq->iwpbl =3D irdma_get_pbl((unsigned long)req.user_cq_buf,
> -				    &ucontext->cq_reg_mem_list);
> -	spin_unlock_irqrestore(&ucontext->cq_reg_mem_list_lock, flags);
> -	if (!iwcq->iwpbl)
> -		return -EPROTO;
> +	cqe_64byte_ena =3D dev->hw_attrs.uk_attrs.feature_flags & IRDMA_FEATURE=
_64_BYTE_CQE ?
> +			 true : false;
> +	cqe_size =3D cqe_64byte_ena ? 64 : 32;
> +
> +	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUF_UMEM)) {
> +		struct ib_umem *umem;
> +		struct irdma_mem_reg_req cq_req =3D {};
> +		u8 shadow_pgcnt =3D (rf->sc_dev.hw_attrs.uk_attrs.feature_flags &
> +				   IRDMA_FEATURE_CQ_RESIZE) ? 0 : IRDMA_SHADOW_PGCNT;
> +		u32 min_size;
> +
> +		cq_req.cq_pages =3D DIV_ROUND_UP(ukinfo->cq_size * cqe_size,
> +					       IRDMA_HW_PAGE_SIZE);
> +		min_size =3D (cq_req.cq_pages + shadow_pgcnt) << IRDMA_HW_PAGE_SHIFT;
> +
> +		umem =3D ib_umem_get_cq_buf(&iwdev->ibdev, attrs, min_size,
> +					  IB_ACCESS_LOCAL_WRITE);

[Severity: Medium]
When IRDMA_FEATURE_CQ_RESIZE is not set in
rf->sc_dev.hw_attrs.uk_attrs.feature_flags, the UMEM passed via
UVERBS_ATTR_CREATE_CQ_BUF_UMEM backs both the CQ ring and the trailing shad=
ow
area page (shadow_pgcnt is IRDMA_SHADOW_PGCNT, and irdma_setup_umode_cq()
later sets info->shadow_area_pa =3D cqmr->shadow from that same UMEM).

However, ib_umem_get_cq_buf() in drivers/infiniband/core/umem.c hardcodes
DMA_FROM_DEVICE instead of deriving DMA_BIDIRECTIONAL from
IB_ACCESS_LOCAL_WRITE:

drivers/infiniband/core/umem.c:ib_umem_get_cq_buf() {
	return ib_umem_get_from_attrs(device, attrs,
				      UVERBS_ATTR_CREATE_CQ_BUF_UMEM,
				      uverbs_create_cq_get_buffer_desc,
				      size, access, DMA_FROM_DEVICE);
}

Since the CPU writes the CQ head index to the shadow area and hardware reads
shadow_area_pa via DMA, mapping this UMEM with DMA_FROM_DEVICE omits IOMMU
read permissions (and skips CPU-to-device bounce buffer syncs).

Should irdma_setup_umode_cq() use ib_umem_get_attr() with
UVERBS_ATTR_CREATE_CQ_BUF_UMEM when IRDMA_FEATURE_CQ_RESIZE is not set (or
unconditionally, as noted in the commit message) so the buffer is mapped wi=
th
DMA_BIDIRECTIONAL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030181512.2056=
056-1-dhu@x6u.co?part=3D5
