From: Kaliszczuk, Leszek <leszek.kaliszczuk@intel.com>
Date: Mon, 22 Nov 2021 10:12:28 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next] ice: Simplify tracking
 status of RDMA support
In-Reply-To: <20211005141446.33609-1-david.m.ertman@intel.com>
References: <20211005141446.33609-1-david.m.ertman@intel.com>
Message-ID: <BYAPR11MB2727D9D9F2D9ECB2660246E5EE9F9@BYAPR11MB2727.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Ertman, David M <david.m.ertman@intel.com>
> Sent: Tuesday, October 5, 2021 4:15 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Subject: [PATCH v2 net-next] ice: Simplify tracking status of RDMA support
> 
> The status of support for RDMA is currently being tracked with two separate status
> flags.  This is unnecessary with the current state of the driver.
> 
> Simplify status tracking down to a single flag.
> 
> Rename the helper function to denote the RDMA specific status and universally use
> the helper function to test the status bit.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ----
> v2: change helper function to ice_is_rdma_ena.
>     universally use helper function.
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  3 ---
>  drivers/net/ethernet/intel/ice/ice_idc.c  |  6 +++---
> drivers/net/ethernet/intel/ice/ice_lib.c  |  8 ++++----
> drivers/net/ethernet/intel/ice/ice_lib.h  |  2 +-
> drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++--------
>  5 files changed, 13 insertions(+), 19 deletions(-)
> 

Tested-by: Leszek Kaliszczuk <leszek.kaliszczuk@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

