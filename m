From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 21 Jun 2019 01:50:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 1/6] igb: clear out tstamp
 after sending the packet.
In-Reply-To: <1560799870-18956-2-git-send-email-vedang.patel@intel.com>
References: <1560799870-18956-1-git-send-email-vedang.patel@intel.com>
 <1560799870-18956-2-git-send-email-vedang.patel@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970B1283@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-06-17 at 12:31 -0700, Vedang Patel wrote:
> skb->tstamp is being used at multiple places. On the transmit side, it
> is used to determine the launchtime of the packet. It is also used to
> determine the software timestamp after the packet has been transmitted.
> 
> So, clear out the tstamp value after it has been read so that we do not
> report false software timestamp on the receive side.
> 
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
