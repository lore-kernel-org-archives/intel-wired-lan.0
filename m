From: Patel, Vedang <vedang.patel@intel.com>
Date: Wed, 10 Feb 2021 17:50:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v5 9/9] igc: Add support for
 XDP_REDIRECT action
In-Reply-To: <8c6e414e03c2bdd01916ee63f6912df3b24e86fa.camel@intel.com>
References: <20210209024141.23298-1-vedang.patel@intel.com>
 <20210209024141.23298-10-vedang.patel@intel.com>
 <8c6e414e03c2bdd01916ee63f6912df3b24e86fa.camel@intel.com>
Message-ID: <CE2BD7EB-B2A0-42AA-BA29-59130804C121@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> On Feb 9, 2021, at 5:47 PM, Nguyen, Anthony L <anthony.l.nguyen@intel.com> wrote:
> 
> On Mon, 2021-02-08 at 18:41 -0800, Vedang Patel wrote:
>> From: Andre Guedes <andre.guedes@intel.com>
>> 
>> This patch adds support for the XDP_REDIRECT action which enables XDP
>> programs to redirect packets arriving at I225 NIC. It also implements
>> the ndo_xdp_xmit ops, enabling the igc driver to transmit packets
>> forwarded to it by xdp programs running on other interfaces.
>> 
>> The patch tweaks the driver's page counting scheme (as described in
>> '8ce29c679a6e i40e: tweak page counting for XDP_REDIRECT' and
>> implemented by other Intel drivers) in order to properly support
>> XDP_REDIRECT action.
>> 
>> This patch has been tested with the sample apps "xdp_redirect_cpu"
>> and
>> "xdp_redirect_map" located in samples/bpf/.
>> 
>> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
>> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
>> ---
>> drivers/net/ethernet/intel/igc/igc_main.c | 59
>> +++++++++++++++++++++--
>> 1 file changed, 56 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index d34d35789e2e..8bb1f8a54368 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -26,6 +26,7 @@
>> #define IGC_XDP_PASS		0
>> #define IGC_XDP_CONSUMED	BIT(0)
>> #define IGC_XDP_TX		BIT(1)
>> +#define IGC_XDP_REDIRECT	BIT(2)
>> 
>> static int debug = -1;
>> 
>> @@ -1708,8 +1709,8 @@ static bool igc_can_reuse_rx_page(struct
>> igc_rx_buffer *rx_buffer)
>> 	 * the pagecnt_bias and page count so that we fully restock the
>> 	 * number of references the driver holds.
>> 	 */
>> -	if (unlikely(!pagecnt_bias)) {
>> -		page_ref_add(page, USHRT_MAX);
>> +	if (unlikely(pagecnt_bias == 1)) {
>> +		page_ref_add(page, USHRT_MAX - 1);
>> 		rx_buffer->pagecnt_bias = USHRT_MAX;
>> 	}
> 
> All of our drivers have needed this fix[1]. I suspect this will need it
> as well.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-
> next.git/commit/?id=75aab4e10ae6a4593a60f66d13de755d4e91f400
I am taking a look at this. I will send out the updated version today.

Thanks,
Vedang
