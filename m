From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 29 Dec 2015 19:17:33 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: restrict synchronization
 of	link_up and speed
In-Reply-To: <87618083B2453E4A8714035B62D67992504FB5FF@FMSMSX105.amr.corp.intel.com>
References: <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
 <1451356326-2919-1-git-send-email-zyjzyj2000@gmail.com>
 <1451356326-2919-3-git-send-email-zyjzyj2000@gmail.com>
 <87618083B2453E4A8714035B62D67992504FB5FF@FMSMSX105.amr.corp.intel.com>
Message-ID: <53C6554C-8692-4EF3-BF5D-7217D2C9FDA0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Emil S <emil.s.tantilov@intel.com> wrote:

>>  */
>> -	if (hw->mac.type == ixgbe_mac_X540)
>> +	if ((hw->mac.type == ixgbe_mac_X540) &&
>> +	    (netdev->flags & IFF_SLAVE))
>> 		if (link_speed == IXGBE_LINK_SPEED_UNKNOWN)
>> 			return;
> 
> If you were to enter ixgbe_watchdog_link_is_up() with unknown speed, then I would
> assume that you also have a dmesg that shows:
> "NIC Link is Up unknown speed"
> 
> by the interface you use in the bond?

It seems odd to be checking the MAC type for this. Is this behavior perhaps more related to the copper phy? If so, then the check should be changed. Or would the check for unknown link speed be sufficient? It seems like an interface as a slave would not work with an unknown link speed, so it may as well wait in all cases, not just for X540.

--
Mark Rustad, Networking Division, Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151229/775e8321/attachment-0001.asc>
