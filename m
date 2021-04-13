From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Tue, 13 Apr 2021 09:34:49 +0200
Subject: [Intel-wired-lan] [PATCH RFC net] igb: Fix XDP with PTP enabled
In-Reply-To: <20210412162846.42706d99@carbon>
References: <20210412101713.15161-1-kurt@linutronix.de>
 <20210412162846.42706d99@carbon>
Message-ID: <874kga1vty.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon Apr 12 2021, Jesper Dangaard Brouer wrote:
> On Mon, 12 Apr 2021 12:17:13 +0200
> Kurt Kanzenbach <kurt@linutronix.de> wrote:
>
>> When using native XDP with the igb driver, the XDP frame data doesn't point to
>> the beginning of the packet. It's off by 16 bytes. Everything works as expected
>> with XDP skb mode.
>> 
>> Actually these 16 bytes are used to store the packet timestamps. Therefore, pull
>> the timestamp before executing any XDP operations and adjust all other code
>> accordingly. The igc driver does it like that as well.
>
> (Cc. Alexander Duyck)

Thanks.

>
> Do we have enough room for the packet page-split tricks when these 16
> bytes are added?

I think so. AFAICT the timestamp header is accounted. There is
IGB_2K_TOO_SMALL_WITH_PADDING. If 2k isn't sufficient, then 3k buffers
are used.

The only thing this patch does, is adjusting the xdp->data pointer
before executing igb_run_xdp() instead of doing it afterwards. So, that
in the eBPF program `data' points to the packet data, and not to the
timestamp.

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210413/d36749d6/attachment.asc>
