From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 13 Jul 2021 19:44:09 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Increase timeout value for
 Speed 100/1000/2500
In-Reply-To: <20210709234516.24753-1-muhammad.husaini.zulkifli@intel.com>
References: <20210709234516.24753-1-muhammad.husaini.zulkifli@intel.com>
Message-ID: <76e834f4-195d-3623-0468-3a84daf19ba7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/10/2021 02:45, Muhammad Husaini Zulkifli wrote:
> As the cycle time is set to maximum of 1s, the TX Hang timeout need to
> be increase to avoid possible TX Hangs caused by using long Qbv cycles.
>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index c8abd7fb70e5..99fb5641297d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -5322,7 +5322,9 @@ static void igc_watchdog_task(struct work_struct *work)
>   				adapter->tx_timeout_factor = 14;
>   				break;
>   			case SPEED_100:
> -				/* maybe add some timeout factor ? */
> +			case SPEED_1000:
> +			case SPEED_2500:
> +				adapter->tx_timeout_factor = 7;
>   				break;
>   			}
>   

Acked-by: Sasha Neftin <sasha.neftin@intel.com>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210713/c45a2a80/attachment.html>
