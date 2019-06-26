From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 26 Jun 2019 12:44:59 -0700
Subject: [Intel-wired-lan] [PATCH net-next v6 1/8] igb: clear out
 skb->tstamp after reading the txtime
In-Reply-To: <1561500439-30276-2-git-send-email-vedang.patel@intel.com>
References: <1561500439-30276-1-git-send-email-vedang.patel@intel.com>
 <1561500439-30276-2-git-send-email-vedang.patel@intel.com>
Message-ID: <4f0681155a6057bf40e281bfc251aba60c296201.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2019-06-25 at 15:07 -0700, Vedang Patel wrote:
> If a packet which is utilizing the launchtime feature (via SO_TXTIME
> socket
> option) also requests the hardware transmit timestamp, the hardware
> timestamp is not delivered to the userspace. This is because the
> value in
> skb->tstamp is mistaken as the software timestamp.
> 
> Applications, like ptp4l, request a hardware timestamp by setting the
> SOF_TIMESTAMPING_TX_HARDWARE socket option. Whenever a new timestamp
> is
> detected by the driver (this work is done in igb_ptp_tx_work() which
> calls
> igb_ptp_tx_hwtstamps() in igb_ptp.c[1]), it will queue the timestamp
> in the
> ERR_QUEUE for the userspace to read. When the userspace is ready, it
> will
> issue a recvmsg() call to collect this timestamp.  The problem is in
> this
> recvmsg() call. If the skb->tstamp is not cleared out, it will be
> interpreted as a software timestamp and the hardware tx timestamp
> will not
> be successfully sent to the userspace. Look at skb_is_swtx_tstamp()
> and the
> callee function __sock_recv_timestamp() in net/socket.c for more
> details.
> 
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)

Since this fix is really not needed for the rest of the patch series,
if you have to do another version of the series, can you drop this
patch from any future version?  I don't want to keep spinning my
validation team on a updated version of this patch, that is not really
being updated.

I plan to take this version of the patch and will hold onto it for my
next 1GbE updates to Dave.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190626/63fd2287/attachment.asc>
