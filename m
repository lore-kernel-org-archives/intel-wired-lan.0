From: Bjorn Helgaas <helgaas@kernel.org>
Date: Wed, 2 Dec 2020 14:12:46 -0600
Subject: [Intel-wired-lan] [PATCH v2 4/5] e1000e: Add more Dell CML
 systems into s0ix heuristics
In-Reply-To: <20201202161748.128938-5-mario.limonciello@dell.com>
Message-ID: <20201202201246.GA1467134@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

s/s0ix/S0ix/ in subject.

On Wed, Dec 02, 2020 at 10:17:47AM -0600, Mario Limonciello wrote:
> These comet lake systems are not yet released, but have been validated
> on pre-release hardware.

s/comet lake/Comet Lake/ to match previous usage in patch 3/5.

> This is being submitted separately from released hardware in case of
> a regression between pre-release and release hardware so this commit
> can be reverted alone.
> 
> Tested-by: Yijun Shen <yijun.shen@dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/net/ethernet/intel/e1000e/s0ix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/s0ix.c b/drivers/net/ethernet/intel/e1000e/s0ix.c
> index 74043e80c32f..0dd2e2702ebb 100644
> --- a/drivers/net/ethernet/intel/e1000e/s0ix.c
> +++ b/drivers/net/ethernet/intel/e1000e/s0ix.c
> @@ -60,6 +60,9 @@ static bool e1000e_check_subsystem_allowlist(struct pci_dev *dev)
>  		case 0x09c2: /* Precision 3551 */
>  		case 0x09c3: /* Precision 7550 */
>  		case 0x09c4: /* Precision 7750 */
> +		case 0x0a40: /* Notebook 0x0a40 */
> +		case 0x0a41: /* Notebook 0x0a41 */
> +		case 0x0a42: /* Notebook 0x0a42 */
>  			return true;
>  		}
>  	}
> -- 
> 2.25.1
> 
