From: Guedes, Andre <andre.guedes@intel.com>
Date: Fri, 10 Nov 2017 22:40:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next] igb: Clarify idleslope
 config constraints
In-Reply-To: <20171110222150.17754-1-jesus.sanchez-palencia@intel.com>
References: <20171110222150.17754-1-jesus.sanchez-palencia@intel.com>
Message-ID: <1510353629.3543.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Reviewed-by:?Andre Guedes <andre.guedes@intel.com>

On Fri, 2017-11-10 at 14:21 -0800, Jesus Sanchez-Palencia wrote:
> By design, the idleslope increments are restricted to 16.384kbps steps.
> Add a comment to igb_main.c making that explicit and add one example
> that illustrates the impact of that.
> 
> Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
> ---
> ?drivers/net/ethernet/intel/igb/igb_main.c | 14 ++++++++++++++
> ?1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 43cf39527660..d56c998f3f14 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1744,6 +1744,20 @@ static void igb_configure_cbs(struct igb_adapter
> *adapter, int queue,
> ?		?*?????value = idleSlope * 61034
> ?		?*?????????????--------------
> ---??????????????????????????(E6)
> ?		?*??????????????????1000000
> +		?*
> +		?* NOTE: For i210, given the above, we can see that
> idleslope
> +		?*???????is represented in 16.38431 kbps units by the value
> at
> +		?*???????the TQAVCC register (1Gbps / 61034), which reduces
> +		?*???????the granularity for idleslope increments.
> +		?*???????For instance, if you want to configure a 2576kbps
> +		?*???????idleslope, the value to be written on the register
> +		?*???????would have to be 157.23. If rounded down, you end
> +		?*???????up with less bandwidth available than originally
> +		?*???????required (~2572 kbps). If rounded up, you end up
> +		?*???????with a higher bandwidth (~2589 kbps). Below the
> +		?*???????approach we take is to always round up the
> +		?*???????calculated value, so the resulting bandwidth might
> +		?*???????be slightly higher for some configurations.
> ?		?*/
> ?		value = DIV_ROUND_UP_ULL(idleslope * 61034ULL, 1000000);
> ?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3262 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171110/bf3b55bd/attachment-0001.bin>
