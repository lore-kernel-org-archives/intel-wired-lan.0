From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 14 Jan 2021 09:57:28 +0000
Subject: [Intel-wired-lan] [net-next] net: iavf: Use the ARRAY_SIZE
 macro for aq_to_posix
In-Reply-To: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
References: <1599641471-204919-1-git-send-email-xuwei5@hisilicon.com>
Message-ID: <CY4PR11MB15769D5697074F230C8742CAABA80@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wei Xu
> Sent: ?roda, 9 wrze?nia 2020 10:51
> To: netdev at vger.kernel.org
> Cc: salil.mehta at huawei.com; jinying at hisilicon.com;
> tangkunshan at huawei.com; huangdaode at hisilicon.com;
> john.garry at huawei.com; linux-kernel at vger.kernel.org;
> linuxarm at huawei.com; shameerali.kolothum.thodi at huawei.com;
> zhangyi.ac at huawei.com; intel-wired-lan at lists.osuosl.org;
> xuwei5 at hisilicon.com; jonathan.cameron at huawei.com; Jakub Kicinski
> <kuba@kernel.org>; liguozhu at hisilicon.com; davem at davemloft.net;
> shiju.jose at huawei.com
> Subject: [Intel-wired-lan] [net-next] net: iavf: Use the ARRAY_SIZE macro for
> aq_to_posix
> 
> Use the ARRAY_SIZE macro to calculate the size of an array.
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_adminq.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> index baf2fe2..eead12c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> @@ -120,7 +120,7 @@ static inline int iavf_aq_rc_to_posix(int aq_ret, int
> aq_rc)
>  	if (aq_ret == IAVF_ERR_ADMIN_QUEUE_TIMEOUT)
>  		return -EAGAIN;
> 
> -	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
> +	if (!((u32)aq_rc < ARRAY_SIZE(aq_to_posix)))
>  		return -ERANGE;
> 
>  	return aq_to_posix[aq_rc];

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
 

