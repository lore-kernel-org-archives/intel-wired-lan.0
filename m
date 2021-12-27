From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Mon, 27 Dec 2021 22:35:31 +0200
Subject: [Intel-wired-lan] [PATCH net v1] igc: Do not enable
 crosstimestamping for i225-V models
In-Reply-To: <20211214003949.666642-1-vinicius.gomes@intel.com>
References: <87wnk8qrt8.fsf@intel.com>
 <20211214003949.666642-1-vinicius.gomes@intel.com>
Message-ID: <30f0321d-14de-e2b8-26b3-c0ed3b01f5de@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/14/2021 02:39, Vinicius Costa Gomes wrote:
> It was reported that when PCIe PTM is enabled, some lockups could
> be observed with some integrated i225-V models.
> 
> While the issue is investigated, we can disable crosstimestamp for
> those models and see no loss of functionality, because those models
> don't have any support for time synchronization.
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Link: https://lore.kernel.org/all/924175a188159f4e03bd69908a91e606b574139b.camel at gmx.de/
> Reported-by: Stefan Dietrich <roots@gmx.de>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_ptp.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

