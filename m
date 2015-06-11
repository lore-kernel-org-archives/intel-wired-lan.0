From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Thu, 11 Jun 2015 17:14:34 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Check whether FDIRCMD writes
 actually complete
In-Reply-To: <5578A0D8.5040902@gmail.com>
References: <20150610170003.36498.97226.stgit@mdrustad-wks.jf.intel.com>
 <5578A0D8.5040902@gmail.com>
Message-ID: <182A1884-DC0B-48C8-9B2C-D24AB5F27CAB@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Jun 10, 2015, at 1:40 PM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
> 
> On 06/10/2015 10:00 AM, Mark D Rustad wrote:
>> Wait up to about 100 us for FDIRCMD writes to complete and return
>> failure indications.
>> 
>> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> 
> Did you do any sort of performance testing with this patch applied? Specifically I would want to see the output of a TCP_RR and TCP_CRR test with this before and after.
> 
> The key reason being that adding signature filters is a part of the Tx hotpath when ATR is enabled, and if you are adding a spin wait to the Tx hotpath than you have killed performance.

Very good point. After consulting with the source for this patch, we agree and the wait for signature filters will be removed. This really was about catching certain conditions that can come up with perfect filters.

Thanks for noticing this!

<snip>

>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> index b6f424f3b1a8..b16d26b8f505 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
>> @@ -3460,6 +3460,7 @@ struct ixgbe_info {
>>  #define IXGBE_ERR_PBA_SECTION                   -31
>>  #define IXGBE_ERR_INVALID_ARGUMENT              -32
>>  #define IXGBE_ERR_HOST_INTERFACE_COMMAND        -33
>> +#define IXGBE_ERR_FDIR_CMD_INCOMPLETE		-38
>>  #define IXGBE_NOT_IMPLEMENTED                   0x7FFFFFFF
>>    #define IXGBE_KRM_PORT_CAR_GEN_CTRL(P)	((P == 0) ? (0x4010) : (0x8010))
>> 
> 
> Do you really need a new error return value?  Why not just rename IXGBE_ERR_FDIR_REINIT_FAILED since that is essentially what you are replacing with this new error value anyway.

It looks to me like IXGBE_ERR_FDIR_REINIT_FAILED is still used. I think a reinit failure is different enough from a command timing out that they should have different error codes. You are right that a usage of IXGBE_ERR_FDIR_REINIT_FAILED was eliminated in this patch - a usage that was not doing reinitialization - but the reference in the reinit path is still there.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150611/1a501ed7/attachment.asc>
