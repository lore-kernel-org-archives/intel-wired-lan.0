From: Du, Fan <fan.du@intel.com>
Date: Sun, 26 Apr 2015 08:02:12 +0000
Subject: [Intel-wired-lan] [PATCH 0/2] RSS fix for ixgbe/ixgbevf
In-Reply-To: <D38E8E86660E514AB505863C19C9287C74187E5E@ORSMSX102.amr.corp.intel.com>
References: <1429774270-21344-1-git-send-email-fan.du@intel.com>
 <D38E8E86660E514AB505863C19C9287C74187E5E@ORSMSX102.amr.corp.intel.com>
Message-ID: <5A90DA2E42F8AE43BC4A093BF0678848E4D077@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Ronciak, John
>Sent: Thursday, April 23, 2015 11:50 PM
>To: Du, Fan; Kirsher, Jeffrey T
>Cc: Du, Fan; Guo, Chaohong
>Subject: RE: [Intel-wired-lan] [PATCH 0/2] RSS fix for ixgbe/ixgbevf
>
>Lists removed, Minskey added
>
Thanks for notifying Minskey about the extra effort for community that beyond my work scope.
Nothing in your comments as an INTEL ETHERNET DRIVERS Reviewer should be out of mail list, 
so I insist all the discussion & challenges must be kept on the arena.

>You have not explained why you want these patches.  It's not obvious as to why
>the patches would be needed.  You say what it does but you don't explain why
>this would be needed.  Please redo the patch set and add the reasons why you
>want this functionality.

You didn't read the cover letter thoroughly, the second sentence explained why this patchset is needed as below:

>> This patchset provide RSS hash value for upper stack by indicating whether it's
>> a L3 or L4 hash. Thus other component of network stack could utilize this hash
>> value providing by NIC without calculating by themselves. 

If you are not sure how upper stack will use skb hash, there is one scenario in OpenvSiwtch,
Which skb L4 hash could be queried by OVS_ACTION_ATTR_HASH action. There are other
Scenarios too, it's one grep of skb_get_hash away from why this functionality is need.

Btw, i40e/i40evf has already incorporates this functionality.


>Cheers,
>John
>
>> -----Original Message-----
>> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>> Behalf Of Fan Du
>> Sent: Thursday, April 23, 2015 12:31 AM
>> To: Kirsher, Jeffrey T
>> Cc: e1000-devel at lists.sourceforge.net; Du, Fan; intel-wired-
>> lan at lists.osuosl.org
>> Subject: [Intel-wired-lan] [PATCH 0/2] RSS fix for ixgbe/ixgbevf
>>
>> This patchset provide RSS hash value for upper stack by indicating whether it's
>> a L3 or L4 hash. Thus other component of network stack could utilize this hash
>> value providing by NIC without caculating by themselves.
>>
>> Test:
>> * Simple iperf test using ixgbe for 82599ES
>> * Build test only for ixgbevf
>> * make C=1 CF=-D__CHECK_ENDIAN__, no warnings introduced by this
>> patchset
>>
>> Fan Du (2):
>>   ixgbe: Specify rx hash type wrt rx desc RSS type
>>   ixgbevf: Set rx hash type for ingress packets
>>
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   25
>++++++++++++++++---
>>  drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 +++++++++
>>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   27
>> +++++++++++++++++++++
>>  3 files changed, 60 insertions(+), 4 deletions(-)
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at lists.osuosl.org
>> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
