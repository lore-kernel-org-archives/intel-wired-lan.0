From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Mon, 22 Aug 2016 09:34:08 -0700
Subject: [Intel-wired-lan] [dev-queue PATCH v2 2/3] i40e: Enable VF
 specific ethtool statistics via VF Port representor netdevs.
In-Reply-To: <CAKgT0UfsO=FGZAnHmXCHsrVXjtfK=G7ebNREw7nnX_KFP-Xi5g@mail.gmail.com>
References: <1471542901-13405-1-git-send-email-sridhar.samudrala@intel.com>
 <1471542901-13405-3-git-send-email-sridhar.samudrala@intel.com>
 <CAKgT0UfsO=FGZAnHmXCHsrVXjtfK=G7ebNREw7nnX_KFP-Xi5g@mail.gmail.com>
Message-ID: <57BB2980.50902@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/19/2016 9:08 AM, Alexander Duyck wrote:
> On Thu, Aug 18, 2016 at 10:55 AM, Sridhar Samudrala
> <sridhar.samudrala@intel.com> wrote:
>> Sample script that shows ethtool stats on VF representor netdev
>> PF: enp5s0f0, VF0: enp5s2  VF_REP0: enp5s0f0-vf0
>>
>>     # echo 2 > /sys/class/net/enp5s0f0/device/sriov_numvfs
>>     # ip link set enp5s2 up
>>     # ethtool -S enp5s0f0-vf0
>>     NIC statistics:
>>       rx_bytes: 0
>>       rx_unicast: 0
>>       rx_multicast: 0
>>       rx_broadcast: 0
>>       rx_discards: 0
>>       rx_unknown_protocol: 0
>>       tx_bytes: 140
>>       tx_unicast: 0
>>       tx_multicast: 2
>>       tx_broadcast: 0
>>       tx_discards: 0
>>       tx_errors: 0
>>
>> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   drivers/net/ethernet/intel/i40e/i40e.h             |  1 +
>>   drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 67 ++++++++++++++++++++++
>>   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  1 +
>>   3 files changed, 69 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>> index 8dc98c2..ad3a720 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>> @@ -869,4 +869,5 @@ i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf);
>>   i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf);
>>   i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf);
>>   void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
>> +void i40e_set_vf_netdev_ethtool_ops(struct net_device *netdev);
>>   #endif /* _I40E_H_ */
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> index 1835186..104d2fb 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> @@ -3116,3 +3116,70 @@ void i40e_set_ethtool_ops(struct net_device *netdev)
>>   {
>>          netdev->ethtool_ops = &i40e_ethtool_ops;
>>   }
>> +
>> +static const char i40e_vf_netdev_ethtool_sset[][ETH_GSTRING_LEN] = {
>> +       "rx_bytes",
>> +       "rx_unicast",
>> +       "rx_multicast",
>> +       "rx_broadcast",
>> +       "rx_discards",
>> +       "rx_unknown_protocol",
>> +       "tx_bytes",
>> +       "tx_unicast",
>> +       "tx_multicast",
>> +       "tx_broadcast",
>> +       "tx_discards",
>> +       "tx_errors",
>> +};
>> +
> So one change you need to this is to swap the rx_ and tx_ portion of
> the strings.  You have to keep in mind this is a switch port
> representation so the Rx and Tx values are swapped.  Every byte the VF
> receives is actually a byte that we transmitted to the VF.
>
> You could probably also add a comment above this block stating that
> the two were swapped and why.
>
Yes. As we are saying that this netdev represents the switch port 
corresponding to the VF, it makes
sense to swap the rx and tx stats.

Jeff,
Should i submit a patch on top of this patchset as it is already in 
dev-queue branch?
Or resubmit the patchset as a v3 with this update.

Thanks
Sridhar
