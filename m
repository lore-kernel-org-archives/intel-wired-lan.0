From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 21 Jun 2021 22:12:03 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: do not abort devlink info if
 PBA can't be found
In-Reply-To: <20210615201420.2001937-1-jacob.e.keller@intel.com>
References: <20210615201420.2001937-1-jacob.e.keller@intel.com>
Message-ID: <SJ0PR11MB5662931B7D5F0E3C1A628D4AFA0A9@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Tuesday, June 15, 2021 1:14 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH net] ice: do not abort devlink info if PBA
> can't be found
> 
> The devlink dev info command reports version information about the device
> and firmware running on the board. This includes the "board.id"
> field which is supposed to represent an identifier of the board design.
> The ice driver uses the Product Board Assembly identifier for this.
> 
> In some cases, the PBA is not present in the NVM. If this happens, devlink
> dev info will fail with an error. Instead, modify the ice_info_pba function to
> just exit without filling in the context buffer. This will cause the board.id field
> to be skipped. Log a dev_dbg message in case someone wants to confirm
> why board.id is not showing up for them.
> 
> While at it, notice that none of the getter/fallback() functions report an error
> anymore. Convert the interface to a void so that it is no longer possible to
> add a version field that is fatal. This makes sense, because we should not fail
> to report other versions just because one of the version pieces could not be
> found.
> 
> Finally, clean up the getter functions line wrapping so that none of them take
> more than 80 columns, as is the usual style for networking files.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 137 +++++++------------
>  1 file changed, 53 insertions(+), 84 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


