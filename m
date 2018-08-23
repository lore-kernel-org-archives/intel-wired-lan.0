From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Aug 2018 22:23:16 +0000
Subject: [Intel-wired-lan] [PATCH v1 net-next] igb: Use an advanced ctx
 descriptor for launchtime
In-Reply-To: <20180726172038.11330-1-jesus.sanchez-palencia@intel.com>
References: <20180726172038.11330-1-jesus.sanchez-palencia@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96550278@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jesus Sanchez-Palencia
> Sent: Thursday, July 26, 2018 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sanchez-Palencia, Jesus <jesus.sanchez-
> palencia at intel.com>
> Subject: [Intel-wired-lan] [PATCH v1 net-next] igb: Use an advanced ctx
> descriptor for launchtime
> 
> On i210, Launchtime (TxTime) requires the usage of an "Advanced
> Transmit Context Descriptor" for retrieving the timestamp of a packet.
> 
> The igb driver correctly builds such descriptor on the segmentation
> flow (i.e. igb_tso()) or on the checksum one (i.e. igb_tx_csum()), but the
> feature is broken for AF_PACKET if the IGB_TX_FLAGS_VLAN is not set,
> which happens due to an early return on igb_tx_csum().
> 
> This flag is only set by the kernel when a VLAN interface is used,
> thus we can't just rely on it. Here we are fixing this issue by checking
> if launchtime is enabled for the current tx_ring before performing the
> early return.
> 
> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
