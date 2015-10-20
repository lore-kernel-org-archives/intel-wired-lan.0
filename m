From: Nicholas Krause <xerofoify@gmail.com>
Date: Tue, 20 Oct 2015 19:25:35 -0400
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the
	function	fm10k_setup_tc
In-Reply-To: <6C4F5FD8-58B6-4A4D-8EAF-A02C3DB64560@intel.com>
References: <1445375114-13378-1-git-send-email-xerofoify@gmail.com>
 <6C4F5FD8-58B6-4A4D-8EAF-A02C3DB64560@intel.com>
Message-ID: <1F6ACC54-8E1F-4F64-A6FF-08877AA36420@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On October 20, 2015 7:11:51 PM EDT, "Rustad, Mark D" <mark.d.rustad@intel.com> wrote:
>Nicholas Krause <xerofoify@gmail.com> wrote:
>
>> This fixes error handling in the function fm10k_setup_tc to properly
>> check if the call to the function fm10k_open has failed by returning
>> a error and if so return immediately to the caller of the function
>> fm10k_setup_tc to properly signal this non recoverable failure.
>> 
>> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
>> ---
>> drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>> index 99228bf..5a4e702 100644
>> --- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
>> @@ -1146,6 +1146,7 @@ static struct rtnl_link_stats64
>*fm10k_get_stats64(struct net_device *netdev,
>> int fm10k_setup_tc(struct net_device *dev, u8 tc)
>> {
>> 	struct fm10k_intfc *interface = netdev_priv(dev);
>> +	int err;
>> 
>> 	/* Currently only the PF supports priority classes */
>> 	if (tc && (interface->hw.mac.type != fm10k_mac_pf))
>> @@ -1175,7 +1176,9 @@ int fm10k_setup_tc(struct net_device *dev, u8
>tc)
>> 	fm10k_mbx_request_irq(interface);
>> 
>> 	if (netif_running(dev))
>> -		fm10k_open(dev);
>> +		err = fm10k_open(dev);
>> +	if (err)
>> +		return err;
>> 
>> 	/* flag to indicate SWPRI has yet to be updated */
>> 	interface->flags |= FM10K_FLAG_SWPRI_CONFIG;
>
>NAK. This will reference an uninitialized err variable when
>netif_running returns false. The compiler should complain about this,
>suggesting that it wasn't compiled.
>
>--
I compiled it but my compiler builds it fine.  However this is a valid complaint that I don't mind fixing if there are no other complaints about the patch content. 
Nick 



>Mark Rustad, Networking Division, Intel Corporation

