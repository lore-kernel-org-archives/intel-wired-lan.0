From: zhuyj <zyjzyj2000@gmail.com>
Date: Wed, 30 Dec 2015 11:06:54 +0800
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: restrict synchronization
 of link_up and speed
In-Reply-To: <53C6554C-8692-4EF3-BF5D-7217D2C9FDA0@intel.com>
References: <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
 <1451356326-2919-1-git-send-email-zyjzyj2000@gmail.com>
 <1451356326-2919-3-git-send-email-zyjzyj2000@gmail.com>
 <87618083B2453E4A8714035B62D67992504FB5FF@FMSMSX105.amr.corp.intel.com>
 <53C6554C-8692-4EF3-BF5D-7217D2C9FDA0@intel.com>
Message-ID: <56834A4E.2090007@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/30/2015 03:17 AM, Rustad, Mark D wrote:
> Emil S <emil.s.tantilov@intel.com> wrote:
>
>>>   */
>>> -	if (hw->mac.type == ixgbe_mac_X540)
>>> +	if ((hw->mac.type == ixgbe_mac_X540) &&
>>> +	    (netdev->flags & IFF_SLAVE))
>>> 		if (link_speed == IXGBE_LINK_SPEED_UNKNOWN)
>>> 			return;
>> If you were to enter ixgbe_watchdog_link_is_up() with unknown speed, then I would
>> assume that you also have a dmesg that shows:
>> "NIC Link is Up unknown speed"
>>
>> by the interface you use in the bond?
> It seems odd to be checking the MAC type for this. Is this behavior perhaps more related to the copper phy? If so, then the check should be changed. Or would the check for unknown link speed be sufficient? It seems like an interface as a slave would not work with an unknown link speed, so it may as well wait in all cases, not just for X540.
>
> --
> Mark Rustad, Networking Division, Intel Corporation
Hi, Mark

Thanks for your suggestions.
The following is the feedback from the customer.
"
...
We observing this issue on x540T interfaces (8086:1528), but not on 
82599_SFP (8086:10FB).
...
"
To narrow this problem, I restrict mac.type to ixgbe_mac_X540. I agree 
with you. Maybe this problem is
related with the copper phy. But I only have X540 NIC to test. So it is 
difficult for me to confirm whether this
problem occurs on other mac type or not, such as X550.

I will consider your suggestions in the latest patch.

Thanks again.

Zhu Yanjun
