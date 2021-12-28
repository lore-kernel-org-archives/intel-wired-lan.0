From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Tue, 28 Dec 2021 09:47:13 +0200
Subject: [Intel-wired-lan] [PATCH] igc: updated TX timestamp support for
 non-MSI-X platforms
In-Reply-To: <20211217205209.723782-1-james.mclaughlin@qsc.com>
References: <20211217205209.723782-1-james.mclaughlin@qsc.com>
Message-ID: <d7d50687-2bee-c540-a7c1-46a6952c0d32@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/17/2021 22:52, James McLaughlin wrote:
> Time synchronization was not properly enabled on non-MSI-X platforms.
> 
> Signed-off-by: James McLaughlin <james.mclaughlin@qsc.com>
> Reviewed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

