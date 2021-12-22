From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 10:40:13 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix incorrect netdev's
 real number of RX/TX queues
In-Reply-To: <20211217142905.41053-1-jedrzej.jagielski@intel.com>
References: <20211217142905.41053-1-jedrzej.jagielski@intel.com>
Message-ID: <BYAPR11MB3367D8978C93AFFC27A64BAFFC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Friday, December 17, 2021 7:59 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Cieplicki, LukaszX <lukaszx.cieplicki@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v3] i40e: Fix incorrect netdev's real
> number of RX/TX queues
> 
> There was a wrong queues representation in sysfs during driver's
> reinitialization in case of online cpus number is less than combined queues. It
> was caused by stopped NetworkManager, which is responsible for calling
> vsi_open function during driver's initialization.
> In specific situation (ex. 12 cpus online) there were 16 queues in
> /sys/class/net/<iface>/queues. In case of modifying queues with value higher,
> than number of online cpus, then it caused write errors and other errors.
> Add updating of sysfs's queues representation during driver initialization.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Lukasz Cieplicki <lukaszx.cieplicki@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2:Fix "CHECK: Lines should not end with a '('" warning v3:Add error check and
> make i40e_vsi_open() to use new function
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 35 ++++++++++++++++-----
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
