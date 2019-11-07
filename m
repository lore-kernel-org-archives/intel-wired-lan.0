From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 07 Nov 2019 14:52:17 -0800
Subject: [Intel-wired-lan] [PATCH net-next 1/2] net: ethernet: intel:
 Demote MTU change prints to debug
In-Reply-To: <20191107223537.23440-2-f.fainelli@gmail.com>
References: <20191107223537.23440-1-f.fainelli@gmail.com>
 <20191107223537.23440-2-f.fainelli@gmail.com>
Message-ID: <6784fee2096c9bb103b8e0b8eb50cc1d9e494ad1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-11-07 at 14:35 -0800, Florian Fainelli wrote:
> Changing a network device MTU can be a fairly frequent operation, and
> failure to change the MTU is reflected to user-space properly, both by
> an appropriate message as well as by looking at whether the device's MTU
> matches the configuration.
> 
> Demote the prints to debug prints by using netdev_dbg(), making all
> Intel wired LAN drivers consistent, since they used a mixture of PCI
> device and network device prints before.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 4 ++--
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c     | 5 ++---
>  drivers/net/ethernet/intel/igbvf/netdev.c     | 4 ++--
>  drivers/net/ethernet/intel/igc/igc_main.c     | 5 ++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>  7 files changed, 14 insertions(+), 14 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191107/ff1f8d3a/attachment.asc>
