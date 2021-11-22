From: Kaliszczuk, Leszek <leszek.kaliszczuk@intel.com>
Date: Mon, 22 Nov 2021 10:10:07 +0000
Subject: [Intel-wired-lan] [net-next 2/3] net/ice: Add support for
 enable_iwarp and enable_roce devlink param
In-Reply-To: <20211018231603.1690-3-shiraz.saleem@intel.com>
References: <20211018231603.1690-1-shiraz.saleem@intel.com>
 <20211018231603.1690-3-shiraz.saleem@intel.com>
Message-ID: <BYAPR11MB272768549B7804453234F1B8EE9F9@BYAPR11MB2727.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Saleem,
> Shiraz
> Sent: Tuesday, October 19, 2021 1:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [net-next 2/3] net/ice: Add support for enable_iwarp and
> enable_roce devlink param
> 
> Allow support for 'enable_iwarp' and 'enable_roce' devlink params to turn on/off
> iWARP or RoCE protocol support for E800 devices.
> 
> For example, a user can turn on iWARP functionality with,
> 
> devlink dev param set pci/0000:07:00.0 name enable_iwarp value true cmode
> runtime
> 
> This add an iWARP auxiliary rdma device, ice.iwarp.<>, under this PF.
> 
> A user request to enable both iWARP and RoCE under the same PF is rejected since
> this device does not support both protocols simultaneously on the same port.
> 
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |   1 +
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 144
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_devlink.h |   6 ++
>  drivers/net/ethernet/intel/ice/ice_idc.c     |   4 +-
>  drivers/net/ethernet/intel/ice/ice_main.c    |   9 +-
>  include/linux/net/intel/iidc.h               |   7 +-
>  6 files changed, 166 insertions(+), 5 deletions(-)
> 

Tested-by: Leszek Kaliszczuk <leszek.kaliszczuk@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

