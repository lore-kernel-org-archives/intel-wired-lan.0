From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 5 Aug 2021 06:45:32 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: don't remove
 netdev->dev_addr from uc sync list
In-Reply-To: <20210728203457.325482-1-brett.creeley@intel.com>
References: <20210728203457.325482-1-brett.creeley@intel.com>
Message-ID: <BYAPR11MB3367123D052CB0235EDB8B4FFCF29@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Brett Creeley
> Sent: Thursday, July 29, 2021 2:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ice: don't remove netdev->dev_addr
> from uc sync list
> 
> In some circumstances, such as with bridging, it's possible that the stack will
> add the device's own MAC address to its unicast address list.
> 
> If, later, the stack deletes this address, the driver will receive a request to
> remove this address.
> 
> The driver stores its current MAC address as part of the VSI MAC filter list
> instead of separately. So, this causes a problem when the device's MAC
> address is deleted unexpectedly, which results in traffic failure in some
> cases.
> 
> Fix this by making sure to not delete the netdev->dev_addr during MAC
> address sync.
> 
> There is a possibility of a race condition between .set_mac and
> .set_rx_mode. Fix this by calling netif_addr_lock_bh() and
> netif_addr_unlock_bh() on the device's netdev when the netdev->dev_addr
> is going to be updated in .set_mac.
> 
> Also, change the netdev_warn() to netdev_dbg() when the device is already
> using the requested mac in .set_mac. The dev_warn() was causing a lot of
> unnecessary noise when configuring/unconfiguring bridging and provides no
> benefit.
> 
> Lastly, instead of using memcpy() to save the netdev->dev_addr, use
> ether_addr_copy() in .set_mac.
> 
> Fixes: e94d44786693 ("ice: Implement filter sync, NDO operations and bump
> version")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 25 +++++++++++++++--------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 

Tested-by: Gurucharan  G <Gurucharanx.g@intel.com> (A Contingent Worker at Intel)
