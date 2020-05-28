From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:43:25 +0000
Subject: [Intel-wired-lan] [PATCH S45 11/15] ice: allow host to clear
 administratively set VF MAC
In-Reply-To: <20200516005121.4963-11-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-11-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16599ACCED4E7DA70290CC178C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S45 11/15] ice: allow host to clear
> administratively set VF MAC
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently a user is not allowed to clear a VF's administratively set MAC on the
> PF. Fix this by allowing an all zero MAC address via "ip link set ${pf_eth} vf
> ${vf_id} mac 00:00:00:00:00:00".
> 
> An example use case for this would be issuing a "virsh shutdown"
> command on a VM. The call to iproute mentioned above is part of this flow.
> Without this change the driver incorrectly rejects clearing the VF's
> administratively set MAC and prints unhelpful log messages.
> 
> Also, improve the comments surrounding this change.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


