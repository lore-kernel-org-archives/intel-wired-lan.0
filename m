From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Wed, 2 Mar 2022 05:49:17 +0000
Subject: [Intel-wired-lan] [PATCH intel-net] ixgbe: xsk: change
 !netif_carrier_ok() handling in ixgbe_xmit_zc()
In-Reply-To: <20220203125803.19407-1-maciej.fijalkowski@intel.com>
References: <20220203125803.19407-1-maciej.fijalkowski@intel.com>
Message-ID: <MW3PR11MB45547E1C71573E66FEE94F409C039@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Maciej Fijalkowski
>Sent: Thursday, February 3, 2022 6:28 PM
To: intel-wired-lan@lists.osuosl.org
>Cc: Maurice Baijens <maurice.baijens@ellips.com>; netdev at vger.kernel.org;
>kuba at kernel.org; bpf at vger.kernel.org; davem at davemloft.net; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH intel-net] ixgbe: xsk: change
>!netif_carrier_ok() handling in ixgbe_xmit_zc()
>
>Commit c685c69fba71 ("ixgbe: don't do any AF_XDP zero-copy transmit if netif
>is not OK") addressed the ring transient state when
>MEM_TYPE_XSK_BUFF_POOL was being configured which in turn caused the
>interface to through down/up. Maurice reported that when carrier is not ok
>and xsk_pool is present on ring pair, ksoftirqd will consume 100% CPU cycles
>due to the constant NAPI rescheduling as ixgbe_poll() states that there is still
>some work to be done.
>
>To fix this, do not set work_done to false for a !netif_carrier_ok().
>
>Fixes: c685c69fba71 ("ixgbe: don't do any AF_XDP zero-copy transmit if netif is
>not OK")
>Reported-by: Maurice Baijens <maurice.baijens@ellips.com>
>Tested-by: Maurice Baijens <maurice.baijens@ellips.com>
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
