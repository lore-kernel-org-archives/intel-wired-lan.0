From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Tue, 2 Nov 2021 00:47:00 +0000
Subject: [Intel-wired-lan] [PATCH net-next 12/15] iavf: Log info when VF
 is entering and leaving Allmulti mode
In-Reply-To: <20210604165335.33329-12-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-12-anthony.l.nguyen@intel.com>
Message-ID: <PH0PR11MB51449D36431D590BE0A679D9E28B9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Nguyen,
> Anthony L
> Sent: Friday, June 4, 2021 9:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 12/15] iavf: Log info when VF is entering
> and leaving Allmulti mode
> 
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> 
> Add log when VF is entering and leaving Allmulti mode.
> The change of VF state is visible in dmesg now.
> Without this commit, entering and leaving Allmulti mode is not logged in dmesg.
> 
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  
