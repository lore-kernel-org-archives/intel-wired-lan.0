From: Jurkowski, Jerzy Wiktor <jerzy.wiktor.jurkowski@intel.com>
Date: Wed, 29 Sep 2021 21:22:28 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix failure to re-add LAN/RDMA
 Tx queues
In-Reply-To: <20210628175345.50764-1-brett.creeley@intel.com>
References: <20210628175345.50764-1-brett.creeley@intel.com>
Message-ID: <DM4PR11MB5389FAFB237B50BF9FC8F2F2C2A99@DM4PR11MB5389.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Creeley, Brett
> Sent: Monday, June 28, 2021 7:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: Fix failure to re-add LAN/RDMA Tx
> queues
> 
> Currently if the VSI is rebuilt/removed and the RDMA PF driver is active the
> RDMA Tx queue scheduler node configuration will not be cleaned up.
> This will cause the rebuild/re-add of the VSI to fail due to the software
> structures not being correctly cleaned up for the VSI index.
> Fix this by always calling ice_rm_vsi_rdma_cfg() for all VSI. If there are no
> RDMA scheduler nodes created, then there is no harm in calling
> ice_rm_vsi_rdma_cfg(). This change applies to all VSI types, so if RDMA
> support is added for other VSI types they will also get this change.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c   |  9 +++++++++
>  drivers/net/ethernet/intel/ice/ice_sched.c | 13 +++++++++++++
> drivers/net/ethernet/intel/ice/ice_sched.h |  1 +
>  3 files changed, 23 insertions(+)
> 
Tested-by: Jerzy Wiktor Jurkowski <jerzy.wiktor.jurkowski@intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
