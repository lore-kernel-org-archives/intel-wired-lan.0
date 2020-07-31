From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 19:57:22 +0000
Subject: [Intel-wired-lan] [PATCH S51 02/13] ice: fix the vsi_id mask to
 be 10 bit for set_rss_lut
In-Reply-To: <20200730001922.52568-2-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-2-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145CABD68FB06B9D6A84E168C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S51 02/13] ice: fix the vsi_id mask to be 10
> bit for set_rss_lut
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> set_rss_lut failed due to incorrect vsi_id mask. vsi_id is 10 bit but mask was
> 0x1FF whereas it should be 0x3FF.
> 
> For vsi_num >= 512, FW set_rss_lut has been failing with return code
> EACCESS (VSI ownership issue) because software was providing incorrect
> vsi_num (dropping 10th bit due to incorrect mask) for set_rss_lut admin
> command
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


