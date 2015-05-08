From: Jonathan Toppins <jtoppins@cumulusnetworks.com>
Date: Fri, 08 May 2015 12:57:48 -0400
Subject: [Intel-wired-lan] [PATCH v1 net-next 2/2] igb: support
	SIOCSMIIREG
In-Reply-To: <93C443E7-4209-45A3-A54F-949A4ECDD508@intel.com>
References: <1429302240-654-1-git-send-email-jtoppins@cumulusnetworks.com>
 <1429302240-654-2-git-send-email-jtoppins@cumulusnetworks.com>
 <554BA646.1060000@gmail.com> <93C443E7-4209-45A3-A54F-949A4ECDD508@intel.com>
Message-ID: <554CEB0C.40308@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/7/15 4:46 PM, Rustad, Mark D wrote:
>> On May 7, 2015, at 10:52 AM, Alexander Duyck <alexander.duyck@gmail.com> wrote:
>>
>>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>>> index 720b785..1071a71 100644
>>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>>> @@ -7141,6 +7141,11 @@ static int igb_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>>>   			return -EIO;
>>>   		break;
>>>   	case SIOCSMIIREG:
>>> +		adapter->hw.phy.addr = data->phy_id;
>>> +		if (igb_write_phy_reg(&adapter->hw, data->reg_num & 0x1F,
>>> +				      data->val_in))
>>> +			return -EIO;
>>> +		break;
>>>   	default:
>>>   		return -EOPNOTSUPP;
>>>   	}
>>
>> How and why is this being used?  From what I can tell it looks like it is an easy way to break any of the existing interfaces if it is misused since all you would need to do is specify a phy address that doesn't match the existing PHY in the system and then you would likely lose link, or possibly mess up the configuration on the system requiring.
>>
>> I suspect this is a back door for some piece of user space code that is being given far more permission than it should be.
>
> I don't know about a back door, but the real problem is that it has a
> side-effect of changing the saved value of the phy addr. That is clearly
> a problem and can't be allowed.

This patch was worse before... it had changes in SIOGMIIREG that had 
similar side-effects, missed this one.

Checking with some of the platform people here this patch can be 
dropped. We don't use it as a backdoor of any kind it was mainly used 
for debugging/guess-what-the-phy-addr-was when we originally got the boards.
>
> For the phylib stuff to really work as intended, the igb_write_phy_reg
> really should take the phy address as a parameter instead of getting
> the value from the structure itself. Or a new function should be
> defined that has that interface.
>
> --
> Mark Rustad, Networking Division, Intel Corporation
>

