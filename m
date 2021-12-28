From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Tue, 28 Dec 2021 10:31:03 +0200
Subject: [Intel-wired-lan] [PATCH net v3] igc: Fix TX timestamp support
 for non-MSI-X platforms
In-Reply-To: <20211217234933.740942-1-james.mclaughlin@qsc.com>
References: <20211217234933.740942-1-james.mclaughlin@qsc.com>
Message-ID: <b9fdc714-ce83-23fc-cde4-b53e02565ae3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/18/2021 01:49, James McLaughlin wrote:
> Time synchronization was not properly enabled on non-MSI-X platforms.
> 
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> 
> Signed-off-by: James McLaughlin <james.mclaughlin@qsc.com>
> Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> 
> Still same work email client issues.  Apologies, mis-titled it again.
> v2->v3 fixed title
> 
>   drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

