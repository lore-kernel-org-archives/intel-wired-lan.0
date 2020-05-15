From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:46:50 +0000
Subject: [Intel-wired-lan] [PATCH S41 11/15] ice: Fix check for
 removing/adding mac filters
In-Reply-To: <20200508004113.39725-11-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-11-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB16592C08453F7FE06753971A8CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 11/15] ice: Fix check for
> removing/adding mac filters
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> In function ice_set_mac_address, we will remove old dev_addr before
> adding the new MAC. In the removing and adding process of the MAC, there
> is no need to return error if the check finds the to-be-removed dev_addr
> does not exist in the MAC filter list or the to-be-added mac already exists,
> keep going or return success accordingly.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


