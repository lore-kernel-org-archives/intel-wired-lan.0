From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 28 Jun 2019 03:01:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next v6 1/8] igb: clear out
 skb->tstamp after reading the txtime
In-Reply-To: <1561500439-30276-2-git-send-email-vedang.patel@intel.com>
References: <1561500439-30276-1-git-send-email-vedang.patel@intel.com>
 <1561500439-30276-2-git-send-email-vedang.patel@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B546C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Patel, Vedang
> Sent: Tuesday, June 25, 2019 3:07 PM
> To: netdev at vger.kernel.org
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net;
> jhs at mojatatu.com; xiyou.wangcong at gmail.com; jiri at resnulli.us; intel-wired-
> lan at lists.osuosl.org; Gomes, Vinicius <vinicius.gomes@intel.com>;
> l at dorileo.org; jakub.kicinski at netronome.com; m-karicheri2 at ti.com;
> sergei.shtylyov at cogentembedded.com; eric.dumazet at gmail.com; Brown,
> Aaron F <aaron.f.brown@intel.com>; Patel, Vedang <vedang.patel@intel.com>
> Subject: [PATCH net-next v6 1/8] igb: clear out skb->tstamp after reading the
> txtime
> 
> If a packet which is utilizing the launchtime feature (via SO_TXTIME socket
> option) also requests the hardware transmit timestamp, the hardware
> timestamp is not delivered to the userspace. This is because the value in
> skb->tstamp is mistaken as the software timestamp.
> 
> Applications, like ptp4l, request a hardware timestamp by setting the
> SOF_TIMESTAMPING_TX_HARDWARE socket option. Whenever a new
> timestamp is
> detected by the driver (this work is done in igb_ptp_tx_work() which calls
> igb_ptp_tx_hwtstamps() in igb_ptp.c[1]), it will queue the timestamp in the
> ERR_QUEUE for the userspace to read. When the userspace is ready, it will
> issue a recvmsg() call to collect this timestamp.  The problem is in this
> recvmsg() call. If the skb->tstamp is not cleared out, it will be
> interpreted as a software timestamp and the hardware tx timestamp will not
> be successfully sent to the userspace. Look at skb_is_swtx_tstamp() and the
> callee function __sock_recv_timestamp() in net/socket.c for more details.
> 
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

