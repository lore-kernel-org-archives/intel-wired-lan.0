From: Kaliszczuk, Leszek <leszek.kaliszczuk@intel.com>
Date: Mon, 22 Nov 2021 09:58:53 +0000
Subject: [Intel-wired-lan] [net-next 1/3] devlink: Add 'enable_iwarp'
 generic device param
In-Reply-To: <20211018231603.1690-2-shiraz.saleem@intel.com>
References: <20211018231603.1690-1-shiraz.saleem@intel.com>
 <20211018231603.1690-2-shiraz.saleem@intel.com>
Message-ID: <BYAPR11MB2727B6F343B89C65CFC3C795EE9F9@BYAPR11MB2727.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Saleem, Shiraz
> Sent: Tuesday, October 19, 2021 1:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [net-next 1/3] devlink: Add 'enable_iwarp' generic
> device param
> 
> Add a new device generic parameter to enable and disable iWARP functionality
> on a multi-protocol RDMA device.
> 
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  Documentation/networking/devlink/devlink-params.rst | 3 +++
>  include/net/devlink.h                               | 4 ++++
>  net/core/devlink.c                                  | 5 +++++
>  3 files changed, 12 insertions(+)
> 

Tested-by: Leszek Kaliszczuk <leszek.kaliszczuk@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

