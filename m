From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:58:35 +0000
Subject: [Intel-wired-lan] [PATCH S51 10/13] ice: Disable VLAN pruning
 in promiscuous mode
In-Reply-To: <20200730001922.52568-10-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-10-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145837D452D65535EA2AB7F8C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 10/13] ice: Disable VLAN pruning in
> promiscuous mode
> 
> From: Nick Nunley <nicholas.d.nunley@intel.com>
> 
> Disable VLAN pruning when entering promiscuous mode, and re-enable it
> when exiting.
> 
> Without this VLAN-over-bridge topologies created on the device won't be
> functional unless rx-vlan-filter is explicitly disabled with ethtool.
> 
> Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 7 +++++++
> drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
>  2 files changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


