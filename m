From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 May 2020 20:26:39 +0000
Subject: [Intel-wired-lan] [PATCH S44 13/14] ice: fix kernel BUG if
 register_netdev fails
In-Reply-To: <20200516004226.4795-13-anthony.l.nguyen@intel.com>
References: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
 <20200516004226.4795-13-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16593DDF91B939D2FDCADE668CB00@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:42 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S44 13/14] ice: fix kernel BUG if
> register_netdev fails
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> If register_netdev() fails, the driver will attempt to cleanup the q_vectors
> and inadvertently trigger a kernel BUG due to a NULL pointer dereference.
> 
> This occurs because cleaning up q_vectors attempts to call netif_napi_del on
> napi_structs which were never initialized.
> 
> Resolve this by releasing the netdev in ice_cfg_netdev and setting
> vsi->netdev to NULL. This ensures that after ice_cfg_netdev fails the
> state is rewound to match as if ice_cfg_netdev was never called.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


