From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 5 Jan 2022 12:44:10 +0100
Subject: [Intel-wired-lan] [syzbot] kernel BUG in pskb_expand_head
In-Reply-To: <0000000000000fbea205d388d749@google.com>
References: <0000000000007ea16705d0cfbb53@google.com>
 <0000000000000fbea205d388d749@google.com>
Message-ID: <20220105114410.brzea3f5flgn5nl2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 19.12.2021 16:19:20, syzbot wrote:
>  skb_over_panic net/core/skbuff.c:118 [inline]
>  skb_over_panic net/core/skbuff.c:118 [inline] net/core/skbuff.c:1986
>  skb_put.cold+0x24/0x24 net/core/skbuff.c:1986 net/core/skbuff.c:1986
>  isotp_rcv_cf net/can/isotp.c:570 [inline]
>  isotp_rcv_cf net/can/isotp.c:570 [inline] net/can/isotp.c:668
>  isotp_rcv+0xa38/0x1e30 net/can/isotp.c:668 net/can/isotp.c:668

> struct tpcon {
> 	int idx;
> 	int len;
        ^^^
> 	u32 state;
> 	u8 bs;
> 	u8 sn;
> 	u8 ll_dl;
> 	u8 buf[MAX_MSG_LENGTH + 1];
> };
> 
> static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
> {

[...]

> 	/* Check for FF_DL escape sequence supporting 32 bit PDU length */
> 	if (so->rx.len) {
> 		ff_pci_sz = FF_PCI_SZ12;
> 	} else {
> 		/* FF_DL = 0 => get real length from next 4 bytes */
> 		so->rx.len = cf->data[ae + 2] << 24;
> 		so->rx.len += cf->data[ae + 3] << 16;
> 		so->rx.len += cf->data[ae + 4] << 8;
> 		so->rx.len += cf->data[ae + 5];
> 		ff_pci_sz = FF_PCI_SZ32;
> 	}

Full 32 Bit PDUs don't work with struct tpcon::len being an "int". I
think converting it to "unsigned int" should be done.

[...]

> }
> 
> static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
> 			struct sk_buff *skb)
> {
> 	struct isotp_sock *so = isotp_sk(sk);
> 	struct sk_buff *nskb;
> 	int i;
> 
> 	if (so->rx.state != ISOTP_WAIT_DATA)
> 		return 0;
> 
> 	/* drop if timestamp gap is less than force_rx_stmin nano secs */
> 	if (so->opt.flags & CAN_ISOTP_FORCE_RXSTMIN) {
> 		if (ktime_to_ns(ktime_sub(skb->tstamp, so->lastrxcf_tstamp)) <
> 		    so->force_rx_stmin)
> 			return 0;
> 
> 		so->lastrxcf_tstamp = skb->tstamp;
> 	}
> 
> 	hrtimer_cancel(&so->rxtimer);
> 
> 	/* CFs are never longer than the FF */
> 	if (cf->len > so->rx.ll_dl)
> 		return 1;
> 
> 	/* CFs have usually the LL_DL length */
> 	if (cf->len < so->rx.ll_dl) {
> 		/* this is only allowed for the last CF */
> 		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
> 			return 1;
> 	}
> 
> 	if ((cf->data[ae] & 0x0F) != so->rx.sn) {
> 		/* wrong sn detected - report 'illegal byte sequence' */
> 		sk->sk_err = EILSEQ;
> 		if (!sock_flag(sk, SOCK_DEAD))
> 			sk_error_report(sk);
> 
> 		/* reset rx state */
> 		so->rx.state = ISOTP_IDLE;
> 		return 1;
> 	}
> 	so->rx.sn++;
> 	so->rx.sn %= 16;
> 
> 	for (i = ae + N_PCI_SZ; i < cf->len; i++) {
> 		so->rx.buf[so->rx.idx++] = cf->data[i];
> 		if (so->rx.idx >= so->rx.len)
> 			break;
> 	}
> 
> 	if (so->rx.idx >= so->rx.len) {
> 		/* we are done */
> 		so->rx.state = ISOTP_IDLE;
> 
> 		if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
> 		    check_pad(so, cf, i + 1, so->opt.rxpad_content)) {
> 			/* malformed PDU - report 'not a data message' */
> 			sk->sk_err = EBADMSG;
> 			if (!sock_flag(sk, SOCK_DEAD))
> 				sk_error_report(sk);
> 			return 1;
> 		}
> 
> 		nskb = alloc_skb(so->rx.len, gfp_any());
> 		if (!nskb)
> 			return 1;
> 
> 		memcpy(skb_put(nskb, so->rx.len), so->rx.buf,
                       ^^^^^^^
> 		       so->rx.len);

This is where the skb_over_panic() happens.

regards,
Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20220105/f5328330/attachment-0001.asc>
