From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 20 Jun 2019 17:56:28 -0400
Subject: [Intel-wired-lan] [PATCH net-next v4 1/7] igb: clear out tstamp
 after sending the packet
In-Reply-To: <D1A9515C-D317-40F3-81A2-451F7228A853@intel.com>
References: <1560966016-28254-1-git-send-email-vedang.patel@intel.com>
 <1560966016-28254-2-git-send-email-vedang.patel@intel.com>
 <d6655497-5246-c24e-de35-fc6acdad0bf1@gmail.com>
 <A1A5CF42-A7D4-4DC4-9D57-ED0340B04A6F@intel.com>
 <99e834ed-1c78-d35c-84dc-511d377284a1@gmail.com>
 <D1A9515C-D317-40F3-81A2-451F7228A853@intel.com>
Message-ID: <799b2d75-a60d-4d93-b8d7-c29442b73dce@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 6/20/19 1:32 PM, Patel, Vedang wrote:
> 

> Ahh.. that?s clearly a false statement. Skb->tstamp is cleared so
> that it is not interpreted as a software timestamp when trying to
> send the Hardware TX timestamp to the userspace. I will rephrase the
> commit message in the next version.
> 
> Some more details: The problem occurs when using the txtime-assist
> mode of taprio with packets which also request the hardware transmit
> timestamp (e.g. PTP packets). Whenever txtime-assist mode is set,
> taprio will assign a hardware transmit timestamp to all the packets
> (in skb->tstamp). PTP packets will also request the hardware transmit
> timestamp be sent to the userspace after packet is transmitted.
> 
> Whenever a new timestamp is detected by the driver (this work is done
> in igb_ptp_tx_work() which calls igb_ptp_tx_hwtstamps() in
> igb_ptp.c[1]), it will queue the timestamp in the ERR_QUEUE for the
> userspace to read. When the userspace is ready, it will issue a
> recvmsg() call to collect this timestamp. The problem is in this
> recvmsg() call. If the skb->tstamp is not cleared out, it will be
> interpreted as a software timestamp and the hardware tx timestamp
> will not be successfully sent to the userspace. Look at
> skb_is_swtx_tstamp() and the callee function __sock_recv_timestamp()
> in net/socket.c for more details.


That amount of details in the changelog would be really nice ;)


