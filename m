From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Mon, 27 Dec 2021 22:38:38 +0200
Subject: [Intel-wired-lan] [PATCH v2] igc: Fix TX timestamp support for
 non-MSI-X platforms
In-Reply-To: <20211217234310.740255-1-james.mclaughlin@qsc.com>
References: <20211217234310.740255-1-james.mclaughlin@qsc.com>
Message-ID: <1d2b0af5-540c-df14-2f78-9698f7055e5a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/18/2021 01:43, James McLaughlin wrote:
> Time synchronization was not properly enabled on non-MSI-X platforms.
> 
> Fixes: 2c344ae24501 ("igc: Add support for TX timestamping")
> 
> Signed-off-by: James McLaughlin <james.mclaughlin@qsc.com>
> Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
> 
> Having trouble with work email client, understand and agree with comments from Vinicius.
> v1->v2 updated commit message, email subject, and reference original commit this is fixing.
> 
>   drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

